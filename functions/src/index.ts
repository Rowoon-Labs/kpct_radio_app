/* eslint-disable */
/* eslint-disable @typescript-eslint/no-var-requires */
/* eslint-disable require-jsdoc */
/* eslint-disable max-len */

import functions = require("firebase-functions/v1");
import { HttpsError, onCall } from "firebase-functions/v2/https";
import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { parse } from "csv-parse";

import { CustomUserRole } from "./model/user";
import {
  db,
  bucket,
  userReference,
  transactionLogReference,
  playListReference as _playListReference,
} from "./firebaseApp";

import {
  createDoc,
  serverTimestamp,
  runTransaction,
  increment,
} from "firelord";
import { FieldValue } from "firebase-admin/firestore";

import { MyInfo, getMyInfo, saveUpSsp, useSsp } from "./module/hod";
import { addPlayList, addVideo } from "./module/youtube";

// Re-export for compatibility
export const playListReference = _playListReference;
export { addPlayList, addVideo };
export { MyInfo, getMyInfo, saveUpSsp, useSsp };

export const region = "asia-northeast3";

export const onUserCreate = functions
  .region(region)
  .auth.user()
  .onCreate(async (user) => {
    const email = user.email ?? "";

    let bonded = false;
    let hodSsp = 0;
    let walletAddress = null;
    let profileImageUrl = null;

    try {
      const myInfo: MyInfo = await getMyInfo(email);
      if (myInfo.result == 1) {
        bonded = true;
        hodSsp = myInfo.user_ssp;
        walletAddress = myInfo.wallet_addr;
        profileImageUrl = myInfo.pfp_url;
      }
    } catch (exception) {
      //
    }

    await createDoc(userReference.doc(user.uid), {
      bonded: bonded,
      role: CustomUserRole.User,
      profileImageUrl: profileImageUrl,
      email: user.email ?? "",
      createdAt: serverTimestamp(),
      walletAddress: walletAddress,
      level: 1,
      stamina: 10000,
      maxStamina: 10000,
      consumedStamina: 0,
      exp: 0,
      maxExp: 1000,
      listeningGauge: 0,
      ep: 0,
      accumulatedEp: 0,
      accumulatedPlayDuration: 0,
      radioSsp: 0,
      accumulatedRadioSsp: 0,
      hodSsp: hodSsp,
      referralCode: null,
      nextRandomBoxAt: serverTimestamp(),
      nextPeriodic12: null,
      nextPeriodic24: null,
      installedEquipments: {
        LG: null,
        Radio: null,
        Accessory: null,
      },
      items: [],
      overcomeLevels: Array<number>(),
    });
  });

export const onTransctionLogCreated = onDocumentCreated(
  {
    region: region,
    document: "transactionLogs/{transactionLogId}",
  },
  async (event) => {
    const data = event.data?.data();

    if (data != null) {
      const transactionLogId = event.params.transactionLogId;

      const transactedAt = data.transactedAt;
      let totalSsp = data.totalSsp;
      let totalEp = data.totalEp;

      if (transactedAt == null || totalSsp == null || totalEp == null) {
        const userId = data.userId;
        const deltaSsp = data.deltaSsp;
        const deltaEp = data.deltaEp;

        await runTransaction(db, async (transaction) => {
          const user = await transaction
            .get(userReference.doc(userId))
            .then((value) => {
              if (value.exists) {
                return value.data();
              } else {
                throw new HttpsError("not-found", "User가 존재하지 않습니다");
              }
            })
            .catch(() => {
              throw new HttpsError(
                "internal",
                "User를 찾는 중 오류가 발생하였습니다",
              );
            });

          if (user != null) {
            totalSsp = Math.max(0, user.radioSsp + deltaSsp);
            totalEp = Math.max(0, user.ep + deltaEp);

            transaction.update(userReference.doc(userId), {
              radioSsp: totalSsp,
              ep: totalEp,

              ...(deltaSsp > 0 && { accumulatedRadioSsp: increment(deltaSsp) }),
              ...(deltaEp > 0 && { accumulatedEp: increment(deltaEp) }),
            });

            transaction.update(transactionLogReference.doc(transactionLogId), {
              transactedAt: serverTimestamp(),
              totalSsp: totalSsp,
              totalEp: totalEp,
            });
          }
        });
      }
    }
  },
);

