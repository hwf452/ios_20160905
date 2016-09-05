//
//  Preview.m
//  PlayerDemo
//
//  Created by Netsdk on 15/4/22.
//
//

#import <Foundation/Foundation.h>
#import "Preview.h"
#import "hcnetsdk.h"
#import "IOSPlayM4.h"

typedef struct tagHANDLE_STRUCT
{
    int iPreviewID;
    int iPlayPort;
    UIView *pView;
    tagHANDLE_STRUCT()
    {
        iPreviewID = -1;
        iPlayPort = -1;
        pView = NULL;
    }
}HANDLE_STRUCT,*LPHANDLE_STRUCT;

HANDLE_STRUCT g_struHandle[MAX_VIEW_NUM];
extern PlayerDemoViewController *g_pController;

// preview callback function
void fRealDataCallBack_V30(LONG lRealHandle, DWORD dwDataType, BYTE *pBuffer, DWORD dwBufSize, void* pUser)
{
    LPHANDLE_STRUCT pHandle = (LPHANDLE_STRUCT)pUser;
    switch (dwDataType)
    {
        case NET_DVR_SYSHEAD:
            if(pHandle->iPlayPort != -1)
            {
                break;
            }
            if(!PlayM4_GetPort(&pHandle->iPlayPort))
            {
                break;
            }
            if (dwBufSize > 0 )
            {
                if (!PlayM4_SetStreamOpenMode(pHandle->iPlayPort, STREAME_REALTIME))
                {
                    break;
                }
                if (!PlayM4_OpenStream(pHandle->iPlayPort, pBuffer , dwBufSize, 2*1024*1024))
                {
                    break;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [g_pController previewPlay:&pHandle->iPlayPort playView:pHandle->pView];
                });
            }
            break;
        default:
            if (dwBufSize > 0 && pHandle->iPlayPort != -1)
            {
                if(!PlayM4_InputData(pHandle->iPlayPort, pBuffer, dwBufSize))
                {
                    break;
                }
            }
            break;
    }
}

int startPreview(int iUserID, int iStartChan, UIView *pView, int iIndex)
{
    // request stream
    NET_DVR_PREVIEWINFO struPreviewInfo = {0};
    struPreviewInfo.lChannel = iStartChan + iIndex;
    struPreviewInfo.dwStreamType = 1;
    struPreviewInfo.bBlocked = 1;
    g_struHandle[iIndex].pView = pView;
    
    NSLog(@"iIndex:%zi",iIndex);
    
    g_struHandle[iIndex].iPreviewID = NET_DVR_RealPlay_V40(iUserID, &struPreviewInfo, fRealDataCallBack_V30, &g_struHandle[iIndex]);
    if (g_struHandle[iIndex].iPreviewID == -1)
    {
        NSLog(@"NET_DVR_RealPlay_V40 failed:%d",  NET_DVR_GetLastError());
        return -1;
    }
    NSLog(@"NET_DVR_RealPlay_V40 succ");
    
    return g_struHandle[iIndex].iPreviewID;
}

void stopPreview(int iIndex)
{
    NET_DVR_StopRealPlay(g_struHandle[iIndex].iPreviewID);
    [g_pController stopPreviewPlay:&g_struHandle[iIndex].iPlayPort];
}