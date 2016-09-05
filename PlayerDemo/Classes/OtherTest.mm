//
//  OtherTest.m
//  PlayerDemo
//
//  Created by Netsdk on 15/4/17.
//
//

#import <Foundation/Foundation.h>
#import "OtherTest.h"

void g_GetFileName(char* pFileName, char* pExtend)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd_hh_mm_ss"];
    date = [formatter stringFromDate:[NSDate date]];
    
    sprintf(pFileName, "%s/%s.%s", (char*)documentsDirectory.UTF8String, (char*)date.UTF8String, pExtend);
}

void Test_HikOnline()
{
    NET_DVR_QUERY_COUNTRYID_COND	struCountryIDCond = {0};
    NET_DVR_QUERY_COUNTRYID_RET		struCountryIDRet = {0};
    struCountryIDCond.wCountryID = 248; //248 is for china,other country's ID please see the interface document
    memcpy(struCountryIDCond.szSvrAddr, "www.hik-online.com", strlen("www.hik-online.com"));
    memcpy(struCountryIDCond.szClientVersion, "iOS NetSDK Demo", strlen("iOS NetSDK Demo"));
    //first you need get the resolve area server address form www.hik-online.com by country ID
	//and then get you dvr/ipc address from the area resolve server
    if(NET_DVR_GetAddrInfoByServer(QUERYSVR_BY_COUNTRYID, &struCountryIDCond, sizeof(struCountryIDCond), &struCountryIDRet, sizeof(struCountryIDRet)))
    {
    	NSLog(@"QUERYSVR_BY_COUNTRYID succ,resolve:%s", struCountryIDRet.szResolveSvrAddr);
    }
    else
    {
    	NSLog(@"QUERYSVR_BY_COUNTRYID failed:%d", NET_DVR_GetLastError());
    }
    //follow code show how to get dvr/ipc address from the area resolve server by nickname or serial no.
    NET_DVR_QUERY_DDNS_COND	struDDNSCond = {0};
    NET_DVR_QUERY_DDNS_RET	struDDNSQueryRet = {0};
    NET_DVR_CHECK_DDNS_RET	struDDNSCheckRet = {0};
    memcpy(struDDNSCond.szClientVersion, "iOS NetSDK Demo", strlen("iOS NetSDK Demo"));
    memcpy(struDDNSCond.szResolveSvrAddr, struCountryIDRet.szResolveSvrAddr, strlen(struCountryIDRet.szResolveSvrAddr));
    memcpy(struDDNSCond.szDevNickName, "nickname", strlen("nickname"));//your dvr/ipc nickname
    memcpy(struDDNSCond.szDevSerial, "serial no.", strlen("serial no."));//your dvr/ipc serial no.
    if(NET_DVR_GetAddrInfoByServer(QUERYDEV_BY_NICKNAME_DDNS, &struDDNSCond, sizeof(struDDNSCond), &struDDNSQueryRet, sizeof(struDDNSQueryRet)))
    {
    	NSLog(@"QUERYDEV_BY_NICKNAME_DDNS succ,ip[%s],sdk port[%d]:", struDDNSQueryRet.szDevIP, struDDNSQueryRet.wCmdPort);
    }
    else
    {
    	NSLog(@"QUERYDEV_BY_NICKNAME_DDNS failed:%d", NET_DVR_GetLastError());
    }
    if(NET_DVR_GetAddrInfoByServer(QUERYDEV_BY_SERIAL_DDNS,  &struDDNSCond, sizeof(struDDNSCond), &struDDNSQueryRet, sizeof(struDDNSQueryRet)))
    {
        NSLog(@"QUERYDEV_BY_SERIAL_DDNS succ,ip[%s],sdk port[%d]:", struDDNSQueryRet.szDevIP, struDDNSQueryRet.wCmdPort);
    }
    else
    {
        NSLog(@"QUERYDEV_BY_SERIAL_DDNS failed:%d", NET_DVR_GetLastError());
    }
    
    //if you get the dvr/ipc address failed from the area reolve server,you can check the reason show as follow
    if(NET_DVR_GetAddrInfoByServer(CHECKDEV_BY_NICKNAME_DDNS, &struDDNSCond, sizeof(struDDNSCond), &struDDNSCheckRet, sizeof(struDDNSCheckRet)))
    {
    	NSLog(@"CHECKDEV_BY_NICKNAME_DDNS succ,ip[%s], sdk port[%d], region[%d], status[%d]",struDDNSCheckRet.struQueryRet.szDevIP, struDDNSCheckRet.struQueryRet.wCmdPort, struDDNSCheckRet.wRegionID, struDDNSCheckRet.byDevStatus);
    }
    else
    {
        NSLog(@"CHECKDEV_BY_NICKNAME_DDNS failed[%d]", NET_DVR_GetLastError());
    }
    if(NET_DVR_GetAddrInfoByServer(CHECKDEV_BY_SERIAL_DDNS, &struDDNSCond, sizeof(struDDNSCond), &struDDNSCheckRet, sizeof(struDDNSCheckRet)))
    {
        NSLog(@"CHECKDEV_BY_SERIAL_DDNS succ,ip[%s], sdk port[%d], region[%d], status[%d]",struDDNSCheckRet.struQueryRet.szDevIP, struDDNSCheckRet.struQueryRet.wCmdPort, struDDNSCheckRet.wRegionID, struDDNSCheckRet.byDevStatus);
    }
    else
    {
        NSLog(@"CHECKDEV_BY_SERIAL_DDNS failed[%d]", NET_DVR_GetLastError());
    }
}

