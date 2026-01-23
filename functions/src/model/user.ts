/* eslint-disable */
/* eslint-disable max-len */
/* eslint-disable new-cap */
/* eslint-disable require-jsdoc */

import { MetaTypeCreator, ServerTimestamp } from "firelord";
import { GearCategory, GearTier } from "./gear";

export enum CustomUserRole {
  Admin = "admin",
  User = "user",
}

export type Item = {
  id: string;
  todayBuyCount: number;
  lastBuyAt: ServerTimestamp;
  effectEndAt?: ServerTimestamp | null;
};

export type InstalledEquipment = {
  gear_ID: string;
  category: GearCategory;
  name: string;
  icon: string;
  tier: GearTier;

  socket_min?: number | null;
  socket_max?: number | null;
  staminaMax?: number | null;
  staminaUse?: number | null;
  luck_addrate?: number | null;
  listeningEP?: number | null;
  listeningSSP?: number | null;
  getEXP?: number | null;
  getEP_24hRate?: number | null;
  getEP_24hAmount?: number | null;
  getSSP_24hRate?: number | null;
  getSSP_Play?: number | null;
  getSSP_24hAmount?: number | null;
  getSSP_PlayDelay?: number | null;
  getSSP_PlayAmount?: number | null;
};

export type User = MetaTypeCreator<
  {
    bonded: boolean;

    role: CustomUserRole;

    profileImageUrl?: string | null;
    email: string;

    createdAt: ServerTimestamp;

    walletAddress?: string | null;

    level: number;
    stamina: number;
    maxStamina: number;
    consumedStamina: number;

    exp: number;
    maxExp: number;

    listeningGauge: number;

    ep: number;
    accumulatedEp: number;

    // milliseconds
    accumulatedPlayDuration: number;

    radioSsp: number;
    accumulatedRadioSsp: number;
    hodSsp: number;

    referralCode?: string | null;

    nextRandomBoxAt: ServerTimestamp;

    nextPeriodic12?: ServerTimestamp | null;
    nextPeriodic24?: ServerTimestamp | null;

    installedEquipments: {
      LG: InstalledEquipment | null;
      Radio: InstalledEquipment | null;
      Accessory: InstalledEquipment | null;
    };

    items: Array<Item>;

    overcomeLevels: Array<number>;
  },
  "users",
  string,
  null
>;
