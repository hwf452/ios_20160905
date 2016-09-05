#ifndef __HIK_DEFINE__
#define __HIK_DEFINE__


typedef long				HK_LONG;
typedef int					HK_INT;
typedef unsigned long		HK_DWORD;
typedef unsigned long       HK_DWORD_PTR;
typedef unsigned char		HK_BYTE;
typedef unsigned char*		HK_PBYTE;
typedef void*				HK_HANDLE;
typedef int                 HK_BOOL;
typedef float               HK_FLOAT;
typedef long                HK_HRESULT;
typedef void                HK_VOID;
typedef void*               HK_LPVOID;
typedef unsigned int        HK_UINT;
typedef char                HK_CHAR;
typedef double              HK_DOUBLE;
typedef unsigned int        HK_SIZE_T;
typedef unsigned short      HK_UINT16;
typedef unsigned short      HK_WORD;
typedef short               HK_INT16;
typedef short               HK_SHORT;


#ifndef HK_TRUE
#define HK_TRUE				1
#endif

#ifndef HK_FALSE
#define HK_FALSE			0
#endif

#ifndef HK_NULL
#define HK_NULL				0
#endif

#ifndef HK_STDCALL

#ifdef WIN32
	#define HK_STDCALL __cdecl
#else
	#define HK_STDCALL
#endif

#endif


#ifndef INVALID_HANDLE_VALUE
#define INVALID_HANDLE_VALUE ((HK_HANDLE)(HK_LONG)-1)
#endif

#ifndef HK_IN
#define HK_IN
#endif

#ifndef HK_OUT
#define HK_OUT
#endif

typedef struct _SYSTEMTIME
{
	HK_WORD  wYear;
	HK_WORD  wMonth;
	HK_WORD  wDayOfWeek;
	HK_WORD  wDay;
	HK_WORD  wHour;
	HK_WORD  wMinute;
	HK_WORD  wSecond;
	HK_WORD  wMilliseconds;
} SYSTEMTIME;

#define HK_FILE_BEGIN      0
#define HK_FILE_CURRENT    1
#define HK_FILE_END        2

//
#define HK_IPHONE_PLAY_OK 1
#define HK_IPHONE_PLAY_FALSE 0




#define HK_DATA_HEAD 0
#define HK_DATA_FRAME 1



#define BUF_POOL_SIZE 1024*1024


#define MIN_IMAGE_SIZE 16

#define MAX_IMAGE_SIZE 1024

#ifndef __cdecl
#define __cdecl
#endif


#define HK_MIN(a,b) (((a) < (b)) ? (a) : (b))
#define HK_MAX(a,b) (((a) > (b)) ? (a) : (b))



#endif
