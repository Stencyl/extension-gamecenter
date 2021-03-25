package;

#if cpp
import cpp.Lib;
#else
import openfl.Lib;
#end

import com.stencyl.Engine;
import com.stencyl.event.EventMaster;
import com.stencyl.event.StencylEvent;

import openfl.utils.ByteArray;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

#if ios
@:buildXml('<include name="${haxelib:com.stencyl.gamecenter}/project/Build.xml"/>')
#end
class GameCenter 
{	
	private static var initialized:Bool = false;
	
	private static function notifyListeners(inEvent:Dynamic)
	{
		#if ios
		var type:String = Std.string(Reflect.field(inEvent, "type"));
		var data:String = Std.string(Reflect.field(inEvent, "data"));
		
		if(type == "auth-success")
		{
			trace("Game Center: Authenticated");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_READY));
		}
		
		else if(type == "auth-failed")
		{
			trace("Game Center: Failed to Authenticate");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_READY_FAIL, data));
		}
		
		else if(type == "score-success")
		{
			trace("Game Center: Submitted Score");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_SCORE, data));
		}
		
		else if(type == "score-failed")
		{
			trace("Game Center: Failed to Submit Score");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_SCORE_FAIL, data));
		}
		
		else if(type == "achieve-success")
		{
			trace("Game Center: Submitted Achievement");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_ACHIEVEMENT, data));
		}
		
		else if(type == "achieve-failed")
		{
			trace("Game Center: Failed to Submit Achievement");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_ACHIEVEMENT_FAIL, data));
		}
		
		else if(type == "achieve-reset-success")
		{
			trace("Game Center: Reset Achievements");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_ACHIEVEMENT_RESET, data));
		}
		
		else if(type == "achieve-reset-failed")
		{
			trace("Game Center: Failed to Reset Achievements");
			Engine.events.addGameCenterEvent(new StencylEvent(StencylEvent.GAME_CENTER_ACHIEVEMENT_RESET_FAIL, data));
		}
		#end
	}

	public static function initialize():Void 
	{
		#if ios
		if(!initialized)
		{
			set_event_handle(notifyListeners);
			gamecenter_initialize();
			initialized = true;
		}
		#end	
	}

	public static function authenticate():Void 
	{
		#if ios
			gamecenter_authenticate();
		#end	
	}
	
	public static function isAvailable():Bool 
	{
		#if ios
			return gamecenter_isavailable();
		#else
			return false;
		#end
	}
	
	public static function isAuthenticated():Bool 
	{
		#if ios
			return gamecenter_isauthenticated();
		#else
			return false;
		#end
	}
	
	public static function getPlayerName():String 
	{
		#if ios
			return gamecenter_playername();
		#else
			return "None";
		#end
	}
	
	public static function getPlayerID():String 
	{
		#if ios
			return gamecenter_playerid();
		#else
			return "None";
		#end
	}
	
	public static function showLeaderboard(categoryID:String):Void 
	{
		#if ios
			gamecenter_showleaderboard(categoryID);
		#end	
	}
	
	public static function showAchievements():Void 
	{
		#if ios
			gamecenter_showachievements();
		#end	
	}
	
	public static function reportScore(categoryID:String, score:Int):Void 
	{
		#if ios
			gamecenter_reportscore(categoryID, score);
		#end	
	}
	
	public static function reportAchievement(achievementID:String, percent:Float):Void 
	{
		#if ios
			gamecenter_reportachievement(achievementID, percent);
		#end	
	}
	
	public static function resetAchievements():Void 
	{
		#if ios
			gamecenter_resetachievements();
		#end	
	}
	
	public static function showAchievementBanner(title:String, message:String):Void
	{
		#if ios
			gamecenter_showachievementbanner(title, message);
		#end	
	}
	
	#if ios
	private static var set_event_handle = Lib.load("gamecenter", "gamecenter_set_event_handle", 1);
	private static var gamecenter_initialize = Lib.load("gamecenter", "gamecenter_initialize", 0);
	private static var gamecenter_authenticate = Lib.load("gamecenter", "gamecenter_authenticate", 0);
	private static var gamecenter_isavailable = Lib.load("gamecenter", "gamecenter_isavailable", 0);
	private static var gamecenter_isauthenticated = Lib.load("gamecenter", "gamecenter_isauthenticated", 0);
	
	private static var gamecenter_playername = Lib.load("gamecenter", "gamecenter_playername", 0);
	private static var gamecenter_playerid = Lib.load("gamecenter", "gamecenter_playerid", 0);
	
	private static var gamecenter_showleaderboard = Lib.load("gamecenter", "gamecenter_showleaderboard", 1);
	private static var gamecenter_showachievements = Lib.load("gamecenter", "gamecenter_showachievements", 0);
	private static var gamecenter_reportscore = Lib.load("gamecenter", "gamecenter_reportscore", 2);
	private static var gamecenter_reportachievement = Lib.load("gamecenter", "gamecenter_reportachievement", 2);
	private static var gamecenter_resetachievements = Lib.load("gamecenter", "gamecenter_resetachievements", 0);
	private static var gamecenter_showachievementbanner = Lib.load("gamecenter", "gamecenter_showachievementbanner", 2);
	#end
}