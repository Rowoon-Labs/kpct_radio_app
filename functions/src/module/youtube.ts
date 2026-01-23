/* eslint-disable */

/* eslint-disable camelcase */
/* eslint-disable require-jsdoc */
/* eslint-disable max-len */
import { google, youtube_v3 } from "googleapis";

import { HttpsError, onCall } from "firebase-functions/v2/https";
import { PlayListImpl, Video } from "../model/play_list";

const youtube = google.youtube({
  version: "v3",
  auth: "AIzaSyDGU1qjZ388cLuVrNt7ZudzMr5fWtETSdo", // Your YouTube Data API Key
});

import { v4 as uuidv4 } from "uuid";
import { increment, runTransaction, setDoc } from "firelord";
import { bucket, db, playListReference } from "../firebaseApp";
import axios from "axios";
import { getDownloadURL } from "firebase-admin/storage";

export const addPlayList = onCall(
  { region: "asia-northeast3" },
  async (request) => {
    const userId = request.auth?.uid;
    const playListUrl = request.data.playListUrl;

    if (userId != null) {
      if (playListUrl != null) {
        const playListId: string = extractPlaylistId(playListUrl);

        const playList: PlayListImpl = await getPlaylist(
          playListUrl,
          playListId,
        );

        try {
          await setDoc(playListReference.doc("playList", playListId), {
            playListId: playListId,
            url: playList.url,
            title: playList.title,
            thumbnail: await thumnailJob(playList.thumbnail),
            // thumbnail: playList.thumbnail,
            totalDuration: playList.totalDuration,
            videos: playList.videos,
          });
        } catch (exception) {
          console.log(exception);
          throw new HttpsError(
            "internal",
            `Firestore에 Set하던중 오류가 발행하였습니다 ${playListId} ${exception}`,
          );
        }

        return playList;
      } else {
        throw new HttpsError(
          "invalid-argument",
          "YoutubePlayListUrl을 확인할 수 없습니다",
        );
      }
    } else {
      throw new HttpsError("unauthenticated", "User Id를 확인할 수 없습니다");
    }
  },
);

export const addVideo = onCall(
  { region: "asia-northeast3" },
  async (request) => {
    const userId = request.auth?.uid;
    const videoUrl = request.data.videoUrl;
    const playListId = request.data.playListId;

    if (userId == null) {
      throw new HttpsError("unauthenticated", "User Id를 확인할 수 없습니다");
    }

    if (videoUrl == null) {
      throw new HttpsError(
        "invalid-argument",
        "Video Url을 확인할 수 없습니다",
      );
    }

    if (playListId == null) {
      throw new HttpsError(
        "invalid-argument",
        "PlayListId을 확인할 수 없습니다",
      );
    }

    const videoId: string = extractVideoId(videoUrl);

    const video: Video = await getVideo(videoUrl, videoId);

    return await runTransaction(db, async (transaction) => {
      const playList = await transaction
        .get(playListReference.doc("playList", playListId))
        .then((value) => {
          if (value.exists) {
            return value.data();
          } else {
            throw new HttpsError("not-found", "PlayList가 존재하지 않습니다");
          }
        })
        .catch(() => {
          throw new HttpsError(
            "internal",
            "PlayList를 찾는 중 오류가 발생하였습니다",
          );
        });

      if (playList != null) {
        const videoIndex = playList.videos.findIndex(
          (element) => element.id === video.id,
        );

        if (videoIndex !== -1) {
          playList.videos[videoIndex] = video;
        } else {
          playList.videos.push(video);
        }

        transaction.update(playListReference.doc("playList", playListId), {
          totalDuration: increment(video.duration),
          videos: playList.videos,
        });
      } else {
        // unrechable
        return;
      }
    });
  },
);

async function thumnailJob(thumbnailUrl: string): Promise<string> {
  try {
    // Fetch the image from the URL
    const response = await axios.get(thumbnailUrl, {
      responseType: "arraybuffer",
    });
    const fileBuffer = Buffer.from(response.data, "binary");

    // Generate a unique file name for the thumbnail
    const fileName = `thumbnails/${uuidv4()}.jpg`;

    // Reference to Firebase Storage

    const file = bucket.file(fileName);

    await file.save(fileBuffer);

    // const storageRef = ref(bucket.storage, fileName);

    // Upload the image to Firebase Storage
    // await uploadBytes(storageRef, fileBuffer);

    // Get the download URL

    const downloadUrl = await getDownloadURL(file);

    return downloadUrl;
  } catch (error) {
    console.log(error);
    throw new HttpsError("internal", `Thumbnail upload failed: ${error}`);
  }
}