export const broadcastTransactionLog = onCall(
  { region: region },
  async (request) => {
    const userId = request.auth?.uid;
    const content = request.data.content;
    const deltaSsp = request.data.deltaSsp;
    const deltaEp = request.data.deltaEp;

    if (userId == null) {
      throw new HttpsError("unauthenticated", "User Id를 확인할 수 없습니다");
    }

    if (content == null) {
      throw new HttpsError("invalid-argument", "Content를 확인할 수 없습니다");
    }

    if (deltaSsp == null) {
      throw new HttpsError("invalid-argument", "DeltaSsp를 확인할 수 없습니다");
    }

    if (deltaEp == null) {
      throw new HttpsError("invalid-argument", "DeltaEp를 확인할 수 없습니다");
    }

    const usersSnapshot = await db.collection("users").select("email").get();

    if (usersSnapshot.empty) {
      return;
    }

    const batch = db.batch();

    usersSnapshot.docs.forEach((doc) => {
      batch.create(db.collection("transactionLogs").doc(), {
        content: content,
        deltaSsp: deltaSsp,
        deltaEp: deltaEp,

        createdAt: FieldValue.serverTimestamp(),
        userId: doc.id,
        email: doc.get("email"),

        transactedAt: null,
        totalSsp: null,
        totalEp: null,
      });
    });

    await batch.commit();
  },
);

export const getHodSsp = onCall({ region: region }, async (request) => {
  const userId = request.auth?.uid;
  const email = request.data?.email;

  if (userId == null) {
    throw new HttpsError("unauthenticated", "User Id를 확인할 수 없습니다");
  }
  if (email == null) {
    throw new HttpsError("invalid-argument", "Email를 확인할 수 없습니다");
  }

  const myInfo = await getMyInfo(email);

  return myInfo.user_ssp;
});

export const transferSsp = onCall({ region: region }, async (request) => {
  const userId = request.auth?.uid;
  const email = request.data?.email;
  const amount = request.data?.amount;

  if (userId == null) {
    throw new HttpsError("unauthenticated", "User Id를 확인할 수 없습니다");
  }

  if (email == null) {
    throw new HttpsError("invalid-argument", "Email를 확인할 수 없습니다");
  }

  if (amount == null) {
    throw new HttpsError("invalid-argument", "Amount를 확인할 수 없습니다");
  }

  const transactionResult = await runTransaction(db, async (transaction) => {
    const userDoc = await transaction.get(userReference.doc(userId));
    const user = userDoc.exists == true ? userDoc.data() : null;

    if (user == null) {
      return "User룰 가져올 수 없습니다";
    }

    if (user.radioSsp < amount) {
      return "SSP가 부족합니다";
    }

    transaction.update(userReference.doc(userId), {
      radioSsp: user.radioSsp - amount,
    });

    return null;
  });

  if (transactionResult != null) {
    return {
      message: transactionResult,
    };
  }

  try {
    switch (await saveUpSsp(email, amount)) {
      case -1:
        return {
          message: "이메일 없음",
        };

      case -2:
        return {
          message: "비용 부족",
        };

      case -3:
        return {
          message: "월간 사용량 부족",
        };

      case -4:
        return {
          message: "기타 오류",
        };
    }
  } catch (exception) {
    return {
      message: "SSP Transfer 실패",
    };
  }

  return null;
});

export const takeSsp = onCall({ region: region }, async (request) => {
  const userId = request.auth?.uid;
  const email = request.data?.email;
  const amount = request.data?.amount;

  if (userId == null) {
    throw new HttpsError(
      "unauthenticated",
      "User Id를 확인할 수 없습니다",
      "User Id를 확인할 수 없습니다",
    );
  }

  if (email == null) {
    throw new HttpsError(
      "invalid-argument",
      "Email를 확인할 수 없습니다",
      "Email를 확인할 수 없습니다",
    );
  }

  if (amount == null) {
    throw new HttpsError(
      "invalid-argument",
      "Amount를 확인할 수 없습니다",
      "Amount를 확인할 수 없습니다",
    );
  }

  try {
    switch (await useSsp(email, amount)) {
      case -1:
        return {
          message: "이메일 없음",
        };

      case -2:
        return {
          message: "비용 부족",
        };

      case -3:
        return {
          message: "월간 사용량 부족",
        };

      case -4:
        return {
          message: "기타 오류",
        };
    }
  } catch (exception) {
    return {
      message: "SSP Transfer 실패",
    };
  }

  const transactionResult = await runTransaction(db, async (transaction) => {
    const userDoc = await transaction.get(userReference.doc(userId));
    const user = userDoc.exists == true ? userDoc.data() : null;

    if (user == null) {
      throw new HttpsError(
        "internal",
        "User룰 가져올 수 없습니다",
        "User룰 가져올 수 없습니다",
      );
    }

    transaction.update(userReference.doc(userId), {
      radioSsp: user.radioSsp + amount,
    });

    return null;
  });

  if (transactionResult != null) {
    return {
      message: transactionResult,
    };
  } else {
    return null;
  }
});

export const isAdminUser = onCall({ region: region }, async (request) => {
  const uid = request.data?.uid;

  if (uid == null) {
    throw new HttpsError("invalid-argument", "UID를 확인할 수 없습니다");
  }

  try {
    const adminDoc = await db.collection("admins").doc(uid).get();
    return {
      result: adminDoc.exists,
    };
  } catch (error) {
    throw new HttpsError("internal", "어드민 유저 확인 중 오류가 발생했습니다");
  }
});

