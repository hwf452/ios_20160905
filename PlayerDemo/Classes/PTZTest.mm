//
//  PTZTest.m
//  PlayerDemo
//
//  Created by Netsdk on 15/4/17.
//
//

#import <Foundation/Foundation.h>
#import "OtherTest.h"
#import "hcnetsdk.h"

void Test_PTZTrack(int iPreviewID)
{
    if(!NET_DVR_PTZTrack(iPreviewID, RUN_CRUISE))
    {
        NSLog(@"PTZTrack RUN_CRUISE failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZTrack RUN_CRUISE succ");
    }
}
void Test_PTZTrack_Other(int iUserID, int iChan)
{
    if(!NET_DVR_PTZTrack_Other(iUserID, iChan, RUN_CRUISE))
    {
        NSLog(@"PTZTrack_Other RUN_CRUISE failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZTrack_Other RUN_CRUISE succ");
    }
}
void Test_PTZCruise(int iPreviewID)
{
    if(!NET_DVR_PTZCruise(iPreviewID, RUN_SEQ, 1, 1, 20))
    {
        NSLog(@"PTZCruise RUN_SEQ failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZCruise RUN_SEQ succ");
    }
    sleep(5);
    if(!NET_DVR_PTZCruise(iPreviewID, STOP_SEQ, 1, 1, 20))
    {
        NSLog(@"PTZCruise STOP_SEQ failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZCruise STOP_SEQ succ");
    }
}
void Test_PTZCruise_Other(int iUserID, int iChan)
{
    if(!NET_DVR_PTZCruise_Other(iUserID, iChan, RUN_SEQ, 1, 1, 20))
    {
        NSLog(@"PTZCruise_Other RUN_SEQ failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZCruise_Other RUN_SEQ succ");
    }
    sleep(5);
    if(!NET_DVR_PTZCruise_Other(iUserID, iChan, STOP_SEQ, 1, 1, 20))
    {
        NSLog(@"PTZCruise_Other STOP_SEQ failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZCruise_Other STOP_SEQ succ");
    }
}
void Test_PTZPreset(int iPreviewID)
{
    if(!NET_DVR_PTZPreset(iPreviewID, GOTO_PRESET, 1))
    {
        NSLog(@"PTZPreset GOTO_PRESET failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZPreset GOTO_PRESET succ");
    }
}
void Test_PTZPreset_Other(int iUserID, int iChan)
{
    if(!NET_DVR_PTZPreset_Other(iUserID, iChan, GOTO_PRESET, 2))
    {
        NSLog(@"PTZPreset_Other GOTO_PRESET failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZPreset_Other GOTO_PRESET succ");
    }
}
void Test_PTZControl(int iPreviewID)
{
    if(!NET_DVR_PTZControl(iPreviewID, PAN_LEFT, 0))
    {
        NSLog(@"PTZControl PAN_LEFT 0 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControl PAN_LEFT 0 succ");
    }
    sleep(1);
    if(!NET_DVR_PTZControl(iPreviewID, PAN_LEFT, 1))
    {
        NSLog(@"PTZControl PAN_LEFT 1 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControl PAN_LEFT 1 succ");
    }
}
void Test_PTZControl_Other(int iUserID, int iChan)
{
    if(!NET_DVR_PTZControl_Other(iUserID, iChan, TILT_UP, 0))
    {
        NSLog(@"PTZControl_Other TILT_UP 0 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControl_Other TILT_UP 0 succ");
    }
    sleep(5);
    if(!NET_DVR_PTZControl_Other(iUserID, iChan, TILT_UP, 1))
    {
        NSLog(@"PTZControl_Other TILT_UP 1 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControl_Other TILT_UP 1 succ");
    }
}
void Test_PTZControlWithSpeed(int iPreviewID)
{
    if(!NET_DVR_PTZControlWithSpeed(iPreviewID, PAN_RIGHT, 0, 4))
    {
        NSLog(@"PTZControlWithSpeed PAN_RIGHT 0 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControlWithSpeed PAN_RIGHT 0 succ");
    }
    sleep(5);
    if(!NET_DVR_PTZControlWithSpeed(iPreviewID, PAN_RIGHT, 1, 4))
    {
        NSLog(@"PTZControlWithSpeed PAN_RIGHT 1 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControlWithSpeed PAN_RIGHT 1 succ");
    }
}
void Test_PTZControlWithSpeed_Other(int iUserID, int iChan)
{
    if(!NET_DVR_PTZControlWithSpeed_Other(iUserID, iChan, PAN_RIGHT, 0, 4))
    {
        NSLog(@"PTZControlWithSpeed_Other PAN_RIGHT 0 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControlWithSpeed_Other PAN_RIGHT 0 succ");
    }
    sleep(5);
    if(!NET_DVR_PTZControlWithSpeed_Other(iUserID, iChan, PAN_RIGHT, 1, 4))
    {
        NSLog(@"PTZControlWithSpeed_Other PAN_RIGHT 1 failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"PTZControlWithSpeed_Other PAN_RIGHT 1 succ");
    }
}
void Test_PTZSelZoomIn(int iPreviewID)
{
    NET_DVR_POINT_FRAME struPointFrame = {0};
    struPointFrame.xTop = 72;
    struPointFrame.yTop = 58;
    struPointFrame.xBottom = 198;
    struPointFrame.yBottom = 183;
    if(!NET_DVR_PTZSelZoomIn(iPreviewID, &struPointFrame))
    {
        NSLog(@"NET_DVR_PTZSelZoomIn failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_PTZSelZoomIn succ");
    }
}
void Test_PTZSelZoomIn_EX(int iUserID, int iChan)
{
    NET_DVR_POINT_FRAME struPointFrame = {0};
    struPointFrame.xTop = 72;
    struPointFrame.yTop = 58;
    struPointFrame.xBottom = 198;
    struPointFrame.yBottom = 183;
    if(!NET_DVR_PTZSelZoomIn_EX(iUserID, iChan, &struPointFrame))
    {
        NSLog(@"NET_DVR_PTZSelZoomIn_EX failed with[%d]", NET_DVR_GetLastError());
    }
    else
    {
        NSLog(@"NET_DVR_PTZSelZoomIn_EX succ");
    }
}


void TEST_PTZ(int iPreviewID, int iUserID, int iChan)
{
    Test_PTZTrack(iPreviewID);
    Test_PTZTrack_Other(iUserID, iChan);
    Test_PTZCruise(iPreviewID);
    Test_PTZCruise_Other(iUserID, iChan);
    Test_PTZPreset(iPreviewID);
    Test_PTZPreset_Other(iUserID, iChan);
    Test_PTZControl(iPreviewID);
    Test_PTZControl_Other(iUserID, iChan);
    Test_PTZControlWithSpeed(iPreviewID);
    Test_PTZControlWithSpeed_Other(iUserID, iChan);
    Test_PTZSelZoomIn(iPreviewID);
    Test_PTZSelZoomIn_EX(iUserID, iChan);
}