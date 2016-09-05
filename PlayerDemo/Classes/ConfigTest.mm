//
//  Config.m
//  PlayerDemo
//
//  Created by Netsdk on 15/4/17.
//
//

#import <Foundation/Foundation.h>
#import "OtherTest.h"
#import "hcnetsdk.h"

//config
void Test_GetDeviceAbility(int iUserID, int iChan)
{
//    NET_DVR_SDKLOCAL_CFG struLocalCfg = {0};
//    struLocalCfg.byEnableAbilityParse = 1;
//    NET_DVR_SetSDKLocalConfig(&struLocalCfg);
    char szInBuf[1024] = {0};
    char *pOutBuf = new char[2*1024*1024];
    memset(pOutBuf, 0, 2*1024*1024);
    sprintf(szInBuf, "<AudioVideoCompressInfo>    \
            <AudioChannelNumber>1</AudioChannelNumber>  \
            <VoiceTalkChannelNumber>1</VoiceTalkChannelNumber>  \
            <VideoChannelNumber>%d</VideoChannelNumber>  \
            </AudioVideoCompressInfo>", iChan);
    if(!NET_DVR_GetDeviceAbility(iUserID, DEVICE_ENCODE_ALL_ABILITY_V20, szInBuf, strlen(szInBuf), pOutBuf, 2*1024*1024))
    {
        NSLog(@"DEVICE_SOFTHARDWARE_ABILITY failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"DEVICE_SOFTHARDWARE_ABILITY succ:\r\n %s", pOutBuf);
    }
    delete []pOutBuf;
    pOutBuf = NULL;
}
void Test_GetPTZProtocol(int iUserID)
{
    NET_DVR_PTZCFG struPTZCfg = {0};
    if(!NET_DVR_GetPTZProtocol(iUserID, &struPTZCfg))
    {
        NSLog(@"NET_DVR_GetPTZProtocol failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetPTZProtocol succ");
    }
}
void Test_DeviceCfg_V40(int iUserID)
{
    NET_DVR_DEVICECFG_V40 struDevCfg = {0};
    DWORD dwRet = 0;
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_DEVICECFG_V40, 1, &struDevCfg, sizeof(struDevCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_DEVICECFG_V40 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_DEVICECFG_V40 succ");
    }
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_DEVICECFG_V40, 1, &struDevCfg, sizeof(struDevCfg)))
    {
        NSLog(@"NET_DVR_SET_DEVICECFG_V40 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_DEVICECFG_V40 succ");
    }
}
void Test_NetCfg_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_NETCFG_V30 struNetCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_NETCFG_V30, 0, &struNetCfg, sizeof(struNetCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_NETCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_NETCFG_V30 succ");
    }
    memcpy(struNetCfg.struMulticastIpAddr.sIpV4, "234.5.6.7", strlen("234.5.6.7"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_NETCFG_V30, 0, &struNetCfg, sizeof(struNetCfg)))
    {
        NSLog(@"NET_DVR_SET_NETCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_NETCFG_V30 succ");
    }
}
void Test_PicCfg_V30(int iUserID, int iChan)
{
    DWORD dwRet = 0;
    NET_DVR_PICCFG_V30 struPicCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_PICCFG_V30, iChan, &struPicCfg, sizeof(struPicCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_PICCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_PICCFG_V30 succ");
    }
    memcpy(struPicCfg.sChanName, "test channel", strlen("test channel"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_PICCFG_V30, iChan, &struPicCfg, sizeof(struPicCfg)))
    {
        NSLog(@"NET_DVR_SET_PICCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_PICCFG_V30 succ");
    }
}
void Test_CompressionCfg_V30(int iUserID, int iChan)
{
    DWORD dwRet = 0;
    NET_DVR_COMPRESSIONCFG_V30 struCompress = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_COMPRESSCFG_V30, iChan, &struCompress, sizeof(struCompress), &dwRet))
    {
        NSLog(@"NET_DVR_GET_COMPRESSCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_COMPRESSCFG_V30 succ");
    }
    struCompress.struNetPara.byResolution = 1;
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_COMPRESSCFG_V30, iChan, &struCompress, sizeof(struCompress)))
    {
        NSLog(@"NET_DVR_SET_COMPRESSCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_COMPRESSCFG_V30 succ");
    }
}
void Test_CompressAudio(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_COMPRESSION_AUDIO struCompressAudio = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_COMPRESSCFG_AUD, 0, &struCompressAudio, sizeof(struCompressAudio), &dwRet))
    {
        NSLog(@"NET_DVR_GET_COMPRESSCFG_AUD failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_COMPRESSCFG_AUD succ");
    }
}
void Test_IPAlarmoutCfg(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_IPALARMOUTCFG struIPAlarmOut = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_IPALARMOUTCFG, 0, &struIPAlarmOut, sizeof(struIPAlarmOut), &dwRet))
    {
        NSLog(@"NET_DVR_GET_IPALARMOUTCFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_IPALARMOUTCFG succ");
    }
}
void Test_IPParaCfg_V40(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_IPPARACFG_V40 struIPParaV40 = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_IPPARACFG_V40, 0, &struIPParaV40, sizeof(struIPParaV40), &dwRet))
    {
        NSLog(@"NET_DVR_GET_IPPARACFG_V40 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_IPPARACFG_V40 succ");
    }
    memcpy(struIPParaV40.struIPDevInfo[0].struIP.sIpV4, "10.10.34.28", strlen("10.10.34.28"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_IPPARACFG_V40, 0, &struIPParaV40, sizeof(struIPParaV40)))
    {
        NSLog(@"NET_DVR_SET_IPPARACFG_V40 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_IPPARACFG_V40 succ");
    }
}
void Test_AlarminCfg_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_ALARMINCFG_V30 struAlarmInCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_ALARMINCFG_V30, 0, &struAlarmInCfg, sizeof(struAlarmInCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_ALARMINCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_ALARMINCFG_V30 succ");
    }
    memcpy(struAlarmInCfg.sAlarmInName, "test alarm in", strlen("test alarm in"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_ALARMINCFG_V30, 0, &struAlarmInCfg, sizeof(struAlarmInCfg)))
    {
        NSLog(@"NET_DVR_SET_ALARMINCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_ALARMINCFG_V30 succ");
    }
}
void Test_AlarmOutCfg_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_ALARMOUTCFG_V30 struAlarmOutCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_ALARMOUTCFG_V30, 0, &struAlarmOutCfg, sizeof(struAlarmOutCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_ALARMOUTCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_ALARMOUTCFG_V30 succ");
    }
    memcpy(struAlarmOutCfg.sAlarmOutName, "test alarm out", strlen("test alarm out"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_ALARMOUTCFG_V30, 0, &struAlarmOutCfg, sizeof(struAlarmOutCfg)))
    {
        NSLog(@"NET_DVR_SET_ALARMOUTCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_ALARMOUTCFG_V30 succ");
    }
}
void Test_NTPPara(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_NTPPARA struNTPPara = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_NTPCFG, 0, &struNTPPara, sizeof(struNTPPara), &dwRet))
    {
        NSLog(@"NET_DVR_GET_NTPCFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_NTPCFG succ");
    }
  
  if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_NTPCFG, 0, &struNTPPara, sizeof(struNTPPara)))
    {
        NSLog(@"NET_DVR_SET_NTPCFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_NTPCFG succ");
    }
}
void Test_DecoderCfg_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_DECODERCFG_V30  struDecoderCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_DECODERCFG_V30, 1, &struDecoderCfg, sizeof(struDecoderCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_DECODERCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_DECODERCFG_V30 succ");
    }
    struDecoderCfg.dwBaudRate = 9;
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_DECODERCFG_V30, 1, &struDecoderCfg, sizeof(struDecoderCfg)))
    {
        NSLog(@"NET_DVR_SET_DECODERCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_DECODERCFG_V30 succ");
    }
}
void Test_AuxAlarmCfg(int iUserID)
{
    DWORD dwRet = 0;
    NET_IPC_AUX_ALARMCFG struAuxAlarmCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_IPC_GET_AUX_ALARMCFG, 1, &struAuxAlarmCfg, sizeof(struAuxAlarmCfg), &dwRet))
    {
        NSLog(@"NET_IPC_GET_AUX_ALARMCFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_IPC_GET_AUX_ALARMCFG succ");
    }
    memcpy(struAuxAlarmCfg.struAlarm[0].uAlarm.struPIRAlarm.byAlarmName, "test alarm name", strlen("test alarm name"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_IPC_SET_AUX_ALARMCFG, 1, &struAuxAlarmCfg, sizeof(struAuxAlarmCfg)))
    {
        NSLog(@"NET_IPC_SET_AUX_ALARMCFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_IPC_SET_AUX_ALARMCFG succ");
    }
}
void Test_Record_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_RECORD_V30 struRecord = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_RECORDCFG_V30, 1, &struRecord, sizeof(struRecord), &dwRet))
    {
        NSLog(@"NET_DVR_GET_RECORDCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_RECORDCFG_V30 succ");
    }
    struRecord.dwRecord = 1;
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_RECORDCFG_V30, 1, &struRecord, sizeof(struRecord)))
    {
        NSLog(@"NET_DVR_SET_RECORDCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_RECORDCFG_V30 succ");
    }
}
void Test_ZeroChanCfg(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_ZEROCHANCFG struZeroChanCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_ZEROCHANCFG, 1, &struZeroChanCfg, sizeof(struZeroChanCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_ZEROCHANCFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_ZEROCHANCFG succ");
    }
    struZeroChanCfg.dwVideoBitrate = 22;
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_ZEROCHANCFG, 1, &struZeroChanCfg, sizeof(struZeroChanCfg)))
    {
        NSLog(@"NET_DVR_SET_ZEROCHANCFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_ZEROCHANCFG succ");
    }
}
void Test_APInfoList(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_AP_INFO_LIST struApList = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_AP_INFO_LIST, 1, &struApList, sizeof(struApList), &dwRet))
    {
        NSLog(@"NET_DVR_GET_AP_INFO_LIST failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_AP_INFO_LIST succ");
    }
}
void Test_WifiCfg(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_WIFI_CFG struWifiCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_WIFI_CFG, 1, &struWifiCfg, sizeof(struWifiCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_WIFI_CFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_WIFI_CFG succ");
    }
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_WIFI_CFG, 1, &struWifiCfg, sizeof(struWifiCfg)))
    {
        NSLog(@"NET_DVR_SET_WIFI_CFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_WIFI_CFG succ");
    }
}
void Test_WifiConnectStatus(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_WIFI_CONNECT_STATUS struWifiStatus = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_WIFI_STATUS, 1, &struWifiStatus, sizeof(struWifiStatus), &dwRet))
    {
        NSLog(@"NET_DVR_GET_WIFI_STATUS failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_WIFI_STATUS succ");
    }
}
void Test_Time(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_TIME struTimeCfg = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_TIMECFG, 1, &struTimeCfg, sizeof(struTimeCfg), &dwRet))
    {
        NSLog(@"NET_DVR_GET_TIMECFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_TIMECFG succ");
    }
    struTimeCfg.dwHour += 1;
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_TIMECFG, 1, &struTimeCfg, sizeof(struTimeCfg)))
    {
        NSLog(@"NET_DVR_SET_TIMECFG failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_TIMECFG succ");
    }
}
void Test_User_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_USER_V30    struUser = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_USERCFG_V30, 1, &struUser, sizeof(struUser), &dwRet))
    {
        NSLog(@"NET_DVR_GET_USERCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_USERCFG_V30 succ");
    }
    memcpy(struUser.struUser[0].sPassword, "sdk123", strlen("sdk123"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_USERCFG_V30, 1, &struUser, sizeof(struUser)))
    {
        NSLog(@"NET_DVR_SET_USERCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_USERCFG_V30 succ");
    }
}
void Test_DDNSPara_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_DDNSPARA_V30    struDDNSPara = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_DDNSCFG_V30, 1, &struDDNSPara, sizeof(struDDNSPara), &dwRet))
    {
        NSLog(@"NET_DVR_GET_DDNSCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_DDNSCFG_V30 succ");
    }
    memcpy(struDDNSPara.struDDNS[0].sDomainName, "www.sdkdomain.com", strlen("www.sdkdomain.com"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_DDNSCFG_V30, 1, &struDDNSPara, sizeof(struDDNSPara)))
    {
        NSLog(@"NET_DVR_SET_DDNSCFG_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_DDNSCFG_V30 succ");
    }
}
void Test_ShowString_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_SHOWSTRING_V30 struShowString = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_SHOWSTRING_V30, 1, &struShowString, sizeof(struShowString), &dwRet))
    {
        NSLog(@"NET_DVR_GET_SHOWSTRING_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_SHOWSTRING_V30 succ");
    }
    memcpy(struShowString.struStringInfo[0].sString, "test string", strlen("test string"));
    if(!NET_DVR_SetDVRConfig(iUserID, NET_DVR_SET_SHOWSTRING_V30, 1, &struShowString, sizeof(struShowString)))
    {
        NSLog(@"NET_DVR_SET_SHOWSTRING_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SET_SHOWSTRING_V30 succ");
    }
}
void Test_DigitalChannelState(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_DIGITAL_CHANNEL_STATE   struChanState = {0};
    if(!NET_DVR_GetDVRConfig(iUserID, NET_DVR_GET_DIGITAL_CHANNEL_STATE, 1, &struChanState, sizeof(struChanState), &dwRet))
    {
        NSLog(@"NET_DVR_GET_DIGITAL_CHANNEL_STATE failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GET_DIGITAL_CHANNEL_STATE succ");
    }
}
void Test_VideoEffect(int iPreviewID)
{
    DWORD dwBright = 0;
    DWORD dwContrast = 0;
    DWORD dwSaturation = 0;
    DWORD dwHue = 0;
    if(!NET_DVR_ClientGetVideoEffect(iPreviewID, &dwBright, &dwContrast, &dwSaturation, &dwHue))
    {
        NSLog(@"NET_DVR_ClientGetVideoEffect failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_ClientGetVideoEffect succ");
    }
    dwBright += 1;
    if(!NET_DVR_ClientSetVideoEffect(iPreviewID, dwBright, dwContrast, dwSaturation, dwHue))
    {
        NSLog(@"NET_DVR_ClientSetVideoEffect failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_ClientSetVideoEffect succ");
    }
}
void Test_AlarmoutStatus_V30(int iUserID)
{
    DWORD dwRet = 0;
    NET_DVR_ALARMOUTSTATUS_V30 struAlarmOutState = {0};
    if(!NET_DVR_GetAlarmOut_V30(iUserID, &struAlarmOutState))
    {
        NSLog(@"NET_DVR_GetAlarmOut_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetAlarmOut_V30 succ");
    }
    if(!NET_DVR_SetAlarmOut(iUserID, 0, 1))
    {
        NSLog(@"NET_DVR_SetAlarmOut failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SetAlarmOut succ");
    }

}
void Test_CurrentAudioCompress(int iUserID)
{
    NET_DVR_COMPRESSION_AUDIO struAudio = {0};
    if(!NET_DVR_GetCurrentAudioCompress(iUserID, &struAudio))
    {
        NSLog(@"NET_DVR_GetCurrentAudioCompress failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetCurrentAudioCompress succ");
    }
}
void Test_WorkState_V30(int iUserID)
{
    NET_DVR_WORKSTATE_V30 struWorkState = {0};
    if(!NET_DVR_GetDVRWorkState_V30(iUserID, &struWorkState))
    {
        NSLog(@"NET_DVR_GetDVRWorkState_V30 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetDVRWorkState_V30 succ");
    }
}
void Test_UpnpNatState(int iUserID)
{
    NET_DVR_UPNP_NAT_STATE struState = {0};
    if(!NET_DVR_GetUpnpNatState(iUserID, &struState))
    {
        NSLog(@"NET_DVR_GetUpnpNatState failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetUpnpNatState succ");
    }
}

