// /* eslint-disable */
// /* eslint-disable max-len */
// /* eslint-disable new-cap */
// /* eslint-disable require-jsdoc */

// import { MetaTypeCreator } from "firelord";

export enum GearCategory {
  Radio = "Radio",
  LG = "LG",
  Accessory = "Accessory",
  Parts = "Parts",
  Gem = "Gem",
  Ntf = "Ntf",
}

export enum GearTier {
  One = 1,
  Two = 2,
  Three = 3,
  Four = 4,
  Five = 5,
  Six = 6,
  Seven = 7,
}

// export type Gear = MetaTypeCreator<
//   {
//     gear_ID: string;
//     category: GearCategory;
//     name: string;
//     icon: string;
//     tier: GearTier;

//     socket_min?: number | null;
//     socket_max?: number | null;
//     staminaMax?: number | null;
//     staminaUse?: number | null;
//     luck_addrate?: number | null;
//     listeningEP?: number | null;
//     listeningSSP?: number | null;
//     getEXP?: number | null;
//     getEP_24hRate?: number | null;
//     getSSP_24hRate?: number | null;
//     getSSP_Play?: number | null;
//     getSSP_24hAmount?: number | null;
//     getSSP_PlayDelay?: number | null;
//     getSSP_PlayAmount?: number | null;
//   },
//   "reserved/gear/elements",
//   string
// >;