function extractPlaylistId(playListId: string): string {
  const match = playListId.match(/list=([a-zA-Z0-9_-]+)/);
  if (match && match[1]) {
    return match[1];
  } else {
    throw new HttpsError("internal", "VideoUrl에서 Id를 추출할 수 없습니다");
  }
}

function extractVideoId(url: string): string {
  // const match = url.match(/(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:watch\?v=|embed\/|v\/|user\/(?:[^\/\n\s]+\/)*|[^#&?]*[^\/\n\s]+)|youtu\.be\/)([a-zA-Z0-9_-]{11})/);
  const match = url.match(
    /(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:watch\?v=|embed\/|v\/|user\/(?:[^\\/\n\s]+\/)*|[^#&?]*[^\\/\n\s]+)|youtu\.be\/)([a-zA-Z0-9_-]{11})/,
  );
  if (match && match[1]) {
    return match[1];
  } else {
    throw new HttpsError(
      "internal",
      "YoutubePlayListUrl에서 Id를 추출할 수 없습니다",
    );
  }
}

async function getPlaylist(
  playListUrl: string,
  playListId: string,
): Promise<PlayListImpl> {
  const playlistResponse = await youtube.playlists.list({
    part: ["snippet", "contentDetails"],
    id: [playListId],
  });

  // playlist 아이템 정보 가져오기
  const playlistItemsResponse = await youtube.playlistItems.list({
    part: ["snippet"],
    playlistId: playListId,
    maxResults: 50,
  });

  const videos: Array<Video> = await Promise.all(
    playlistItemsResponse.data.items?.map(
      async (item: youtube_v3.Schema$PlaylistItem) => {
        const videoId: string = item.snippet?.resourceId?.videoId || "";

        return {
          id: videoId,
          title: item.snippet?.title || "",
          url: `https://www.youtube.com/watch?v=${videoId}`,
          limitLevel: 0,
          limitPlayDuration: 0,
          duration: await getVideoDuration(videoId),
        };
      },
    ) ?? [],
  );

  return {
    url: playListUrl,
    title: playlistResponse.data.items?.[0]?.snippet?.title || "",
    thumbnail:
      playlistResponse.data.items?.[0]?.snippet?.thumbnails?.medium?.url || "",
    // totalVideos: playlistResponse.data.items?.[0]?.contentDetails?.itemCount || 0,
    totalDuration: videos.reduce((sum, video) => sum + video.duration, 0),

    videos: videos,
  };
}

async function getVideo(videoUrl: string, videoId: string): Promise<Video> {
  const videoResponse = await youtube.videos.list({
    part: ["snippet", "contentDetails"],
    id: [videoId],
  });

  const video = videoResponse.data.items?.[0];
  if (!video) {
    throw new HttpsError("internal", "Video 정보를 가져올 수 없습니다");
  }

  return {
    id: videoId,
    title: video.snippet?.title || "",
    url: `https://www.youtube.com/watch?v=${videoId}`,
    limitLevel: 0,
    limitPlayDuration: 0,
    duration: await getVideoDuration(videoId),
  };
}

// 비디오의 ID를 기반으로 비디오의 duration 가져오기
async function getVideoDuration(videoId: string): Promise<number> {
  try {
    // videos.list 메서드를 사용하여 비디오의 상세 정보 가져오기
    const response = await youtube.videos.list({
      part: ["contentDetails"],
      id: [videoId],
    });

    // 가져온 비디오 정보에서 duration 추출
    const duration: string =
      response.data.items?.[0]?.contentDetails?.duration || "";

    // ISO 8601 형식에서 초로 변환
    const seconds: number = iso8601ToSeconds(duration);

    return seconds;
  } catch (error) {
    throw new HttpsError(
      "internal",
      "YoutubePlayListUrl에서 Id를 추출할 수 없습니다",
    );
  }
}

// duration을 ISO 8601 형식에서 초로 변환하는 함수
function iso8601ToSeconds(duration: string): number {
  const match = duration.match(/PT(\d+H)?(\d+M)?(\d+S)?/);

  const hours = match && match[1] ? parseInt(match[1]) : 0;
  const minutes = match && match[2] ? parseInt(match[2]) : 0;
  const seconds = match && match[3] ? parseInt(match[3]) : 0;

  return hours * 3600 + minutes * 60 + seconds;
}
