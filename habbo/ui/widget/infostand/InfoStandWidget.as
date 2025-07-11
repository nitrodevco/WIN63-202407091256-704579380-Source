package com.sulake.habbo.ui.widget.infostand
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetFigureUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class InfoStandWidget extends RoomWidgetBase
   {
       
      
      private const USER_VIEW:String = "infostand_user_view";
      
      private const const_821:String = "infostand_furni_view";
      
      private const PET_VIEW:String = "infostand_pet_view";
      
      private const BOT_VIEW:String = "infostand_bot_view";
      
      private const RENTABLE_BOT_VIEW:String = "infostand_rentable_bot_view";
      
      private const const_1203:String = "infostand_jukebox_view";
      
      private const CRACKABLE_FURNI_VIEW:String = "infostand_crackable_furni_view";
      
      private const SONGDISK_VIEW:String = "infostand_songdisk_view";
      
      private var var_2760:InfoStandFurniView;
      
      private var var_1820:InfoStandUserView;
      
      private var var_1951:InfoStandPetView;
      
      private var var_2090:InfoStandBotView;
      
      private var var_2490:InfoStandRentableBotView;
      
      private var var_2789:InfoStandJukeboxView;
      
      private var var_3051:InfoStandCrackableFurniView;
      
      private var var_2968:InfoStandSongDiskView;
      
      private var var_4990:Array;
      
      private var var_3308:InfoStandUserData;
      
      private var var_1691:InfoStandFurniData;
      
      private var var_328:InfoStandPetData;
      
      private var var_4093:InfoStandRentableBotData;
      
      private var var_1647:IWindowContainer;
      
      private var var_1794:Timer;
      
      private var _config:ICoreConfiguration;
      
      private const UPDATE_INTERVAL_MS:int = 3000;
      
      public function InfoStandWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:ICoreConfiguration, param6:IHabboCatalog)
      {
         super(param1,param2,param3,param4);
         _config = param5;
         var_2760 = new InfoStandFurniView(this,"infostand_furni_view",param6);
         var_1820 = new InfoStandUserView(this,"infostand_user_view");
         var_1951 = new InfoStandPetView(this,"infostand_pet_view",param6);
         var_2090 = new InfoStandBotView(this,"infostand_bot_view");
         var_2490 = new InfoStandRentableBotView(this,"infostand_rentable_bot_view",param6);
         var_2789 = new InfoStandJukeboxView(this,"infostand_jukebox_view",param6);
         var_3051 = new InfoStandCrackableFurniView(this,"infostand_crackable_furni_view",param6);
         var_2968 = new InfoStandSongDiskView(this,"infostand_songdisk_view",param6);
         var_3308 = new InfoStandUserData();
         var_1691 = new InfoStandFurniData();
         var_328 = new InfoStandPetData();
         var_4093 = new InfoStandRentableBotData();
         var_1794 = new Timer(3000);
         var_1794.addEventListener("timer",onUpdateTimer);
         mainContainer.visible = false;
         this.handler.widget = this;
      }
      
      public function get handler() : InfoStandWidgetHandler
      {
         return var_1653 as InfoStandWidgetHandler;
      }
      
      public function get furniView() : InfoStandFurniView
      {
         return var_2760;
      }
      
      override public function get mainWindow() : IWindow
      {
         return mainContainer;
      }
      
      public function get config() : ICoreConfiguration
      {
         return _config;
      }
      
      public function get mainContainer() : IWindowContainer
      {
         if(var_1647 == null)
         {
            var_1647 = windowManager.createWindow("infostand_main_container","",4,0,0,new Rectangle(0,0,50,100)) as IWindowContainer;
            var_1647.tags.push("room_widget_infostand");
            var_1647.background = true;
            var_1647.color = 0;
         }
         return var_1647;
      }
      
      public function favouriteGroupUpdated(param1:int, param2:int, param3:int, param4:String) : void
      {
         var _loc6_:String = null;
         if(!userData || userData.userRoomId != param1)
         {
            return;
         }
         if(!mainContainer)
         {
            return;
         }
         var _loc5_:IWindow;
         if(!(_loc5_ = mainContainer.findChildByName("infostand_user_view")) || !_loc5_.visible)
         {
            return;
         }
         var_1820.clearGroupBadge();
         if(param2 != -1)
         {
            _loc6_ = handler.container.sessionDataManager.getGroupBadgeId(param2);
            userData.groupId = param2;
            userData.groupBadgeId = _loc6_;
            userData.groupName = param4;
            var_1820.setGroupBadge(_loc6_);
         }
      }
      
      public function getXmlWindow(param1:String) : IWindow
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IWindow = null;
         try
         {
            _loc4_ = this.findAssetByName(param1);
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
            class_14.log("[InfoStandWidget] Missing window XML: " + param1);
         }
         return _loc3_;
      }
      
      public function setRelationshipStatus(param1:int, param2:Map) : void
      {
         if(var_3308.userId == param1)
         {
            var_1820.setRelationshipStatuses(param2);
         }
      }
      
      override public function dispose() : void
      {
         if(var_1794)
         {
            var_1794.stop();
         }
         var_1794 = null;
         if(var_1820)
         {
            var_1820.dispose();
         }
         var_1820 = null;
         if(var_2760)
         {
            var_2760.dispose();
         }
         var_2760 = null;
         if(var_2090)
         {
            var_2090.dispose();
         }
         var_2090 = null;
         if(var_2490)
         {
            var_2490.dispose();
         }
         var_2490 = null;
         if(var_1951)
         {
            var_1951.dispose();
         }
         var_1951 = null;
         if(var_2789)
         {
            var_2789.dispose();
         }
         var_2789 = null;
         if(var_3051)
         {
            var_3051.dispose();
         }
         var_3051 = null;
         if(var_2968)
         {
            var_2968.dispose();
         }
         var_2968 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWROUE_OBJECT_SELECTED",onRoomObjectSelected);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",onClose);
         param1.addEventListener("RWROUE_USER_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.addEventListener("RWUIUE_PEER",onUserInfo);
         param1.addEventListener("RWUIUE_BOT",onBotInfo);
         param1.addEventListener("RWFIUE_FURNI",onFurniInfo);
         param1.addEventListener("RWRBIUE_RENTABLE_BOT",onRentableBotInfo);
         param1.addEventListener("RWPIUE_PET_INFO",onPetInfo);
         param1.addEventListener("RWPCUE_PET_COMMANDS",onPetCommands);
         param1.addEventListener("RWPCUE_OPEN_PET_TRAINING",onOpenPetTraining);
         param1.addEventListener("RWPCUE_CLOSE_PET_TRAINING",onClosePetTraining);
         param1.addEventListener("RWSUE_PLAYING_CHANGED",onSongUpdate);
         param1.addEventListener("RWSUE_DATA_RECEIVED",onSongUpdate);
         param1.addEventListener("RWPIUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWROUE_OBJECT_SELECTED",onRoomObjectSelected);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",onClose);
         param1.removeEventListener("RWROUE_USER_REMOVED",onRoomObjectRemoved);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.removeEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.removeEventListener("RWUIUE_PEER",onUserInfo);
         param1.removeEventListener("RWUIUE_BOT",onBotInfo);
         param1.removeEventListener("RWFIUE_FURNI",onFurniInfo);
         param1.removeEventListener("RWPIUE_PET_INFO",onPetInfo);
         param1.removeEventListener("RWPCUE_PET_COMMANDS",onPetCommands);
         param1.removeEventListener("RWPCUE_OPEN_PET_TRAINING",onOpenPetTraining);
         param1.removeEventListener("RWPCUE_CLOSE_PET_TRAINING",onClosePetTraining);
         param1.removeEventListener("RWSUE_PLAYING_CHANGED",onSongUpdate);
         param1.removeEventListener("RWSUE_DATA_RECEIVED",onSongUpdate);
         param1.removeEventListener("RWPIUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
      }
      
      public function get rentableBotData() : InfoStandRentableBotData
      {
         return var_4093;
      }
      
      public function get userData() : InfoStandUserData
      {
         return var_3308;
      }
      
      public function get furniData() : InfoStandFurniData
      {
         return var_1691;
      }
      
      public function get petData() : InfoStandPetData
      {
         return var_328;
      }
      
      private function onUpdateTimer(param1:TimerEvent) : void
      {
         if(var_1951 == null)
         {
            return;
         }
         messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_REQUEST_PET_UPDATE",var_1951.getCurrentPetId()));
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userData.setData(param1);
         var_1820.update(param1);
         selectView("infostand_user_view");
         if(var_1794)
         {
            var_1794.stop();
         }
      }
      
      private function onBotInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userData.setData(param1);
         var_2090.update(param1);
         selectView("infostand_bot_view");
         if(var_1794)
         {
            var_1794.stop();
         }
      }
      
      private function onRentableBotInfo(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         rentableBotData.setData(param1);
         var_2490.update(param1);
         selectView("infostand_rentable_bot_view");
         if(var_1794)
         {
            var_1794.stop();
         }
      }
      
      private function onFurniInfo(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         furniData.setData(param1);
         if(param1.extraParam == "RWEIEP_JUKEBOX")
         {
            var_2789.update(param1);
            selectView("infostand_jukebox_view");
         }
         else if(param1.extraParam.indexOf("RWEIEP_SONGDISK") != -1)
         {
            var_2968.update(param1);
            selectView("infostand_songdisk_view");
         }
         else if(param1.extraParam.indexOf("RWEIEP_CRACKABLE_FURNI") != -1)
         {
            var_3051.update(param1);
            selectView("infostand_crackable_furni_view");
         }
         else
         {
            var_2760.update(param1);
            selectView("infostand_furni_view");
         }
         if(var_1794)
         {
            var_1794.stop();
         }
      }
      
      private function onPetInfo(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         petData.setData(param1);
         userData.petRespectLeft = param1.petRespectLeft;
         var_1951.update(petData);
         selectView("infostand_pet_view");
         if(var_1794)
         {
            var_1794.start();
         }
      }
      
      private function onPetFigureUpdate(param1:RoomWidgetPetFigureUpdateEvent) : void
      {
         var_1951.updateImage(param1.petId,param1.image);
      }
      
      private function onPetCommands(param1:RoomWidgetPetCommandsUpdateEvent) : void
      {
         var _loc2_:Array = param1.allCommands;
         var _loc3_:Array = param1.enabledCommands;
         if(petData.type == 0 && !_config.getBoolean("nest.breeding.dog.enabled") || petData.type == 1 && !_config.getBoolean("nest.breeding.cat.enabled") || petData.type == 5 && !_config.getBoolean("nest.breeding.pig.enabled"))
         {
            if(_loc2_.indexOf(46) != -1)
            {
               _loc2_.splice(_loc2_.indexOf(46),1);
            }
            if(_loc3_.indexOf(46) != -1)
            {
               _loc3_.splice(_loc3_.indexOf(46),1);
            }
         }
         var_1951.updateEnabledTrainingCommands(param1.id,new CommandConfiguration(param1.allCommands,param1.enabledCommands));
      }
      
      private function onOpenPetTraining(param1:RoomWidgetUpdateEvent) : void
      {
         var_1951.openTrainView();
      }
      
      private function onClosePetTraining(param1:RoomWidgetUpdateEvent) : void
      {
         var_1951.closeTrainView();
      }
      
      public function updateUserData(param1:int, param2:String, param3:int, param4:String, param5:Boolean) : void
      {
         if(param1 != userData.userId)
         {
            return;
         }
         if(userData.isBot())
         {
            var_2090.setFigure(param2);
         }
         else
         {
            var_1820.setFigure(param2);
            var_1820.setMotto(param4,param5);
            if(handler.isActivityDisplayEnabled)
            {
               var_1820.achievementScore = param3;
            }
         }
      }
      
      public function refreshBadges(param1:int, param2:Array) : void
      {
         if(param1 != userData.userId)
         {
            return;
         }
         userData.badges = param2;
         if(userData.isBot())
         {
            var_2090.clearBadges();
         }
         else
         {
            var_1820.clearBadges();
         }
         for each(var _loc3_ in param2)
         {
            refreshBadge(_loc3_);
         }
      }
      
      public function refreshBadge(param1:String) : void
      {
         var _loc2_:int = userData.badges.indexOf(param1);
         if(_loc2_ >= 0)
         {
            if(userData.isBot())
            {
               var_2090.setBadge(_loc2_,param1);
            }
            else
            {
               var_1820.setBadge(_loc2_,param1);
            }
            return;
         }
         if(param1 == userData.groupBadgeId)
         {
            var_1820.setGroupBadge(param1);
         }
      }
      
      private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",param1.id,param1.category);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:* = false;
         switch(param1.type)
         {
            case "RWROUE_FURNI_REMOVED":
               _loc2_ = param1.id == var_1691.id;
               break;
            case "RWROUE_USER_REMOVED":
               if(var_1820 != null && var_1820.window != null && Boolean(var_1820.window.visible))
               {
                  _loc2_ = param1.id == var_3308.userRoomId;
                  break;
               }
               if(var_1951 != null && var_1951.window != null && Boolean(var_1951.window.visible))
               {
                  _loc2_ = param1.id == var_328.roomIndex;
                  break;
               }
               if(var_2090 != null && var_2090.window != null && Boolean(var_2090.window.visible))
               {
                  _loc2_ = param1.id == var_3308.userRoomId;
                  break;
               }
               if(var_2490 != null && var_2490.window != null && Boolean(var_2490.window.visible))
               {
                  _loc2_ = param1.id == var_4093.userRoomId;
               }
               break;
         }
         if(_loc2_)
         {
            close();
         }
      }
      
      private function onSongUpdate(param1:RoomWidgetSongUpdateEvent) : void
      {
         var_2789.updateSongInfo(param1);
         var_2968.updateSongInfo(param1);
      }
      
      public function close() : void
      {
         hideChildren();
         if(var_1794)
         {
            var_1794.stop();
         }
      }
      
      private function onClose(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         close();
         if(var_1794)
         {
            var_1794.stop();
         }
      }
      
      private function hideChildren() : void
      {
         var _loc1_:int = 0;
         if(var_1647 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_1647.numChildren)
            {
               var_1647.getChildAt(_loc1_).visible = false;
               _loc1_++;
            }
         }
      }
      
      public function isFurniViewVisible() : Boolean
      {
         var _loc1_:IWindow = null;
         if(var_1647 != null)
         {
            _loc1_ = var_1647.getChildByName("infostand_furni_view") as IWindow;
            if(_loc1_ != null)
            {
               return _loc1_.visible;
            }
         }
         return false;
      }
      
      private function selectView(param1:String) : void
      {
         hideChildren();
         var _loc2_:IWindow = mainContainer.getChildByName(param1) as IWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         mainContainer.visible = true;
         mainContainer.width = _loc2_.width;
         mainContainer.height = _loc2_.height;
      }
      
      public function refreshContainer() : void
      {
         var _loc2_:IWindow = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < mainContainer.numChildren)
         {
            _loc2_ = mainContainer.getChildAt(_loc1_);
            if(_loc2_.visible)
            {
               mainContainer.width = _loc2_.width;
               mainContainer.height = _loc2_.height;
            }
            _loc1_++;
         }
      }
   }
}
