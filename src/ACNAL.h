// ACNAL.h : project common include PCH, will be used project wide.

#pragma once
#include <iostream>

#ifdef ACNAL_EXPORTS
#define ACNAL_API extern "C" __declspec(dllexport)
#else
#define ACNAL_API extern "C" __declspec(dllexport)
#endif

// TODO: Ref additional project headers.
