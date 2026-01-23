/* eslint-disable */
import * as admin from "firebase-admin";
import { getFirelord } from "firelord";
import { User } from "./model/user";
import { TransactionLog } from "./model/transaction_log";
import { PlayList } from "./model/play_list";

admin.initializeApp();

export const db = admin.firestore();
export const bucket = admin.storage().bucket();

export const userReference = getFirelord<User>(db, "users");
export const transactionLogReference = getFirelord<TransactionLog>(
  db,
  "transactionLogs",
);
export const playListReference = getFirelord<PlayList>(
  db,
  "reserved",
  "elements",
);
