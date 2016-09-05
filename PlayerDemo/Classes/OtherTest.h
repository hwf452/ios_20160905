//
//  OtherTest.h
//  PlayerDemo
//
//  Created by Netsdk on 15/4/17.
//
//

#ifndef PlayerDemo_OtherTest_h
#define PlayerDemo_OtherTest_h
#import "hcnetsdk.h"
#import "PlayerDemoViewController.h"

//entrance
void TEST_Manage(int iUserID, int iChan);
void TEST_PTZ(int iPreviewID, int iUserID, int iChan);
void TEST_Config(int iPreviewID, int iUserID, int iChan);
void TEST_Other(int iPreviewID, int iUserID, int iChan);
void TEST_Alarm(int iUserID);
//common function
void g_GetFileName(char* pFileName, char* pExtend);
//PTZ
void Test_PTZTrack(int iPreviewID);
void Test_PTZTrack_Other(int iUserID, int iChan);
void Test_PTZCruise(int iPreviewID);
void Test_PTZCruise_Other(int iUserID, int iChan);
void Test_PTZPreset(int iPreviewID);
void Test_PTZPreset_Other(int iUserID, int iChan);
void Test_PTZControl(int iPreviewID);
void Test_PTZControl_Other(int iUserID, int iChan);
void Test_PTZControlWithSpeed(int iPreviewID);
void Test_PTZControlWithSpeed_Other(int iUserID, int iChan);
void Test_PTZSelZoomIn(int iPreviewID);
void Test_PTZSelZoomIn_EX(int iUserID, int iChan);
//config
void Test_GetDeviceAbility(int iUserID, int iChan);
void Test_GetPTZProtocol(int iUserID);
void Test_DeviceCfg_V40(int iUserID);
void Test_NetCfg_V30(int iUserID);
void Test_PicCfg_V30(int iUserID, int iChan);
void Test_CompressionCfg_V30(int iUserID, int iChan);
void Test_CompressAudio(int iUserID);
void Test_IPAlarmoutCfg(int iUserID);
void Test_IPParaCfg_V40(int iUserID);
void Test_AlarminCfg_V30(int iUserID);
void Test_AlarmOutCfg_V30(int iUserID);
void Test_NTPPara(int iUserID);
void Test_DecoderCfg_V30(int iUserID);
void Test_AuxAlarmCfg(int iUserID);
void Test_Record_V30(int iUserID);
void Test_ZeroChanCfg(int iUserID);
void Test_APInfoList(int iUserID);
void Test_WifiCfg(int iUserID);
void Test_WifiConnectStatus(int iUserID);
void Test_Time(int iUserID);
void Test_User_V30(int iUserID);
void Test_DDNSPara_V30(int iUserID);
void Test_ShowString_V30(int iUserID);
void Test_DigitalChannelState(int iUserID);
void Test_VideoEffect(int iPreviewID);
void Test_AlarmoutStatus_V30(int iUserID);
void Test_CurrentAudioCompress(int iUserID);
void Test_WorkState_V30(int iUserID);
void Test_UpnpNatState(int iUserID);
void Test_GetCurrentAudioCompression_V50(int iUserID);
//manage
void Test_Upgrade(int iUserID);
void Test_RebootDVR(int iUserID);
void Test_ShutDownDVR(int iUserID);
void Test_ClickKey(int iUserID);
void Test_GetDiskList(int iUserID);
void Test_BackupByTime(int iUserID, int iChan);
void Test_FindFile_V30(int iUserID);
void Test_FormatDisk(int iUserID);
void Test_UpdateRecordIndex(int iUserID, int iChan);
void Test_GetFileByName(int iUserID);
void Test_GetFileByTime(int iUserID, int iChan);
void Test_FindFileByEvent(int iUserID);
//alarm
void Test_SetupAlarm(int iUserID);
void Test_SetDVRMessageCallback();
//other
void Test_HikOnline();
void Test_IPServer();
void Test_Activate();
void Test_CaptureJPEGPicture(int iUserID, int iChan);
void Test_CaptureJPEGPicture_NEW(int iUserID, int iChan);
void Test_ZeroChanPreview(int iUserID, int iChan);
void Test_TransChannel(int iUserID);
void Test_Serial(int iUserID);
#endif
