package com.sulake.habbo.notifications.singular
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.class_3540;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class SingularNotificationController implements IUpdateReceiver
   {
      
      private static const MODERATION_DISCLAIMER_DELAY_MS:int = 5000;
       
      
      private var _notifications:HabboNotifications;
      
      private var var_3504:Array;
      
      private var var_3093:Map;
      
      private var var_2444:HabboNotificationViewManager;
      
      private var var_3052:HabboAlertDialogManager;
      
      private var var_4355:Boolean;
      
      private var var_2712:ClubGiftNotification;
      
      private var var_2480:SafetyLockedNotification;
      
      private var var_4874:Dictionary;
      
      private var var_2192:Timer;
      
      private var var_318:Boolean;
      
      public function SingularNotificationController(param1:HabboNotifications)
      {
         var _loc5_:int = 0;
         var _loc7_:Map = null;
         var _loc3_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         super();
         _notifications = param1;
         var_3504 = [];
         var_3093 = new Map();
         var_4874 = new Dictionary();
         var_3052 = new HabboAlertDialogManager(_notifications.windowManager,_notifications.localization,_notifications.habboHelp);
         var _loc8_:IAsset = _notifications.assetLibrary.getAssetByName("habbo_notifications_config_xml");
         var _loc2_:XmlAsset = XmlAsset(_loc8_);
         if(_loc2_ != null)
         {
            class_3540.parseVariableList(XML(_loc2_.content).children(),var_3093);
         }
         var _loc6_:Map;
         if((_loc6_ = var_3093["styles"]) != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               if((_loc7_ = _loc6_.getWithIndex(_loc5_))["icon"] != null)
               {
                  _loc3_ = _notifications.assetLibrary.getAssetByName(_loc7_["icon"]) as BitmapDataAsset;
                  _loc4_ = _loc3_.content as BitmapData;
                  _loc7_["icon"] = _loc4_;
               }
               _loc5_++;
            }
         }
         var_2444 = new HabboNotificationViewManager(_notifications,_notifications.assetLibrary,_notifications.windowManager,_notifications.toolBar,var_3093["styles"],var_3093["view"]);
         _notifications.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImage);
         _notifications.registerUpdateReceiver(this,2);
      }
      
      public function get alertDialogManager() : HabboAlertDialogManager
      {
         return var_3052;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function dispose() : void
      {
         if(var_2192)
         {
            var_2192.removeEventListener("timerComplete",onShowModerationDisclaimer);
            var_2192 = null;
         }
         if(var_2444 != null)
         {
            var_2444.dispose();
            var_2444 = null;
         }
         if(var_3052 != null)
         {
            var_3052.dispose();
            var_3052 = null;
         }
         if(var_2712 != null)
         {
            var_2712.dispose();
            var_2712 = null;
         }
         if(var_2480 != null)
         {
            var_2480.dispose();
            var_2480 = null;
         }
         if(_notifications != null)
         {
            _notifications.removeUpdateReceiver(this);
            _notifications = null;
         }
         var_318 = true;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:HabboNotificationItem = null;
         if(var_3504.length > 0 && var_2444.isSpaceAvailable())
         {
            _loc2_ = getNextItemFromQueue();
            if(!var_2444.showItem(_loc2_))
            {
               _loc2_.dispose();
            }
         }
      }
      
      public function addItem(param1:String, param2:String, param3:BitmapData, param4:String = null, param5:String = null, param6:String = null) : int
      {
         if(_notifications.disabled)
         {
            return 0;
         }
         var _loc8_:Map;
         if((_loc8_ = var_3093["styles"]) == null)
         {
            return 0;
         }
         var _loc10_:Map;
         if((_loc10_ = _loc8_[param2]) == null)
         {
            return 0;
         }
         var _loc9_:HabboNotificationItemStyle = new HabboNotificationItemStyle(_loc10_,param3,param4,true,param5);
         if(param6)
         {
            _loc9_.internalLink = param6;
         }
         var _loc7_:HabboNotificationItem = new HabboNotificationItem(param1,_loc9_,this);
         var_3504.push(_loc7_);
         return var_3504.length;
      }
      
      private function getNextItemFromQueue() : HabboNotificationItem
      {
         var _loc1_:Array = var_3504.splice(0,1);
         return _loc1_[0] as HabboNotificationItem;
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         _notifications.localization.registerParameter("soundmachine.notification.playing","songname",param1);
         _notifications.localization.registerParameter("soundmachine.notification.playing","songauthor",param2);
         var _loc3_:ILocalization = _notifications.localization.getLocalizationRaw("soundmachine.notification.playing");
         if(_loc3_)
         {
            addItem(_loc3_.value,"soundmachine",null);
         }
      }
      
      public function onInternalLink(param1:String) : void
      {
         _notifications.createLinkEvent(param1);
      }
      
      private function onShowModerationDisclaimer(param1:TimerEvent) : void
      {
         var_2192.removeEventListener("timerComplete",onShowModerationDisclaimer);
         var_2192 = null;
         showModerationDisclaimer();
      }
      
      public function showModerationDisclaimer() : void
      {
         var _loc1_:String = null;
         if(RoomEnterEffect.isRunning())
         {
            if(var_2192 == null)
            {
               var_2192 = new Timer(RoomEnterEffect.totalRunningTime + 5000,1);
               var_2192.addEventListener("timerComplete",onShowModerationDisclaimer);
               var_2192.start();
            }
         }
         else if(!var_4355)
         {
            _loc1_ = String(_notifications.localization.getLocalization("mod.chatdisclaimer","NA"));
            this.addItem(_loc1_,"info",null);
            var_4355 = true;
            class_14.log("DISPLAYED MOD INFO: " + _loc1_);
         }
      }
      
      public function showClubGiftNotification(param1:int) : void
      {
         if(var_2712 && (var_2712.visible || var_2712.isCancelled))
         {
            return;
         }
         var_2712 = new ClubGiftNotification(param1,_notifications.assets,_notifications.windowManager,_notifications.catalog,_notifications.toolBar);
      }
      
      public function showSafetyLockedNotification(param1:int) : void
      {
         if(var_2480 && var_2480.visible)
         {
            return;
         }
         var_2480 = new SafetyLockedNotification(param1,_notifications.assets,_notifications.windowManager,_notifications.catalog,_notifications.toolBar);
      }
      
      public function hideSafetyLockedNotification() : void
      {
         if(!var_2480)
         {
            return;
         }
         var_2480.dispose();
      }
      
      private function onBadgeImage(param1:BadgeImageReadyEvent) : void
      {
         if(param1 != null && this.var_2444 != null)
         {
            var_2444.replaceIcon(param1);
         }
      }
   }
}
