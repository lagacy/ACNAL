// ACNAL.h : fichier Include pour les fichiers Include système standard,
// ou les fichiers Include spécifiques aux projets.

#pragma once
#include <iostream>

#ifdef ACNAL_EXPORTS
#define ACNAL_API extern "C" __declspec(dllexport)
#else
#define ACNAL_API extern "C" __declspec(dllexport)
#endif

 ACNAL_API void printTarget();

// TODO: Référencez ici les en-têtes supplémentaires nécessaires à votre programme.
