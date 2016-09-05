//
//  VoiceTalk.m
//  PlayerDemo
//
//  Created by Netsdk on 15/4/20.
//
//

#import <Foundation/Foundation.h>
#import "VoiceTalk.h"
#import "hcnetsdk.h"
#import "AudioEngine.h"

#if !TARGET_IPHONE_SIMULATOR
CAudioEngine g_audioEngine(CAE_INTERCOM);
int g_iTalkID = -1;

void fVoiceTalkRecordCallBack(OutputDataInfo* pstDataInfo, void* pUser)
{
    NET_DVR_VoiceComSendData(g_iTalkID, (char*)pstDataInfo->pData, pstDataInfo->dwDataLen);
}
void fVoiceTalkPlayCallBack(LONG iTalkID, char *pBuff, DWORD dwBufLen, BYTE byAudioFlag, void *pUser)
{
    g_audioEngine.InputData((BYTE*)pBuff, dwBufLen);
}
BOOL startAudioEngine(AudioCodecParam *pAuidoParam)
{
    //audio engine open
    int iRet = g_audioEngine.Open();
    if(iRet != 0)
    {
        NSLog(@"CAudioEngine open failed[%d]", iRet);
        return FALSE;
    }
    //set parameter
    iRet = g_audioEngine.SetAudioParam(pAuidoParam, PARAM_MODE_PLAY);
    if(iRet != 0)
    {
        g_audioEngine.Close();
        NSLog(@"CAudioEngine SetAudioParam PARAM_MODE_PLAY failed[%d]", iRet);
        return FALSE;
    }
    iRet = g_audioEngine.SetAudioParam(pAuidoParam, PARAM_MODE_RECORD);
    if(iRet != 0)
    {
        g_audioEngine.Close();
        NSLog(@"CAudioEngine SetAudioParam PARAM_MODE_RECORD failed[%d]", iRet);
        return FALSE;
    }
    g_audioEngine.OpenAEC(true);
    //set callback
    iRet = g_audioEngine.SetAudioDataCallBack(fVoiceTalkRecordCallBack, RECORD_DATA_CALLBACK, NULL);
    if(iRet != 0)
    {
        g_audioEngine.Close();
        NSLog(@"CAudioEngine SetAudioDataCallBack failed[%d]", iRet);
        return FALSE;
    }
    iRet = g_audioEngine.StartPlay();
    if(iRet != 0)
    {
        g_audioEngine.Close();
        NSLog(@"CAudioEngine StartPlay failed[%d]", iRet);
        return FALSE;
    }
    iRet = g_audioEngine.StartRecord();
    if(iRet != 0)
    {
        g_audioEngine.Close();
        g_audioEngine.StopPlay();
        NSLog(@"CAudioEngine StartRecord failed[%d]", iRet);
        return FALSE;
    }
    return TRUE;
}

int startVoiceTalk(int iUserID)
{
    NET_DVR_COMPRESSION_AUDIO   compressAudio = {0};
    if(!NET_DVR_GetCurrentAudioCompress(iUserID, &compressAudio))
    {
        NSLog(@"NET_DVR_GetCurrentAudioCompress failed[%d]", NET_DVR_GetLastError());
        return -1;
    }
    
    AudioCodecParam struAudioParam ;
    
    if(compressAudio.byAudioEncType == 1)//G711_U
    {
        struAudioParam.enAudioEncodeType = AUDIO_TYPE_G711U;
        struAudioParam.nBitWidth = 16;
        struAudioParam.nSampleRate = 8000;
        struAudioParam.nChannel = 1;
        struAudioParam.nBitRate = 16000;
    }
    else if(compressAudio.byAudioEncType == 2)//G711_A
    {
        struAudioParam.enAudioEncodeType = AUDIO_TYPE_G711A;
        struAudioParam.nBitWidth = 16;
        struAudioParam.nSampleRate = 8000;
        struAudioParam.nChannel = 1;
        struAudioParam.nBitRate = 16000;
    }
    else if(compressAudio.byAudioEncType == 0)//G722
    {
        struAudioParam.enAudioEncodeType = AUDIO_TYPE_G722;
        struAudioParam.nBitWidth = 16;
        struAudioParam.nSampleRate = 16000;
        struAudioParam.nChannel = 1;
        struAudioParam.nBitRate = 16000;
    }
    else
    {
        NSLog(@"the device audio type is not support by AudioEngineSDK for ios,type:%d", compressAudio.byAudioEncType);
        return -1;
    }
    //start audioengine
    if(!startAudioEngine(&struAudioParam))
    {
        return  -1;
    }
    //start hcnetsdk
    g_iTalkID = NET_DVR_StartVoiceCom_MR_V30(iUserID, 1, fVoiceTalkPlayCallBack, NULL);
    if(g_iTalkID < 0)
    {
        stopVoiceTalk();
        NSLog(@"NET_DVR_StartVoiceCom_MR_V30 falied[%d]", NET_DVR_GetLastError());
    }
    return  g_iTalkID;
}
void stopVoiceTalk()
{
    NET_DVR_StopVoiceCom(g_iTalkID);
    g_iTalkID = -1;
    g_audioEngine.StopRecord();
    g_audioEngine.StopPlay();
    g_audioEngine.Close();
}

#endif