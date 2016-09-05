#ifndef __IOS_PLAYM4_H__
#define __IOS_PLAYM4_H__

#ifdef __cplusplus
	extern "C" 
	{
#endif

typedef void * PLAYM4_HWND;
typedef void * PLAYM4_HDC;

#define PLAYM4_API 
#define __stdcall

#ifndef CALLBACK
#define CALLBACK
#endif

//Max channel numbers
#define PLAYM4_MAX_SUPPORTS             500

//Wave coef range;
#define MIN_WAVE_COEF                   -100
#define MAX_WAVE_COEF                   100

//BUFFER TYPE
#define BUF_VIDEO_SRC                   1
#define BUF_AUDIO_SRC                   2
#define BUF_VIDEO_RENDER                3
#define BUF_AUDIO_RENDER                4

//Error code
#define  PLAYM4_NOERROR					0	//no error
#define	 PLAYM4_PARA_OVER				1	//input parameter is invalid;
#define  PLAYM4_ORDER_ERROR				2	//The order of the function to be called is error.
#define	 PLAYM4_TIMER_ERROR				3	//Create multimedia clock failed;
#define  PLAYM4_DEC_VIDEO_ERROR			4	//Decode video data failed.
#define  PLAYM4_DEC_AUDIO_ERROR			5	//Decode audio data failed.
#define	 PLAYM4_ALLOC_MEMORY_ERROR		6	//Allocate memory failed.
#define  PLAYM4_OPEN_FILE_ERROR			7	//Open the file failed.
#define  PLAYM4_CREATE_OBJ_ERROR		8	//Create thread or event failed
#define  PLAYM4_BUF_OVER			   11	//buffer is overflow
#define  PLAYM4_CREATE_SOUND_ERROR	   12	//failed when creating audio device.	
#define	 PLAYM4_SET_VOLUME_ERROR	   13	//Set volume failed
#define  PLAYM4_SUPPORT_FILE_ONLY	   14	//The function only support play file.
#define  PLAYM4_SUPPORT_STREAM_ONLY	   15	//The function only support play stream.
#define  PLAYM4_SYS_NOT_SUPPORT		   16	//System not support.
#define  PLAYM4_FILEHEADER_UNKNOWN     17	//No file header.
#define  PLAYM4_VERSION_INCORRECT	   18	//The version of decoder and encoder is not adapted.  
#define  PLAYM4_INIT_DECODER_ERROR     19	//Initialize decoder failed.
#define  PLAYM4_CHECK_FILE_ERROR	   20	//The file data is unknown.
#define  PLAYM4_INIT_TIMER_ERROR	   21	//Initialize multimedia clock failed.
#define	 PLAYM4_BLT_ERROR		       22	//Display failed.
#define  PLAYM4_OPEN_FILE_ERROR_MULTI  24   //openfile error, streamtype is multi
#define  PLAYM4_OPEN_FILE_ERROR_VIDEO  25   //openfile error, streamtype is video
#define  PLAYM4_JPEG_COMPRESS_ERROR    26   //JPEG compress error
#define  PLAYM4_EXTRACT_NOT_SUPPORT    27	//Don't support the version of this file.
#define  PLAYM4_EXTRACT_DATA_ERROR     28	//extract video data failed.
#define  PLAYM4_SECRET_KEY_ERROR       29	//Secret key is error //add 20071218
#define  PLAYM4_DECODE_KEYFRAME_ERROR  30   //add by hy 20090318
#define  PLAYM4_NEED_MORE_DATA         31   //add by hy 20100617
#define  PLAYM4_INVALID_PORT		   32	//add by cj 20100913

#define  PLAYM4_FAIL_UNKNOWN		   99   //Fail, but the reason is unknown;	

//Max display regions.
#define MAX_DISPLAY_WND                4

//Display buffers
#define MAX_DIS_FRAMES                 50
#define MIN_DIS_FRAMES                 1

//Locate by
#define BY_FRAMENUM                    1
#define BY_FRAMETIME                   2

//Source buffer
#define SOURCE_BUF_MAX	              (1024*100000)
#define SOURCE_BUF_MIN	              (1024*50)

//Stream type
#define STREAME_REALTIME              0
#define STREAME_FILE	              1

//frame type
#define T_AUDIO16	                  101
#define T_AUDIO8	                  100
#define T_UYVY		                  1
#define T_YV12		                  3
#define T_RGB32		                  7

// 以下宏定义用于HIK_MEDIAINFO结构
#define FOURCC_HKMI			          0x484B4D49	// "HKMI" HIK_MEDIAINFO结构标记
// 系统封装格式	
#define SYSTEM_NULL			          0x0			// 没有系统层，纯音频流或视频流	
#define SYSTEM_HIK                    0x1			// 海康文件层
#define SYSTEM_MPEG2_PS               0x2			// PS封装
#define SYSTEM_MPEG2_TS               0x3			// TS封装
#define SYSTEM_RTP                    0x4			// rtp封装
#define SYSTEM_RTPHIK                 0x401		    // rtp封装

// 视频编码类型
#define VIDEO_NULL                    0x0           // 没有视频
#define VIDEO_H264                    0x1           // 标准H.264和海康H.264都可以用这个定义
#define VIDEO_MPEG4                   0x3           // 标准MPEG4
#define VIDEO_MJPEG			          0x4
#define VIDEO_AVC264                  0x0100

// 音频编码类型
#define AUDIO_NULL                    0x0000        // 没有音频
#define AUDIO_ADPCM                   0x1000        // ADPCM 
#define AUDIO_MPEG                    0x2000        // MPEG 系列音频，解码器能自适应各种MPEG音频
// G系列音频
#define AUDIO_RAW_DATA8		          0x7000        // 采样率为8k的原始数据
#define AUDIO_RAW_UDATA16	          0x7001        // 采样率为16k的原始数据，即L16
#define AUDIO_G711_U		          0x7110
#define AUDIO_G711_A		          0x7111
#define AUDIO_G722_1		          0x7221
#define AUDIO_G723_1                  0x7231
#define AUDIO_G726_U                  0x7260
#define AUDIO_G726_A                  0x7261
#define AUDIO_G729                    0x7290
#define AUDIO_AMR_NB		          0x3000


typedef struct tagSystemTime
{
	short wYear;
	short wMonth;
	short wDayOfWeek;
	short wDay;
	short wHour;
	short wMinute;
	short wSecond;
	short wMilliseconds;
}SYSTEMTIME;

typedef struct tagHKRect
{
	unsigned long nLeft;	
	unsigned long nTop;
	unsigned long nRight;
	unsigned long nBottom;
}HKRECT;

//Frame Info
typedef struct
{
	int nWidth;
	int nHeight;
	int nStamp;
	int nType;
	int nFrameRate;
	unsigned int dwFrameNum;
}FRAME_INFO;

#ifndef _HIK_MEDIAINFO_FLAG_
#define _HIK_MEDIAINFO_FLAG_
typedef struct _HIK_MEDIAINFO_				// modified by gb 080425
{
	unsigned int    media_fourcc;			// "HKMI": 0x484B4D49 Hikvision Media Information
	unsigned short  media_version;			// 版本号：指本信息结构版本号，目前为0x0101,即1.01版本，01：主版本号；01：子版本号。
	unsigned short  device_id;				// 设备ID，便于跟踪/分析			
    
	unsigned short  system_format;          // 系统封装层
    unsigned short  video_format;           // 视频编码类型
	
    unsigned short  audio_format;           // 音频编码类型
	unsigned char   audio_channels;         // 通道数  
    unsigned char   audio_bits_per_sample;  // 样位率
    unsigned int    audio_samplesrate;      // 采样率 
    unsigned int    audio_bitrate;          // 压缩音频码率,单位：bit
	
    unsigned int    reserved[4];            // 保留
}HIK_MEDIAINFO;
#endif

typedef struct PLAYM4_SYSTEM_TIME //绝对时间 
{
	unsigned int dwYear;   //年
	unsigned int dwMon;	   //月
	unsigned int dwDay;	   //日
	unsigned int dwHour;   //时
	unsigned int dwMin;	   //分
	unsigned int dwSec;	   //秒
	unsigned int dwMs;	   //毫秒
} PLAYM4_SYSTEM_TIME;

//////////////////////////////////////////////////////////////////////////////
//API
//////////////////////////////////////////////////////////////////////////////

 int            PlayM4_OpenFile(int nPort,char *sFileName);
 int            PlayM4_CloseFile(int nPort);
 int            PlayM4_Play(int nPort, PLAYM4_HWND hWnd);
 int            PlayM4_Stop(int nPort);
 int            PlayM4_Pause(int nPort,unsigned int nPause);
 int            PlayM4_Fast(int nPort);
 int            PlayM4_Slow(int nPort);
 int            PlayM4_OneByOne(int nPort);
 int            PlayM4_SetVolume(int nPort,unsigned short nVolume);
 int            PlayM4_StopSound();
 int            PlayM4_PlaySound(int nPort);
 int            PlayM4_OpenStream(int nPort,unsigned char *pFileHeadBuf,unsigned int nSize,unsigned int nBufPoolSize);
 int            PlayM4_InputData(int nPort,unsigned char *pBuf,unsigned int nSize);
 int            PlayM4_CloseStream(int nPort);
 unsigned int   PlayM4_GetFileTime(int nPort);
 //int  	        PlayM4_SetDisplayMode(int nPort, unsigned int dwType);
 unsigned int   PlayM4_GetPlayedTime(int nPort);
 int	        PlayM4_GetFileTimeEx(int nPort, unsigned int* pStart, unsigned int* pStop, unsigned int* pRev);
 unsigned int   PlayM4_GetPlayedFrames(int nPort);
 int 	        PlayM4_SetDecCallBack(int nPort,void (CALLBACK* DecCBFun)(int nPort,char * pBuf,int nSize,FRAME_INFO * pFrameInfo, int nReserved1,int nReserved2));
 int 	        PlayM4_SetDisplayCallBack(int nPort,void (CALLBACK* DisplayCBFun)(int nPort,char * pBuf,int nSize,int nWidth,int nHeight,int nStamp,int nType,int nReserved));
 unsigned int   PlayM4_GetFileTotalFrames(int nPort);
 int 	        PlayM4_GetCurrentFrameRateEx(int nPort, float* pfFrameRate);
 unsigned int   PlayM4_GetPlayedTimeEx(int nPort);
 int 	        PlayM4_SetPlayedTimeEx(int nPort,unsigned int nTime);
 unsigned int   PlayM4_GetCurrentFrameNum(int nPort);
 int 	        PlayM4_SetStreamOpenMode(int nPort,unsigned int nMode);
 unsigned int   PlayM4_GetSdkVersion();
 unsigned int   PlayM4_GetLastError(int nPort);
 int            PlayM4_RefreshPlay(int nPort);
 int            PlayM4_GetPictureSize(int nPort,int *pWidth,int *pHeight);
 int            PlayM4_GetStreamOpenMode(int nPort);
 unsigned short PlayM4_GetVolume(int nPort);
 unsigned int   PlayM4_GetSourceBufferRemain(int nPort);
 int            PlayM4_ResetSourceBuffer(int nPort);
 int            PlayM4_SetDisplayBuf(int nPort,unsigned int nNum);
 unsigned int   PlayM4_GetDisplayBuf(int nPort);
 int            PlayM4_OneByOneBack(int nPort);
 int            PlayM4_SetFileRefCallBack(int nPort, void (__stdcall *pFileRefDone)(unsigned int nPort,unsigned int nUser),unsigned int nUser);
 int            PlayM4_SetCurrentFrameNum(int nPort,unsigned int nFrameNum);
 int            PlayM4_ThrowBFrameNum(int nPort,unsigned int nNum);
 int            PlayM4_SetDisplayRegion(int nPort,unsigned int nRegionNum, HKRECT *pSrcRect, PLAYM4_HWND hDestWnd, int bEnable);
 int            PlayM4_ResetBuffer(int nPort,unsigned int nBufType);
 unsigned int   PlayM4_GetBufferValue(int nPort,unsigned int nBufType);
 int            PlayM4_SetDecodeFrameType(int nPort,unsigned int nFrameType);
 int            PlayM4_ConvertToJpegFile(char * pBuf,int nSize,int nWidth,int nHeight,int nType,char *sFileName);
 int            PlayM4_SetJpegQuality(int nQuality);
 int            PlayM4_GetBMP(int nPort,unsigned char * pBitmap,unsigned int nBufSize,unsigned int* pBmpSize);
 int            PlayM4_GetJPEG(int nPort,unsigned char * pJpeg,unsigned int nBufSize,unsigned int* pJpegSize);
 int            PlayM4_SetSecretKey(int nPort, int lKeyType, char *pSecretKey, int lKeyLen);
 int            PlayM4_SetFileEndCallback(int nPort, void(CALLBACK*FileEndCallback)(int nPort, void *pUser), void *pUser);
 int            PlayM4_GetPort(int* nPort);
 int            PlayM4_FreePort(int nPort);
 int            PlayM4_SkipErrorData(int nPort, int bSkip);
 int            PlayM4_GetSystemTime(int nPort, PLAYM4_SYSTEM_TIME *pstSystemTime);
 int            PlayM4_SetVideoWindow(int nPort, unsigned int nRegionNum, PLAYM4_HWND hWnd);
  
 int            PlayM4_SetDecCallBackMend(int nPort,void (CALLBACK* DecCBFun)(int nPort,char * pBuf,int nSize,FRAME_INFO * pFrameInfo, int nUser,int nReserved2), int nUser);
 int            PlayM4_SetDecCBStream(int nPort,unsigned int nStream);
        
 unsigned int   PlayM4_GetSpecialData(int nPort);

#ifndef _FISHEYE_DEF_
#define _FISHEYE_DEF_

#define R_ANGLE_0   -1  //不旋转
#define R_ANGLE_L90  0  //向左旋转90度
#define R_ANGLE_R90  1  //向右旋转90度
#define R_ANGLE_180  2  //旋转180度

// 以下实现鱼眼相关的接口

// 矫正类型
typedef enum tagFECPlaceType
{
	FEC_PLACE_WALL    = 0x1,		// 壁装方式		(法线水平)
	FEC_PLACE_FLOOR   = 0x2,		// 地面安装		(法线向上)
	FEC_PLACE_CEILING = 0x3,		// 顶装方式		(法线向下)

}FECPLACETYPE;

typedef enum tagFECCorrectType
{
	FEC_CORRECT_PTZ = 0x100,		// PTZ
	FEC_CORRECT_180 = 0x200,		// 180度矫正  （对应2P）
	FEC_CORRECT_360 = 0x300,		// 360全景矫正 （对应1P）

}FECCORRECTTYPE;

typedef struct tagCycleParam
{
	float	fRadiusLeft;	      // 圆的最左边X坐标
	float	fRadiusRight;	      // 圆的最右边X坐标
	float   fRadiusTop;		      // 圆的最上边Y坐标
	float   fRadiusBottom;	      // 圆的最下边Y坐标

}CYCLEPARAM;

typedef struct tagPTZParam
{
	float fPTZPositionX;		 // PTZ 显示的中心位置 X坐标
	float fPTZPositionY;		 // PTZ 显示的中心位置 Y坐标	

}PTZPARAM;


// 错误码
#define FEC_ERR_ENABLEFAIL						0x500 // 鱼眼模块加载失败
#define FEC_ERR_NOTENABLE						0x501 // 鱼眼模块没有加载
#define FEC_ERR_NOSUBPORT						0x502 // 子端口没有分配
#define FEC_ERR_PARAMNOTINIT					0x503 // 没有初始化对应端口的参数
#define FEC_ERR_SUBPORTOVER						0x504 // 子端口已经用完
#define FEC_ERR_EFFECTNOTSUPPORT				0x505 // 该安装方式下这种效果不支持
#define FEC_ERR_INVALIDWND						0x506 // 非法的窗口
#define FEC_ERR_PTZOVERFLOW						0x507 // PTZ位置越界
#define FEC_ERR_RADIUSINVALID					0x508 // 圆心参数非法
#define FEC_ERR_UPDATENOTSUPPORT				0x509 // 指定的安装方式和矫正效果，该参数更新不支持
#define FEC_ERR_NOPLAYPORT						0x510 // 播放库端口没有启用
#define FEC_ERR_PARAMVALID						0x511 // 参数为空
#define FEC_ERR_INVALIDPORT						0x512 // 非法子端口
#define FEC_ERR_PTZZOOMOVER						0x513 // PTZ矫正范围越界
#define FEC_ERR_OVERMAXPORT						0x514  // 矫正通道饱和，最大支持的矫正通道为四个

// 更新标记变量定义
#define 		FEC_UPDATE_RADIUS			 0x1
#define 		FEC_UPDATE_PTZZOOM			 0x2
#define 		FEC_UPDATE_WIDESCANOFFSET	 0x4
#define 		FEC_UPDATE_PTZPARAM			 0x8

typedef struct tagFECParam
{
	unsigned int 	nUpDateType;			// 更新的类型
	unsigned int	nPlaceAndCorrect;		// 安装方式和矫正方式，只能用于获取，SetParam的时候无效,该值表示安装方式和矫正方式的和
	PTZPARAM		stPTZParam;				// PTZ 校正的参数
	CYCLEPARAM		stCycleParam;			// 鱼眼图像圆心参数
	float			fZoom;					// PTZ 显示的范围参数
	float			fWideScanOffset;		// 180或者360度校正的偏移角度
	int				nResver[16];			// 保留字段
}FISHEYEPARAM;

#endif

typedef void (__stdcall * FISHEYE_CallBack )(  void* pUser  , unsigned int  nPort , unsigned int nCBType , void * hDC ,   unsigned int nWidth , unsigned int nHeight); 

PLAYM4_API int __stdcall PlayM4_SetRotateAngle(int nPort, unsigned int nRegionNum, unsigned int dwType);
// 启用鱼眼
PLAYM4_API int __stdcall PlayM4_FEC_Enable(int nPort);

// 关闭鱼眼模块
PLAYM4_API int __stdcall PlayM4_FEC_Disable(int nPort);

// 获取鱼眼矫正处理子端口 [1~31] 
PLAYM4_API int  __stdcall PlayM4_FEC_GetPort(int nPort , FECPLACETYPE emPlaceType , FECCORRECTTYPE emCorrectType);

// 删除鱼眼矫正处理子端口
PLAYM4_API int __stdcall PlayM4_FEC_DelPort(int nPort , int nSubPort);

// 设置鱼眼矫正参数
PLAYM4_API int __stdcall PlayM4_FEC_SetParam(int nPort , int nSubPort , FISHEYEPARAM * pPara);

// 获取鱼眼矫正参数
PLAYM4_API int __stdcall PlayM4_FEC_GetParam(int nPort , int nSubPort , FISHEYEPARAM * pPara);

// 设置显示窗口，可以随时切换
PLAYM4_API int __stdcall PlayM4_FEC_SetWnd(int nPort , int nSubPort , void * hWnd);

// 设置鱼眼窗口的绘图回调
PLAYM4_API int __stdcall PlayM4_FEC_SetCallBack(int nPort , int nSubPort , FISHEYE_CallBack cbFunc , void * pUser);


// 鱼眼播放库内部函数，用于实现一些界面PTZ的效果
//实现PTZ窗口上点击的鼠标位置转换到原始图像上的点 

PLAYM4_API int __stdcall PlayM4_FEC_PTZ2Window( unsigned int nPort , unsigned int nSubPort ,PTZPARAM stPTZRefOrigin , PTZPARAM stPTZRefWindow , PTZPARAM stPTZWindow , float * fXWindow , float * fYWindow);

PLAYM4_API int __stdcall PlayM4_FEC_Scan(unsigned int nPort , unsigned int nSubPort , float fAngle , float * fXWindow , float * fYWindow , FECPLACETYPE emType);

#ifdef __cplusplus
	}
#endif

#endif //_PLAYM4_H_
