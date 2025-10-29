package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
   import com.sulake.habbo.notifications.singular.MOTDNotification;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1540;
   import com.sulake.habbo.communication.messages.parser.users.class_1585;
   import com.sulake.habbo.communication.messages.parser.handshake.class_1267;
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1451;
   import com.sulake.habbo.communication.messages.parser.room.furniture.class_1137;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1303;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1324;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1578;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1438;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1657;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1679;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetReceivedMessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.class_1271;
   import com.sulake.habbo.communication.messages.parser.notifications.class_1361;
   import com.sulake.habbo.communication.messages.parser.notifications.class_1422;
   import com.sulake.habbo.communication.messages.parser.notifications.class_1434;
   import com.sulake.habbo.communication.messages.parser.notifications.class_1452;
   import com.sulake.habbo.communication.messages.parser.notifications.class_1505;
   import com.sulake.habbo.communication.messages.parser.availability.class_1211;
   import com.sulake.habbo.communication.messages.parser.availability.class_1248;
   import com.sulake.habbo.communication.messages.parser.availability.class_1255;
   import com.sulake.habbo.communication.messages.parser.availability.class_1528;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.NotificationDialogMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.RestoreClientMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorCautionEvent;
   import com.sulake.habbo.communication.messages.incoming.users.AccountSafetyLockStatusChangeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1718;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent;
   
   [SecureSWF(rename="true")]
   public class class_3353
   {
       
      
      private var _notifications:HabboNotifications;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private const CALL_FOR_HELP_NOTIFICATION_TYPE:String = "cfh.created";
      
      public function class_3353(param1:HabboNotifications, param2:IHabboCommunicationManager)
      {
         super();
         _notifications = param1;
         _communication = param2;
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new ModeratorMessageEvent(onModMessageEvent));
         addMessageEvent(new RespectNotificationMessageEvent(onRespectNotification));
         addMessageEvent(new MaintenanceStatusMessageEvent(onHotelMaintenance));
         addMessageEvent(new PetLevelNotificationEvent(onPetLevelNotification));
         addMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosing));
         addMessageEvent(new InfoFeedEnableMessageEvent(onInfoFeedEnable));
         addMessageEvent(new UserObjectEvent(onUserObject));
         addMessageEvent(new MOTDNotificationEvent(onMOTD));
         addMessageEvent(new HabboBroadcastMessageEvent(onBroadcastMessageEvent));
         addMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointNotification));
         addMessageEvent(new NotificationDialogMessageEvent(onNotificationDialogMessageEvent));
         addMessageEvent(new ClubGiftSelectedEvent(onClubGiftSelected));
         addMessageEvent(new UserBannedMessageEvent(onUserBannedMessageEvent));
         addMessageEvent(new OpenConnectionMessageEvent(onRoomEnter));
         addMessageEvent(new PetReceivedMessageEvent(onPetReceived));
         addMessageEvent(new PetRespectFailedEvent(onPetRespectFailed));
         addMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
         addMessageEvent(new ModeratorCautionEvent(onModCautionEvent));
         addMessageEvent(new ClubGiftNotificationEvent(onClubGiftNotification));
         addMessageEvent(new HabboAchievementNotificationMessageEvent(onLevelUp));
         addMessageEvent(new LoginFailedHotelClosedMessageEvent(onLoginFailedHotelClosed));
         addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         addMessageEvent(new RoomMessageNotificationMessageEvent(onRoomMessagesNotification));
         addMessageEvent(new RestoreClientMessageEvent(onRestoreClientMessageEvent));
         addMessageEvent(new AccountSafetyLockStatusChangeMessageEvent(onAccountSafetyLockStatusChanged));
         _notifications.activate();
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      public function dispose() : void
      {
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         _messageEvents = null;
         _notifications = null;
         _communication = null;
      }
      
      private function useNotificationFeed() : Boolean
      {
         return _notifications.getBoolean("notification.feed.enabled");
      }
      
      private function useNotifications() : Boolean
      {
         return _notifications.getBoolean("notification.items.enabled");
      }
      
      internal function onMOTD(param1:IMessageEvent) : void
      {
         var _loc4_:GenericNotificationItemData = null;
         var _loc5_:MOTDNotificationEvent;
         var _loc3_:class_1361 = (_loc5_ = param1 as MOTDNotificationEvent).getParser() as class_1361;
         if(_loc3_.messages && _loc3_.messages.length > 0)
         {
            if(useNotifications())
            {
               new MOTDNotification(_loc3_.messages,_notifications.assetLibrary,_notifications.windowManager);
            }
            if(useNotificationFeed())
            {
               for each(var _loc2_ in _loc3_.messages)
               {
                  (_loc4_ = new GenericNotificationItemData()).title = _loc2_;
                  _loc4_.timeStamp = getTimer();
                  _notifications.feedController.addFeedItem(3,_loc4_);
               }
            }
         }
      }
      
      private function onLevelUp(param1:IMessageEvent) : void
      {
         var _loc2_:HabboAchievementNotificationMessageEvent = param1 as HabboAchievementNotificationMessageEvent;
         var _loc3_:class_1271 = _loc2_.getParser();
         var _loc4_:String = String(_notifications.localization.getLocalization("achievements.levelup.desc",""));
         var _loc6_:String = String(_notifications.localization.getBadgeName(_loc3_.data.badgeCode));
         var _loc5_:BitmapData = _notifications.sessionDataManager.requestBadgeImage(_loc3_.data.badgeCode);
         _notifications.singularController.addItem(_loc4_ + " " + _loc6_,"achievement",_loc5_,null,_loc3_.data.badgeCode,"questengine/achievements/" + _loc3_.data.category);
      }
      
      internal function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc4_:ILocalization = null;
         var _loc2_:ILocalization = null;
         var _loc3_:RespectNotificationMessageEvent = param1 as RespectNotificationMessageEvent;
         if(_notifications.sessionDataManager.userId == _loc3_.userId)
         {
            _notifications.localization.registerParameter("notifications.text.respect.2","count",String(_loc3_.respectTotal));
            _loc4_ = _notifications.localization.getLocalizationRaw("notifications.text.respect.1");
            _loc2_ = _notifications.localization.getLocalizationRaw("notifications.text.respect.2");
            if(_loc4_)
            {
               _notifications.singularController.addItem(_loc4_.value,"respect",null);
            }
            if(_loc2_)
            {
               _notifications.singularController.addItem(_loc2_.value,"respect",null);
            }
         }
      }
      
      private function onRoomMessagesNotification(param1:RoomMessageNotificationMessageEvent) : void
      {
         var _loc2_:ILocalization = null;
         var _loc3_:class_1137 = param1.getParser();
         var _loc5_:String = "roommessagesposted";
         _notifications.localization.registerParameter("notifications.text.room.messages.posted","room_name",_loc3_.roomName);
         _notifications.localization.registerParameter("notifications.text.room.messages.posted","messages_count",_loc3_.messageCount.toString());
         _loc2_ = _notifications.localization.getLocalizationRaw("notifications.text.room.messages.posted");
         var _loc6_:BitmapDataAsset;
         var _loc4_:BitmapData = (_loc6_ = _notifications.assets.getAssetByName("if_icon_temp_png") as BitmapDataAsset).content as BitmapData;
         if(_loc2_)
         {
            _notifications.singularController.addItem(_loc2_.value,_loc5_,_loc4_.clone());
         }
      }
      
      private function onInfoFeedEnable(param1:IMessageEvent) : void
      {
         var _loc2_:InfoFeedEnableMessageEvent = param1 as InfoFeedEnableMessageEvent;
         if(_loc2_ != null)
         {
            _notifications.disabled = !_loc2_.enabled;
         }
      }
      
      private function onModCautionEvent(param1:IMessageEvent) : void
      {
         var _loc3_:GenericNotificationItemData = null;
         var _loc2_:class_1578 = (param1 as ModeratorCautionEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         if(useNotifications())
         {
            _notifications.singularController.alertDialogManager.handleModeratorCaution(_loc2_.message,_loc2_.url);
         }
         if(useNotificationFeed())
         {
            _loc3_ = new GenericNotificationItemData();
            _loc3_.title = _loc2_.message;
            _loc3_.buttonAction = _loc2_.url;
            _loc3_.buttonCaption = _loc2_.url;
            _loc3_.timeStamp = getTimer();
            _notifications.feedController.addFeedItem(3,_loc3_);
         }
      }
      
      private function onModMessageEvent(param1:IMessageEvent) : void
      {
         var _loc3_:GenericNotificationItemData = null;
         var _loc2_:class_1324 = (param1 as ModeratorMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         if(useNotifications())
         {
            _notifications.singularController.alertDialogManager.handleModeratorMessage(_loc2_.message,_loc2_.url);
         }
         if(useNotificationFeed())
         {
            _loc3_ = new GenericNotificationItemData();
            _loc3_.title = _loc2_.message;
            _loc3_.buttonAction = _loc2_.url;
            _loc3_.buttonCaption = _loc2_.url;
            _loc3_.timeStamp = getTimer();
            _notifications.feedController.addFeedItem(3,_loc3_);
         }
      }
      
      private function onUserBannedMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:class_1303 = (param1 as UserBannedMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleUserBannedMessage(_loc2_.message);
      }
      
      private function onHotelClosing(param1:IMessageEvent) : void
      {
         var _loc2_:class_1255 = (param1 as InfoHotelClosingMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelClosingMessage(_loc2_.minutesUntilClosing);
      }
      
      private function onHotelMaintenance(param1:IMessageEvent) : void
      {
         var _loc2_:class_1211 = (param1 as MaintenanceStatusMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelMaintenanceMessage(_loc2_.minutesUntilMaintenance,_loc2_.duration);
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:class_1248 = (param1 as InfoHotelClosedMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute,_loc2_.userThrownOutAtClose);
      }
      
      private function onLoginFailedHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:class_1528 = (param1 as LoginFailedHotelClosedMessageEvent).getParser();
         if(_loc2_ == null || _notifications.singularController.alertDialogManager == null)
         {
            return;
         }
         _notifications.singularController.alertDialogManager.handleLoginFailedHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute);
      }
      
      private function onRestoreClientMessageEvent(param1:IMessageEvent) : void
      {
         HabboWebTools.closeWebPageAndRestoreClient();
      }
      
      private function onPetLevelNotification(param1:PetLevelNotificationEvent) : void
      {
         var _loc2_:class_1657 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:class_1422 = param1.getParser();
         _notifications.localization.registerParameter("notifications.text.petlevel","pet_name",_loc4_.petName);
         _notifications.localization.registerParameter("notifications.text.petlevel","level",_loc4_.level.toString());
         var _loc3_:ILocalization = _notifications.localization.getLocalizationRaw("notifications.text.petlevel");
         if(_loc3_)
         {
            _loc2_ = _loc4_.figureData;
            _loc5_ = _notifications.petImageUtility.getPetImage(_loc2_.typeId,_loc2_.paletteId,_loc2_.color);
            _notifications.singularController.addItem(_loc3_.value,"petlevel",_loc5_);
         }
      }
      
      private function onPetReceived(param1:PetReceivedMessageEvent) : void
      {
         var _loc2_:ILocalization = null;
         var _loc4_:class_1679 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:class_1438 = param1.getParser();
         if(_loc3_.boughtAsGift)
         {
            _loc2_ = _notifications.localization.getLocalizationRaw("notifications.text.petbought");
         }
         else
         {
            _loc2_ = _notifications.localization.getLocalizationRaw("notifications.text.petreceived");
         }
         if(_loc2_)
         {
            _loc4_ = _loc3_.pet;
            _loc5_ = _notifications.petImageUtility.getPetImage(_loc4_.typeId,_loc4_.paletteId,_loc4_.color);
            _notifications.singularController.addItem(_loc2_.value,"petlevel",_loc5_);
         }
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         _notifications.singularController.showModerationDisclaimer();
      }
      
      private function onBroadcastMessageEvent(param1:IMessageEvent) : void
      {
         var _loc4_:class_1434;
         var _loc2_:String = (_loc4_ = (param1 as HabboBroadcastMessageEvent).getParser()).messageText;
         var _loc3_:RegExp = /\\r/g;
         _loc2_ = _loc2_.replace(_loc3_,"\r");
         _notifications.windowManager.simpleAlert("${notifications.broadcast.title}","",_loc2_,"","",null,"illumina_alert_illustrations_frank_neutral_png");
      }
      
      private function onNotificationDialogMessageEvent(param1:NotificationDialogMessageEvent) : void
      {
         var _loc2_:class_1505 = param1.getParser();
         if("cfh.created" == _loc2_.type)
         {
            showCallCreatedNotification(_loc2_.parameters["message"],_loc2_.parameters["linkUrl"]);
         }
         else
         {
            _notifications.showNotification(_loc2_.type,_loc2_.parameters);
         }
      }
      
      private function showCallCreatedNotification(param1:String, param2:String) : void
      {
         var _loc3_:String = param1.replace(/\\r/g,"\r");
         if(param2 != null)
         {
            _notifications.windowManager.simpleAlert("${help.cfh.sent.title}","",_loc3_,"${help.main.faq.link.text}",param2,null,"illumina_alert_illustrations_frank_neutral_png");
         }
         else
         {
            _notifications.windowManager.simpleAlert("${help.cfh.sent.title}","",_loc3_,null,null,null,"illumina_alert_illustrations_frank_neutral_png");
         }
      }
      
      private function onPetRespectFailed(param1:IMessageEvent) : void
      {
         var _loc2_:class_1451 = (param1 as PetRespectFailedEvent).getParser();
         this._notifications.localization.registerParameter("room.error.pets.respectfailed","required_age","" + _loc2_.requiredDays);
         this._notifications.localization.registerParameter("room.error.pets.respectfailed","avatar_age","" + _loc2_.avatarAgeInDays);
         _notifications.windowManager.alert("${error.title}","${room.error.pets.respectfailed}",0,onAlert);
      }
      
      public function onAlert(param1:class_3348, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK" || param2.type == "WE_CANCEL")
         {
            param1.dispose();
         }
      }
      
      private function onClubGiftNotification(param1:ClubGiftNotificationEvent) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:class_1452 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.numGifts < 1)
         {
            return;
         }
         _notifications.singularController.showClubGiftNotification(_loc2_.numGifts);
      }
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         var _loc2_:class_1267 = param1.getParser();
         if(_loc2_.accountSafetyLocked)
         {
            _notifications.singularController.showSafetyLockedNotification(_loc2_.id);
         }
      }
      
      private function onAccountSafetyLockStatusChanged(param1:AccountSafetyLockStatusChangeMessageEvent) : void
      {
         var _loc2_:class_1585 = param1.getParser();
         if(_loc2_.status == 1)
         {
            _notifications.singularController.hideSafetyLockedNotification();
         }
      }
      
      private function onClubGiftSelected(param1:ClubGiftSelectedEvent) : void
      {
         if(!param1 || !_notifications.localization)
         {
            return;
         }
         var _loc3_:class_1540 = param1.getParser();
         if(!_loc3_)
         {
            return;
         }
         var _loc6_:Array;
         if(!(_loc6_ = _loc3_.products) || _loc6_.length == 0)
         {
            return;
         }
         var _loc2_:class_1718 = _loc6_[0] as class_1718;
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:String = String(_notifications.localization.getLocalization("notifications.text.club_gift.received"));
         var _loc4_:BitmapData = _notifications.productImageUtility.getProductImage(_loc2_.productType,_loc2_.furniClassId,_loc2_.extraParam);
         _notifications.singularController.addItem(_loc5_,"info",_loc4_);
      }
      
      private function onActivityPointNotification(param1:HabboActivityPointNotificationMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:BitmapData = null;
         if(param1.change <= 0)
         {
            return;
         }
         switch(param1.type - 5)
         {
            case 0:
               _loc3_ = String(_notifications.localization.getLocalizationWithParams("notifications.text.loyalty.received","","amount",param1.change));
               _loc2_ = _notifications.assets.getAssetByName("if_icon_diamond_png").content as BitmapData;
               _notifications.singularController.addItem(_loc3_,"info",_loc2_.clone());
               return;
            default:
               return;
         }
      }
   }
}