void Test_IPServer()
{
    NET_DVR_QUERY_IPSERVER_COND	struIPServerCond = {0};
    NET_DVR_QUERY_IPSERVER_RET	struIPServerRet = {0};
    struIPServerCond.wResolveSvrPort = 7071;
    memcpy(struIPServerCond.szResolveSvrAddr, "10.10.34.27", strlen("10.10.34.27"));//your ipserver ip
    memcpy(struIPServerCond.szDevNickName, "IP CAMERA", strlen("IP CAMERA"));//your dvr/ipc nickname on ipserver
    //search by nickname
    if(NET_DVR_GetAddrInfoByServer(QUERYDEV_BY_NICKNAME_IPSERVER, &struIPServerCond, sizeof(struIPServerCond), &struIPServerRet, sizeof(struIPServerRet)))
    {
    	NSLog(@"QUERYDEV_BY_NICKNAME_IPSERVER succ,ip[%s],sdk port[%d]", struIPServerRet.szDevIP, struIPServerRet.wCmdPort);
    }
    else
    {
    	NSLog(@"QUERYDEV_BY_NICKNAME_IPSERVER failed[%d]", NET_DVR_GetLastError());
    }
    
    memcpy(struIPServerCond.szDevSerial, "DS-2CD4026FWD-A20140811CCCH475523795", strlen("DS-2CD4026FWD-A20140811CCCH475523795"));//your dvr/ipc serial no.
    //search by serial no.
    if(NET_DVR_GetAddrInfoByServer(QUERYDEV_BY_SERIAL_IPSERVER, &struIPServerCond, sizeof(struIPServerCond), &struIPServerRet, sizeof(struIPServerRet)))
    {
        NSLog(@"QUERYDEV_BY_SERIAL_IPSERVER succ,ip[%s],sdk port[%d]", struIPServerRet.szDevIP, struIPServerRet.wCmdPort);
    }
    else
    {
        NSLog(@"QUERYDEV_BY_SERIAL_IPSERVER failed[%d]", NET_DVR_GetLastError());
    }
}

void Test_Activate()
{
    NET_DVR_ACTIVATECFG struActivate = {0};
    struActivate.dwSize = sizeof(struActivate);
    memcpy(struActivate.sPassword, "1q2w3e4r5t", strlen("1q2w3e4r5t"));
    if(!NET_DVR_ActivateDevice("192.168.1.64", 8000, &struActivate))
    {
        NSLog(@"NET_DVR_ActivateDevice failed[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_ActivateDevice succ");
    }
}

void Test_CaptureJPEGPicture(int iUserID, int iChan)
{
    NET_DVR_JPEGPARA struJpegPara = {0};
    struJpegPara.wPicSize = 2;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    char szFileName[256] = {0};
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    sprintf(szFileName, "%s/%s.jpg", (char*)documentsDirectory.UTF8String, (char*)date.UTF8String);
    if(!NET_DVR_CaptureJPEGPicture(iUserID, iChan, &struJpegPara, szFileName))
    {
        NSLog(@"NET_DVR_CaptureJPEGPicture failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_CaptureJPEGPicture succ");
    }
}
void Test_CaptureJPEGPicture_NEW(int iUserID, int iChan)
{
    NET_DVR_JPEGPARA struJpegPara = {0};
    struJpegPara.wPicSize = 2;
    
    char *pBuf = new char[2*1024*1024];
    memset(pBuf, 0, 2*1024*1024);
    DWORD dwRet = 0;
    if(!NET_DVR_CaptureJPEGPicture_NEW(iUserID, iChan, &struJpegPara, pBuf, 2*1024*1024, &dwRet))
    {
        NSLog(@"NET_DVR_CaptureJPEGPicture_NEW failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_CaptureJPEGPicture_NEW succ");
    }
    delete []pBuf;
    pBuf = NULL;
}

