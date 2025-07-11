package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.game.score.class_1729;
   
   public class LeaderboardViewController implements IDisposable, IAvatarImageListener
   {
      
      private static const STATE_FRIENDS_ALLTIME:int = 0;
      
      private static const STATE_ALLTIME:int = 1;
      
      private static const STATE_WEEKLY:int = 2;
      
      private static const STATE_FRIENDS_WEEKLY:int = 3;
      
      private static const STATE_GROUP_WEEKLY:int = 4;
      
      private static const STATE_GROUP_ALLTIME:int = 5;
       
      
      private var var_1655:SnowWarEngine;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _window:IWindowContainer;
      
      private var _disposed:Boolean;
      
      private var var_149:int;
      
      private var var_19:IItemListWindow;
      
      private var _listBorder:IWindow;
      
      private var var_3660:ITextLinkWindow;
      
      private var var_3708:ITextLinkWindow;
      
      private var var_3838:ITextLinkWindow;
      
      private var var_3397:IBitmapWrapperWindow;
      
      private var var_2800:ITextWindow;
      
      private var var_3409:IBitmapWrapperWindow;
      
      private var var_3565:ITextWindow;
      
      private var var_2626:IRegionWindow;
      
      private var var_3286:IRegionWindow;
      
      private var _nextWeek:IRegionWindow;
      
      private var _previousWeek:IRegionWindow;
      
      private var var_2628:String;
      
      private var _minutesUntilWeeklyReset:int;
      
      private var var_2481:Timer;
      
      private var _avatarPlaceholders:Map;
      
      private var var_2199:LeaderboardTable;
      
      private var var_2455:TotalLeaderboardTable;
      
      private var var_2281:TotalGroupLeaderboardTable;
      
      private var var_1872:WeeklyTotalLeaderboardTable;
      
      private var var_1818:WeeklyGroupLeaderboardTable;
      
      private var var_1853:WeeklyFriendLeaderboardTable;
      
      private var var_4494:Boolean;
      
      private var _selectedGame:int = 0;
      
      public function LeaderboardViewController(param1:SnowWarEngine)
      {
         super();
         var_1655 = param1;
         _localization = param1.localization;
         _avatarPlaceholders = new Map();
         var_4494 = var_1655.config.getBoolean("games.highscores.scrolling.enabled");
         var_2199 = new LeaderboardTable(var_1655);
         var_2455 = new TotalLeaderboardTable(var_1655);
         var_2281 = new TotalGroupLeaderboardTable(var_1655);
         var_1872 = new WeeklyTotalLeaderboardTable(var_1655);
         var_1818 = new WeeklyGroupLeaderboardTable(var_1655);
         var_1853 = new WeeklyFriendLeaderboardTable(var_1655);
         sendGetFriendsAllTimeData();
      }
      
      public function set selectedGame(param1:int) : void
      {
         _selectedGame = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_1655 = null;
         var_19 = null;
         _listBorder = null;
         var_3660 = null;
         var_3708 = null;
         var_3838 = null;
         var_3397 = null;
         var_2800 = null;
         var_3409 = null;
         var_3565 = null;
         var_2626 = null;
         var_3286 = null;
         _nextWeek = null;
         _previousWeek = null;
         var_2628 = null;
         _avatarPlaceholders.dispose();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_2199)
         {
            var_2199.dispose();
            var_2199 = null;
         }
         if(var_2455)
         {
            var_2455.dispose();
            var_2455 = null;
         }
         if(var_2281)
         {
            var_2281.dispose();
            var_2281 = null;
         }
         if(var_1872)
         {
            var_1872.dispose();
            var_1872 = null;
         }
         if(var_1818)
         {
            var_1818.dispose();
            var_1818 = null;
         }
         if(var_1853)
         {
            var_1853.dispose();
            var_1853 = null;
         }
         disposeWeeklyResetTimer();
         _disposed = true;
      }
      
      private function disposeWeeklyResetTimer() : void
      {
         if(var_2481 != null)
         {
            var_2481.removeEventListener("timer",onTick);
            var_2481.stop();
            var_2481 = null;
         }
      }
      
      private function startWeeklyResetTimer(param1:int) : void
      {
         var_2481 = new Timer(60000,param1);
         var_2481.addEventListener("timer",onTick);
         var_2481.start();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function enableAllTimeButton() : void
      {
         var_2800.textColor = 0;
         var_3565.textColor = 16777215;
         WindowUtils.setElementImage(var_3397,getBitmap("left_blue"));
         WindowUtils.setElementImage(var_3409,getBitmap("right_black"));
      }
      
      private function enableThisWeekButton() : void
      {
         var_2800.textColor = 16777215;
         var_3565.textColor = 0;
         WindowUtils.setElementImage(var_3397,getBitmap("left_black"));
         WindowUtils.setElementImage(var_3409,getBitmap("right_blue"));
      }
      
      public function showFriendsAllTime() : void
      {
         var_149 = 0;
         sendGetFriendsAllTimeData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.friends}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showAllTime() : void
      {
         var_149 = 1;
         sendGetAllTimeData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showGroupAllTime() : void
      {
         var_149 = 5;
         sendGetAllTimeGroupData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showWeekly() : void
      {
         var_149 = 2;
         var_1872.offset = 0;
         sendGetWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showGroupWeekly() : void
      {
         var_149 = 4;
         var_1818.offset = 0;
         sendGetGroupWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showFriendsWeekly() : void
      {
         var_149 = 3;
         var_1853.offset = 0;
         sendGetFriendsWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.friends}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function addAllTimeData(param1:Array, param2:int) : void
      {
         var_2455.addEntries(param1,param2);
         if(var_149 == 1 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addAllTimeGroupData(param1:Array, param2:int, param3:int) : void
      {
         var_2281.addGroupEntries(param1,param2,param3);
         if(var_149 == 5 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addWeeklyData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int) : void
      {
         disposeWeeklyResetTimer();
         _minutesUntilWeeklyReset = param6;
         var_2628 = param1 + "/" + param2;
         var_1872.maxOffset = param5;
         var_1872.addEntries(param3,param4);
         if(var_149 == 2 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addWeeklyGroupData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int, param7:int) : void
      {
         disposeWeeklyResetTimer();
         _minutesUntilWeeklyReset = param6;
         var_2628 = param1 + "/" + param2;
         var_1818.maxOffset = param5;
         var_1818.addGroupEntries(param3,param4,param7);
         if(var_149 == 4 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addFriendAllTimeData(param1:Array, param2:int) : void
      {
         var_2199.addEntries(param1,param2);
         if(var_149 == 0 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addFriendWeeklyData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int) : void
      {
         disposeWeeklyResetTimer();
         _minutesUntilWeeklyReset = param6;
         var_2628 = param1 + "/" + param2;
         var_1853.maxOffset = param5;
         var_1853.addEntries(param3,param4);
         if(var_149 == 3 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _avatarPlaceholders.remove(param1);
         if(_loc2_ && !_loc2_.disposed)
         {
            setAvatarImage(_loc2_,param1);
         }
      }
      
      private function sendGetFriendsAllTimeData() : void
      {
         var_2199.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetAllTimeData() : void
      {
         var_2455.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetAllTimeGroupData() : void
      {
         var_2281.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetWeeklyData(param1:int) : void
      {
         var_1872.offset = param1;
         var_1872.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetGroupWeeklyData(param1:int) : void
      {
         var_1818.offset = param1;
         var_1818.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetFriendsWeeklyData(param1:int) : void
      {
         var_1853.offset = param1;
         var_1853.revertToDefaultView(_selectedGame);
      }
      
      private function get visible() : Boolean
      {
         return _window && _window.visible;
      }
      
      private function set visible(param1:Boolean) : void
      {
         if(param1 && !_window)
         {
            createMainWindow();
         }
         if(param1)
         {
            _window.visible = true;
            _window.activate();
         }
         else if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function createMainWindow() : void
      {
         var _loc2_:IWindow = null;
         var _loc1_:IWindow = null;
         if(!_window)
         {
            _window = WindowUtils.createWindow("snowwar_leaderboard",1) as IWindowContainer;
            _window.center();
            _window.findChildByTag("close").addEventListener("WME_CLICK",onClose);
            var_19 = _window.findChildByName("list") as IItemListWindow;
            _listBorder = _window.findChildByName("listBorder");
            var_3660 = _window.findChildByName("changeView") as ITextLinkWindow;
            var_3660.addEventListener("WME_CLICK",onChangeView);
            var_3708 = _window.findChildByName("changeGroupView") as ITextLinkWindow;
            var_3708.addEventListener("WME_CLICK",onChangeGroupView);
            var_3838 = _window.findChildByName("changeFriendsView") as ITextLinkWindow;
            var_3838.addEventListener("WME_CLICK",onChangeFriendsView);
            _loc2_ = _window.findChildByName("all_time_region");
            _loc2_.addEventListener("WME_DOWN",onAllTimeButtonDown);
            _loc1_ = _window.findChildByName("this_week_region");
            _loc1_.addEventListener("WME_DOWN",onThisWeekButtonDown);
            var_3409 = _window.findChildByName("all_time_image") as IBitmapWrapperWindow;
            var_3397 = _window.findChildByName("this_week_image") as IBitmapWrapperWindow;
            var_3565 = _window.findChildByName("all_time_text") as ITextWindow;
            var_2800 = _window.findChildByName("this_week_text") as ITextWindow;
            var_2626 = _window.findChildByName("scrollUp") as IRegionWindow;
            addScrollButtonEventListeners(var_2626);
            WindowUtils.setElementImage(var_2626.getChildAt(0),getBitmap("scroll_up_normal"));
            var_3286 = _window.findChildByName("scrollDown") as IRegionWindow;
            addScrollButtonEventListeners(var_3286);
            WindowUtils.setElementImage(var_3286.getChildAt(0),getBitmap("scroll_down_normal"));
            _nextWeek = _window.findChildByName("nextWeek") as IRegionWindow;
            _nextWeek.addEventListener("WME_CLICK",onNextWeekButton);
            _nextWeek.visible = false;
            _previousWeek = _window.findChildByName("previousWeek") as IRegionWindow;
            _previousWeek.addEventListener("WME_CLICK",onPreviousWeekButton);
            _previousWeek.visible = false;
            updateScrollButtons();
            updateWeekSelection();
         }
      }
      
      private function addScrollButtonEventListeners(param1:IWindow) : void
      {
         param1.addEventListener("WME_CLICK",onScrollButton);
         param1.addEventListener("WME_OVER",onScrollButton);
         param1.addEventListener("WME_OUT",onScrollButton);
         param1.addEventListener("WME_DOWN",onScrollButton);
         param1.addEventListener("WME_UP",onScrollButton);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function onChangeView(param1:WindowMouseEvent) : void
      {
         switch(var_149 - 1)
         {
            case 0:
               showAllTime();
               break;
            case 1:
               showWeekly();
               break;
            default:
               var_149 = 2;
               showWeekly();
         }
      }
      
      private function onChangeFriendsView(param1:WindowMouseEvent) : void
      {
         switch(var_149)
         {
            case 0:
               showFriendsAllTime();
               break;
            case 3:
               showFriendsWeekly();
               break;
            default:
               var_149 = 3;
               showFriendsWeekly();
         }
      }
      
      private function onChangeGroupView(param1:WindowMouseEvent) : void
      {
         switch(var_149 - 4)
         {
            case 0:
               showGroupWeekly();
               break;
            case 1:
               showGroupAllTime();
               break;
            default:
               var_149 = 4;
               showGroupWeekly();
         }
      }
      
      private function onAllTimeButtonDown(param1:WindowMouseEvent) : void
      {
         switch(var_149 - 2)
         {
            case 0:
               showAllTime();
               break;
            case 1:
               showFriendsAllTime();
               break;
            case 2:
               showGroupAllTime();
         }
      }
      
      private function onThisWeekButtonDown(param1:WindowMouseEvent) : void
      {
         switch(var_149)
         {
            case 0:
               showFriendsWeekly();
               break;
            case 1:
               showWeekly();
               break;
            case 5:
               showGroupWeekly();
         }
      }
      
      private function getCurrentLeaderboard() : LeaderboardTable
      {
         var _loc1_:LeaderboardTable = null;
         switch(var_149)
         {
            case 0:
               _loc1_ = var_2199;
               break;
            case 1:
               _loc1_ = var_2455;
               break;
            case 2:
               _loc1_ = var_1872;
               break;
            case 3:
               _loc1_ = var_1853;
               break;
            case 4:
               _loc1_ = var_1818;
               break;
            case 5:
               _loc1_ = var_2281;
               break;
            default:
               HabboGamesCom.log("Invalid state " + var_149);
         }
         return _loc1_;
      }
      
      private function onScrollUp() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && _loc1_.scrollUp())
         {
            populateList();
         }
      }
      
      private function onScrollDown() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && _loc1_.scrollDown())
         {
            populateList();
         }
      }
      
      private function onScrollButton(param1:WindowMouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = param1.window == var_2626 ? "up" : "down";
         switch(param1.type)
         {
            case "WME_CLICK":
               param1.window == var_2626 ? onScrollUp() : onScrollDown();
               return;
            case "WME_OUT":
               _loc4_ = "normal";
               break;
            case "WME_OVER":
               _loc4_ = "hilite";
               break;
            case "WME_DOWN":
               _loc4_ = "click";
               break;
            case "WME_UP":
               _loc4_ = "normal";
         }
         var _loc3_:String = "scroll_" + _loc5_ + "_" + _loc4_;
         var _loc2_:IWindowContainer = param1.window as IWindowContainer;
         WindowUtils.setElementImage(_loc2_.getChildAt(0),getBitmap(_loc3_));
      }
      
      private function onNextWeekButton(param1:WindowMouseEvent) : void
      {
         if(_nextWeek.visible)
         {
            switch(var_149 - 2)
            {
               case 0:
                  sendGetWeeklyData(var_1872.offset - 1);
                  break;
               case 1:
                  sendGetFriendsWeeklyData(var_1853.offset - 1);
                  break;
               case 2:
                  sendGetGroupWeeklyData(var_1818.offset - 1);
            }
         }
      }
      
      private function onPreviousWeekButton(param1:WindowMouseEvent) : void
      {
         if(_previousWeek.visible)
         {
            switch(var_149 - 2)
            {
               case 0:
                  sendGetWeeklyData(var_1872.offset + 1);
                  break;
               case 1:
                  sendGetFriendsWeeklyData(var_1853.offset + 1);
                  break;
               case 2:
                  sendGetGroupWeeklyData(var_1818 + 1);
            }
         }
      }
      
      private function updateWeekSelection() : void
      {
         var _loc1_:* = null;
         switch(var_149 - 2)
         {
            case 0:
               _nextWeek.visible = var_1872.offset > 0;
               _previousWeek.visible = var_1872.offset < var_1872.maxOffset;
               break;
            case 1:
               _nextWeek.visible = var_1853.offset > 0;
               _previousWeek.visible = var_1853.offset < var_1853.maxOffset;
               break;
            case 2:
               _nextWeek.visible = var_1818.offset > 0;
               _previousWeek.visible = var_1818.offset < var_1818.maxOffset;
               break;
            default:
               _nextWeek.visible = false;
               _previousWeek.visible = false;
         }
         if(_nextWeek.visible)
         {
            var_2800.caption = var_2628;
         }
         else
         {
            var_2800.caption = "${snowwar.leaderboard.this_week}";
         }
         switch(var_149 - 2)
         {
            case 0:
            case 1:
            case 2:
               if(!_nextWeek.visible)
               {
                  showTimeUntilWeeklyReset();
                  if(var_2481 == null)
                  {
                     startWeeklyResetTimer(_minutesUntilWeeklyReset);
                  }
                  break;
               }
            default:
               WindowUtils.hideElement(_window,"reset_text");
               disposeWeeklyResetTimer();
         }
      }
      
      private function showTimeUntilWeeklyReset() : void
      {
         WindowUtils.showElement(_window,"reset_text");
         var _loc4_:String = "snowwar.leaderboard.weekly_reset";
         var _loc3_:int = convertToDays(_minutesUntilWeeklyReset);
         var _loc1_:int = convertToHours(_minutesUntilWeeklyReset);
         var _loc2_:int = convertToMinutes(_minutesUntilWeeklyReset);
         _localization.registerParameter(_loc4_,"days","" + convertToDays(_minutesUntilWeeklyReset));
         _localization.registerParameter(_loc4_,"hours","" + convertToHours(_minutesUntilWeeklyReset));
         _localization.registerParameter(_loc4_,"minutes","" + convertToMinutes(_minutesUntilWeeklyReset));
         WindowUtils.setCaption(_window.findChildByName("reset_text"),"${" + _loc4_ + "}");
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(!_nextWeek.visible && (var_149 == 2 || var_149 == 3))
         {
            if(_minutesUntilWeeklyReset > 0)
            {
               _minutesUntilWeeklyReset--;
            }
            showTimeUntilWeeklyReset();
         }
      }
      
      private function convertToDays(param1:int) : int
      {
         return Math.floor(param1 / 60 / 24);
      }
      
      private function convertToHours(param1:int) : int
      {
         var _loc2_:int = convertToDays(param1);
         return Math.floor((param1 - _loc2_ * 24 * 60) / 60);
      }
      
      private function convertToMinutes(param1:int) : int
      {
         var _loc3_:int = convertToDays(param1);
         var _loc2_:int = convertToHours(param1);
         return param1 - _loc3_ * 24 * 60 - _loc2_ * 60;
      }
      
      private function getData() : Array
      {
         switch(var_149)
         {
            case 0:
               return var_2199.getVisibleEntries();
            case 1:
               return var_2455.getVisibleEntries();
            case 2:
               return var_1872.getVisibleEntries();
            case 3:
               return var_1853.getVisibleEntries();
            case 4:
               return var_1818.getVisibleEntries();
            case 5:
               return var_2281.getVisibleEntries();
            default:
               return null;
         }
      }
      
      private function getFavouriteGroupId() : int
      {
         switch(var_149 - 4)
         {
            case 0:
               return var_1818.favouriteGroupId;
            case 1:
               return var_2281.favouriteGroupId;
            default:
               return -1;
         }
      }
      
      private function populateList() : void
      {
         var _loc8_:class_1729 = null;
         var _loc15_:IWindowContainer = null;
         var _loc11_:* = false;
         var _loc13_:Boolean = false;
         var _loc1_:Boolean = false;
         var _loc2_:IWindowContainer = null;
         var _loc6_:IWindow = null;
         var _loc7_:int = 0;
         var _loc14_:IWindowContainer = null;
         var _loc3_:IWindowContainer = null;
         var _loc4_:Array = getData();
         var _loc10_:int = getFavouriteGroupId();
         var _loc9_:int = var_1655.sessionDataManager.userId;
         if(!_loc4_ || _loc4_.length == 0)
         {
            var_19.visible = false;
            _listBorder.visible = false;
            return;
         }
         var _loc5_:int = 0;
         var_19.destroyListItems();
         var _loc12_:IWindowContainer = WindowUtils.createWindow("snowwar_leaderboard_entry") as IWindowContainer;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc8_ = _loc4_[_loc5_])
            {
               (_loc15_ = _loc12_.clone() as IWindowContainer).findChildByName("rank").caption = _loc8_.rank.toString();
               _loc15_.findChildByName("score").caption = _loc8_.score.toString();
               _loc15_.findChildByName("name").caption = _loc8_.name;
               if(_loc11_ = _loc8_.gender == "g")
               {
                  setGroupBadgeImage(_loc15_.findChildByName("avatarImage") as IBitmapWrapperWindow,_loc8_.figure);
               }
               else
               {
                  setAvatarImage(_loc15_.findChildByName("avatarImage") as IBitmapWrapperWindow,_loc8_.figure,_loc8_.gender);
               }
               _loc1_ = (_loc13_ = var_149 == 1 || var_149 == 5) && (_loc8_.userId == _loc9_ || _loc11_ && _loc8_.userId == _loc10_);
               if(!_loc11_ && _loc8_.userId != var_1655.sessionDataManager.userId || _loc11_ && _loc8_.userId != _loc10_ || _loc1_ && _loc5_ < _loc4_.length - 1)
               {
                  _loc15_.findChildByName("highlight").visible = false;
                  _loc15_.findChildByName("divider").visible = false;
                  _loc2_ = var_19.getListItemAt(var_19.numListItems - 1) as IWindowContainer;
                  if(_loc2_)
                  {
                     _loc2_.findChildByName("divider").visible = false;
                  }
               }
               _loc15_.findChildByName("imageRegion").id = _loc8_.userId;
               if(_loc8_.gender == "g")
               {
                  _loc15_.findChildByName("imageRegion").addEventListener("WME_CLICK",onGroupImageRegion);
               }
               else
               {
                  _loc15_.findChildByName("imageRegion").addEventListener("WME_CLICK",onImageRegion);
               }
               var_19.addListItem(_loc15_);
            }
            _loc5_++;
         }
         if(var_149 == 1 || var_149 == 5 || var_149 == 2 || var_149 == 4)
         {
            if(_loc5_ % var_2199.viewSize != 0)
            {
               _loc6_ = var_19.getListItemAt(var_19.numListItems - 1);
               _loc7_ = 0;
               while(_loc7_ < _loc5_ % var_2199.viewSize - 1)
               {
                  (_loc14_ = _loc12_.clone() as IWindowContainer).findChildByName("rank").caption = "";
                  _loc14_.findChildByName("score").caption = "";
                  _loc14_.findChildByName("name").caption = "";
                  _loc14_.findChildByName("highlight").visible = false;
                  _loc14_.findChildByName("divider").visible = false;
                  _loc3_ = var_19.getListItemAt(var_19.numListItems - 1) as IWindowContainer;
                  if(_loc3_)
                  {
                     _loc3_.findChildByName("divider").visible = false;
                  }
                  _loc14_.removeChild(_loc14_.findChildByName("imageRegion"));
                  var_19.addListItem(_loc14_);
                  _loc7_++;
               }
               var_19.addListItem(_loc6_);
            }
         }
         _loc12_.dispose();
         if(_loc12_ = var_19.getListItemAt(var_19.numListItems - 1) as IWindowContainer)
         {
            _loc12_.findChildByName("divider").visible = false;
         }
         var_19.visible = true;
         _listBorder.visible = true;
         updateScrollButtons();
         _window.invalidate();
      }
      
      private function setGroupBadgeImage(param1:IBitmapWrapperWindow, param2:String) : *
      {
         var _loc3_:BitmapData = var_1655.sessionDataManager.getGroupBadgeImage(param2);
         if(_loc3_)
         {
            _avatarPlaceholders.remove(param2);
            _avatarPlaceholders.add(param2,param1);
            WindowUtils.setElementImage(param1,_loc3_);
            _loc3_.dispose();
         }
      }
      
      private function setAvatarImage(param1:IBitmapWrapperWindow, param2:String, param3:String = null) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:class_3374;
         if(_loc5_ = var_1655.avatarManager.createAvatarImage(param2,"h",param3,this))
         {
            _loc5_.setDirection("full",2);
            _loc4_ = _loc5_.getCroppedImage("head");
            if(_loc5_.isPlaceholder())
            {
               _avatarPlaceholders.remove(param2);
               _avatarPlaceholders.add(param2,param1);
            }
            _loc5_.dispose();
         }
         WindowUtils.setElementImage(param1,_loc4_);
         _loc4_.dispose();
      }
      
      private function onImageRegion(param1:WindowMouseEvent) : void
      {
         var_1655.groupsManager.showExtendedProfile(param1.window.id);
      }
      
      private function onGroupImageRegion(param1:WindowMouseEvent) : void
      {
         var_1655.groupsManager.showGroupBadgeInfo(false,param1.window.id);
      }
      
      private function updateScrollButtons() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && var_4494)
         {
            var_2626.visible = _loc1_.canScrollUp();
            var_3286.visible = _loc1_.canScrollDown();
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc2_:IAsset = var_1655.assets.getAssetByName(param1);
         if(_loc2_)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
   }
}
