/* eslint-disable */
/* eslint-disable max-len */
/* eslint-disable new-cap */
/* eslint-disable require-jsdoc */

import { MetaTypeCreator, ServerTimestamp } from "firelord";

export type TransactionLog = MetaTypeCreator<
  {
    content: string;
    deltaSsp: number;
    deltaEp: number;

    createdAt: ServerTimestamp;
    email: string;
    userId: string;

    transactedAt: ServerTimestamp | null;
    totalSsp: number | null;
    totalEp: number | null;
  },
  "transactionLogs",
  string
>;