void Test_GetCurrentAudioCompression_V50(int iUserID)
{
    NET_DVR_AUDIO_CHANNEL struAudioChannel = {0};
    struAudioChannel.dwChannelNum = 3;
    NET_DVR_COMPRESSION_AUDIO struCompressionAudio = {0};
    if(NET_DVR_GetCurrentAudioCompress_V50(iUserID, &struAudioChannel, &struCompressionAudio))
    {
        NSLog(@"NET_DVR_GetCurrentAudioCompress_V50 succ");
    }
    else
    {
        NSLog(@"NET_DVR_GetCurrentAudioCompress_V50 failed with[%d]", NET_DVR_GetLastError());
    }
}

void TEST_Config(int iPreviewID, int iUserID, int iChan)
{
    Test_GetDeviceAbility(iUserID, iChan);
    Test_GetPTZProtocol(iUserID);
    Test_DeviceCfg_V40(iUserID);
    Test_NetCfg_V30(iUserID);
    Test_PicCfg_V30(iUserID, iChan);
    Test_CompressionCfg_V30(iUserID, iChan);
    Test_CompressAudio(iUserID);
    Test_IPAlarmoutCfg(iUserID);
    Test_IPParaCfg_V40(iUserID);
    Test_AlarminCfg_V30(iUserID);
    Test_AlarmOutCfg_V30(iUserID);
    Test_NTPPara(iUserID);
    Test_DecoderCfg_V30(iUserID);
    Test_AuxAlarmCfg(iUserID);
    Test_Record_V30(iUserID);
    Test_ZeroChanCfg(iUserID);
    Test_APInfoList(iUserID);
    Test_WifiCfg(iUserID);
    Test_WifiConnectStatus(iUserID);
    Test_Time(iUserID);
    Test_User_V30(iUserID);
    Test_DDNSPara_V30(iUserID);
    Test_ShowString_V30(iUserID);
    Test_DigitalChannelState(iUserID);
    Test_VideoEffect(iPreviewID);
    Test_AlarmoutStatus_V30(iUserID);
    Test_CurrentAudioCompress(iUserID);
    Test_WorkState_V30(iUserID);
    Test_UpnpNatState(iUserID);
    Test_GetCurrentAudioCompression_V50(iUserID);
}