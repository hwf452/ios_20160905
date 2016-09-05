//
//  ManageTest.m
//  PlayerDemo
//
//  Created by Netsdk on 15/4/17.
//
//

#import <Foundation/Foundation.h>
#import "OtherTest.h"
#import "hcnetsdk.h"

void Test_Upgrade(int iUserID)
{
    char szFileName[256] = {0};
    if(!NET_DVR_SetNetworkEnvironment(0))
    {
        NSLog(@"NET_DVR_SetNetworkEnvironment failed with[%d]", NET_DVR_GetLastError());
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    sprintf(szFileName, "%s/digicap.dav", (char*)documentsDirectory.UTF8String);
    int lUpgradeHandle = NET_DVR_Upgrade(iUserID, szFileName);
    int nRet = -1;
    if(lUpgradeHandle >= 0)
    {
        int nProgress = -1;
        int nSubProgress = -1;
        int nStep = -1;
        while(true)
        {
            nProgress = NET_DVR_GetUpgradeProgress(lUpgradeHandle);
            nRet = NET_DVR_GetUpgradeState(lUpgradeHandle);
            nStep = NET_DVR_GetUpgradeStep(lUpgradeHandle, &nSubProgress);
            NSLog(@"progress[%d],state[%d],step[%d],sub progress[%d]", nProgress, nRet, nStep, nSubProgress);
            if(nProgress < 0 || nProgress == 100)
            {
                break;
            }
            sleep(1);
        }
        NET_DVR_CloseUpgradeHandle(lUpgradeHandle);
    }
}
void Test_RebootDVR(int iUserID)
{
    if(!NET_DVR_RebootDVR(iUserID))
    {
        NSLog(@"NET_DVR_RebootDVR error[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_RebootDVR succ");
    }
}
void Test_ShutDownDVR(int iUserID)
{
    if(!NET_DVR_ShutDownDVR(iUserID))
    {
        NSLog(@"NET_DVR_ShutDownDVR error[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_ShutDownDVR succ");
    }
}
void Test_ClickKey(int iUserID)
{
    if(!NET_DVR_ClickKey(iUserID, KEY_CODE_MENU))
    {
        NSLog(@"NET_DVR_ClickKey failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_ClickKey succ");
    }
}
void Test_GetDiskList(int iUserID)
{
    NET_DVR_DISKABILITY_LIST struDiskList = {0};
    if(!NET_DVR_GetDiskList(iUserID, &struDiskList))
    {
        NSLog(@"NET_DVR_GetDiskList failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetDiskList succ");
    }
}
void Test_BackupByTime(int iUserID, int iChan)
{
     NET_DVR_DISKABILITY_LIST struDiskList = {0};
     if(!NET_DVR_GetDiskList(iUserID, &struDiskList))
     {
         NSLog(@"NET_DVR_GetDiskList failed with[%d]", NET_DVR_GetLastError());
         return;
     }
     NET_DVR_BACKUP_TIME_PARAM struTimeParam = {0};
     struTimeParam.lChannel = iChan;
     struTimeParam.struStartTime.dwYear = 2014;
     struTimeParam.struStartTime.dwMonth = 6;
     struTimeParam.struStartTime.dwDay = 26;
     struTimeParam.struStartTime.dwHour = 10;
    
     struTimeParam.struStopTime.dwYear = 2014;
     struTimeParam.struStopTime.dwMonth = 6;
     struTimeParam.struStopTime.dwDay = 26;
     struTimeParam.struStopTime.dwHour = 11;
     memcpy(struTimeParam.byDiskDes, struDiskList.struDescNode[0].byDescribe, DESC_LEN_32);
    
     LONG lBackup = NET_DVR_BackupByTime(iUserID, &struTimeParam);
     if(lBackup >= 0)
     {
        DWORD dwState = 0;
        while(dwState < 100 || dwState == 300)
        {
            sleep(1);
            if(!NET_DVR_GetBackupProgress(lBackup, &dwState))
            {
                NSLog(@"NET_DVR_GetBackupProgress failed with[%d]", NET_DVR_GetLastError());
                break;
            }
        }
        NSLog(@"NET_DVR_GetBackupProgress over with[%d]", dwState);
        NET_DVR_StopBackup(lBackup);
     }
     else
     {
         NSLog(@"NET_DVR_BackupByTime failed with[%d]", NET_DVR_GetLastError());
         return;
     }
}
void Test_FindFile_V30(int iUserID)
{
     NET_DVR_FILECOND    struFileCond = {0};
     struFileCond.lChannel = 1;
     struFileCond.dwFileType = 0xff;
     struFileCond.struStartTime.dwYear = 2015;
     struFileCond.struStartTime.dwMonth = 5;
     struFileCond.struStartTime.dwDay = 12;
     struFileCond.struStopTime.dwYear = 2015;
     struFileCond.struStopTime.dwMonth = 5;
     struFileCond.struStopTime.dwDay = 13;
    
     int nRet = -1;
     int nFindHandle = NET_DVR_FindFile_V30(iUserID, &struFileCond);
     NET_DVR_FINDDATA_V30 struFindData = {0};
     if(nFindHandle >= 0)
     {
         while(true)
         {
             nRet = NET_DVR_FindNextFile_V30(nFindHandle, &struFindData);
             if (nRet != NET_DVR_FILE_SUCCESS && nRet != NET_DVR_ISFINDING)
             {
                 break;
             }
             else if(nRet == NET_DVR_FILE_SUCCESS)
             {
                 NSLog(@"find file[%s]", struFindData.sFileName);
             }
         }
         NSLog(@"find next with[%d]", nRet);
         NET_DVR_FindClose_V30(nFindHandle);
     }
    else
    {
        NSLog(@"NET_DVR_FindFile_V30 failed with[%d]", NET_DVR_GetLastError());
    }
}
void Test_FormatDisk(int iUserID)
{
    int nFormatHandle = NET_DVR_FormatDisk(iUserID, 0xff);
    if(nFormatHandle >= 0)
    {
        int nCurrentFormatDisk = 0;
        int nCurrentDiskPos = 0;
        int nFormatStatic = 0;
        BOOL bRet = FALSE;
        while(true)
        {
            bRet = NET_DVR_GetFormatProgress(nFormatHandle, &nCurrentFormatDisk, &nCurrentDiskPos, &nFormatStatic);
            NSLog(@"nCurrentFormatDisk[%d], nCurrentDiskPos[%d], nFormatStatic[%d]", nCurrentFormatDisk, nCurrentDiskPos, nFormatStatic);
            if(nCurrentDiskPos == 100)
            {
                break;
            }
            
            sleep(1);
        }
        NET_DVR_CloseFormatHandle(nFormatHandle);
    }
    else
    {
        NSLog(@"NET_DVR_FormatDisk failed with[%d]", NET_DVR_GetLastError());
    }
}
void Test_UpdateRecordIndex(int iUserID, int iChan)
{
    if(!NET_DVR_UpdateRecordIndex(iUserID, iChan))
    {
        NSLog(@"NET_DVR_UpdateRecordIndex failed:%d",  NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_UpdateRecordIndex succ");
    }
}
void Test_GetFileByName(int iUserID)
{
    char szSavedFileName[256] = {0};
    g_GetFileName(szSavedFileName, "mp4");
    int nDownload = NET_DVR_GetFileByName(iUserID, "ch0001_01000000224000200", szSavedFileName);
    if(nDownload >= 0)
    {
        NET_DVR_PlayBackControl_V40(nDownload, NET_DVR_PLAYSTART, NULL, 0, NULL, NULL);
        int nProgress = 0;
        while(1)
        {
            nProgress = NET_DVR_GetDownloadPos(nDownload);
            NSLog(@"NET_DVR_GetDownloadPos [%d]", nProgress);
            if (nProgress >= 100 || nProgress < 0)
            {
                break;
            }
            sleep(1);
         }
         NET_DVR_StopGetFile(nDownload);
      }
      else
      {
         NSLog(@"NET_DVR_GetFileByName failed with[%d]", NET_DVR_GetLastError());
      }
}


void Test_SetRecvTimeOut()
{
    if(!NET_DVR_SetRecvTimeOut( 5000 ))
    {
        NSLog(@"NET_DVR_SetRecvTimeOut failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SetRecvTimeOut succ!");
    }
}

void Test_GetFileByTime(int iUserID, int iChan)
{
    char szSavedFileName[256] = {0};
    g_GetFileName(szSavedFileName, "mp4");
    NET_DVR_TIME struStartTime = {0};
    NET_DVR_TIME struEndTime = {0};
    struStartTime.dwYear = 2015;
    struStartTime.dwMonth = 5;
    struStartTime.dwDay = 11;
    struStartTime.dwHour = 7;
    
    struEndTime.dwYear = 2015;
    struEndTime.dwMonth = 5;
    struEndTime.dwDay = 11;
    struEndTime.dwHour = 8;
    
    int nDownload = NET_DVR_GetFileByTime(iUserID, iChan, &struStartTime, &struEndTime, szSavedFileName);
    if(nDownload >= 0)
    {
       NET_DVR_PlayBackControl_V40(nDownload, NET_DVR_PLAYSTART, NULL, 0, NULL, NULL);
       int nProgress = 0;
       while(1)
       {
           nProgress = NET_DVR_GetDownloadPos(nDownload);
           NSLog(@"NET_DVR_GetDownloadPos [%d]", nProgress);
           if (nProgress >= 100 || nProgress < 0)
           {
               break;
           }
           sleep(1);
        }
        NET_DVR_StopGetFile(nDownload);
      }
      else
      {
         NSLog(@"NET_DVR_GetFileByTime failed with[%d]", NET_DVR_GetLastError());
      }
}
void Test_FindFileByEvent(int iUserID)
{
     NET_DVR_SEARCH_EVENT_PARAM struEventParam = {0};
     struEventParam.wMajorType = EVENT_MOT_DET;
     struEventParam.wMinorType = 0xffff;
     struEventParam.struStartTime.dwYear = 2015;
     struEventParam.struStartTime.dwMonth = 05;
     struEventParam.struStartTime.dwDay = 12;
     struEventParam.struEndTime.dwYear = 2015;
     struEventParam.struEndTime.dwMonth = 05;
     struEventParam.struEndTime.dwDay = 13;
     struEventParam.byValue = 1;
     struEventParam.uSeniorParam.struMotionParamByValue.wMotDetChanNo[0] = 1;
     int lSearchHandle = NET_DVR_FindFileByEvent(iUserID, &struEventParam);
     if(lSearchHandle >= 0)
     {
        NET_DVR_SEARCH_EVENT_RET struEventRet = {0};
        int lSearchState = -1;
        int nCount = 0;
        while (1)
        {
            lSearchState = NET_DVR_FindNextEvent(lSearchHandle, &struEventRet);
            if (lSearchState != NET_DVR_FILE_SUCCESS && lSearchState != NET_DVR_ISFINDING)
            {
                break;
            }
            else if(lSearchState == NET_DVR_FILE_SUCCESS)
            {
                 NSLog(@"NET_DVR_FILE_SUCCESS MajorType[%d], chan[%d]", struEventRet.wMajorType, struEventRet.uSeniorRet.struMotionRet.dwMotDetNo);
                 nCount++;
            }
        }
        NSLog(@"find next event over, search state[%d],count[%d]", lSearchState, nCount);
        NET_DVR_FindClose_V30(lSearchHandle);
    }
    else
    {
        NSLog(@"NET_DVR_FindFileByEvent failed with[%d]", NET_DVR_GetLastError());
    }
}


void Test_DVRSetConnectTime()
{
    if(!NET_DVR_SetConnectTime(3000))
    {
        NSLog(@"NET_DVR_SetConnectTime failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SetConnectTime succ!");
    }
}


void Test_DVRSetReConnect()
{
    if(!NET_DVR_SetReconnect(3000,true))
    {
        NSLog(@"NET_DVR_SetReconnect failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
         NSLog(@"NET_DVR_SetReconnect succ!");
    }
}

void Test_GetSDKVersion()
{
    long SDKVersion = -1;
    long SDKBuildVersion = -1;
    SDKVersion = NET_DVR_GetSDKVersion();
    if( SDKVersion < 0)
    {
        NSLog(@"NET_DVR_GetSDKVersion failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetSDKVersion succ! SDKVersion [%ld]", SDKVersion);
    }
    SDKBuildVersion = NET_DVR_GetSDKBuildVersion();
    if( SDKBuildVersion < 0)
    {
        NSLog(@"NET_DVR_GetSDKBuildVersion failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_GetSDKBuildVersion succ! SDKBuildVersion [%ld]" , SDKBuildVersion );
    }
}






void TEST_Manage(int iUserID, int iChan)
{
    Test_Upgrade(iUserID);
    Test_RebootDVR(iUserID);
    Test_ShutDownDVR(iUserID);
    Test_ClickKey(iUserID);
    Test_GetDiskList(iUserID);
    Test_BackupByTime(iUserID, iChan);
    Test_FindFile_V30(iUserID);
    Test_FormatDisk(iUserID);
    Test_UpdateRecordIndex(iUserID, iChan);
    Test_GetFileByName(iUserID);
    Test_GetFileByTime(iUserID, iChan);
    Test_FindFileByEvent(iUserID);
    Test_DVRSetConnectTime();
    Test_DVRSetReConnect();
    Test_GetSDKVersion();
    Test_SetRecvTimeOut();
}