﻿#include "pch-c.h"
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
static const Il2CppMethodExecutionContextInfoIndex g_methodExecutionContextInfoIndexes[15] = 
{
	{ 0, 0 } /* 0x06000001 System.Boolean UnityEngine.XR.XRSettings::get_enabled() */,
	{ 0, 0 } /* 0x06000002 System.Boolean UnityEngine.XR.XRSettings::get_isDeviceActive() */,
	{ 0, 0 } /* 0x06000003 System.Single UnityEngine.XR.XRSettings::get_eyeTextureResolutionScale() */,
	{ 0, 0 } /* 0x06000004 System.Void UnityEngine.XR.XRSettings::set_eyeTextureResolutionScale(System.Single) */,
	{ 0, 0 } /* 0x06000005 System.Int32 UnityEngine.XR.XRSettings::get_eyeTextureWidth() */,
	{ 0, 0 } /* 0x06000006 System.Int32 UnityEngine.XR.XRSettings::get_eyeTextureHeight() */,
	{ 0, 0 } /* 0x06000007 UnityEngine.RenderTextureDescriptor UnityEngine.XR.XRSettings::get_eyeTextureDesc() */,
	{ 0, 0 } /* 0x06000008 System.Single UnityEngine.XR.XRSettings::get_renderViewportScale() */,
	{ 0, 0 } /* 0x06000009 System.Single UnityEngine.XR.XRSettings::get_renderViewportScaleInternal() */,
	{ 0, 0 } /* 0x0600000A System.String UnityEngine.XR.XRSettings::get_loadedDeviceName() */,
	{ 0, 0 } /* 0x0600000B System.String[] UnityEngine.XR.XRSettings::get_supportedDevices() */,
	{ 0, 0 } /* 0x0600000C UnityEngine.XR.XRSettings/StereoRenderingMode UnityEngine.XR.XRSettings::get_stereoRenderingMode() */,
	{ 0, 0 } /* 0x0600000D System.Void UnityEngine.XR.XRSettings::get_eyeTextureDesc_Injected(UnityEngine.RenderTextureDescriptor&) */,
	{ 0, 0 } /* 0x0600000E System.Void UnityEngine.XR.XRDevice::InvokeDeviceLoaded(System.String) */,
	{ 0, 0 } /* 0x0600000F System.Void UnityEngine.XR.XRDevice::.cctor() */,
};
#else
static const Il2CppMethodExecutionContextInfoIndex g_methodExecutionContextInfoIndexes[1] = { { 0, 0} };
#endif
#if IL2CPP_MONO_DEBUGGER
IL2CPP_EXTERN_C Il2CppSequencePoint g_sequencePointsUnityEngine_VRModule[];
Il2CppSequencePoint g_sequencePointsUnityEngine_VRModule[19] = 
{
	{ 19074, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 0 } /* seqPointIndex: 0 */,
	{ 19074, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 1 } /* seqPointIndex: 1 */,
	{ 19074, 1, 110, 110, 13, 14, 0, kSequencePointKind_Normal, 0, 2 } /* seqPointIndex: 2 */,
	{ 19074, 1, 111, 111, 17, 52, 1, kSequencePointKind_Normal, 0, 3 } /* seqPointIndex: 3 */,
	{ 19074, 1, 112, 112, 13, 14, 9, kSequencePointKind_Normal, 0, 4 } /* seqPointIndex: 4 */,
	{ 19074, 1, 111, 111, 17, 52, 1, kSequencePointKind_StepOut, 0, 5 } /* seqPointIndex: 5 */,
	{ 19080, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 6 } /* seqPointIndex: 6 */,
	{ 19080, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 7 } /* seqPointIndex: 7 */,
	{ 19080, 1, 206, 206, 9, 10, 0, kSequencePointKind_Normal, 0, 8 } /* seqPointIndex: 8 */,
	{ 19080, 1, 207, 207, 13, 38, 1, kSequencePointKind_Normal, 0, 9 } /* seqPointIndex: 9 */,
	{ 19080, 1, 207, 207, 0, 0, 10, kSequencePointKind_Normal, 0, 10 } /* seqPointIndex: 10 */,
	{ 19080, 1, 208, 208, 13, 14, 13, kSequencePointKind_Normal, 0, 11 } /* seqPointIndex: 11 */,
	{ 19080, 1, 209, 209, 17, 48, 14, kSequencePointKind_Normal, 0, 12 } /* seqPointIndex: 12 */,
	{ 19080, 1, 210, 210, 13, 14, 26, kSequencePointKind_Normal, 0, 13 } /* seqPointIndex: 13 */,
	{ 19080, 1, 211, 211, 9, 10, 27, kSequencePointKind_Normal, 0, 14 } /* seqPointIndex: 14 */,
	{ 19080, 1, 209, 209, 17, 48, 20, kSequencePointKind_StepOut, 0, 15 } /* seqPointIndex: 15 */,
	{ 19081, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 16 } /* seqPointIndex: 16 */,
	{ 19081, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 17 } /* seqPointIndex: 17 */,
	{ 19081, 1, 202, 202, 9, 64, 0, kSequencePointKind_Normal, 0, 18 } /* seqPointIndex: 18 */,
};
#else
extern Il2CppSequencePoint g_sequencePointsUnityEngine_VRModule[];
Il2CppSequencePoint g_sequencePointsUnityEngine_VRModule[1] = { { 0, 0, 0, 0, 0, 0, 0, kSequencePointKind_Normal, 0, 0, } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppCatchPoint g_catchPoints[1] = { { 0, 0, 0, 0, } };
#else
static const Il2CppCatchPoint g_catchPoints[1] = { { 0, 0, 0, 0, } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppSequencePointSourceFile g_sequencePointSourceFiles[] = {
{ "", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //0 
{ "/Users/bokken/buildslave/unity/build/Modules/VR/ScriptBindings/XR.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //1 
};
#else
static const Il2CppSequencePointSourceFile g_sequencePointSourceFiles[1] = { NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppTypeSourceFilePair g_typeSourceFiles[2] = 
{
	{ 3092, 1 },
	{ 3093, 1 },
};
#else
static const Il2CppTypeSourceFilePair g_typeSourceFiles[1] = { { 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodScope g_methodScopes[2] = 
{
	{ 0, 11 },
	{ 0, 28 },
};
#else
static const Il2CppMethodScope g_methodScopes[1] = { { 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodHeaderInfo g_methodHeaderInfos[15] = 
{
	{ 0, 0, 0 } /* System.Boolean UnityEngine.XR.XRSettings::get_enabled() */,
	{ 0, 0, 0 } /* System.Boolean UnityEngine.XR.XRSettings::get_isDeviceActive() */,
	{ 0, 0, 0 } /* System.Single UnityEngine.XR.XRSettings::get_eyeTextureResolutionScale() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.XR.XRSettings::set_eyeTextureResolutionScale(System.Single) */,
	{ 0, 0, 0 } /* System.Int32 UnityEngine.XR.XRSettings::get_eyeTextureWidth() */,
	{ 0, 0, 0 } /* System.Int32 UnityEngine.XR.XRSettings::get_eyeTextureHeight() */,
	{ 0, 0, 0 } /* UnityEngine.RenderTextureDescriptor UnityEngine.XR.XRSettings::get_eyeTextureDesc() */,
	{ 11, 0, 1 } /* System.Single UnityEngine.XR.XRSettings::get_renderViewportScale() */,
	{ 0, 0, 0 } /* System.Single UnityEngine.XR.XRSettings::get_renderViewportScaleInternal() */,
	{ 0, 0, 0 } /* System.String UnityEngine.XR.XRSettings::get_loadedDeviceName() */,
	{ 0, 0, 0 } /* System.String[] UnityEngine.XR.XRSettings::get_supportedDevices() */,
	{ 0, 0, 0 } /* UnityEngine.XR.XRSettings/StereoRenderingMode UnityEngine.XR.XRSettings::get_stereoRenderingMode() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.XR.XRSettings::get_eyeTextureDesc_Injected(UnityEngine.RenderTextureDescriptor&) */,
	{ 28, 1, 1 } /* System.Void UnityEngine.XR.XRDevice::InvokeDeviceLoaded(System.String) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.XR.XRDevice::.cctor() */,
};
#else
static const Il2CppMethodHeaderInfo g_methodHeaderInfos[1] = { { 0, 0, 0 } };
#endif
IL2CPP_EXTERN_C const Il2CppDebuggerMetadataRegistration g_DebuggerMetadataRegistrationUnityEngine_VRModule;
const Il2CppDebuggerMetadataRegistration g_DebuggerMetadataRegistrationUnityEngine_VRModule = 
{
	(Il2CppMethodExecutionContextInfo*)g_methodExecutionContextInfos,
	(Il2CppMethodExecutionContextInfoIndex*)g_methodExecutionContextInfoIndexes,
	(Il2CppMethodScope*)g_methodScopes,
	(Il2CppMethodHeaderInfo*)g_methodHeaderInfos,
	(Il2CppSequencePointSourceFile*)g_sequencePointSourceFiles,
	19,
	(Il2CppSequencePoint*)g_sequencePointsUnityEngine_VRModule,
	0,
	(Il2CppCatchPoint*)g_catchPoints,
	2,
	(Il2CppTypeSourceFilePair*)g_typeSourceFiles,
	(const char**)g_methodExecutionContextInfoStrings,
};
