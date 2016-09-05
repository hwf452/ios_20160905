//
//  AudioEngine.h
//  AudioEngine
//
//  Created by wangzhiguang on 14-4-4.
//  Copyright (c) 2014年 pc-wangzhiguang. All rights reserved.
//

#ifndef __AudioEngine__AudioEngine__
#define __AudioEngine__AudioEngine__


//语言对讲库的使用模式：播放、录音、对讲
typedef enum _CAE_MODE_
{
    CAE_PLAY		= 1,                //只播放
    CAE_RECORD 		= 2,                //只采集
    CAE_INTERCOM	= 3                 //对讲
}CAEMODE;

//音频格式
typedef enum _AUDIO_ENCODE_TYPE
{
    AUDIO_TYPE_PCM    = 0x00,      //PCM
    AUDIO_TYPE_G711A  = 0x01,      //G711A
    AUDIO_TYPE_G711U  = 0x02,      //G711U
    AUDIO_TYPE_G722   = 0x03,      //G722
    AUDIO_TYPE_G726   = 0x04,      //G726
    AUDIO_TYPE_MPEG2  = 0x05,      //MPEG2
    AUDIO_TYPE_AAC    = 0x06       //AAC
}AudioEncodeType;

//播放/采集音频格式
typedef struct _AudioCodecParam_
{
    AudioEncodeType 	enAudioEncodeType;  //音频格式
    int                 nBitWidth;          //位宽
    int                 nSampleRate;        //采样率
    int                 nChannel;           //声道个数
    int                 nBitRate;           //比特率
    int                 reserved[4];        // 保留
}AudioCodecParam;

//播放或者录音枚举类型
typedef enum _PARAMMODE_
{
    PARAM_MODE_PLAY 	= 1,            //播放参数
    PARAM_MODE_RECORD 	= 2             //采集参数
}PARAMMODE;

//回调的枚举类型
typedef enum _CALLBACK_TYPE_
{
    PLAY_DATA_CALLBACK         = 1,    //播放回调
    RECORD_DATA_CALLBACK       = 2,    //采集编码回调
    RECORD_PCMDATA_CALLBACK    = 3     //采集pcm数据回调
}CALLBACKTYPE;

//输出数据结构体
typedef struct _OUTPUT_DATA_INFO
{
    unsigned char*    pData;            //数据地址
    unsigned int      dwDataLen;        //数据长度
    AudioEncodeType   enDataType;       //回调数据类型
} OutputDataInfo;

//输出数据回调函数
typedef void (* OutputDataCallBack)(OutputDataInfo* pstDataInfo, void* pUser);


class CAudioEngine
{
public:
    CAudioEngine(int nMode);
    ~CAudioEngine(void);
    
    /*打开对讲库*/
    int Open(void);
    
    /*关闭对讲库*/
    int Close(void);
    
    /*开始播放*/
    int StartPlay(void);
    
    /*停止播放*/
    int StopPlay(void);
    
    /*输入播放数据*/
    int InputData(unsigned char *pData, unsigned int nLen);
    
    /*开始声音采集*/
    int StartRecord(void);
    
    /*停止声音采集*/
    int StopRecord(void);
    
    //开启双向声音采集
//    int OpenMixRecord(bool bFlag);
    
    /*开启AEC回音消除*/
    int OpenAEC(bool bFlag);
    
    /*设置音频参数*/
    int SetAudioParam(AudioCodecParam *pstAudioCodecParam, int nType);
    
    /*获取音频参数*/
    int GetAudioParam(AudioCodecParam *pstAudioCodecParam, int nType);
    
    /*设置回调函数*/
    int SetAudioDataCallBack(OutputDataCallBack pfunc, int nType, void *pUser);
    
    /*获取版本号*/
    int GetVersion(void);
    
private:
    int              m_nMode;               //对讲库使用模式
    bool             m_bHasOpen;            //是否打开
    AudioCodecParam  m_stPlayAudioParam;    //播放音频类型
    AudioCodecParam  m_stCapAudioParam;     //采集音频类型
    
    void            *m_pcManager;           //管理类
    
};

#endif /* defined(__AudioEngine__AudioEngine__) */