void fZeroChanPreviewCallBack(LONG lRealHandle, DWORD dwDataType, BYTE *pBuffer, DWORD dwBufSize, void* pUser)
{
    NSLog(@"fRealDataCallBack_V30 lRealHandle[%d], DataType[%d], BufSize[%d]", lRealHandle, dwDataType, dwBufSize);
}
void Test_ZeroChanPreview(int iUserID, int iChan)
{
    NET_DVR_CLIENTINFO ClientInfo = {0};
    ClientInfo.lChannel = iChan;
  
    int iRealPlayID = NET_DVR_ZeroStartPlay(iUserID, &ClientInfo, fZeroChanPreviewCallBack, NULL);
    if(iRealPlayID < 0)
    {
        NSLog(@"NET_DVR_ZeroStartPlay failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        sleep(10);
        NET_DVR_ZeroStopPlay(iRealPlayID);
    }
}
void Test_TransChannel(int iUserID)
{
    NET_DVR_SERIALSTART_V40 struSerial  = {0};
    struSerial.dwSize = sizeof(struSerial);
    struSerial.dwSerialType = 2;
    int iSerialHandle = NET_DVR_SerialStart_V40(iUserID, &struSerial, sizeof(struSerial), NULL, NULL);
    if(iSerialHandle >= 0)
    {
        NSLog(@"NET_DVR_SerialStart_V40 succ");
        if(!NET_DVR_SerialSend(iSerialHandle, 1, "11", 2))
        {
            NSLog(@"NET_DVR_SerialStart_V40 failed with[%d]", NET_DVR_GetLastError());
        }
        else
        {
            NSLog(@"NET_DVR_SerialStart_V40 succ");
        }
        NET_DVR_SerialStop(iSerialHandle);
    }
    else
    {
        NSLog(@"NET_DVR_SerialStart_V40 failed with[%d]", NET_DVR_GetLastError());
    }
    
}


void Test_DVRRecord(int iUserID, int iChan)
{
    if(!NET_DVR_StartDVRRecord(iUserID, 1, 0))
    {
        NSLog(@"NET_DVR_StartDVRRecord failed with[%d]" , NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_StartDVRRecord succ!");
    }
    sleep(5);
    if(!NET_DVR_StopDVRRecord(iUserID, 1))
    {
        NSLog(@"NET_DVR_StopDVRRecord failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_StopDVRRecord succ!");
    }
}


void Test_Serial(int iUserID)
{
    if(!NET_DVR_SendToSerialPort(iUserID, 2, 1, "11", 2))
    {
        NSLog(@"NET_DVR_SendToSerialPort failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SendToSerialPort succ");
    }
    
    if(!NET_DVR_SendTo232Port(iUserID, "11", 2))
    {
        NSLog(@"NET_DVR_SendTo232Port failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_SendTo232Port succ");
    }
}


void Test_DVRMakeKeyFrame(int iUserID, int iChan)
{
    if(!NET_DVR_MakeKeyFrame( iUserID, iChan))
    {
        NSLog(@"NET_DVR_MakeKeyFrame failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_MakeKeyFrame succ!");
    }
}

void Test_DVRMakeKeyFrameSub(int iUserID, int iChan)
{
    if(!NET_DVR_MakeKeyFrameSub( iUserID, iChan))
    {
        NSLog(@"NET_DVR_MakeKeyFrameSub failed with[%d]", NET_DVR_GetLastError());
        
    }
    else
    {
        NSLog(@"NET_DVR_MakeKeyFrameSub succ!");
    }
}
void Test_SearchLog(int iUserID)
{
    NET_DVR_TIME struStartTime = {0};
    NET_DVR_TIME struEndTime = {0};
    struStartTime.dwYear = 2015;
    struStartTime.dwMonth = 5;
    struStartTime.dwDay = 12;
    struEndTime.dwYear = 2015;
    struEndTime.dwMonth = 5;
    struEndTime.dwDay = 13;
    int nSearchHandle = (int)NET_DVR_FindDVRLog_V30(iUserID, 0, 0, 0, &struStartTime, &struEndTime, false);
    if(nSearchHandle >= 0)
    {
        NET_DVR_LOG_V30	struLog = {0};
        int nState = -1;
        int nCount = 0;
        while(true)
        {
            nState = (int)NET_DVR_FindNextLog_V30((long)nSearchHandle, &struLog);
            if(nState != NET_DVR_FILE_SUCCESS && nState != NET_DVR_ISFINDING)
            {
                break;
            }
            else if(nState == NET_DVR_FILE_SUCCESS)
            {
                nCount++;
                NSLog(@"find log time: [%d]-[%d]-[%d]" ,struLog.strLogTime.dwHour ,struLog.strLogTime.dwMinute , struLog.strLogTime.dwSecond);
            }
            sleep(5);
        }
        NET_DVR_FindLogClose_V30(nSearchHandle);
    }
}

extern PlayerDemoViewController *g_pController;
void Test_LoginMultiThread()
{
    int i = 0;
    for(i = 0; i < 100; i++)
    {
        NSThread *loginThread = [[NSThread alloc]initWithTarget: g_pController selector: @selector(loginMultiThread) object:nil];
        [loginThread start];
    }
}



void TEST_Other(int iPreviewID, int iUserID, int iChan)
{
//    Test_HikOnline();
//    Test_IPServer();
//    Test_CaptureJPEGPicture(iUserID, iChan);
//    Test_CaptureJPEGPicture_NEW(iUserID, iChan);
//    Test_ZeroChanPreview(iUserID, iChan);
//    Test_TransChannel(iUserID);
//    Test_Serial(iUserID);
//    Test_DVRMakeKeyFrame(iUserID, iChan);
//    Test_DVRMakeKeyFrameSub(iUserID, iChan);
//    Test_DVRRecord(iUserID, iChan);
//    Test_Activate();
//    Test_SearchLog(iUserID);
}