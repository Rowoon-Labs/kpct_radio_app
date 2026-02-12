/* eslint-disable */
/* eslint-disable max-len */
/* eslint-disable new-cap */
/* eslint-disable require-jsdoc */

import { MetaTypeCreator } from "firelord";

export type Video = {
  id: string;
  title: string;
  url: string;
  limitLevel: number;
  // milliseconds
  limitPlayDuration: number;
  duration: number;
};

export type PlayList = MetaTypeCreator<
  {
    playListId: string;
    url: string;
    title: string;
    thumbnail: string;
    totalDuration: number;

    videos: Array<Video>;
  },
  "reserved/playList/elements",
  string
>;

export type PlayListImpl = {
  url: string;
  title: string;
  thumbnail: string;
  totalDuration: number;

  videos: Array<Video>;
};
