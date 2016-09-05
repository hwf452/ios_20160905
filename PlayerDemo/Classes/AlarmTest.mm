//
//  AlarmTest.m
//  PlayerDemo
//
//  Created by Netsdk on 15/4/20.
//
//

#import <Foundation/Foundation.h>
#import "OtherTest.h"
#import "hcnetsdk.h"

void Test_SetupAlarm(int iUserID)
{
    int iAlarmHandle = NET_DVR_SetupAlarmChan_V30(iUserID);
    if(iAlarmHandle == -1)
    {
        NSLog(@"NET_DVR_SetupAlarmChan_V30 failed[%d]", NET_DVR_GetLastError());
        return;
    }
    else
    {
        NSLog(@"NET_DVR_SetupAlarmChan_V30 succ");
    }
    
    sleep(10);
    
    if(!NET_DVR_CloseAlarmChan_V30(iAlarmHandle))
    {
        NSLog(@"NET_DVR_CloseAlarmChan_V30 failed[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_CloseAlarmChan_V30 succ");
    }

}

void fAlarmMessageCallBack(LONG lCommand, NET_DVR_ALARMER *pAlarmer, char *pAlarmInfo, DWORD dwBufLen, void* pUser)
{
    NSLog(@"lCommand[%d], device ip[%s]", lCommand, pAlarmer->sDeviceIP);
}
void Test_SetDVRMessageCallback()
{
    NET_DVR_SetDVRMessageCallBack_V30(fAlarmMessageCallBack, NULL);
    
}


void TEST_Alarm(int iUserID)
{
    Test_SetDVRMessageCallback();
    Test_SetupAlarm(iUserID);
}