async function _deleteAllDocumentsInCollection(collectionName: string) {
  try {
    const collectionRef = db.collection(collectionName);

    const snapshot = await collectionRef.limit(1).get();
    if (snapshot.empty) {
      console.log(`'${collectionName}' 컬렉션이 비어있거나 존재하지 않습니다.`);
      return;
    }

    const deleteBatch = async (
      docs: FirebaseFirestore.QueryDocumentSnapshot[],
    ) => {
      const batch = db.batch();
      docs.forEach((doc) => {
        batch.delete(doc.ref);
      });
      await batch.commit();
    };

    let deletedCount = 0;
    let query = collectionRef.limit(500);

    while (true) {
      const snapshot = await query.get();
      if (snapshot.empty) break;

      await deleteBatch(snapshot.docs);
      deletedCount += snapshot.docs.length;

      const lastDoc = snapshot.docs[snapshot.docs.length - 1];
      query = collectionRef.startAfter(lastDoc).limit(500);
    }

    console.log(
      `'${collectionName}' 컬렉션에서 ${deletedCount}개의 문서를 삭제했습니다.`,
    );
  } catch (error: any) {
    console.error(`'${collectionName}' 컬렉션 삭제 중 오류 발생:`, error);
    throw new Error(`컬렉션 삭제 중 오류가 발생했습니다: ${error}`);
  }
}

export const uploadCSVToFirestore = onCall(
  { region: region },
  async (request) => {
    try {
      const uid = request.auth?.uid;
      const fileName = request.data.fileName;

      if (uid == null) {
        throw new HttpsError("unauthenticated", "사용자 인증이 필요합니다");
      }

      if (fileName == null) {
        throw new HttpsError(
          "invalid-argument",
          "파일 이름을 확인할 수 없습니다",
        );
      }

      const adminDoc = await db.collection("admins").doc(uid).get();
      if (!adminDoc.exists) {
        throw new HttpsError("permission-denied", "어드민 권한이 필요합니다");
      }

      if (!bucket) throw new Error("Bucket not found");

      const file = bucket.file(fileName);
      const [exists] = await file.exists();
      if (!exists) {
        throw new HttpsError("not-found", "파일이 존재하지 않습니다");
      }

      const collectionName = fileName.split("/").pop()?.split(".").shift();
      if (!collectionName) {
        throw new HttpsError("invalid-argument", "유효하지 않은 파일명입니다");
      }

      const finalCollectionName =
        "new_reserved/" + collectionName + "/elements";

      if (!ALLOWED_CSV_COLLECTIONS.includes(collectionName)) {
        console.log(`허용되지 않은 컬렉션 이름입니다: ${collectionName}`);
        throw new HttpsError(
          "invalid-argument",
          "허용되지 않은 컬렉션 이름입니다",
        );
      }

      await _deleteAllDocumentsInCollection(finalCollectionName);

      return new Promise((resolve, reject) => {
        const stream = file.createReadStream();
        const parser = stream.pipe(parse({ columns: true }));
        const writePromises: Promise<any>[] = [];

        parser.on("data", (row: any) => {
          const keys = Object.keys(row);
          if (keys.length > 0) {
            if (DOC_CREATE_TYPE_COLLECTIONS.includes(collectionName)) {
              const writePromise = db
                .collection(finalCollectionName)
                .doc()
                .set(row);
              writePromises.push(writePromise);
            } else {
              const firstKey = keys[0] as string;
              const docId = row[firstKey];
              const writePromise = db
                .collection(finalCollectionName)
                .doc(docId)
                .set(row);
              writePromises.push(writePromise);
            }
          }
        });

        parser.on("end", async () => {
          try {
            await Promise.all(writePromises);
            console.log(
              `CSV 파일이 Firestore의 '${finalCollectionName}' 컬렉션에 업로드되었습니다.`,
            );
            resolve({
              success: true,
              message: "CSV 업로드가 성공적으로 처리되었습니다",
            });
          } catch (error) {
            console.error("Firestore 업로드 중 오류 발생:", error);
            reject(
              new HttpsError(
                "internal",
                "Firestore 업로드 중 오류가 발생했습니다",
              ),
            );
          }
        });

        parser.on("error", (error) => {
          console.error("CSV 파싱 중 오류 발생:", error);
          reject(new HttpsError("internal", "CSV 파싱 중 오류가 발생했습니다"));
        });
      });
    } catch (error) {
      console.error("CSV 업로드 처리 중 오류 발생:", error);
      throw new HttpsError(
        "internal",
        "CSV 업로드 처리 중 오류가 발생했습니다",
      );
    }
  },
);

const ALLOWED_CSV_COLLECTIONS = [
  "gear",
  "crafting",
  "decomposition",
  "draw",
  "level",
  "shop",
  "unlock",
];

const DOC_CREATE_TYPE_COLLECTIONS = ["draw"];
