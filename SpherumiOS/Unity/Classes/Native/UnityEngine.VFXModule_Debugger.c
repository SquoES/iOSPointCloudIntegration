﻿#include "pch-c.h"
#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif


#include "codegen/il2cpp-codegen-metadata.h"





#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodExecutionContextInfo g_methodExecutionContextInfos[5] = 
{
	{ 8847, 0,  0 } /*tableIndex: 0 */,
	{ 8850, 1,  2 } /*tableIndex: 1 */,
	{ 8855, 2,  3 } /*tableIndex: 2 */,
	{ 8847, 3,  6 } /*tableIndex: 3 */,
	{ 8852, 4,  11 } /*tableIndex: 4 */,
};
#else
static const Il2CppMethodExecutionContextInfo g_methodExecutionContextInfos[1] = { { 0, 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const char* g_methodExecutionContextInfoStrings[5] = 
{
	"eventAttribute",
	"expressionValue",
	"spawnerState",
	"vfxEventAttribute",
	"evt",
};
#else
static const char* g_methodExecutionContextInfoStrings[1] = { NULL };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodExecutionContextInfoIndex g_methodExecutionContextInfoIndexes[49] = 
{
	{ 0, 0 } /* 0x06000001 System.Void UnityEngine.VFX.VFXEventAttribute::.ctor(System.IntPtr,System.Boolean,UnityEngine.VFX.VisualEffectAsset) */,
	{ 0, 0 } /* 0x06000002 System.IntPtr UnityEngine.VFX.VFXEventAttribute::Internal_Create() */,
	{ 0, 1 } /* 0x06000003 UnityEngine.VFX.VFXEventAttribute UnityEngine.VFX.VFXEventAttribute::Internal_InstanciateVFXEventAttribute(UnityEngine.VFX.VisualEffectAsset) */,
	{ 0, 0 } /* 0x06000004 System.Void UnityEngine.VFX.VFXEventAttribute::Internal_InitFromAsset(UnityEngine.VFX.VisualEffectAsset) */,
	{ 0, 0 } /* 0x06000005 System.Void UnityEngine.VFX.VFXEventAttribute::Release() */,
	{ 0, 0 } /* 0x06000006 System.Void UnityEngine.VFX.VFXEventAttribute::Finalize() */,
	{ 0, 0 } /* 0x06000007 System.Void UnityEngine.VFX.VFXEventAttribute::Dispose() */,
	{ 0, 0 } /* 0x06000008 System.Void UnityEngine.VFX.VFXEventAttribute::Internal_Destroy(System.IntPtr) */,
	{ 0, 0 } /* 0x06000009 System.Void UnityEngine.VFX.VFXExpressionValues::.ctor() */,
	{ 1, 1 } /* 0x0600000A UnityEngine.VFX.VFXExpressionValues UnityEngine.VFX.VFXExpressionValues::CreateExpressionValuesWrapper(System.IntPtr) */,
	{ 0, 0 } /* 0x0600000B System.Void UnityEngine.VFX.VFXManager::PrepareCamera(UnityEngine.Camera) */,
	{ 0, 0 } /* 0x0600000C System.Void UnityEngine.VFX.VFXManager::ProcessCameraCommand(UnityEngine.Camera,UnityEngine.Rendering.CommandBuffer) */,
	{ 0, 0 } /* 0x0600000D System.Void UnityEngine.VFX.VFXSpawnerCallbacks::OnPlay(UnityEngine.VFX.VFXSpawnerState,UnityEngine.VFX.VFXExpressionValues,UnityEngine.VFX.VisualEffect) */,
	{ 0, 0 } /* 0x0600000E System.Void UnityEngine.VFX.VFXSpawnerCallbacks::OnUpdate(UnityEngine.VFX.VFXSpawnerState,UnityEngine.VFX.VFXExpressionValues,UnityEngine.VFX.VisualEffect) */,
	{ 0, 0 } /* 0x0600000F System.Void UnityEngine.VFX.VFXSpawnerCallbacks::OnStop(UnityEngine.VFX.VFXSpawnerState,UnityEngine.VFX.VFXExpressionValues,UnityEngine.VFX.VisualEffect) */,
	{ 0, 0 } /* 0x06000010 System.Void UnityEngine.VFX.VFXSpawnerCallbacks::.ctor() */,
	{ 0, 0 } /* 0x06000011 System.Void UnityEngine.VFX.VFXSpawnerState::.ctor(System.IntPtr,System.Boolean) */,
	{ 2, 1 } /* 0x06000012 UnityEngine.VFX.VFXSpawnerState UnityEngine.VFX.VFXSpawnerState::CreateSpawnerStateWrapper() */,
	{ 0, 0 } /* 0x06000013 System.Void UnityEngine.VFX.VFXSpawnerState::SetWrapValue(System.IntPtr) */,
	{ 0, 0 } /* 0x06000014 System.Void UnityEngine.VFX.VFXSpawnerState::Release() */,
	{ 0, 0 } /* 0x06000015 System.Void UnityEngine.VFX.VFXSpawnerState::Finalize() */,
	{ 0, 0 } /* 0x06000016 System.Void UnityEngine.VFX.VFXSpawnerState::Dispose() */,
	{ 0, 0 } /* 0x06000017 System.Void UnityEngine.VFX.VFXSpawnerState::Internal_Destroy(System.IntPtr) */,
	{ 0, 0 } /* 0x06000018 System.Void UnityEngine.VFX.VisualEffectObject::.ctor() */,
	{ 0, 0 } /* 0x06000019 System.Void UnityEngine.VFX.VisualEffectAsset::.ctor() */,
	{ 0, 0 } /* 0x0600001A System.Void UnityEngine.VFX.VisualEffectAsset::.cctor() */,
	{ 0, 0 } /* 0x0600001B System.Void UnityEngine.VFX.VFXOutputEventArgs::.ctor(System.Int32,UnityEngine.VFX.VFXEventAttribute) */,
	{ 0, 0 } /* 0x0600001C UnityEngine.VFX.VisualEffectAsset UnityEngine.VFX.VisualEffect::get_visualEffectAsset() */,
	{ 3, 1 } /* 0x0600001D UnityEngine.VFX.VFXEventAttribute UnityEngine.VFX.VisualEffect::CreateVFXEventAttribute() */,
	{ 0, 0 } /* 0x0600001E System.Void UnityEngine.VFX.VisualEffect::SendEventFromScript(System.Int32,UnityEngine.VFX.VFXEventAttribute) */,
	{ 0, 0 } /* 0x0600001F System.Void UnityEngine.VFX.VisualEffect::SendEvent(System.Int32) */,
	{ 0, 0 } /* 0x06000020 System.Void UnityEngine.VFX.VisualEffect::Play() */,
	{ 0, 0 } /* 0x06000021 System.Void UnityEngine.VFX.VisualEffect::Reinit() */,
	{ 0, 0 } /* 0x06000022 System.Boolean UnityEngine.VFX.VisualEffect::HasUInt(System.Int32) */,
	{ 0, 0 } /* 0x06000023 System.Boolean UnityEngine.VFX.VisualEffect::HasFloat(System.Int32) */,
	{ 0, 0 } /* 0x06000024 System.Boolean UnityEngine.VFX.VisualEffect::HasTexture(System.Int32) */,
	{ 0, 0 } /* 0x06000025 System.Void UnityEngine.VFX.VisualEffect::SetBool(System.Int32,System.Boolean) */,
	{ 0, 0 } /* 0x06000026 System.Void UnityEngine.VFX.VisualEffect::SetUInt(System.Int32,System.UInt32) */,
	{ 0, 0 } /* 0x06000027 System.Void UnityEngine.VFX.VisualEffect::SetFloat(System.Int32,System.Single) */,
	{ 0, 0 } /* 0x06000028 System.Void UnityEngine.VFX.VisualEffect::SetTexture(System.Int32,UnityEngine.Texture) */,
	{ 0, 0 } /* 0x06000029 System.Boolean UnityEngine.VFX.VisualEffect::HasUInt(System.String) */,
	{ 0, 0 } /* 0x0600002A System.Boolean UnityEngine.VFX.VisualEffect::HasFloat(System.String) */,
	{ 0, 0 } /* 0x0600002B System.Boolean UnityEngine.VFX.VisualEffect::HasTexture(System.String) */,
	{ 0, 0 } /* 0x0600002C System.Void UnityEngine.VFX.VisualEffect::SetUInt(System.String,System.UInt32) */,
	{ 0, 0 } /* 0x0600002D System.Void UnityEngine.VFX.VisualEffect::SetFloat(System.String,System.Single) */,
	{ 0, 0 } /* 0x0600002E System.Void UnityEngine.VFX.VisualEffect::SetTexture(System.String,UnityEngine.Texture) */,
	{ 0, 0 } /* 0x0600002F System.Void UnityEngine.VFX.VisualEffect::SetBool(System.String,System.Boolean) */,
	{ 0, 0 } /* 0x06000030 UnityEngine.VFX.VFXEventAttribute UnityEngine.VFX.VisualEffect::InvokeGetCachedEventAttributeForOutputEvent_Internal(UnityEngine.VFX.VisualEffect) */,
	{ 4, 1 } /* 0x06000031 System.Void UnityEngine.VFX.VisualEffect::InvokeOutputEventReceived_Internal(UnityEngine.VFX.VisualEffect,System.Int32) */,
};
#else
static const Il2CppMethodExecutionContextInfoIndex g_methodExecutionContextInfoIndexes[1] = { { 0, 0} };
#endif
#if IL2CPP_MONO_DEBUGGER
IL2CPP_EXTERN_C Il2CppSequencePoint g_sequencePointsUnityEngine_VFXModule[];
Il2CppSequencePoint g_sequencePointsUnityEngine_VFXModule[223] = 
{
	{ 21638, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 0 } /* seqPointIndex: 0 */,
	{ 21638, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 1 } /* seqPointIndex: 1 */,
	{ 21638, 1, 16, 16, 9, 86, 0, kSequencePointKind_Normal, 0, 2 } /* seqPointIndex: 2 */,
	{ 21638, 1, 17, 17, 9, 10, 7, kSequencePointKind_Normal, 0, 3 } /* seqPointIndex: 3 */,
	{ 21638, 1, 18, 18, 13, 25, 8, kSequencePointKind_Normal, 0, 4 } /* seqPointIndex: 4 */,
	{ 21638, 1, 19, 19, 13, 29, 15, kSequencePointKind_Normal, 0, 5 } /* seqPointIndex: 5 */,
	{ 21638, 1, 20, 20, 13, 35, 22, kSequencePointKind_Normal, 0, 6 } /* seqPointIndex: 6 */,
	{ 21638, 1, 21, 21, 9, 10, 29, kSequencePointKind_Normal, 0, 7 } /* seqPointIndex: 7 */,
	{ 21638, 1, 16, 16, 9, 86, 1, kSequencePointKind_StepOut, 0, 8 } /* seqPointIndex: 8 */,
	{ 21640, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 9 } /* seqPointIndex: 9 */,
	{ 21640, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 10 } /* seqPointIndex: 10 */,
	{ 21640, 1, 39, 39, 9, 10, 0, kSequencePointKind_Normal, 0, 11 } /* seqPointIndex: 11 */,
	{ 21640, 1, 40, 40, 13, 91, 1, kSequencePointKind_Normal, 0, 12 } /* seqPointIndex: 12 */,
	{ 21640, 1, 41, 41, 13, 61, 14, kSequencePointKind_Normal, 0, 13 } /* seqPointIndex: 13 */,
	{ 21640, 1, 42, 42, 13, 35, 22, kSequencePointKind_Normal, 0, 14 } /* seqPointIndex: 14 */,
	{ 21640, 1, 43, 43, 9, 10, 26, kSequencePointKind_Normal, 0, 15 } /* seqPointIndex: 15 */,
	{ 21640, 1, 40, 40, 13, 91, 1, kSequencePointKind_StepOut, 0, 16 } /* seqPointIndex: 16 */,
	{ 21640, 1, 40, 40, 13, 91, 8, kSequencePointKind_StepOut, 0, 17 } /* seqPointIndex: 17 */,
	{ 21640, 1, 41, 41, 13, 61, 16, kSequencePointKind_StepOut, 0, 18 } /* seqPointIndex: 18 */,
	{ 21642, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 19 } /* seqPointIndex: 19 */,
	{ 21642, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 20 } /* seqPointIndex: 20 */,
	{ 21642, 1, 51, 51, 9, 10, 0, kSequencePointKind_Normal, 0, 21 } /* seqPointIndex: 21 */,
	{ 21642, 1, 52, 52, 13, 49, 1, kSequencePointKind_Normal, 0, 22 } /* seqPointIndex: 22 */,
	{ 21642, 1, 52, 52, 0, 0, 29, kSequencePointKind_Normal, 0, 23 } /* seqPointIndex: 23 */,
	{ 21642, 1, 53, 53, 13, 14, 32, kSequencePointKind_Normal, 0, 24 } /* seqPointIndex: 24 */,
	{ 21642, 1, 54, 54, 17, 41, 33, kSequencePointKind_Normal, 0, 25 } /* seqPointIndex: 25 */,
	{ 21642, 1, 55, 55, 13, 14, 45, kSequencePointKind_Normal, 0, 26 } /* seqPointIndex: 26 */,
	{ 21642, 1, 56, 56, 13, 33, 46, kSequencePointKind_Normal, 0, 27 } /* seqPointIndex: 27 */,
	{ 21642, 1, 57, 57, 13, 31, 57, kSequencePointKind_Normal, 0, 28 } /* seqPointIndex: 28 */,
	{ 21642, 1, 58, 58, 9, 10, 64, kSequencePointKind_Normal, 0, 29 } /* seqPointIndex: 29 */,
	{ 21642, 1, 52, 52, 13, 49, 20, kSequencePointKind_StepOut, 0, 30 } /* seqPointIndex: 30 */,
	{ 21642, 1, 54, 54, 17, 41, 39, kSequencePointKind_StepOut, 0, 31 } /* seqPointIndex: 31 */,
	{ 21643, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 32 } /* seqPointIndex: 32 */,
	{ 21643, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 33 } /* seqPointIndex: 33 */,
	{ 21643, 1, 61, 61, 9, 10, 0, kSequencePointKind_Normal, 0, 34 } /* seqPointIndex: 34 */,
	{ 21643, 1, 61, 61, 9, 10, 1, kSequencePointKind_Normal, 0, 35 } /* seqPointIndex: 35 */,
	{ 21643, 1, 62, 62, 13, 23, 2, kSequencePointKind_Normal, 0, 36 } /* seqPointIndex: 36 */,
	{ 21643, 1, 63, 63, 9, 10, 11, kSequencePointKind_Normal, 0, 37 } /* seqPointIndex: 37 */,
	{ 21643, 1, 63, 63, 9, 10, 19, kSequencePointKind_Normal, 0, 38 } /* seqPointIndex: 38 */,
	{ 21643, 1, 62, 62, 13, 23, 3, kSequencePointKind_StepOut, 0, 39 } /* seqPointIndex: 39 */,
	{ 21643, 1, 63, 63, 9, 10, 12, kSequencePointKind_StepOut, 0, 40 } /* seqPointIndex: 40 */,
	{ 21644, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 41 } /* seqPointIndex: 41 */,
	{ 21644, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 42 } /* seqPointIndex: 42 */,
	{ 21644, 1, 66, 66, 9, 10, 0, kSequencePointKind_Normal, 0, 43 } /* seqPointIndex: 43 */,
	{ 21644, 1, 67, 67, 13, 23, 1, kSequencePointKind_Normal, 0, 44 } /* seqPointIndex: 44 */,
	{ 21644, 1, 68, 68, 13, 39, 8, kSequencePointKind_Normal, 0, 45 } /* seqPointIndex: 45 */,
	{ 21644, 1, 69, 69, 9, 10, 15, kSequencePointKind_Normal, 0, 46 } /* seqPointIndex: 46 */,
	{ 21644, 1, 67, 67, 13, 23, 2, kSequencePointKind_StepOut, 0, 47 } /* seqPointIndex: 47 */,
	{ 21644, 1, 68, 68, 13, 39, 9, kSequencePointKind_StepOut, 0, 48 } /* seqPointIndex: 48 */,
	{ 21646, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 49 } /* seqPointIndex: 49 */,
	{ 21646, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 50 } /* seqPointIndex: 50 */,
	{ 21646, 2, 14, 14, 9, 38, 0, kSequencePointKind_Normal, 0, 51 } /* seqPointIndex: 51 */,
	{ 21646, 2, 15, 15, 9, 10, 7, kSequencePointKind_Normal, 0, 52 } /* seqPointIndex: 52 */,
	{ 21646, 2, 16, 16, 9, 10, 8, kSequencePointKind_Normal, 0, 53 } /* seqPointIndex: 53 */,
	{ 21646, 2, 14, 14, 9, 38, 1, kSequencePointKind_StepOut, 0, 54 } /* seqPointIndex: 54 */,
	{ 21647, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 55 } /* seqPointIndex: 55 */,
	{ 21647, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 56 } /* seqPointIndex: 56 */,
	{ 21647, 2, 20, 20, 9, 10, 0, kSequencePointKind_Normal, 0, 57 } /* seqPointIndex: 57 */,
	{ 21647, 2, 21, 21, 13, 61, 1, kSequencePointKind_Normal, 0, 58 } /* seqPointIndex: 58 */,
	{ 21647, 2, 22, 22, 13, 41, 7, kSequencePointKind_Normal, 0, 59 } /* seqPointIndex: 59 */,
	{ 21647, 2, 23, 23, 13, 36, 14, kSequencePointKind_Normal, 0, 60 } /* seqPointIndex: 60 */,
	{ 21647, 2, 24, 24, 9, 10, 18, kSequencePointKind_Normal, 0, 61 } /* seqPointIndex: 61 */,
	{ 21647, 2, 21, 21, 13, 61, 1, kSequencePointKind_StepOut, 0, 62 } /* seqPointIndex: 62 */,
	{ 21654, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 63 } /* seqPointIndex: 63 */,
	{ 21654, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 64 } /* seqPointIndex: 64 */,
	{ 21654, 3, 28, 28, 9, 57, 0, kSequencePointKind_Normal, 0, 65 } /* seqPointIndex: 65 */,
	{ 21654, 3, 29, 29, 9, 10, 7, kSequencePointKind_Normal, 0, 66 } /* seqPointIndex: 66 */,
	{ 21654, 3, 30, 30, 13, 25, 8, kSequencePointKind_Normal, 0, 67 } /* seqPointIndex: 67 */,
	{ 21654, 3, 31, 31, 13, 29, 15, kSequencePointKind_Normal, 0, 68 } /* seqPointIndex: 68 */,
	{ 21654, 3, 32, 32, 9, 10, 22, kSequencePointKind_Normal, 0, 69 } /* seqPointIndex: 69 */,
	{ 21654, 3, 28, 28, 9, 57, 1, kSequencePointKind_StepOut, 0, 70 } /* seqPointIndex: 70 */,
	{ 21655, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 71 } /* seqPointIndex: 71 */,
	{ 21655, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 72 } /* seqPointIndex: 72 */,
	{ 21655, 3, 38, 38, 9, 10, 0, kSequencePointKind_Normal, 0, 73 } /* seqPointIndex: 73 */,
	{ 21655, 3, 39, 39, 13, 72, 1, kSequencePointKind_Normal, 0, 74 } /* seqPointIndex: 74 */,
	{ 21655, 3, 40, 40, 13, 33, 13, kSequencePointKind_Normal, 0, 75 } /* seqPointIndex: 75 */,
	{ 21655, 3, 41, 41, 9, 10, 17, kSequencePointKind_Normal, 0, 76 } /* seqPointIndex: 76 */,
	{ 21655, 3, 39, 39, 13, 72, 7, kSequencePointKind_StepOut, 0, 77 } /* seqPointIndex: 77 */,
	{ 21656, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 78 } /* seqPointIndex: 78 */,
	{ 21656, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 79 } /* seqPointIndex: 79 */,
	{ 21656, 3, 45, 45, 9, 10, 0, kSequencePointKind_Normal, 0, 80 } /* seqPointIndex: 80 */,
	{ 21656, 3, 46, 46, 13, 25, 1, kSequencePointKind_Normal, 0, 81 } /* seqPointIndex: 81 */,
	{ 21656, 3, 46, 46, 0, 0, 8, kSequencePointKind_Normal, 0, 82 } /* seqPointIndex: 82 */,
	{ 21656, 3, 47, 47, 13, 14, 11, kSequencePointKind_Normal, 0, 83 } /* seqPointIndex: 83 */,
	{ 21656, 3, 48, 48, 17, 107, 12, kSequencePointKind_Normal, 0, 84 } /* seqPointIndex: 84 */,
	{ 21656, 3, 50, 50, 13, 25, 23, kSequencePointKind_Normal, 0, 85 } /* seqPointIndex: 85 */,
	{ 21656, 3, 51, 51, 9, 10, 30, kSequencePointKind_Normal, 0, 86 } /* seqPointIndex: 86 */,
	{ 21656, 3, 48, 48, 17, 107, 17, kSequencePointKind_StepOut, 0, 87 } /* seqPointIndex: 87 */,
	{ 21657, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 88 } /* seqPointIndex: 88 */,
	{ 21657, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 89 } /* seqPointIndex: 89 */,
	{ 21657, 3, 59, 59, 9, 10, 0, kSequencePointKind_Normal, 0, 90 } /* seqPointIndex: 90 */,
	{ 21657, 3, 60, 60, 13, 49, 1, kSequencePointKind_Normal, 0, 91 } /* seqPointIndex: 91 */,
	{ 21657, 3, 60, 60, 0, 0, 29, kSequencePointKind_Normal, 0, 92 } /* seqPointIndex: 92 */,
	{ 21657, 3, 61, 61, 13, 14, 32, kSequencePointKind_Normal, 0, 93 } /* seqPointIndex: 93 */,
	{ 21657, 3, 62, 62, 17, 41, 33, kSequencePointKind_Normal, 0, 94 } /* seqPointIndex: 94 */,
	{ 21657, 3, 63, 63, 13, 14, 45, kSequencePointKind_Normal, 0, 95 } /* seqPointIndex: 95 */,
	{ 21657, 3, 64, 64, 13, 33, 46, kSequencePointKind_Normal, 0, 96 } /* seqPointIndex: 96 */,
	{ 21657, 3, 65, 65, 9, 10, 57, kSequencePointKind_Normal, 0, 97 } /* seqPointIndex: 97 */,
	{ 21657, 3, 60, 60, 13, 49, 12, kSequencePointKind_StepOut, 0, 98 } /* seqPointIndex: 98 */,
	{ 21657, 3, 62, 62, 17, 41, 39, kSequencePointKind_StepOut, 0, 99 } /* seqPointIndex: 99 */,
	{ 21658, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 100 } /* seqPointIndex: 100 */,
	{ 21658, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 101 } /* seqPointIndex: 101 */,
	{ 21658, 3, 68, 68, 9, 10, 0, kSequencePointKind_Normal, 0, 102 } /* seqPointIndex: 102 */,
	{ 21658, 3, 68, 68, 9, 10, 1, kSequencePointKind_Normal, 0, 103 } /* seqPointIndex: 103 */,
	{ 21658, 3, 69, 69, 13, 23, 2, kSequencePointKind_Normal, 0, 104 } /* seqPointIndex: 104 */,
	{ 21658, 3, 70, 70, 9, 10, 11, kSequencePointKind_Normal, 0, 105 } /* seqPointIndex: 105 */,
	{ 21658, 3, 70, 70, 9, 10, 19, kSequencePointKind_Normal, 0, 106 } /* seqPointIndex: 106 */,
	{ 21658, 3, 69, 69, 13, 23, 3, kSequencePointKind_StepOut, 0, 107 } /* seqPointIndex: 107 */,
	{ 21658, 3, 70, 70, 9, 10, 12, kSequencePointKind_StepOut, 0, 108 } /* seqPointIndex: 108 */,
	{ 21659, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 109 } /* seqPointIndex: 109 */,
	{ 21659, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 110 } /* seqPointIndex: 110 */,
	{ 21659, 3, 73, 73, 9, 10, 0, kSequencePointKind_Normal, 0, 111 } /* seqPointIndex: 111 */,
	{ 21659, 3, 74, 74, 13, 23, 1, kSequencePointKind_Normal, 0, 112 } /* seqPointIndex: 112 */,
	{ 21659, 3, 75, 75, 13, 39, 8, kSequencePointKind_Normal, 0, 113 } /* seqPointIndex: 113 */,
	{ 21659, 3, 76, 76, 9, 10, 15, kSequencePointKind_Normal, 0, 114 } /* seqPointIndex: 114 */,
	{ 21659, 3, 74, 74, 13, 23, 2, kSequencePointKind_StepOut, 0, 115 } /* seqPointIndex: 115 */,
	{ 21659, 3, 75, 75, 13, 39, 9, kSequencePointKind_StepOut, 0, 116 } /* seqPointIndex: 116 */,
	{ 21663, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 117 } /* seqPointIndex: 117 */,
	{ 21663, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 118 } /* seqPointIndex: 118 */,
	{ 21663, 4, 36, 36, 9, 85, 0, kSequencePointKind_Normal, 0, 119 } /* seqPointIndex: 119 */,
	{ 21663, 4, 37, 37, 9, 85, 15, kSequencePointKind_Normal, 0, 120 } /* seqPointIndex: 120 */,
	{ 21663, 4, 36, 36, 9, 85, 5, kSequencePointKind_StepOut, 0, 121 } /* seqPointIndex: 121 */,
	{ 21663, 4, 37, 37, 9, 85, 20, kSequencePointKind_StepOut, 0, 122 } /* seqPointIndex: 122 */,
	{ 21664, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 123 } /* seqPointIndex: 123 */,
	{ 21664, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 124 } /* seqPointIndex: 124 */,
	{ 21664, 4, 59, 59, 9, 10, 0, kSequencePointKind_Normal, 0, 125 } /* seqPointIndex: 125 */,
	{ 21664, 4, 60, 60, 13, 34, 1, kSequencePointKind_Normal, 0, 126 } /* seqPointIndex: 126 */,
	{ 21664, 4, 61, 61, 13, 50, 8, kSequencePointKind_Normal, 0, 127 } /* seqPointIndex: 127 */,
	{ 21664, 4, 62, 62, 9, 10, 15, kSequencePointKind_Normal, 0, 128 } /* seqPointIndex: 128 */,
	{ 21666, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 129 } /* seqPointIndex: 129 */,
	{ 21666, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 130 } /* seqPointIndex: 130 */,
	{ 21666, 4, 95, 95, 9, 10, 0, kSequencePointKind_Normal, 0, 131 } /* seqPointIndex: 131 */,
	{ 21666, 4, 96, 96, 13, 43, 1, kSequencePointKind_Normal, 0, 132 } /* seqPointIndex: 132 */,
	{ 21666, 4, 96, 96, 0, 0, 14, kSequencePointKind_Normal, 0, 133 } /* seqPointIndex: 133 */,
	{ 21666, 4, 97, 97, 17, 29, 17, kSequencePointKind_Normal, 0, 134 } /* seqPointIndex: 134 */,
	{ 21666, 4, 98, 98, 13, 112, 21, kSequencePointKind_Normal, 0, 135 } /* seqPointIndex: 135 */,
	{ 21666, 4, 99, 99, 13, 38, 33, kSequencePointKind_Normal, 0, 136 } /* seqPointIndex: 136 */,
	{ 21666, 4, 100, 100, 9, 10, 37, kSequencePointKind_Normal, 0, 137 } /* seqPointIndex: 137 */,
	{ 21666, 4, 96, 96, 13, 43, 2, kSequencePointKind_StepOut, 0, 138 } /* seqPointIndex: 138 */,
	{ 21666, 4, 96, 96, 13, 43, 8, kSequencePointKind_StepOut, 0, 139 } /* seqPointIndex: 139 */,
	{ 21666, 4, 98, 98, 13, 112, 22, kSequencePointKind_StepOut, 0, 140 } /* seqPointIndex: 140 */,
	{ 21666, 4, 98, 98, 13, 112, 27, kSequencePointKind_StepOut, 0, 141 } /* seqPointIndex: 141 */,
	{ 21668, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 142 } /* seqPointIndex: 142 */,
	{ 21668, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 143 } /* seqPointIndex: 143 */,
	{ 21668, 4, 125, 125, 9, 10, 0, kSequencePointKind_Normal, 0, 144 } /* seqPointIndex: 144 */,
	{ 21668, 4, 126, 126, 13, 52, 1, kSequencePointKind_Normal, 0, 145 } /* seqPointIndex: 145 */,
	{ 21668, 4, 127, 127, 9, 10, 10, kSequencePointKind_Normal, 0, 146 } /* seqPointIndex: 146 */,
	{ 21668, 4, 126, 126, 13, 52, 4, kSequencePointKind_StepOut, 0, 147 } /* seqPointIndex: 147 */,
	{ 21669, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 148 } /* seqPointIndex: 148 */,
	{ 21669, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 149 } /* seqPointIndex: 149 */,
	{ 21669, 4, 140, 140, 9, 10, 0, kSequencePointKind_Normal, 0, 150 } /* seqPointIndex: 150 */,
	{ 21669, 4, 141, 141, 13, 54, 1, kSequencePointKind_Normal, 0, 151 } /* seqPointIndex: 151 */,
	{ 21669, 4, 142, 142, 9, 10, 13, kSequencePointKind_Normal, 0, 152 } /* seqPointIndex: 152 */,
	{ 21669, 4, 141, 141, 13, 54, 7, kSequencePointKind_StepOut, 0, 153 } /* seqPointIndex: 153 */,
	{ 21678, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 154 } /* seqPointIndex: 154 */,
	{ 21678, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 155 } /* seqPointIndex: 155 */,
	{ 21678, 4, 255, 255, 9, 10, 0, kSequencePointKind_Normal, 0, 156 } /* seqPointIndex: 156 */,
	{ 21678, 4, 256, 256, 13, 55, 1, kSequencePointKind_Normal, 0, 157 } /* seqPointIndex: 157 */,
	{ 21678, 4, 257, 257, 9, 10, 16, kSequencePointKind_Normal, 0, 158 } /* seqPointIndex: 158 */,
	{ 21678, 4, 256, 256, 13, 55, 3, kSequencePointKind_StepOut, 0, 159 } /* seqPointIndex: 159 */,
	{ 21678, 4, 256, 256, 13, 55, 8, kSequencePointKind_StepOut, 0, 160 } /* seqPointIndex: 160 */,
	{ 21679, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 161 } /* seqPointIndex: 161 */,
	{ 21679, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 162 } /* seqPointIndex: 162 */,
	{ 21679, 4, 260, 260, 9, 10, 0, kSequencePointKind_Normal, 0, 163 } /* seqPointIndex: 163 */,
	{ 21679, 4, 261, 261, 13, 56, 1, kSequencePointKind_Normal, 0, 164 } /* seqPointIndex: 164 */,
	{ 21679, 4, 262, 262, 9, 10, 16, kSequencePointKind_Normal, 0, 165 } /* seqPointIndex: 165 */,
	{ 21679, 4, 261, 261, 13, 56, 3, kSequencePointKind_StepOut, 0, 166 } /* seqPointIndex: 166 */,
	{ 21679, 4, 261, 261, 13, 56, 8, kSequencePointKind_StepOut, 0, 167 } /* seqPointIndex: 167 */,
	{ 21680, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 168 } /* seqPointIndex: 168 */,
	{ 21680, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 169 } /* seqPointIndex: 169 */,
	{ 21680, 4, 285, 285, 9, 10, 0, kSequencePointKind_Normal, 0, 170 } /* seqPointIndex: 170 */,
	{ 21680, 4, 286, 286, 13, 58, 1, kSequencePointKind_Normal, 0, 171 } /* seqPointIndex: 171 */,
	{ 21680, 4, 287, 287, 9, 10, 16, kSequencePointKind_Normal, 0, 172 } /* seqPointIndex: 172 */,
	{ 21680, 4, 286, 286, 13, 58, 3, kSequencePointKind_StepOut, 0, 173 } /* seqPointIndex: 173 */,
	{ 21680, 4, 286, 286, 13, 58, 8, kSequencePointKind_StepOut, 0, 174 } /* seqPointIndex: 174 */,
	{ 21681, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 175 } /* seqPointIndex: 175 */,
	{ 21681, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 176 } /* seqPointIndex: 176 */,
	{ 21681, 4, 321, 321, 9, 10, 0, kSequencePointKind_Normal, 0, 177 } /* seqPointIndex: 177 */,
	{ 21681, 4, 322, 322, 13, 51, 1, kSequencePointKind_Normal, 0, 178 } /* seqPointIndex: 178 */,
	{ 21681, 4, 323, 323, 9, 10, 15, kSequencePointKind_Normal, 0, 179 } /* seqPointIndex: 179 */,
	{ 21681, 4, 322, 322, 13, 51, 3, kSequencePointKind_StepOut, 0, 180 } /* seqPointIndex: 180 */,
	{ 21681, 4, 322, 322, 13, 51, 9, kSequencePointKind_StepOut, 0, 181 } /* seqPointIndex: 181 */,
	{ 21682, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 182 } /* seqPointIndex: 182 */,
	{ 21682, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 183 } /* seqPointIndex: 183 */,
	{ 21682, 4, 326, 326, 9, 10, 0, kSequencePointKind_Normal, 0, 184 } /* seqPointIndex: 184 */,
	{ 21682, 4, 327, 327, 13, 52, 1, kSequencePointKind_Normal, 0, 185 } /* seqPointIndex: 185 */,
	{ 21682, 4, 328, 328, 9, 10, 15, kSequencePointKind_Normal, 0, 186 } /* seqPointIndex: 186 */,
	{ 21682, 4, 327, 327, 13, 52, 3, kSequencePointKind_StepOut, 0, 187 } /* seqPointIndex: 187 */,
	{ 21682, 4, 327, 327, 13, 52, 9, kSequencePointKind_StepOut, 0, 188 } /* seqPointIndex: 188 */,
	{ 21683, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 189 } /* seqPointIndex: 189 */,
	{ 21683, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 190 } /* seqPointIndex: 190 */,
	{ 21683, 4, 351, 351, 9, 10, 0, kSequencePointKind_Normal, 0, 191 } /* seqPointIndex: 191 */,
	{ 21683, 4, 352, 352, 13, 54, 1, kSequencePointKind_Normal, 0, 192 } /* seqPointIndex: 192 */,
	{ 21683, 4, 353, 353, 9, 10, 15, kSequencePointKind_Normal, 0, 193 } /* seqPointIndex: 193 */,
	{ 21683, 4, 352, 352, 13, 54, 3, kSequencePointKind_StepOut, 0, 194 } /* seqPointIndex: 194 */,
	{ 21683, 4, 352, 352, 13, 54, 9, kSequencePointKind_StepOut, 0, 195 } /* seqPointIndex: 195 */,
	{ 21684, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 196 } /* seqPointIndex: 196 */,
	{ 21684, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 197 } /* seqPointIndex: 197 */,
	{ 21684, 4, 371, 371, 9, 10, 0, kSequencePointKind_Normal, 0, 198 } /* seqPointIndex: 198 */,
	{ 21684, 4, 372, 372, 13, 51, 1, kSequencePointKind_Normal, 0, 199 } /* seqPointIndex: 199 */,
	{ 21684, 4, 373, 373, 9, 10, 15, kSequencePointKind_Normal, 0, 200 } /* seqPointIndex: 200 */,
	{ 21684, 4, 372, 372, 13, 51, 3, kSequencePointKind_StepOut, 0, 201 } /* seqPointIndex: 201 */,
	{ 21684, 4, 372, 372, 13, 51, 9, kSequencePointKind_StepOut, 0, 202 } /* seqPointIndex: 202 */,
	{ 21685, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 203 } /* seqPointIndex: 203 */,
	{ 21685, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 204 } /* seqPointIndex: 204 */,
	{ 21685, 4, 461, 461, 9, 10, 0, kSequencePointKind_Normal, 0, 205 } /* seqPointIndex: 205 */,
	{ 21685, 4, 463, 463, 13, 52, 1, kSequencePointKind_Normal, 0, 206 } /* seqPointIndex: 206 */,
	{ 21685, 4, 463, 463, 0, 0, 11, kSequencePointKind_Normal, 0, 207 } /* seqPointIndex: 207 */,
	{ 21685, 4, 464, 464, 17, 29, 14, kSequencePointKind_Normal, 0, 208 } /* seqPointIndex: 208 */,
	{ 21685, 4, 466, 466, 13, 55, 18, kSequencePointKind_Normal, 0, 209 } /* seqPointIndex: 209 */,
	{ 21685, 4, 466, 466, 0, 0, 28, kSequencePointKind_Normal, 0, 210 } /* seqPointIndex: 210 */,
	{ 21685, 4, 467, 467, 17, 82, 31, kSequencePointKind_Normal, 0, 211 } /* seqPointIndex: 211 */,
	{ 21685, 4, 468, 468, 13, 50, 43, kSequencePointKind_Normal, 0, 212 } /* seqPointIndex: 212 */,
	{ 21685, 4, 469, 469, 9, 10, 52, kSequencePointKind_Normal, 0, 213 } /* seqPointIndex: 213 */,
	{ 21685, 4, 467, 467, 17, 82, 33, kSequencePointKind_StepOut, 0, 214 } /* seqPointIndex: 214 */,
	{ 21686, 0, 0, 0, 0, 0, -1, kSequencePointKind_Normal, 0, 215 } /* seqPointIndex: 215 */,
	{ 21686, 0, 0, 0, 0, 0, 16777215, kSequencePointKind_Normal, 0, 216 } /* seqPointIndex: 216 */,
	{ 21686, 4, 474, 474, 9, 10, 0, kSequencePointKind_Normal, 0, 217 } /* seqPointIndex: 217 */,
	{ 21686, 4, 475, 475, 13, 90, 1, kSequencePointKind_Normal, 0, 218 } /* seqPointIndex: 218 */,
	{ 21686, 4, 476, 476, 13, 52, 15, kSequencePointKind_Normal, 0, 219 } /* seqPointIndex: 219 */,
	{ 21686, 4, 477, 477, 9, 10, 28, kSequencePointKind_Normal, 0, 220 } /* seqPointIndex: 220 */,
	{ 21686, 4, 475, 475, 13, 90, 10, kSequencePointKind_StepOut, 0, 221 } /* seqPointIndex: 221 */,
	{ 21686, 4, 476, 476, 13, 52, 22, kSequencePointKind_StepOut, 0, 222 } /* seqPointIndex: 222 */,
};
#else
extern Il2CppSequencePoint g_sequencePointsUnityEngine_VFXModule[];
Il2CppSequencePoint g_sequencePointsUnityEngine_VFXModule[1] = { { 0, 0, 0, 0, 0, 0, 0, kSequencePointKind_Normal, 0, 0, } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppCatchPoint g_catchPoints[1] = { { 0, 0, 0, 0, } };
#else
static const Il2CppCatchPoint g_catchPoints[1] = { { 0, 0, 0, 0, } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppSequencePointSourceFile g_sequencePointSourceFiles[] = {
{ "", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //0 
{ "/Users/bokken/buildslave/unity/build/Modules/VFX/Public/ScriptBindings/VFXEventAttribute.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //1 
{ "/Users/bokken/buildslave/unity/build/Modules/VFX/Public/ScriptBindings/VFXExpressionValues.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //2 
{ "/Users/bokken/buildslave/unity/build/Modules/VFX/Public/ScriptBindings/VFXSpawnerState.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //3 
{ "/Users/bokken/buildslave/unity/build/Modules/VFX/Public/ScriptBindings/VisualEffect.bindings.cs", { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} }, //4 
};
#else
static const Il2CppSequencePointSourceFile g_sequencePointSourceFiles[1] = { NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppTypeSourceFilePair g_typeSourceFiles[6] = 
{
	{ 3548, 1 },
	{ 3549, 2 },
	{ 3552, 3 },
	{ 3554, 4 },
	{ 3555, 4 },
	{ 3556, 4 },
};
#else
static const Il2CppTypeSourceFilePair g_typeSourceFiles[1] = { { 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodScope g_methodScopes[12] = 
{
	{ 0, 28 },
	{ 0, 65 },
	{ 0, 20 },
	{ 0, 19 },
	{ 0, 31 },
	{ 0, 58 },
	{ 0, 39 },
	{ 0, 18 },
	{ 0, 18 },
	{ 0, 18 },
	{ 0, 54 },
	{ 0, 29 },
};
#else
static const Il2CppMethodScope g_methodScopes[1] = { { 0, 0 } };
#endif
#if IL2CPP_MONO_DEBUGGER
static const Il2CppMethodHeaderInfo g_methodHeaderInfos[49] = 
{
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXEventAttribute::.ctor(System.IntPtr,System.Boolean,UnityEngine.VFX.VisualEffectAsset) */,
	{ 0, 0, 0 } /* System.IntPtr UnityEngine.VFX.VFXEventAttribute::Internal_Create() */,
	{ 28, 0, 1 } /* UnityEngine.VFX.VFXEventAttribute UnityEngine.VFX.VFXEventAttribute::Internal_InstanciateVFXEventAttribute(UnityEngine.VFX.VisualEffectAsset) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXEventAttribute::Internal_InitFromAsset(UnityEngine.VFX.VisualEffectAsset) */,
	{ 65, 1, 1 } /* System.Void UnityEngine.VFX.VFXEventAttribute::Release() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXEventAttribute::Finalize() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXEventAttribute::Dispose() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXEventAttribute::Internal_Destroy(System.IntPtr) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXExpressionValues::.ctor() */,
	{ 20, 2, 1 } /* UnityEngine.VFX.VFXExpressionValues UnityEngine.VFX.VFXExpressionValues::CreateExpressionValuesWrapper(System.IntPtr) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXManager::PrepareCamera(UnityEngine.Camera) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXManager::ProcessCameraCommand(UnityEngine.Camera,UnityEngine.Rendering.CommandBuffer) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerCallbacks::OnPlay(UnityEngine.VFX.VFXSpawnerState,UnityEngine.VFX.VFXExpressionValues,UnityEngine.VFX.VisualEffect) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerCallbacks::OnUpdate(UnityEngine.VFX.VFXSpawnerState,UnityEngine.VFX.VFXExpressionValues,UnityEngine.VFX.VisualEffect) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerCallbacks::OnStop(UnityEngine.VFX.VFXSpawnerState,UnityEngine.VFX.VFXExpressionValues,UnityEngine.VFX.VisualEffect) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerCallbacks::.ctor() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerState::.ctor(System.IntPtr,System.Boolean) */,
	{ 19, 3, 1 } /* UnityEngine.VFX.VFXSpawnerState UnityEngine.VFX.VFXSpawnerState::CreateSpawnerStateWrapper() */,
	{ 31, 4, 1 } /* System.Void UnityEngine.VFX.VFXSpawnerState::SetWrapValue(System.IntPtr) */,
	{ 58, 5, 1 } /* System.Void UnityEngine.VFX.VFXSpawnerState::Release() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerState::Finalize() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerState::Dispose() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXSpawnerState::Internal_Destroy(System.IntPtr) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffectObject::.ctor() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffectAsset::.ctor() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffectAsset::.cctor() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VFXOutputEventArgs::.ctor(System.Int32,UnityEngine.VFX.VFXEventAttribute) */,
	{ 0, 0, 0 } /* UnityEngine.VFX.VisualEffectAsset UnityEngine.VFX.VisualEffect::get_visualEffectAsset() */,
	{ 39, 6, 1 } /* UnityEngine.VFX.VFXEventAttribute UnityEngine.VFX.VisualEffect::CreateVFXEventAttribute() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SendEventFromScript(System.Int32,UnityEngine.VFX.VFXEventAttribute) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SendEvent(System.Int32) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::Play() */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::Reinit() */,
	{ 0, 0, 0 } /* System.Boolean UnityEngine.VFX.VisualEffect::HasUInt(System.Int32) */,
	{ 0, 0, 0 } /* System.Boolean UnityEngine.VFX.VisualEffect::HasFloat(System.Int32) */,
	{ 0, 0, 0 } /* System.Boolean UnityEngine.VFX.VisualEffect::HasTexture(System.Int32) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetBool(System.Int32,System.Boolean) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetUInt(System.Int32,System.UInt32) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetFloat(System.Int32,System.Single) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetTexture(System.Int32,UnityEngine.Texture) */,
	{ 18, 7, 1 } /* System.Boolean UnityEngine.VFX.VisualEffect::HasUInt(System.String) */,
	{ 18, 8, 1 } /* System.Boolean UnityEngine.VFX.VisualEffect::HasFloat(System.String) */,
	{ 18, 9, 1 } /* System.Boolean UnityEngine.VFX.VisualEffect::HasTexture(System.String) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetUInt(System.String,System.UInt32) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetFloat(System.String,System.Single) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetTexture(System.String,UnityEngine.Texture) */,
	{ 0, 0, 0 } /* System.Void UnityEngine.VFX.VisualEffect::SetBool(System.String,System.Boolean) */,
	{ 54, 10, 1 } /* UnityEngine.VFX.VFXEventAttribute UnityEngine.VFX.VisualEffect::InvokeGetCachedEventAttributeForOutputEvent_Internal(UnityEngine.VFX.VisualEffect) */,
	{ 29, 11, 1 } /* System.Void UnityEngine.VFX.VisualEffect::InvokeOutputEventReceived_Internal(UnityEngine.VFX.VisualEffect,System.Int32) */,
};
#else
static const Il2CppMethodHeaderInfo g_methodHeaderInfos[1] = { { 0, 0, 0 } };
#endif
IL2CPP_EXTERN_C const Il2CppDebuggerMetadataRegistration g_DebuggerMetadataRegistrationUnityEngine_VFXModule;
const Il2CppDebuggerMetadataRegistration g_DebuggerMetadataRegistrationUnityEngine_VFXModule = 
{
	(Il2CppMethodExecutionContextInfo*)g_methodExecutionContextInfos,
	(Il2CppMethodExecutionContextInfoIndex*)g_methodExecutionContextInfoIndexes,
	(Il2CppMethodScope*)g_methodScopes,
	(Il2CppMethodHeaderInfo*)g_methodHeaderInfos,
	(Il2CppSequencePointSourceFile*)g_sequencePointSourceFiles,
	223,
	(Il2CppSequencePoint*)g_sequencePointsUnityEngine_VFXModule,
	0,
	(Il2CppCatchPoint*)g_catchPoints,
	6,
	(Il2CppTypeSourceFilePair*)g_typeSourceFiles,
	(const char**)g_methodExecutionContextInfoStrings,
};
