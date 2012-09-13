#ifndef IPHONE
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include "GameCenter.h"
#include <stdio.h>

using namespace gamecenter;

#ifdef IPHONE

static void gamecenter_initialize() 
{
	initializeGameCenter();
}
DEFINE_PRIM (gamecenter_initialize, 0);

static void gamecenter_authenticate() 
{
	authenticateLocalUser();
}
DEFINE_PRIM (gamecenter_authenticate, 0);

static value gamecenter_isavailable()
{
	return alloc_bool(isGameCenterAvailable());
}
DEFINE_PRIM(gamecenter_isavailable, 0);

static value gamecenter_isauthenticated()
{
	return alloc_bool(isUserAuthenticated());
}
DEFINE_PRIM(gamecenter_isauthenticated, 0);

static value gamecenter_playername()
{
	return alloc_string(getPlayerName());
}
DEFINE_PRIM(gamecenter_playername, 0);

static value gamecenter_playerid()
{
	return alloc_string(getPlayerID());
}
DEFINE_PRIM(gamecenter_playerid, 0);

static void gamecenter_showachievements()
{
	showAchievements();
}
DEFINE_PRIM(gamecenter_showachievements, 0);

static void gamecenter_showleaderboard(value categoryID)
{
	showLeaderboard(val_string(categoryID));
}
DEFINE_PRIM(gamecenter_showleaderboard, 1);

static void gamecenter_reportscore(value categoryID, value score)
{
	reportScore(val_string(categoryID), val_int(score));
}
DEFINE_PRIM(gamecenter_reportscore, 2);

static void gamecenter_reportachievement(value achievementID, value percent)
{
	reportAchievement(val_string(achievementID),val_float(percent));
}
DEFINE_PRIM(gamecenter_reportachievement, 2);

static void gamecenter_resetachievements()
{
	resetAchievements();
}
DEFINE_PRIM(gamecenter_resetachievements, 0);

#endif

extern "C" void gamecenter_main() 
{	
	// Here you could do some initialization, if needed	
}
DEFINE_ENTRY_POINT(gamecenter_main);

extern "C" int gamecenter_register_prims() 
{ 
    return 0; 
}