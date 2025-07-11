package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChangeNameConfiguration;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChatterMarkovConfiguration;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotSkillConfigurationViewBase;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.class_3551;
   import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
   import com.sulake.habbo.ui.widget.contextmenu.class_3386;
   import com.sulake.habbo.ui.widget.events.ConfirmPetBreedingPetData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetLevelUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetStatusUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   import com.sulake.habbo.ui.widget.memenu.class_3522;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.class_445;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.class_989;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.class_717;
   
   public class AvatarInfoWidget extends RoomWidgetBase implements IUpdateReceiver, class_3386
   {
      
      private static const EFFECT_TYPE_RIDE:int = 77;
      
      private static const EFFECT_TYPE_DEEP_WATER:int = 29;
      
      private static const EFFECT_TYPE_SHALLOW_WATER:int = 30;
      
      private static const const_978:int = 185;
      
      private static const AVATAR_HIGHLIGHT_DURATION_MSEC:int = 5000;
      
      private static const const_625:String = "avatar";
      
      private static const const_797:String = "use_minimized_own_avatar_menu";
       
      
      private var var_1660:Component;
      
      private var var_209:ICoreConfiguration;
      
      private var var_1631:AvatarContextInfoButtonView;
      
      private var var_1874:DecorateModeView;
      
      private var var_1618:Boolean = false;
      
      private var var_3050:Boolean = false;
      
      private var var_2622:Boolean = false;
      
      private var var_2967:Timer;
      
      private var var_3938:class_3630;
      
      private var var_1807:class_3605;
      
      private var var_2069:PetInfoData;
      
      private var var_3749:int = -1;
      
      private var var_4937:Boolean = false;
      
      private var var_2419:AvatarContextInfoButtonView;
      
      private var _cachedOwnAvatarMenu:OwnAvatarMenuView;
      
      private var var_2443:AvatarMenuView;
      
      private var var_2418:RentableBotMenuView;
      
      private var var_3356:OwnPetMenuView;
      
      private var var_2493:PetMenuView;
      
      private var var_3378:NewUserHelpView;
      
      private var var_1970:Map;
      
      private var var_2116:Map;
      
      private var var_2087:Map;
      
      private var var_1912:UseProductConfirmationView;
      
      private var var_1903:BreedMonsterPlantsConfirmationView;
      
      private var var_2164:ConfirmPetBreedingView;
      
      private var var_1857:BreedPetsResultView;
      
      private var _breedingConfirmationAlert:class_3348;
      
      private var var_3730:int = -1;
      
      private var var_3168:int = -1;
      
      private var var_4668:Boolean = false;
      
      private var _handlePetInfo:Boolean = true;
      
      private var _catalog:IHabboCatalog;
      
      private var var_2178:Map;
      
      private var var_2744:Map;
      
      private var var_3976:NestBreedingSuccessView;
      
      public function AvatarInfoWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:ICoreConfiguration, param5:IHabboLocalizationManager, param6:Component, param7:IHabboCatalog)
      {
         var_2178 = new Map();
         var_2744 = new Map();
         super(param1,param2,param3,param5);
         var_1660 = param6;
         _catalog = param7;
         var_209 = param4;
         var_3938 = new class_3630();
         var_2069 = new PetInfoData();
         var_1807 = null;
         var_1970 = new Map();
         var_2116 = new Map();
         var_2087 = new Map();
         this.handler.roomEngine.events.addEventListener("REOE_ADDED",onRoomObjectAdded);
         this.handler.roomEngine.events.addEventListener("REOE_REMOVED",onRoomObjectRemoved);
         this.handler.container.inventory.events.addEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         this.handler.widget = this;
      }
      
      public function get component() : Component
      {
         return var_1660;
      }
      
      public function get handler() : AvatarInfoWidgetHandler
      {
         return var_1653 as AvatarInfoWidgetHandler;
      }
      
      public function get configuration() : ICoreConfiguration
      {
         return var_209;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return var_44;
      }
      
      public function set handlePetInfo(param1:Boolean) : void
      {
         _handlePetInfo = param1;
      }
      
      private function onRoomObjectAdded(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:class_3490 = null;
         if(param1.category == 100)
         {
            _loc2_ = handler.roomSession.userDataManager.getUserDataByIndex(param1.objectId);
            if(_loc2_)
            {
               if(handler.friendList.getFriendNames().indexOf(_loc2_.name) > -1)
               {
                  showUserName(_loc2_,param1.objectId);
               }
            }
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomEngineObjectEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         if(param1.category == 100)
         {
            for each(var _loc2_ in var_1970)
            {
               if(_loc2_.objectId == param1.objectId)
               {
                  removeView(_loc2_,false);
               }
            }
            _loc4_ = [];
            for each(var _loc8_ in var_2087)
            {
               if((_loc6_ = int(_loc8_.requestRoomObjectId)) == _loc5_)
               {
                  _loc4_.push(_loc8_);
               }
            }
            for each(_loc8_ in _loc4_)
            {
               removeView(_loc8_,false);
            }
            if(var_1903 != null)
            {
               if(param1.objectId == var_1903.requestRoomObjectId || param1.objectId == var_1903.targetRoomObjectId)
               {
                  removeBreedMonsterPlantsConfirmationView();
               }
            }
            if(var_2164 != null)
            {
               if(param1.objectId == var_2164.requestRoomObjectId || param1.objectId == var_2164.targetRoomObjectId)
               {
                  removeConfirmPetBreedingView();
               }
            }
            if(var_1912 != null)
            {
               if(param1.objectId == var_1912.requestObjectId || param1.objectId == var_1912.targetRoomObjectId)
               {
                  removeUseProductConfirmationView();
               }
            }
         }
         if(param1.category == 10)
         {
            _loc5_ = param1.objectId;
            if(var_1912 != null)
            {
               if(var_1912.requestObjectId == _loc5_)
               {
                  removeUseProductConfirmationView();
               }
            }
            if(var_1857 != null)
            {
               var_1857.roomObjectRemoved(_loc5_);
            }
            _loc3_ = [];
            for each(var _loc7_ in var_2116)
            {
               if((_loc6_ = int(_loc7_.requestRoomObjectId)) == _loc5_)
               {
                  _loc3_.push(_loc7_);
               }
            }
            for each(_loc7_ in _loc3_)
            {
               removeView(_loc7_,false);
            }
         }
      }
      
      public function showUseProductMenuForItems(param1:Array) : void
      {
         var _loc3_:class_3490 = null;
         removeUseProductViews();
         removeUseProductConfirmationView();
         removeBreedMonsterPlantsConfirmationView();
         for each(var _loc2_ in param1)
         {
            _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.id);
            showUseProductMenu(_loc3_,_loc2_);
         }
      }
      
      public function showBreedPetMenuForItems(param1:Array) : void
      {
         var _loc3_:class_3490 = null;
         removeBreedPetViews();
         removeUseProductConfirmationView();
         removeBreedMonsterPlantsConfirmationView();
         for each(var _loc2_ in param1)
         {
            _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.id);
            showBreedPetMenu(_loc3_,_loc2_);
         }
      }
      
      private function onEffectsChanged(param1:HabboInventoryEffectsEvent) : void
      {
         if(var_1631 is OwnAvatarMenuView)
         {
            (var_1631 as OwnAvatarMenuView).updateButtons();
         }
      }
      
      private function getOwnCharacterInfo() : void
      {
         messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OWN_CHARACTER_INFO",0,0));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         removeAvatarHighlightTimer();
         for each(var _loc1_ in var_1970)
         {
            _loc1_.dispose();
         }
         var_1970 = null;
         for each(var _loc2_ in var_2116)
         {
            _loc2_.dispose();
         }
         var_2116 = null;
         for each(var _loc4_ in var_2087)
         {
            _loc4_.dispose();
         }
         var_2087 = null;
         if(var_1660)
         {
            var_1660.removeUpdateReceiver(this);
            var_1660 = null;
         }
         if(var_2419)
         {
            var_2419.dispose();
            var_2419 = null;
         }
         if(var_2443)
         {
            var_2443.dispose();
            var_2443 = null;
         }
         if(_cachedOwnAvatarMenu)
         {
            _cachedOwnAvatarMenu.dispose();
            _cachedOwnAvatarMenu = null;
         }
         if(var_2418)
         {
            var_2418.dispose();
            var_2418 = null;
         }
         if(var_2493)
         {
            var_2493.dispose();
            var_2493 = null;
         }
         if(var_1631)
         {
            if(!var_1631.disposed)
            {
               var_1631.dispose();
               var_1631 = null;
            }
         }
         if(var_1874)
         {
            var_1874.dispose();
            var_1874 = null;
         }
         if(var_1912)
         {
            var_1912.dispose();
            var_1912 = null;
         }
         removeBreedMonsterPlantsConfirmationView();
         removeConfirmPetBreedingView();
         if(var_1857)
         {
            var_1857.dispose();
            var_1857 = null;
         }
         if(_breedingConfirmationAlert)
         {
            _breedingConfirmationAlert.dispose();
            _breedingConfirmationAlert = null;
         }
         if(var_2178)
         {
            for each(var _loc3_ in var_2178.getKeys())
            {
               BotSkillConfigurationViewBase(var_2178.getValue(_loc3_)).dispose();
            }
            var_2178.dispose();
            var_2178 = null;
         }
         if(var_2744 && var_2744.length > 0)
         {
            var_2744.dispose();
            var_2744 = null;
         }
         handler.roomEngine.events.removeEventListener("REOE_ADDED",onRoomObjectAdded);
         handler.roomEngine.events.removeEventListener("REOE_REMOVED",onRoomObjectRemoved);
         handler.container.inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         var_1631 = null;
         var_209 = null;
         super.dispose();
      }
      
      public function close() : void
      {
         removeView(var_1631,false);
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener("RWRBFOCME_OPEN",updateEventHandler);
         param1.addEventListener("RWRBSLUE_SKILL_LIST",updateEventHandler);
         param1.addEventListener("RWRBIUE_RENTABLE_BOT",updateEventHandler);
         param1.addEventListener("RWAIE_AVATAR_INFO",updateEventHandler);
         param1.addEventListener("RWUIUE_OWN_USER",updateEventHandler);
         param1.addEventListener("RWUIUE_PEER",updateEventHandler);
         param1.addEventListener("RWROUE_FURNI_ADDED",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_SELECTED",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",updateEventHandler);
         param1.addEventListener("RWFIUE_FURNI",updateEventHandler);
         param1.addEventListener("RWUIUE_BOT",updateEventHandler);
         param1.addEventListener("RWPIUE_PET_INFO",updateEventHandler);
         param1.addEventListener("rwudue_user_data_updated",updateEventHandler);
         param1.addEventListener("RWROUE_USER_REMOVED",updateEventHandler);
         param1.addEventListener("RWREUE_NORMAL_MODE",updateEventHandler);
         param1.addEventListener("RWREUE_GAME_MODE",updateEventHandler);
         param1.addEventListener("RWONE_TYPE",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_ROLL_OVER",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.addEventListener("RWPIUE_PET_STATUS_UPDATE",updateEventHandler);
         param1.addEventListener("RWPLUE_PET_LEVEL_UPDATE",updateEventHandler);
         param1.addEventListener("RWPBRE_PET_BREEDING_RESULT",updateEventHandler);
         param1.addEventListener("RWPPBE_PET_BREEDING_",updateEventHandler);
         param1.addEventListener("RWIUM_INVENTORY_UPDATED",updateEventHandler);
         param1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_",updateEventHandler);
         param1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT",updateEventHandler);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWRBFOCME_OPEN",updateEventHandler);
         param1.removeEventListener("RWRBSLUE_SKILL_LIST",updateEventHandler);
         param1.removeEventListener("RWRBIUE_RENTABLE_BOT",updateEventHandler);
         param1.removeEventListener("RWAIE_AVATAR_INFO",updateEventHandler);
         param1.removeEventListener("RWUIUE_OWN_USER",updateEventHandler);
         param1.removeEventListener("RWUIUE_PEER",updateEventHandler);
         param1.removeEventListener("RWROUE_FURNI_ADDED",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_SELECTED",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",updateEventHandler);
         param1.removeEventListener("RWFIUE_FURNI",updateEventHandler);
         param1.removeEventListener("RWUIUE_BOT",updateEventHandler);
         param1.removeEventListener("RWPIUE_PET_INFO",updateEventHandler);
         param1.removeEventListener("rwudue_user_data_updated",updateEventHandler);
         param1.removeEventListener("RWROUE_USER_REMOVED",updateEventHandler);
         param1.removeEventListener("RWREUE_NORMAL_MODE",updateEventHandler);
         param1.removeEventListener("RWREUE_GAME_MODE",updateEventHandler);
         param1.removeEventListener("RWONE_TYPE",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.removeEventListener("RWPIUE_PET_STATUS_UPDATE",updateEventHandler);
         param1.removeEventListener("RWPLUE_PET_LEVEL_UPDATE",updateEventHandler);
         param1.removeEventListener("RWPBRE_PET_BREEDING_RESULT",updateEventHandler);
         param1.removeEventListener("RWPPBE_PET_BREEDING_",updateEventHandler);
         param1.removeEventListener("RWIUM_INVENTORY_UPDATED",updateEventHandler);
         param1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_",updateEventHandler);
         param1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT",updateEventHandler);
      }
      
      private function updateEventHandler(param1:RoomWidgetUpdateEvent) : void
      {
         var _loc12_:RoomWidgetAvatarInfoEvent = null;
         var _loc8_:RoomWidgetPetStatusUpdateEvent = null;
         var _loc3_:class_3490 = null;
         var _loc22_:RoomWidgetPetLevelUpdateEvent = null;
         var _loc27_:class_3490 = null;
         var _loc2_:RoomWidgetPetBreedingResultEvent = null;
         var _loc4_:BreedPetsResultData = null;
         var _loc14_:BreedPetsResultData = null;
         var _loc20_:RoomWidgetPetBreedingEvent = null;
         var _loc7_:int = 0;
         var _loc25_:int = 0;
         var _loc16_:RoomWidgetConfirmPetBreedingEvent = null;
         var _loc15_:RoomWidgetConfirmPetBreedingResultEvent = null;
         var _loc9_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc11_:class_3630 = null;
         var _loc13_:RoomWidgetRentableBotInfoUpdateEvent = null;
         var _loc5_:IRoomSession = null;
         var _loc26_:class_3490 = null;
         var _loc23_:RoomWidgetRentableBotSkillListUpdateEvent = null;
         var _loc18_:RoomWidgetRentableBotForceOpenContextMenuEvent = null;
         var _loc21_:int = 0;
         var _loc17_:class_3490 = null;
         var _loc6_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc24_:RoomWidgetPetInfoUpdateEvent = null;
         var _loc19_:RoomWidgetRoomObjectUpdateEvent = null;
         switch(param1.type)
         {
            case "RWAIE_AVATAR_INFO":
               _loc12_ = param1 as RoomWidgetAvatarInfoEvent;
               var_2622 = !var_1618 && handler.container.roomSession != null && _loc12_.roomIndex == handler.container.roomSession.ownUserRoomId;
               if(_loc12_.allowNameChange)
               {
                  useMinimizedOwnAvatarMenu = true;
                  selectOwnAvatar();
               }
               else
               {
                  updateUserView(_loc12_.userId,_loc12_.userName,_loc12_.userType,_loc12_.roomIndex,_loc12_.allowNameChange,null);
               }
               var_1618 = true;
               break;
            case "RWONE_TYPE":
               if(RoomWidgetRoomObjectNameEvent(param1).category == 100)
               {
                  updateUserView(RoomWidgetRoomObjectNameEvent(param1).userId,RoomWidgetRoomObjectNameEvent(param1).userName,RoomWidgetRoomObjectNameEvent(param1).userType,RoomWidgetRoomObjectNameEvent(param1).roomIndex,false,null);
               }
               break;
            case "RWROUE_FURNI_ADDED":
               if(RoomWidgetRoomObjectUpdateEvent(param1).category == 10)
               {
                  if(var_1857 != null)
                  {
                     var_1857.roomObjectAdded(RoomWidgetRoomObjectUpdateEvent(param1).id);
                  }
               }
               break;
            case "RWROUE_OBJECT_SELECTED":
               if(RoomWidgetRoomObjectUpdateEvent(param1).category == 100)
               {
                  _handlePetInfo = true;
               }
               removeBreedPetViews();
               break;
            case "RWROUE_OBJECT_DESELECTED":
               if(var_1631 && !(var_1631 is NewUserHelpView))
               {
                  removeView(var_1631,false);
               }
               removeUseProductViews();
               removeBreedPetViews();
               break;
            case "RWFIUE_FURNI":
               if(var_1631)
               {
                  removeView(var_1631,false);
               }
               removeUseProductViews();
               removeBreedPetViews();
               break;
            case "RWROUE_OBJECT_ROLL_OVER":
               if(var_2622)
               {
                  return;
               }
               if(!(var_1631 is AvatarMenuView || var_1631 is OwnAvatarMenuView || var_1631 is OwnPetMenuView || var_1631 is NewUserHelpView || var_1631 is RentableBotMenuView))
               {
                  var_3749 = RoomWidgetRoomObjectUpdateEvent(param1).id;
                  messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_NAME",RoomWidgetRoomObjectUpdateEvent(param1).id,RoomWidgetRoomObjectUpdateEvent(param1).category));
               }
               break;
            case "RWROUE_OBJECT_ROLL_OUT":
               if(var_2622)
               {
                  return;
               }
               if(!(var_1631 is AvatarMenuView || var_1631 is OwnAvatarMenuView || var_1631 is OwnPetMenuView || var_1631 is NewUserHelpView || var_1631 is RentableBotMenuView))
               {
                  if(RoomWidgetRoomObjectUpdateEvent(param1).id == var_3749)
                  {
                     if(var_1631 && !var_1631.allowNameChange)
                     {
                        removeView(var_1631,false);
                        var_3749 = -1;
                     }
                  }
               }
               break;
            case "RWPIUE_PET_STATUS_UPDATE":
               _loc8_ = param1 as RoomWidgetPetStatusUpdateEvent;
               if(var_1631 && var_1631 is OwnPetMenuView)
               {
                  if(_loc8_ != null && var_2069 != null)
                  {
                     _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc8_.petId);
                     if(_loc3_ != null && _loc3_.webID == var_2069.id)
                     {
                        removeView(var_1631,true);
                     }
                  }
               }
               if(_loc8_ != null)
               {
                  removeBreedPetViewsWithId(_loc8_.petId);
               }
               break;
            case "RWPLUE_PET_LEVEL_UPDATE":
               _loc22_ = param1 as RoomWidgetPetLevelUpdateEvent;
               if(var_1631 && var_1631 is OwnPetMenuView)
               {
                  if(_loc22_ != null && var_2069 != null)
                  {
                     if((_loc27_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc22_.petId)) != null && _loc27_.webID == var_2069.id)
                     {
                        removeView(var_1631,true);
                     }
                  }
               }
               if(_loc22_ != null)
               {
                  removeBreedPetViewsWithId(_loc22_.petId);
               }
               break;
            case "RWPBRE_PET_BREEDING_RESULT":
               _loc2_ = param1 as RoomWidgetPetBreedingResultEvent;
               (_loc4_ = new BreedPetsResultData()).stuffId = _loc2_.resultData.stuffId;
               _loc4_.classId = _loc2_.resultData.classId;
               _loc4_.productCode = _loc2_.resultData.productCode;
               _loc4_.userId = _loc2_.resultData.userId;
               _loc4_.userName = _loc2_.resultData.userName;
               _loc4_.rarityLevel = _loc2_.resultData.rarityLevel;
               _loc4_.hasMutation = _loc2_.resultData.hasMutation;
               (_loc14_ = new BreedPetsResultData()).stuffId = _loc2_.resultData2.stuffId;
               _loc14_.classId = _loc2_.resultData2.classId;
               _loc14_.productCode = _loc2_.resultData2.productCode;
               _loc14_.userId = _loc2_.resultData2.userId;
               _loc14_.userName = _loc2_.resultData2.userName;
               _loc14_.rarityLevel = _loc2_.resultData2.rarityLevel;
               _loc14_.hasMutation = _loc2_.resultData2.hasMutation;
               showBreedPetsResultView(_loc4_,_loc14_);
               break;
            case "RWPPBE_PET_BREEDING_":
               _loc20_ = param1 as RoomWidgetPetBreedingEvent;
               _loc7_ = findPetRoomObjectIdByWebId(_loc20_.ownPetId);
               _loc25_ = findPetRoomObjectIdByWebId(_loc20_.otherPetId);
               switch(_loc20_.state)
               {
                  case 0:
                     showBreedMonsterPlantsConfirmationView(_loc7_,_loc25_,false);
                     break;
                  case 1:
                     cancelBreedingPets(_loc7_,_loc25_);
                     break;
                  case 2:
                     acceptBreedingPets(_loc7_,_loc25_);
                     break;
                  case 3:
                     showBreedMonsterPlantsConfirmationView(_loc7_,_loc25_,true);
               }
               break;
            case "RWIUM_INVENTORY_UPDATED":
               if(var_1857 != null)
               {
                  var_1857.updatePlacingButtons();
               }
               break;
            case "RWPPBE_CONFIRM_PET_BREEDING_":
               _loc16_ = param1 as RoomWidgetConfirmPetBreedingEvent;
               showConfirmPetBreedingView(_loc16_.pet1,_loc16_.pet2,_loc16_.nestId,_loc16_.rarityCategories,_loc16_.resultPetTypeId);
               break;
            case "RWPPBE_CONFIRM_PET_BREEDING_RESULT":
               switch((_loc15_ = param1 as RoomWidgetConfirmPetBreedingResultEvent).result)
               {
                  case 0:
                     removeConfirmPetBreedingView();
                     break;
                  case 1:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.nonest.head}","${breedpets.confirmation.alert.nonest.desc}");
                     removeConfirmPetBreedingView();
                     break;
                  case 2:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.petsmissing.head}","${breedpets.confirmation.alert.petsmissing.desc}");
                     removeConfirmPetBreedingView();
                     break;
                  case 3:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.name.invalid.head}","${breedpets.confirmation.alert.name.invalid.desc}");
                     if(var_2164)
                     {
                        var_2164.enable();
                     }
               }
               break;
            case "RWUIUE_OWN_USER":
            case "RWUIUE_PEER":
               _loc9_ = param1 as RoomWidgetUserInfoUpdateEvent;
               var_3938.populate(_loc9_);
               _loc11_ = _loc9_.isSpectatorMode ? null : var_3938;
               updateUserView(_loc9_.webID,_loc9_.name,_loc9_.userType,_loc9_.userRoomId,var_3938.allowNameChange,_loc11_);
               break;
            case "RWRBIUE_RENTABLE_BOT":
               _loc13_ = param1 as RoomWidgetRentableBotInfoUpdateEvent;
               if(!var_1807)
               {
                  var_1807 = new class_3605();
               }
               var_1807.populate(_loc13_);
               if(!(_loc5_ = handler.container.roomSessionManager.getSession(_loc21_)))
               {
                  return;
               }
               if(!(_loc26_ = _loc5_.userDataManager.getRentableBotUserData(_loc13_.webID)))
               {
                  return;
               }
               var_2744[_loc13_.webID.toString()] = _loc26_.botSkillData;
               if(var_1807 && _loc26_.botSkillData)
               {
                  var_1807.cloneAndSetSkillsWithCommands(_loc26_.botSkillData);
               }
               updateRentableBotView(_loc13_.webID,_loc13_.name,_loc13_.userRoomId,var_1807);
               break;
            case "RWRBSLUE_SKILL_LIST":
               _loc23_ = param1 as RoomWidgetRentableBotSkillListUpdateEvent;
               var_2744[_loc23_.botId.toString()] = _loc23_.botSkillsWithCommands;
               if(var_1807)
               {
                  var_1807.cloneAndSetSkillsWithCommands(_loc23_.botSkillsWithCommands);
                  updateRentableBotView(var_1807.id,var_1807.name,var_1807.roomIndex,var_1807,true);
               }
               break;
            case "RWRBFOCME_OPEN":
               _loc18_ = param1 as RoomWidgetRentableBotForceOpenContextMenuEvent;
               if(var_1807)
               {
                  updateRentableBotView(var_1807.id,var_1807.name,var_1807.roomIndex,var_1807,false,true);
               }
               else
               {
                  _loc21_ = handler.container.roomEngine.activeRoomId;
                  _loc17_ = handler.container.roomSessionManager.getSession(_loc21_).userDataManager.getUserDataByType(_loc18_.botId,4);
                  messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",_loc17_.roomObjectId,100));
                  handler.container.roomEngine.selectAvatar(_loc21_,_loc17_.roomObjectId);
               }
               break;
            case "RWUIUE_BOT":
               _loc6_ = param1 as RoomWidgetUserInfoUpdateEvent;
               updateUserView(_loc6_.webID,_loc6_.name,_loc6_.userType,_loc6_.userRoomId,false,null);
               break;
            case "RWPIUE_PET_INFO":
               if(_handlePetInfo)
               {
                  _loc24_ = param1 as RoomWidgetPetInfoUpdateEvent;
                  var_2069.populate(_loc24_);
                  updatePetView(_loc24_.id,_loc24_.name,_loc24_.roomIndex,var_2069);
               }
               break;
            case "rwudue_user_data_updated":
               if(!var_1618)
               {
                  getOwnCharacterInfo();
               }
               break;
            case "RWROUE_USER_REMOVED":
               _loc19_ = param1 as RoomWidgetRoomObjectUpdateEvent;
               if(var_1631 && var_1631.roomIndex == _loc19_.id)
               {
                  removeView(var_1631,false);
               }
               for each(var _loc10_ in var_1970)
               {
                  if(_loc10_.objectId == _loc19_.id)
                  {
                     removeView(_loc10_,false);
                     break;
                  }
               }
               removeBreedPetViewsWithId(_loc19_.id);
               break;
            case "RWREUE_NORMAL_MODE":
               var_3050 = false;
               break;
            case "RWREUE_GAME_MODE":
               var_3050 = true;
         }
         checkUpdateNeed();
      }
      
      private function findPetRoomObjectIdByWebId(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc6_:class_3490 = null;
         var _loc5_:int = handler.container.roomSession.roomId;
         var _loc3_:int = handler.container.roomEngine.getRoomObjectCount(_loc5_,100);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = handler.container.roomEngine.getRoomObjectWithIndex(_loc5_,_loc4_,100);
            if(!((_loc6_ = handler.container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId())) == null || _loc6_.type != 2))
            {
               if(_loc6_.webID == param1)
               {
                  return _loc2_.getId();
               }
            }
            _loc4_++;
         }
         return -1;
      }
      
      private function removeBreedPetViewsWithId(param1:int) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in var_2087)
         {
            if(_loc2_.objectId == param1 || _loc2_.requestRoomObjectId == param1)
            {
               if(_loc3_.indexOf(_loc2_) == -1)
               {
                  _loc3_.push(_loc2_);
               }
            }
         }
         for each(var _loc4_ in _loc3_)
         {
            removeView(_loc4_,false);
         }
      }
      
      public function selectOwnAvatar() : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = null;
         if(!handler || !handler.container || !handler.roomSession)
         {
            return;
         }
         var _loc3_:int = handler.container.sessionDataManager.userId;
         var _loc1_:class_3490 = handler.roomSession.userDataManager.getUserData(_loc3_);
         if(!_loc1_)
         {
            return;
         }
         _loc2_ = new RoomWidgetRoomObjectMessage("RWROM_SELECT_OBJECT",_loc1_.roomObjectId,100);
         handler.container.processWidgetMessage(_loc2_);
      }
      
      public function get ownAvatarPosture() : String
      {
         var _loc2_:IRoomObjectModel = null;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getModel();
            if(_loc2_ != null)
            {
               return _loc2_.getString("figure_posture");
            }
         }
         return "std";
      }
      
      public function get canStandUp() : Boolean
      {
         var _loc2_:IRoomObjectModel = null;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getModel();
            if(_loc2_ != null)
            {
               return _loc2_.getNumber("figure_can_stand_up") > 0;
            }
         }
         return false;
      }
      
      public function get isSwimming() : Boolean
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:Number = NaN;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = Number(_loc3_.getNumber("figure_effect"));
               return _loc2_ == 29 || _loc2_ == 30 || _loc2_ == 185;
            }
         }
         return false;
      }
      
      private function updateRentableBotView(param1:int, param2:String, param3:int, param4:class_3605, param5:Boolean = false, param6:Boolean = false) : void
      {
         if(!param4)
         {
            return;
         }
         var _loc8_:Boolean = Boolean(var_209.getBoolean("menu.bot.enabled"));
         var _loc7_:Boolean = param5 && !var_1631;
         if(param6)
         {
            _loc7_ = false;
         }
         if(_loc8_ && var_1631 && !(var_1631 is AvatarMenuView || var_1631 is OwnAvatarMenuView || var_1631 is PetMenuView || var_1631 is OwnPetMenuView || var_1631 is RentableBotMenuView))
         {
            removeView(var_1631,false);
         }
         removeUseProductViews();
         if(param6 || var_1631 != null && var_1631.userId == param1 && !param5 || var_1631 == null || var_1631.userId != param1 || var_1631.userName != param2 || var_1631.roomIndex != param3 || var_1631.userType != 4)
         {
            if(var_1631)
            {
               removeView(var_1631,false);
            }
            if(!var_3050)
            {
               if(!var_2418)
               {
                  var_2418 = new RentableBotMenuView(this);
               }
               if(!_loc7_)
               {
                  var_1631 = var_2418;
                  RentableBotMenuView.setup(var_1631 as RentableBotMenuView,param1,param2,param3,4,param4);
               }
            }
         }
         else if(var_1631 is RentableBotMenuView)
         {
            if(var_1631.userName == param2)
            {
               removeView(var_1631,false);
            }
         }
      }
      
      private function updatePetView(param1:int, param2:String, param3:int, param4:PetInfoData) : void
      {
         if(!param4)
         {
            return;
         }
         if(var_1631 && !(var_1631 is AvatarMenuView || var_1631 is OwnAvatarMenuView || var_1631 is PetMenuView || var_1631 is OwnPetMenuView || var_1631 is RentableBotMenuView))
         {
            removeView(var_1631,false);
         }
         removeUseProductViews();
         if(var_1631 == null || var_1631.userId != param1 || var_1631.userName != param2 || var_1631.roomIndex != param3 || var_1631.userType != 2)
         {
            if(var_1631)
            {
               removeView(var_1631,false);
            }
            if(!var_3050)
            {
               if(param4.isOwnPet)
               {
                  if(!var_3356)
                  {
                     var_3356 = new OwnPetMenuView(this,_catalog);
                  }
                  var_1631 = var_3356;
                  OwnPetMenuView.setup(var_1631 as OwnPetMenuView,param1,param2,param3,2,param4);
               }
               else
               {
                  if(!var_2493)
                  {
                     var_2493 = new PetMenuView(this);
                  }
                  var_1631 = var_2493;
                  PetMenuView.setup(var_1631 as PetMenuView,param1,param2,param3,2,param4);
               }
            }
         }
         else if(var_1631 is AvatarMenuView || var_1631 is OwnAvatarMenuView)
         {
            if(var_1631.userName == param2)
            {
               removeView(var_1631,false);
            }
         }
      }
      
      private function updateUserView(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:class_3630) : void
      {
         var _loc7_:*;
         if((_loc7_ = param6 != null) && var_1631 && !(var_1631 is AvatarMenuView || var_1631 is OwnAvatarMenuView || var_1631 is PetMenuView || var_1631 is OwnPetMenuView || var_1631 is RentableBotMenuView))
         {
            removeView(var_1631,false);
         }
         removeUseProductViews();
         if(var_1631 == null || var_1631.userId != param1 || var_1631.userName != param2 || var_1631.roomIndex != param4 || var_1631.userType != 1 || param5)
         {
            if(var_1631)
            {
               removeView(var_1631,false);
            }
            if(!var_3050)
            {
               if(_loc7_)
               {
                  if(param6.isOwnUser)
                  {
                     if(isUserDecorating)
                     {
                        return;
                     }
                     if(RoomEnterEffect.isRunning())
                     {
                        if(!var_3378)
                        {
                           var_3378 = new NewUserHelpView(this);
                        }
                        var_1631 = var_3378;
                        NewUserHelpView.setup(var_1631 as NewUserHelpView,param1,param2,param4,1);
                     }
                     else
                     {
                        if(!_cachedOwnAvatarMenu)
                        {
                           _cachedOwnAvatarMenu = new OwnAvatarMenuView(this);
                        }
                        var_1631 = _cachedOwnAvatarMenu;
                        OwnAvatarMenuView.setup(var_1631 as OwnAvatarMenuView,param1,param2,param4,1,param6);
                     }
                  }
                  else
                  {
                     if(!var_2443)
                     {
                        var_2443 = new AvatarMenuView(this);
                     }
                     var_1631 = var_2443;
                     AvatarMenuView.setup(var_1631 as AvatarMenuView,param1,param2,param4,param3,param6);
                     for each(var _loc8_ in var_1970)
                     {
                        if(_loc8_.userId == param1)
                        {
                           removeView(_loc8_,false);
                           break;
                        }
                     }
                  }
               }
               else if(!handler.roomEngine.isDecorateMode)
               {
                  if(!var_2419)
                  {
                     var_2419 = new AvatarContextInfoButtonView(this);
                  }
                  var_1631 = var_2419;
                  if(handler.container.sessionDataManager.userId == param1)
                  {
                     AvatarContextInfoButtonView.setup(var_1631,param1,param2,param4,param3,param5);
                     if(var_2622)
                     {
                        _catalog.windowManager.registerHintWindow("avatar",var_1631.window);
                        _catalog.windowManager.showHint("avatar");
                        if(!handler.container.sessionDataManager.isNoob)
                        {
                           setAvatarHightlightTimer();
                        }
                     }
                  }
                  else
                  {
                     AvatarContextInfoButtonView.setup(var_1631,param1,param2,param4,param3,param5,true);
                  }
               }
            }
         }
         else if(var_1631 is AvatarMenuView || var_1631 is OwnAvatarMenuView)
         {
            if(var_1631.userName == param2)
            {
               removeView(var_1631,false);
            }
         }
      }
      
      public function removeView(param1:ContextInfoView, param2:Boolean) : void
      {
         var_2622 = false;
         removeAvatarHighlightTimer();
         if(param1)
         {
            if(var_4937)
            {
               param1.hide(param2);
            }
            else
            {
               param1.dispose();
               var_2419 = null;
               var_2443 = null;
               _cachedOwnAvatarMenu = null;
               var_3356 = null;
               var_2418 = null;
               var_2493 = null;
               var_3378 = null;
            }
            if(param1 == var_1631)
            {
               var_1631 = null;
            }
            if(param1 is UserNameView)
            {
               var_1970.remove((param1 as UserNameView).userName);
               param1.dispose();
               checkUpdateNeed();
            }
            if(param1 is UseProductView)
            {
               var_2116.remove((param1 as UseProductView).userId);
               param1.dispose();
               checkUpdateNeed();
            }
            if(param1 is BreedPetView)
            {
               var_2087.remove((param1 as BreedPetView).userId);
               param1.dispose();
               checkUpdateNeed();
            }
         }
      }
      
      public function removeUseProductViews() : void
      {
         for each(var _loc1_ in var_2116)
         {
            _loc1_.dispose();
         }
         var_2116.reset();
         checkUpdateNeed();
      }
      
      public function removeBreedPetViews() : void
      {
         for each(var _loc1_ in var_2087)
         {
            _loc1_.dispose();
         }
         var_2087.reset();
         checkUpdateNeed();
      }
      
      public function showUserName(param1:class_3490, param2:int) : void
      {
         var _loc3_:UserNameView = null;
         if(var_1970[param1.name] == null)
         {
            _loc3_ = new UserNameView(this);
            UserNameView.setup(_loc3_,param1.webID,param1.name,-1,1,param2);
            var_1970[param1.name] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         var _loc5_:UserNameView = null;
         if(var_1970[param2] == null)
         {
            _loc5_ = new UserNameView(this,true);
            UserNameView.setup(_loc5_,param1,param2,param1,1,param1,param3,param4);
            var_1970[param2] = _loc5_;
            checkUpdateNeed();
         }
      }
      
      private function showUseProductMenu(param1:class_3490, param2:UseProductItem) : void
      {
         var _loc3_:UseProductView = null;
         if(var_2116[param1.webID.toString()] == null)
         {
            _loc3_ = new UseProductView(this);
            UseProductView.setup(_loc3_,param1.webID,param1.name,-1,2,param2);
            var_2116[param1.webID.toString()] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      private function showBreedPetMenu(param1:class_3490, param2:UseProductItem) : void
      {
         var _loc3_:BreedPetView = null;
         if(var_2087[param1.webID.toString()] == null)
         {
            _loc3_ = new BreedPetView(this);
            BreedPetView.setup(_loc3_,param1.webID,param1.name,-1,2,param2,param1.canBreed);
            var_2087[param1.webID.toString()] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      private function setAvatarHightlightTimer() : void
      {
         var_2967 = new Timer(5000);
         var_2967.addEventListener("timer",onAvatarHighlightTimerEvent);
         var_2967.start();
      }
      
      private function removeAvatarHighlightTimer() : void
      {
         var_2622 = false;
         _catalog.windowManager.unregisterHintWindow("avatar");
         if(!var_2967)
         {
            return;
         }
         var_2967.stop();
         var_2967 = null;
      }
      
      private function onAvatarHighlightTimerEvent(param1:TimerEvent) : void
      {
         removeAvatarHighlightTimer();
      }
      
      public function checkUpdateNeed() : void
      {
         if(!var_1660)
         {
            return;
         }
         if(var_1631 || var_1970.length > 0 || var_2116.length > 0 || var_2087.length > 0 || var_1874 && var_1874.isVisible)
         {
            var_1660.registerUpdateReceiver(this,10);
         }
         else
         {
            var_1660.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:RoomWidgetUserLocationUpdateEvent = null;
         if(var_1631)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",var_1631.userId,var_1631.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(!_loc3_)
            {
               return;
            }
            var_1631.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
         }
         if(var_1874 && var_1874.isVisible())
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",var_1874.userId,var_1874.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(!_loc3_)
            {
               return;
            }
            var_1874.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
         }
         for each(var _loc2_ in var_1970)
         {
            if(_loc2_.isGameRoomMode)
            {
               _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION",_loc2_.userId,_loc2_.userType)) as RoomWidgetUserLocationUpdateEvent;
            }
            else
            {
               _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc2_.userId,_loc2_.userType)) as RoomWidgetUserLocationUpdateEvent;
            }
            if(_loc3_)
            {
               _loc2_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
         for each(var _loc4_ in var_2116)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc4_.userId,_loc4_.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               _loc4_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
         for each(var _loc5_ in var_2087)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc5_.userId,_loc5_.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               _loc5_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
      }
      
      public function openAvatarEditor() : void
      {
         handler.container.avatarEditor.openEditor(0,null,null,true);
         handler.container.avatarEditor.loadOwnAvatarInEditor(0);
      }
      
      public function get hasClub() : Boolean
      {
         return handler.container.sessionDataManager.hasClub;
      }
      
      public function get hasVip() : Boolean
      {
         return handler.container.sessionDataManager.hasVip;
      }
      
      public function get hasEffectOn() : Boolean
      {
         var _loc1_:Array = handler.container.inventory.getActivatedAvatarEffects();
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.isInUse)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set isDancing(param1:Boolean) : void
      {
         var_4668 = param1;
      }
      
      public function get isDancing() : Boolean
      {
         return var_4668;
      }
      
      public function get hasFreeSaddle() : Boolean
      {
         if(var_2069 != null)
         {
            return var_2069.hasFreeSaddle;
         }
         return false;
      }
      
      public function get isRiding() : Boolean
      {
         if(var_2069 != null)
         {
            return var_2069.isRiding;
         }
         return false;
      }
      
      public function get isCurrentUserRiding() : Boolean
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:Number = NaN;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = Number(_loc3_.getNumber("figure_effect"));
               if(_loc2_ == 77)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function openTrainingView() : void
      {
         handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_OPEN_PET_TRAINING"));
      }
      
      public function closeTrainingView() : void
      {
         handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_CLOSE_PET_TRAINING"));
      }
      
      public function get useMinimizedOwnAvatarMenu() : Boolean
      {
         return handler.container.config.getBoolean("use_minimized_own_avatar_menu");
      }
      
      public function set useMinimizedOwnAvatarMenu(param1:Boolean) : void
      {
         handler.container.config.setProperty("use_minimized_own_avatar_menu",param1 ? "1" : "0");
      }
      
      public function sendSignRequest(param1:int) : void
      {
         handler.container.roomSession.sendSignMessage(param1);
      }
      
      public function showUseProductConfirmation(param1:int, param2:int, param3:int) : void
      {
         if(!var_1912)
         {
            var_1912 = new UseProductConfirmationView(this);
         }
         var_1912.open(param1,param2,param3);
      }
      
      private function removeUseProductConfirmationView() : void
      {
         if(var_1912)
         {
            var_1912.dispose();
            var_1912 = null;
         }
      }
      
      public function showBreedingPetsWaitingConfirmationAlert(param1:int, param2:int) : void
      {
         removeBreedingPetsWaitingConfirmationAlert();
         _breedingConfirmationAlert = windowManager.confirm("${breedpets.confirmation.notification.title}","${breedpets.confirmation.notification.text}",0,onWaitingConfirmationAlert);
         var_3730 = param1;
         var_3168 = param2;
      }
      
      public function onWaitingConfirmationAlert(param1:class_3348, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
         }
         if(param2.type == "WE_CANCEL")
         {
            if(var_3168 != -1 && var_3168 != -1)
            {
               cancelBreedPets(var_3730,var_3168);
            }
         }
         removeBreedingPetsWaitingConfirmationAlert();
      }
      
      private function removeBreedingPetsWaitingConfirmationAlert() : void
      {
         if(_breedingConfirmationAlert != null)
         {
            _breedingConfirmationAlert.dispose();
            _breedingConfirmationAlert = null;
            var_3730 = -1;
            var_3168 = -1;
         }
      }
      
      public function acceptBreedingPets(param1:int, param2:int) : void
      {
         if(var_1903 != null)
         {
            if(var_1903.requestRoomObjectId == param1 && var_1903.targetRoomObjectId == param2)
            {
               removeBreedMonsterPlantsConfirmationView();
            }
         }
         if(_breedingConfirmationAlert != null)
         {
            _breedingConfirmationAlert.dispose();
         }
      }
      
      public function cancelBreedingPets(param1:int, param2:int) : void
      {
         if(var_1903 != null)
         {
            if(var_1903.requestRoomObjectId == param1 && var_1903.targetRoomObjectId == param2)
            {
               removeBreedMonsterPlantsConfirmationView();
            }
         }
         removeBreedingPetsWaitingConfirmationAlert();
         windowManager.alert("${breedpets.cancel.notification.title}","${breedpets.cancel.notification.text}",0,onBreedingAlert);
      }
      
      public function onBreedingAlert(param1:class_3348, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK" || param2.type == "WE_CANCEL")
         {
            param1.dispose();
         }
      }
      
      public function showBreedMonsterPlantsConfirmationView(param1:int, param2:int, param3:Boolean) : void
      {
         if(!var_1903)
         {
            var_1903 = new BreedMonsterPlantsConfirmationView(this);
         }
         var_1903.open(param1,param2,param3);
      }
      
      public function showConfirmPetBreedingView(param1:ConfirmPetBreedingPetData, param2:ConfirmPetBreedingPetData, param3:int, param4:Array, param5:int) : void
      {
         if(!var_2164)
         {
            var_2164 = new ConfirmPetBreedingView(this);
         }
         var _loc6_:int = findPetRoomObjectIdByWebId(param1.webId);
         var _loc7_:int = findPetRoomObjectIdByWebId(param2.webId);
         var_2164.open(_loc6_,_loc7_,param3,param4,param5,param1.level,param2.level);
      }
      
      private function removeBreedMonsterPlantsConfirmationView() : void
      {
         if(var_1903)
         {
            var_1903.dispose();
            var_1903 = null;
         }
      }
      
      private function removeConfirmPetBreedingView() : void
      {
         if(var_2164)
         {
            var_2164.dispose();
            var_2164 = null;
         }
      }
      
      public function showBreedPetsResultView(param1:BreedPetsResultData, param2:BreedPetsResultData) : void
      {
         if(!var_1857)
         {
            var_1857 = new BreedPetsResultView(this);
         }
         var_1857.open(param1,param2);
      }
      
      public function removeBreedPetsResultView(param1:BreedPetsResultView) : void
      {
         if(param1 != null)
         {
            if(param1 == var_1857)
            {
               var_1857.dispose();
               var_1857 = null;
            }
            else
            {
               param1.dispose();
            }
         }
      }
      
      private function findCurrentUserRoomObject() : IRoomObject
      {
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc1_:class_3490 = null;
         var _loc5_:int = handler.container.sessionDataManager.userId;
         var _loc6_:int = handler.roomEngine.activeRoomId;
         var _loc7_:int = 100;
         var _loc3_:int = handler.roomEngine.getRoomObjectCount(_loc6_,_loc7_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = handler.roomEngine.getRoomObjectWithIndex(_loc6_,_loc4_,100);
            if(_loc2_ != null)
            {
               _loc1_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
               if(_loc1_ != null)
               {
                  if(_loc1_.webID == _loc5_)
                  {
                     return _loc2_;
                  }
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      internal function get isUserDecorating() : Boolean
      {
         return handler.roomSession.isUserDecorating;
      }
      
      internal function set isUserDecorating(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         var _loc3_:RoomWidgetUserLocationUpdateEvent = null;
         handler.roomSession.isUserDecorating = param1;
         if(param1)
         {
            _loc5_ = handler.container.sessionDataManager.userId;
            if(!var_1874)
            {
               _loc4_ = handler.container.sessionDataManager.userName;
               _loc2_ = handler.container.roomSession.ownUserRoomId;
               var_1874 = new DecorateModeView(this,_loc5_,_loc4_,_loc2_);
            }
            var_1874.show();
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc5_,1)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               var_1874.update(_loc3_.rectangle,_loc3_.screenLocation,0);
            }
         }
         else if(var_1874)
         {
            var_1874.hide(false);
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function isMonsterPlant() : Boolean
      {
         if(var_2069 != null)
         {
            return var_2069.petType == 16;
         }
         return false;
      }
      
      public function cancelBreedPets(param1:int, param2:int) : void
      {
         var _loc3_:class_3490 = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:class_3490 = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new class_717(1,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function acceptBreedPets(param1:int, param2:int) : void
      {
         var _loc3_:class_3490 = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:class_3490 = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new class_717(2,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function breedPets(param1:int, param2:int) : void
      {
         var _loc3_:class_3490 = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:class_3490 = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new class_717(0,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function openBotSkillConfigurationView(param1:int, param2:int, param3:Point = null) : void
      {
         if(!var_2178.hasKey(param2))
         {
            switch(param2 - 2)
            {
               case 0:
                  var_2178.add(2,new BotChatterMarkovConfiguration(this));
                  break;
               case 3:
                  var_2178.add(5,new BotChangeNameConfiguration(this));
                  break;
               default:
                  return;
            }
         }
         var _loc4_:class_3551;
         (_loc4_ = var_2178.getValue(param2)).open(param1,param3);
      }
      
      public function cancelPetBreeding(param1:int) : void
      {
         handler.container.connection.send(new class_989(param1));
      }
      
      public function confirmPetBreeding(param1:int, param2:String, param3:int, param4:int) : void
      {
         handler.container.connection.send(new class_445(param1,param2,param3,param4));
      }
      
      public function showNestBreedingSuccess(param1:int, param2:int) : void
      {
         if(var_3976 == null)
         {
            var_3976 = new NestBreedingSuccessView(this);
         }
         var _loc3_:int = findPetRoomObjectIdByWebId(param1);
         var_3976.open(_loc3_,param2);
      }
      
      public function get friendList() : IHabboFriendList
      {
         return handler.friendList;
      }
   }
}
