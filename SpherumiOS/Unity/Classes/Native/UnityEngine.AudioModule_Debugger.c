#include "pch-c.h"
#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif


#include "codegen/il2cpp-codegen-metadata.h"





#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodExecutionContextInfo g_methodExecutionContextInfos[1] = { { 0, 0, 0 } };
#else
static const Il2CppMethodExecutionContextInfo g_methodExecutionContextInfos[1] = { { 0, 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const char* g_methodExecutionContextInfoStrings[1] = { NULL };
#else
static const char* g_methodExecutionContextInfoStrings[1] = { NULL };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodExecutionContextInfoIndex g_methodExecutionContextInfoIndexes[41] = 
{
	{ 0, 0 } /* 0x06000001 System.Void UnityEngine.AudioSettings::InvokeOnAudioConfigurationChanged(System.Boolean) */,
	{ 0, 0 } /* 0x06000002 System.Boolean UnityEngine.AudioSettings::StartAudioOutput() */,
	{ 0, 0 } /* 0x06000003 System.Boolean UnityEngine.AudioSettings::StopAudioOutput() */,
	{ 0, 0 } /* 0x06000004 System.Void UnityEngine.AudioSettings/AudioConfigurationChangeHandler::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0 } /* 0x06000005 System.Void UnityEngine.AudioSettings/AudioConfigurationChangeHandler::Invoke(System.Boolean) */,
	{ 0, 0 } /* 0x06000006 System.IAsyncResult UnityEngine.AudioSettings/AudioConfigurationChangeHandler::BeginInvoke(System.Boolean,System.AsyncCallback,System.Object) */,
	{ 0, 0 } /* 0x06000007 System.Void UnityEngine.AudioSettings/AudioConfigurationChangeHandler::EndInvoke(System.IAsyncResult) */,
	{ 0, 0 } /* 0x06000008 System.Boolean UnityEngine.AudioSettings/Mobile::get_muteState() */,
	{ 0, 0 } /* 0x06000009 System.Void UnityEngine.AudioSettings/Mobile::set_muteState(System.Boolean) */,
	{ 0, 0 } /* 0x0600000A System.Boolean UnityEngine.AudioSettings/Mobile::get_stopAudioOutputOnMute() */,
	{ 0, 0 } /* 0x0600000B System.Void UnityEngine.AudioSettings/Mobile::InvokeOnMuteStateChanged(System.Boolean) */,
	{ 0, 0 } /* 0x0600000C System.Void UnityEngine.AudioSettings/Mobile::StartAudioOutput() */,
	{ 0, 0 } /* 0x0600000D System.Void UnityEngine.AudioSettings/Mobile::StopAudioOutput() */,
	{ 0, 0 } /* 0x0600000E System.Void UnityEngine.AudioSettings/Mobile::.cctor() */,
	{ 0, 0 } /* 0x0600000F System.Void UnityEngine.AudioClip::InvokePCMReaderCallback_Internal(System.Single[]) */,
	{ 0, 0 } /* 0x06000010 System.Void UnityEngine.AudioClip::InvokePCMSetPositionCallback_Internal(System.Int32) */,
	{ 0, 0 } /* 0x06000011 System.Void UnityEngine.AudioClip/PCMReaderCallback::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0 } /* 0x06000012 System.Void UnityEngine.AudioClip/PCMReaderCallback::Invoke(System.Single[]) */,
	{ 0, 0 } /* 0x06000013 System.IAsyncResult UnityEngine.AudioClip/PCMReaderCallback::BeginInvoke(System.Single[],System.AsyncCallback,System.Object) */,
	{ 0, 0 } /* 0x06000014 System.Void UnityEngine.AudioClip/PCMReaderCallback::EndInvoke(System.IAsyncResult) */,
	{ 0, 0 } /* 0x06000015 System.Void UnityEngine.AudioClip/PCMSetPositionCallback::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0 } /* 0x06000016 System.Void UnityEngine.AudioClip/PCMSetPositionCallback::Invoke(System.Int32) */,
	{ 0, 0 } /* 0x06000017 System.IAsyncResult UnityEngine.AudioClip/PCMSetPositionCallback::BeginInvoke(System.Int32,System.AsyncCallback,System.Object) */,
	{ 0, 0 } /* 0x06000018 System.Void UnityEngine.AudioClip/PCMSetPositionCallback::EndInvoke(System.IAsyncResult) */,
	{ 0, 0 } /* 0x06000019 System.Void UnityEngine.AudioSource::PlayHelper(UnityEngine.AudioSource,System.UInt64) */,
	{ 0, 0 } /* 0x0600001A System.Void UnityEngine.AudioSource::Stop(System.Boolean) */,
	{ 0, 0 } /* 0x0600001B System.Void UnityEngine.AudioSource::Play() */,
	{ 0, 0 } /* 0x0600001C System.Void UnityEngine.AudioSource::Stop() */,
	{ 0, 0 } /* 0x0600001D System.Void UnityEngine.AudioSource::Pause() */,
	{ 0, 0 } /* 0x0600001E System.Void UnityEngine.AudioSource::set_loop(System.Boolean) */,
	{ 0, 0 } /* 0x0600001F System.Void UnityEngine.AudioSource::set_playOnAwake(System.Boolean) */,
	{ 0, 0 } /* 0x06000020 UnityEngine.Playables.PlayableHandle UnityEngine.Audio.AudioClipPlayable::GetHandle() */,
	{ 0, 0 } /* 0x06000021 System.Boolean UnityEngine.Audio.AudioClipPlayable::Equals(UnityEngine.Audio.AudioClipPlayable) */,
	{ 0, 0 } /* 0x06000022 UnityEngine.Playables.PlayableHandle UnityEngine.Audio.AudioMixerPlayable::GetHandle() */,
	{ 0, 0 } /* 0x06000023 System.Boolean UnityEngine.Audio.AudioMixerPlayable::Equals(UnityEngine.Audio.AudioMixerPlayable) */,
	{ 0, 0 } /* 0x06000024 System.Void UnityEngine.Experimental.Audio.AudioSampleProvider::InvokeSampleFramesAvailable(System.Int32) */,
	{ 0, 0 } /* 0x06000025 System.Void UnityEngine.Experimental.Audio.AudioSampleProvider::InvokeSampleFramesOverflow(System.Int32) */,
	{ 0, 0 } /* 0x06000026 System.Void UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0 } /* 0x06000027 System.Void UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::Invoke(UnityEngine.Experimental.Audio.AudioSampleProvider,System.UInt32) */,
	{ 0, 0 } /* 0x06000028 System.IAsyncResult UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::BeginInvoke(UnityEngine.Experimental.Audio.AudioSampleProvider,System.UInt32,System.AsyncCallback,System.Object) */,
	{ 0, 0 } /* 0x06000029 System.Void UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::EndInvoke(System.IAsyncResult) */,
};
#else
static const Il2CppMethodExecutionContextInfoIndex g_methodExecutionContextInfoIndexes[1] = { { 0, 0} };
#endif
#if IL2CPP_MONO_DEBUGGER
IL2CPP_EXTERN_C Il2CppSequencePoint g_sequencePointsUnityEngine_AudioModule[];
Il2CppSequencePoint g_sequencePointsUnityEngine_AudioModule[132] = 
{
	{ 21406, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 0 } /* seqPointIndex: 0 */,
	{ 21406, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 1 } /* seqPointIndex: 1 */,
	{ 21406, 1, 331, 331, 9, 10, 0, kSequencePointKind_Normal, 0, 2 } /* seqPointIndex: 2 */,
	{ 21406, 1, 332, 332, 13, 53, 1, kSequencePointKind_Normal, 0, 3 } /* seqPointIndex: 3 */,
	{ 21406, 1, 332, 332, 0, 0, 10, kSequencePointKind_Normal, 0, 4 } /* seqPointIndex: 4 */,
	{ 21406, 1, 333, 333, 17, 63, 13, kSequencePointKind_Normal, 0, 5 } /* seqPointIndex: 5 */,
	{ 21406, 1, 334, 334, 9, 10, 25, kSequencePointKind_Normal, 0, 6 } /* seqPointIndex: 6 */,
	{ 21406, 1, 333, 333, 17, 63, 19, kSequencePointKind_StepOut, 0, 7 } /* seqPointIndex: 7 */,
	{ 21413, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 8 } /* seqPointIndex: 8 */,
	{ 21413, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 9 } /* seqPointIndex: 9 */,
	{ 21413, 1, 359, 359, 17, 21, 0, kSequencePointKind_Normal, 0, 10 } /* seqPointIndex: 10 */,
	{ 21414, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 11 } /* seqPointIndex: 11 */,
	{ 21414, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 12 } /* seqPointIndex: 12 */,
	{ 21414, 1, 360, 360, 17, 29, 0, kSequencePointKind_Normal, 0, 13 } /* seqPointIndex: 13 */,
	{ 21415, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 14 } /* seqPointIndex: 14 */,
	{ 21415, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 15 } /* seqPointIndex: 15 */,
	{ 21415, 1, 367, 367, 17, 18, 0, kSequencePointKind_Normal, 0, 16 } /* seqPointIndex: 16 */,
	{ 21415, 1, 368, 368, 21, 51, 1, kSequencePointKind_Normal, 0, 17 } /* seqPointIndex: 17 */,
	{ 21415, 1, 369, 369, 17, 18, 9, kSequencePointKind_Normal, 0, 18 } /* seqPointIndex: 18 */,
	{ 21416, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 19 } /* seqPointIndex: 19 */,
	{ 21416, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 20 } /* seqPointIndex: 20 */,
	{ 21416, 1, 392, 392, 13, 14, 0, kSequencePointKind_Normal, 0, 21 } /* seqPointIndex: 21 */,
	{ 21416, 1, 393, 393, 17, 39, 1, kSequencePointKind_Normal, 0, 22 } /* seqPointIndex: 22 */,
	{ 21416, 1, 393, 393, 0, 0, 13, kSequencePointKind_Normal, 0, 23 } /* seqPointIndex: 23 */,
	{ 21416, 1, 394, 394, 17, 18, 16, kSequencePointKind_Normal, 0, 24 } /* seqPointIndex: 24 */,
	{ 21416, 1, 395, 395, 21, 38, 17, kSequencePointKind_Normal, 0, 25 } /* seqPointIndex: 25 */,
	{ 21416, 1, 396, 396, 21, 47, 24, kSequencePointKind_Normal, 0, 26 } /* seqPointIndex: 26 */,
	{ 21416, 1, 396, 396, 0, 0, 30, kSequencePointKind_Normal, 0, 27 } /* seqPointIndex: 27 */,
	{ 21416, 1, 397, 397, 21, 22, 33, kSequencePointKind_Normal, 0, 28 } /* seqPointIndex: 28 */,
	{ 21416, 1, 398, 398, 25, 39, 34, kSequencePointKind_Normal, 0, 29 } /* seqPointIndex: 29 */,
	{ 21416, 1, 398, 398, 0, 0, 40, kSequencePointKind_Normal, 0, 30 } /* seqPointIndex: 30 */,
	{ 21416, 1, 399, 399, 29, 47, 43, kSequencePointKind_Normal, 0, 31 } /* seqPointIndex: 31 */,
	{ 21416, 1, 401, 401, 29, 48, 51, kSequencePointKind_Normal, 0, 32 } /* seqPointIndex: 32 */,
	{ 21416, 1, 402, 402, 21, 22, 57, kSequencePointKind_Normal, 0, 33 } /* seqPointIndex: 33 */,
	{ 21416, 1, 403, 403, 21, 52, 58, kSequencePointKind_Normal, 0, 34 } /* seqPointIndex: 34 */,
	{ 21416, 1, 403, 403, 0, 0, 67, kSequencePointKind_Normal, 0, 35 } /* seqPointIndex: 35 */,
	{ 21416, 1, 404, 404, 25, 50, 70, kSequencePointKind_Normal, 0, 36 } /* seqPointIndex: 36 */,
	{ 21416, 1, 405, 405, 17, 18, 82, kSequencePointKind_Normal, 0, 37 } /* seqPointIndex: 37 */,
	{ 21416, 1, 406, 406, 13, 14, 83, kSequencePointKind_Normal, 0, 38 } /* seqPointIndex: 38 */,
	{ 21416, 1, 393, 393, 17, 39, 2, kSequencePointKind_StepOut, 0, 39 } /* seqPointIndex: 39 */,
	{ 21416, 1, 395, 395, 21, 38, 18, kSequencePointKind_StepOut, 0, 40 } /* seqPointIndex: 40 */,
	{ 21416, 1, 396, 396, 21, 47, 24, kSequencePointKind_StepOut, 0, 41 } /* seqPointIndex: 41 */,
	{ 21416, 1, 398, 398, 25, 39, 34, kSequencePointKind_StepOut, 0, 42 } /* seqPointIndex: 42 */,
	{ 21416, 1, 399, 399, 29, 47, 43, kSequencePointKind_StepOut, 0, 43 } /* seqPointIndex: 43 */,
	{ 21416, 1, 401, 401, 29, 48, 51, kSequencePointKind_StepOut, 0, 44 } /* seqPointIndex: 44 */,
	{ 21416, 1, 404, 404, 25, 50, 76, kSequencePointKind_StepOut, 0, 45 } /* seqPointIndex: 45 */,
	{ 21417, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 46 } /* seqPointIndex: 46 */,
	{ 21417, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 47 } /* seqPointIndex: 47 */,
	{ 21417, 1, 409, 409, 13, 14, 0, kSequencePointKind_Normal, 0, 48 } /* seqPointIndex: 48 */,
	{ 21417, 1, 410, 410, 17, 50, 1, kSequencePointKind_Normal, 0, 49 } /* seqPointIndex: 49 */,
	{ 21417, 1, 411, 411, 13, 14, 7, kSequencePointKind_Normal, 0, 50 } /* seqPointIndex: 50 */,
	{ 21417, 1, 410, 410, 17, 50, 1, kSequencePointKind_StepOut, 0, 51 } /* seqPointIndex: 51 */,
	{ 21418, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 52 } /* seqPointIndex: 52 */,
	{ 21418, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 53 } /* seqPointIndex: 53 */,
	{ 21418, 1, 414, 414, 13, 14, 0, kSequencePointKind_Normal, 0, 54 } /* seqPointIndex: 54 */,
	{ 21418, 1, 415, 415, 17, 49, 1, kSequencePointKind_Normal, 0, 55 } /* seqPointIndex: 55 */,
	{ 21418, 1, 416, 416, 13, 14, 7, kSequencePointKind_Normal, 0, 56 } /* seqPointIndex: 56 */,
	{ 21418, 1, 415, 415, 17, 49, 1, kSequencePointKind_StepOut, 0, 57 } /* seqPointIndex: 57 */,
	{ 21419, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 58 } /* seqPointIndex: 58 */,
	{ 21419, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 59 } /* seqPointIndex: 59 */,
	{ 21419, 1, 361, 361, 17, 22, 0, kSequencePointKind_Normal, 0, 60 } /* seqPointIndex: 60 */,
	{ 21419, 1, 363, 363, 13, 64, 6, kSequencePointKind_Normal, 0, 61 } /* seqPointIndex: 61 */,
	{ 21420, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 62 } /* seqPointIndex: 62 */,
	{ 21420, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 63 } /* seqPointIndex: 63 */,
	{ 21420, 1, 606, 606, 9, 10, 0, kSequencePointKind_Normal, 0, 64 } /* seqPointIndex: 64 */,
	{ 21420, 1, 607, 607, 13, 45, 1, kSequencePointKind_Normal, 0, 65 } /* seqPointIndex: 65 */,
	{ 21420, 1, 607, 607, 0, 0, 11, kSequencePointKind_Normal, 0, 66 } /* seqPointIndex: 66 */,
	{ 21420, 1, 608, 608, 17, 43, 14, kSequencePointKind_Normal, 0, 67 } /* seqPointIndex: 67 */,
	{ 21420, 1, 609, 609, 9, 10, 27, kSequencePointKind_Normal, 0, 68 } /* seqPointIndex: 68 */,
	{ 21420, 1, 608, 608, 17, 43, 21, kSequencePointKind_StepOut, 0, 69 } /* seqPointIndex: 69 */,
	{ 21421, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 70 } /* seqPointIndex: 70 */,
	{ 21421, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 71 } /* seqPointIndex: 71 */,
	{ 21421, 1, 613, 613, 9, 10, 0, kSequencePointKind_Normal, 0, 72 } /* seqPointIndex: 72 */,
	{ 21421, 1, 614, 614, 13, 50, 1, kSequencePointKind_Normal, 0, 73 } /* seqPointIndex: 73 */,
	{ 21421, 1, 614, 614, 0, 0, 11, kSequencePointKind_Normal, 0, 74 } /* seqPointIndex: 74 */,
	{ 21421, 1, 615, 615, 17, 52, 14, kSequencePointKind_Normal, 0, 75 } /* seqPointIndex: 75 */,
	{ 21421, 1, 616, 616, 9, 10, 27, kSequencePointKind_Normal, 0, 76 } /* seqPointIndex: 76 */,
	{ 21421, 1, 615, 615, 17, 52, 21, kSequencePointKind_StepOut, 0, 77 } /* seqPointIndex: 77 */,
	{ 21432, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 78 } /* seqPointIndex: 78 */,
	{ 21432, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 79 } /* seqPointIndex: 79 */,
	{ 21432, 1, 819, 819, 9, 10, 0, kSequencePointKind_Normal, 0, 80 } /* seqPointIndex: 80 */,
	{ 21432, 1, 820, 820, 13, 33, 1, kSequencePointKind_Normal, 0, 81 } /* seqPointIndex: 81 */,
	{ 21432, 1, 821, 821, 9, 10, 10, kSequencePointKind_Normal, 0, 82 } /* seqPointIndex: 82 */,
	{ 21432, 1, 820, 820, 13, 33, 4, kSequencePointKind_StepOut, 0, 83 } /* seqPointIndex: 83 */,
	{ 21433, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 84 } /* seqPointIndex: 84 */,
	{ 21433, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 85 } /* seqPointIndex: 85 */,
	{ 21433, 1, 863, 863, 9, 10, 0, kSequencePointKind_Normal, 0, 86 } /* seqPointIndex: 86 */,
	{ 21433, 1, 864, 864, 13, 24, 1, kSequencePointKind_Normal, 0, 87 } /* seqPointIndex: 87 */,
	{ 21433, 1, 865, 865, 9, 10, 9, kSequencePointKind_Normal, 0, 88 } /* seqPointIndex: 88 */,
	{ 21433, 1, 864, 864, 13, 24, 3, kSequencePointKind_StepOut, 0, 89 } /* seqPointIndex: 89 */,
	{ 21437, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 90 } /* seqPointIndex: 90 */,
	{ 21437, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 91 } /* seqPointIndex: 91 */,
	{ 21437, 2, 49, 49, 9, 10, 0, kSequencePointKind_Normal, 0, 92 } /* seqPointIndex: 92 */,
	{ 21437, 2, 50, 50, 13, 29, 1, kSequencePointKind_Normal, 0, 93 } /* seqPointIndex: 93 */,
	{ 21437, 2, 51, 51, 9, 10, 10, kSequencePointKind_Normal, 0, 94 } /* seqPointIndex: 94 */,
	{ 21438, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 95 } /* seqPointIndex: 95 */,
	{ 21438, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 96 } /* seqPointIndex: 96 */,
	{ 21438, 2, 64, 64, 9, 10, 0, kSequencePointKind_Normal, 0, 97 } /* seqPointIndex: 97 */,
	{ 21438, 2, 65, 65, 13, 53, 1, kSequencePointKind_Normal, 0, 98 } /* seqPointIndex: 98 */,
	{ 21438, 2, 66, 66, 9, 10, 22, kSequencePointKind_Normal, 0, 99 } /* seqPointIndex: 99 */,
	{ 21438, 2, 65, 65, 13, 53, 2, kSequencePointKind_StepOut, 0, 100 } /* seqPointIndex: 100 */,
	{ 21438, 2, 65, 65, 13, 53, 9, kSequencePointKind_StepOut, 0, 101 } /* seqPointIndex: 101 */,
	{ 21438, 2, 65, 65, 13, 53, 14, kSequencePointKind_StepOut, 0, 102 } /* seqPointIndex: 102 */,
	{ 21439, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 103 } /* seqPointIndex: 103 */,
	{ 21439, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 104 } /* seqPointIndex: 104 */,
	{ 21439, 3, 47, 47, 9, 10, 0, kSequencePointKind_Normal, 0, 105 } /* seqPointIndex: 105 */,
	{ 21439, 3, 48, 48, 13, 29, 1, kSequencePointKind_Normal, 0, 106 } /* seqPointIndex: 106 */,
	{ 21439, 3, 49, 49, 9, 10, 10, kSequencePointKind_Normal, 0, 107 } /* seqPointIndex: 107 */,
	{ 21440, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 108 } /* seqPointIndex: 108 */,
	{ 21440, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 109 } /* seqPointIndex: 109 */,
	{ 21440, 3, 62, 62, 9, 10, 0, kSequencePointKind_Normal, 0, 110 } /* seqPointIndex: 110 */,
	{ 21440, 3, 63, 63, 13, 53, 1, kSequencePointKind_Normal, 0, 111 } /* seqPointIndex: 111 */,
	{ 21440, 3, 64, 64, 9, 10, 22, kSequencePointKind_Normal, 0, 112 } /* seqPointIndex: 112 */,
	{ 21440, 3, 63, 63, 13, 53, 2, kSequencePointKind_StepOut, 0, 113 } /* seqPointIndex: 113 */,
	{ 21440, 3, 63, 63, 13, 53, 9, kSequencePointKind_StepOut, 0, 114 } /* seqPointIndex: 114 */,
	{ 21440, 3, 63, 63, 13, 53, 14, kSequencePointKind_StepOut, 0, 115 } /* seqPointIndex: 115 */,
	{ 21441, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 116 } /* seqPointIndex: 116 */,
	{ 21441, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 117 } /* seqPointIndex: 117 */,
	{ 21441, 4, 177, 177, 9, 10, 0, kSequencePointKind_Normal, 0, 118 } /* seqPointIndex: 118 */,
	{ 21441, 4, 178, 178, 13, 47, 1, kSequencePointKind_Normal, 0, 119 } /* seqPointIndex: 119 */,
	{ 21441, 4, 178, 178, 0, 0, 11, kSequencePointKind_Normal, 0, 120 } /* seqPointIndex: 120 */,
	{ 21441, 4, 180, 180, 17, 69, 14, kSequencePointKind_Normal, 0, 121 } /* seqPointIndex: 121 */,
	{ 21441, 4, 181, 181, 9, 10, 28, kSequencePointKind_Normal, 0, 122 } /* seqPointIndex: 122 */,
	{ 21441, 4, 180, 180, 17, 69, 22, kSequencePointKind_StepOut, 0, 123 } /* seqPointIndex: 123 */,
	{ 21442, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 124 } /* seqPointIndex: 124 */,
	{ 21442, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 125 } /* seqPointIndex: 125 */,
	{ 21442, 4, 185, 185, 9, 10, 0, kSequencePointKind_Normal, 0, 126 } /* seqPointIndex: 126 */,
	{ 21442, 4, 186, 186, 13, 46, 1, kSequencePointKind_Normal, 0, 127 } /* seqPointIndex: 127 */,
	{ 21442, 4, 186, 186, 0, 0, 11, kSequencePointKind_Normal, 0, 128 } /* seqPointIndex: 128 */,
	{ 21442, 4, 187, 187, 17, 75, 14, kSequencePointKind_Normal, 0, 129 } /* seqPointIndex: 129 */,
	{ 21442, 4, 188, 188, 9, 10, 28, kSequencePointKind_Normal, 0, 130 } /* seqPointIndex: 130 */,
	{ 21442, 4, 187, 187, 17, 75, 22, kSequencePointKind_StepOut, 0, 131 } /* seqPointIndex: 131 */,
};
#else
extern Il2CppSequencePoint g_sequencePointsUnityEngine_AudioModule[];
Il2CppSequencePoint g_sequencePointsUnityEngine_AudioModule[1] = { { 0, 0, 0, 0, 0, 0, 0, kSequencePointKind_Normal, 0, 0, } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppCatchPoint g_catchPoints[1] = { { 0, 0, 0, 0, } };
#else
static const Il2CppCatchPoint g_catchPoints[1] = { { 0, 0, 0, 0, } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppSequencePointSourceFile g_sequencePointSourceFiles[] = {
{ "", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //0 
{ "/Users/bokken/buildslave/unity/build/Modules/Audio/Public/ScriptBindings/Audio.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //1 
{ "/Users/bokken/buildslave/unity/build/Modules/Audio/Public/ScriptBindings/AudioClipPlayable.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //2 
{ "/Users/bokken/buildslave/unity/build/Modules/Audio/Public/ScriptBindings/AudioMixerPlayable.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //3 
{ "/Users/bokken/buildslave/unity/build/Modules/Audio/Public/ScriptBindings/AudioSampleProvider.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //4 
};
#else
static const Il2CppSequencePointSourceFile g_sequencePointSourceFiles[1] = { NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppTypeSourceFilePair g_typeSourceFiles[7] = 
{
	{ 3489, 1 },
	{ 3488, 1 },
	{ 3492, 1 },
	{ 3495, 1 },
	{ 3496, 2 },
	{ 3497, 3 },
	{ 3500, 4 },
};
#else
static const Il2CppTypeSourceFilePair g_typeSourceFiles[1] = { { 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodScope g_methodScopes[11] = 
{
	{ 0, 26 },
	{ 0, 11 },
	{ 0, 84 },
	{ 0, 28 },
	{ 0, 28 },
	{ 0, 12 },
	{ 0, 24 },
	{ 0, 12 },
	{ 0, 24 },
	{ 0, 29 },
	{ 0, 29 },
};
#else
static const Il2CppMethodScope g_methodScopes[1] = { { 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodHeaderInfo g_methodHeaderInfos[41] = 
{
	{ 26, 0, 1 } /* System.Void UnityEngine.AudioSettings::InvokeOnAudioConfigurationChanged(System.Boolean) */,
	{ 0, 0, 0 } /* System.Boolean UnityEngine.AudioSettings::StartAudioOutput() */,
	{ 0, 0, 0 } /* System.Boolean UnityEngine.AudioSettings::StopAudioOutput() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSettings/AudioConfigurationChangeHandler::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSettings/AudioConfigurationChangeHandler::Invoke(System.Boolean) */,
	{ 0, 0, 0 } /* System.IAsyncResult UnityEngine.AudioSettings/AudioConfigurationChangeHandler::BeginInvoke(System.Boolean,System.AsyncCallback,System.Object) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSettings/AudioConfigurationChangeHandler::EndInvoke(System.IAsyncResult) */,
	{ 0, 0, 0 } /* System.Boolean UnityEngine.AudioSettings/Mobile::get_muteState() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSettings/Mobile::set_muteState(System.Boolean) */,
	{ 11, 1, 1 } /* System.Boolean UnityEngine.AudioSettings/Mobile::get_stopAudioOutputOnMute() */,
	{ 84, 2, 1 } /* System.Void UnityEngine.AudioSettings/Mobile::InvokeOnMuteStateChanged(System.Boolean) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSettings/Mobile::StartAudioOutput() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSettings/Mobile::StopAudioOutput() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSettings/Mobile::.cctor() */,
	{ 28, 3, 1 } /* System.Void UnityEngine.AudioClip::InvokePCMReaderCallback_Internal(System.Single[]) */,
	{ 28, 4, 1 } /* System.Void UnityEngine.AudioClip::InvokePCMSetPositionCallback_Internal(System.Int32) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioClip/PCMReaderCallback::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioClip/PCMReaderCallback::Invoke(System.Single[]) */,
	{ 0, 0, 0 } /* System.IAsyncResult UnityEngine.AudioClip/PCMReaderCallback::BeginInvoke(System.Single[],System.AsyncCallback,System.Object) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioClip/PCMReaderCallback::EndInvoke(System.IAsyncResult) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioClip/PCMSetPositionCallback::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioClip/PCMSetPositionCallback::Invoke(System.Int32) */,
	{ 0, 0, 0 } /* System.IAsyncResult UnityEngine.AudioClip/PCMSetPositionCallback::BeginInvoke(System.Int32,System.AsyncCallback,System.Object) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioClip/PCMSetPositionCallback::EndInvoke(System.IAsyncResult) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSource::PlayHelper(UnityEngine.AudioSource,System.UInt64) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSource::Stop(System.Boolean) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSource::Play() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSource::Stop() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSource::Pause() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSource::set_loop(System.Boolean) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.AudioSource::set_playOnAwake(System.Boolean) */,
	{ 12, 5, 1 } /* UnityEngine.Playables.PlayableHandle UnityEngine.Audio.AudioClipPlayable::GetHandle() */,
	{ 24, 6, 1 } /* System.Boolean UnityEngine.Audio.AudioClipPlayable::Equals(UnityEngine.Audio.AudioClipPlayable) */,
	{ 12, 7, 1 } /* UnityEngine.Playables.PlayableHandle UnityEngine.Audio.AudioMixerPlayable::GetHandle() */,
	{ 24, 8, 1 } /* System.Boolean UnityEngine.Audio.AudioMixerPlayable::Equals(UnityEngine.Audio.AudioMixerPlayable) */,
	{ 29, 9, 1 } /* System.Void UnityEngine.Experimental.Audio.AudioSampleProvider::InvokeSampleFramesAvailable(System.Int32) */,
	{ 29, 10, 1 } /* System.Void UnityEngine.Experimental.Audio.AudioSampleProvider::InvokeSampleFramesOverflow(System.Int32) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::.ctor(System.Object,System.IntPtr) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::Invoke(UnityEngine.Experimental.Audio.AudioSampleProvider,System.UInt32) */,
	{ 0, 0, 0 } /* System.IAsyncResult UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::BeginInvoke(UnityEngine.Experimental.Audio.AudioSampleProvider,System.UInt32,System.AsyncCallback,System.Object) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.Experimental.Audio.AudioSampleProvider/SampleFramesHandler::EndInvoke(System.IAsyncResult) */,
};
#else
static const Il2CppMethodHeaderInfo g_methodHeaderInfos[1] = { { 0, 0, 0 } };
#endif
IL2CPP_EXTERN_C const Il2CppDebuggerMetadataRegistration g_DebuggerMetadataRegistrationUnityEngine_AudioModule;
const Il2CppDebuggerMetadataRegistration g_DebuggerMetadataRegistrationUnityEngine_AudioModule = 
{
	(Il2CppMethodExecutionContextInfo*)g_methodExecutionContextInfos,
	(Il2CppMethodExecutionContextInfoIndex*)g_methodExecutionContextInfoIndexes,
	(Il2CppMethodScope*)g_methodScopes,
	(Il2CppMethodHeaderInfo*)g_methodHeaderInfos,
	(Il2CppSequencePointSourceFile*)g_sequencePointSourceFiles,
	132,
	(Il2CppSequencePoint*)g_sequencePointsUnityEngine_AudioModule,
	0,
	(Il2CppCatchPoint*)g_catchPoints,
	7,
	(Il2CppTypeSourceFilePair*)g_typeSourceFiles,
	(const char**)g_methodExecutionContextInfoStrings,
};
