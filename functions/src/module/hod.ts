/* eslint-disable */
/* eslint-disable max-len */
import axios from "axios";
import qs from "qs";

export interface MyInfo {
  result: number;
  wallet_addr: null | string;
  pfp_url: null | string;
  user_ssp: number;
  msg: string;
}

const HOD_API_BASE_URL = "https://webserver-1.kpopctzen.io:8443";

const _getToken = async (): Promise<string> =>
  (
    await axios.request({
      method: "post",
      url: `${HOD_API_BASE_URL}/oauth/token`,
      timeout: 3000,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: "Basic dGVzdGJiYjp0ZXN0YWFh",
      },
      data: qs.stringify({
        grant_type: "client_credentials",
        scope: "read",
      }),
    })
  ).data.access_token;

export const getMyInfo = async (email: string): Promise<MyInfo> =>
  (
    await axios.request({
      method: "post",
      url: `${HOD_API_BASE_URL}/lte/myinfo`,
      timeout: 3000,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: `Bearer ${await _getToken()}`,
      },
      data: qs.stringify({
        user_email: email,
      }),
    })
  ).data;

export const saveUpSsp = async (
  email: string,
  amount: number,
): Promise<number> =>
  (
    await axios.request({
      method: "post",
      url: `${HOD_API_BASE_URL}/lte/ssp/save`,
      timeout: 3000,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: `Bearer ${await _getToken()}`,
      },
      data: qs.stringify({
        user_email: email,
        ssp: amount,
        comment: "TRANSFER SSP TO HOD FROM RADIO",
      }),
    })
  ).data["result"];

export const useSsp = async (email: string, amount: number): Promise<number> =>
  (
    await axios.request({
      method: "post",
      url: `${HOD_API_BASE_URL}/lte/ssp/use`,
      timeout: 3000,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: `Bearer ${await _getToken()}`,
      },
      data: qs.stringify({
        user_email: email,
        ssp: amount,
        comment: "TAKE SSP FROM HOD TO RADIO",
      }),
    })
  ).data["result"];
