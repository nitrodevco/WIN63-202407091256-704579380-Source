package com.sulake.habbo.session
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.events.MysteryBoxKeysUpdateEvent;
   import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
   import com.sulake.habbo.session.events.UserNameUpdateEvent;
   import com.sulake.habbo.session.furniture.FurnitureDataParser;
   import com.sulake.habbo.session.furniture.class_1813;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.ProductDataParser;
   import com.sulake.habbo.session.product.class_1812;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.*;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.mysterybox.MysteryBoxKeysMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.class_698;
   import com.sulake.habbo.communication.messages.parser.users.class_1127;
   import com.sulake.habbo.communication.messages.parser.users.class_1297;
   import com.sulake.habbo.communication.messages.parser.users.class_1585;
   import com.sulake.habbo.communication.messages.parser.handshake.class_1267;
   import com.sulake.habbo.communication.messages.parser.room.session.class_1207;
   import com.sulake.habbo.communication.messages.parser.avatar.class_1162;
   import com.sulake.habbo.communication.messages.parser.availability.class_1579;
   import com.sulake.habbo.communication.messages.parser.mysterybox.class_1470;
   import com.sulake.habbo.communication.messages.parser.preferences.class_1413;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.preferences.class_433;
   import com.sulake.habbo.communication.messages.outgoing.vault.class_186;
   import com.sulake.habbo.communication.messages.outgoing.vault.WithdrawCreditVaultMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.vault.class_763;
   import com.sulake.habbo.communication.messages.outgoing.vault.class_982;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.FigureUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.AccountSafetyLockStatusChangeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.EmailStatusResultEvent;
   import com.sulake.habbo.communication.messages.incoming.users.InClientLinkMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.nft.UserNftChatStylesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.NoobnessLevelMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.class_1017;
   import com.sulake.habbo.communication.messages.outgoing.users.class_664;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.class_850;
   
   public class SessionDataManager extends Component implements ISessionDataManager
   {
      
      public static const const_443:uint = 1;
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var var_2547:PerkManager;
      
      private var var_280:int;
      
      private var _name:String;
      
      private var var_426:String;
      
      private var var_129:String;
      
      private var _realName:String;
      
      private var var_1501:int = 0;
      
      private var var_1524:int = 0;
      
      private var var_1569:int = 0;
      
      private var var_1539:Boolean = true;
      
      private var var_4141:Vector.<int>;
      
      private var _systemOpen:Boolean;
      
      private var var_4560:Boolean;
      
      private var var_300:Dictionary;
      
      private var var_2097:ProductDataParser;
      
      private var _floorItems:Map;
      
      private var _wallItems:Map;
      
      private var var_2304:Map;
      
      private var var_2307:Map;
      
      private var var_2545:FurnitureDataParser;
      
      private var var_1880:FurnitureDataParser;
      
      private var var_2136:BadgeImageManager;
      
      private var var_4518:HabboGroupInfoManager;
      
      private var var_3416:IgnoredUsersManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var var_3682:Boolean = false;
      
      private var _productDataListeners:Array;
      
      private var _furniDataListeners:Array;
      
      private var var_842:int;
      
      private var var_1393:int;
      
      private var var_4021:int = 0;
      
      private var var_1262:int = -1;
      
      private var _isAmbassador:Boolean;
      
      private var var_4681:Boolean;
      
      private var var_3908:Boolean;
      
      private var var_533:int;
      
      private var var_1528:Boolean = false;
      
      private var _mysteryBoxColor:String;
      
      private var _mysteryKeyColor:String;
      
      private var var_4739:Boolean = false;
      
      private var var_3439:Boolean = false;
      
      private var _newFurniDataHash:String = null;
      
      public function SessionDataManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         },(flags & 1) == 0),new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false)]);
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var_300 = new Dictionary();
         _floorItems = new Map();
         _wallItems = new Map();
         var_2304 = new Map();
         var_2307 = new Map();
         initFurnitureData();
         initProductData();
         initBadgeImageManager();
      }
      
      override protected function initComponent() : void
      {
         if(_communication)
         {
            _communication.addHabboConnectionMessageEvent(new AccountSafetyLockStatusChangeMessageEvent(onAccountSafetyLockStatusChanged));
            _communication.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(onChangeUserNameResult));
            _communication.addHabboConnectionMessageEvent(new UserNftChatStylesMessageEvent(onNftChatStyles));
            _communication.addHabboConnectionMessageEvent(new EmailStatusResultEvent(onEmailStatus));
            _communication.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(onUserNameChange));
            _communication.addHabboConnectionMessageEvent(new InClientLinkMessageEvent(onInClientLink));
            _communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(onRoomReady) as IMessageEvent);
            _communication.addHabboConnectionMessageEvent(new UserChangeMessageEvent(onUserChange));
            _communication.addHabboConnectionMessageEvent(new PetRespectFailedEvent(onPetRespectFailed));
            _communication.addHabboConnectionMessageEvent(new AccountPreferencesEvent(onAccountPreferences));
            _communication.addHabboConnectionMessageEvent(new MysteryBoxKeysMessageEvent(onMysteryBoxKeys));
            _communication.addHabboConnectionMessageEvent(new AvailabilityStatusMessageEvent(onAvailabilityStatus));
            _communication.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
            _communication.addHabboConnectionMessageEvent(new NoobnessLevelMessageEvent(onNoobnessLevelEvent));
            _communication.addHabboConnectionMessageEvent(new FigureUpdateEvent(onFigureUpdate));
            _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         }
         var_4518 = new HabboGroupInfoManager(this);
         var_3416 = new IgnoredUsersManager(this);
         var_2547 = new PerkManager(this);
         _productDataListeners = [];
         _furniDataListeners = [];
         if(_communication)
         {
            initSessionData();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_floorItems)
         {
            _floorItems.dispose();
            _floorItems = null;
         }
         if(var_2304)
         {
            var_2304.dispose();
            var_2304 = null;
         }
         if(var_2307)
         {
            var_2307.dispose();
            var_2307 = null;
         }
         if(var_2547)
         {
            var_2547.dispose();
            var_2547 = null;
         }
         _furniDataListeners = null;
         if(var_2545)
         {
            var_2545.dispose();
            var_2545 = null;
         }
         if(var_1880)
         {
            var_1880.removeEventListener("FDP_furniture_data_ready",onFurnitureReady);
            var_1880.dispose();
            var_1880 = null;
         }
         if(var_2097)
         {
            var_2097.removeEventListener("PDP_product_data_ready",onProductsReady);
            var_2097.dispose();
            var_2097 = null;
         }
         super.dispose();
      }
      
      private function initSessionData() : void
      {
         var_3416.initIgnoreList();
         send(new class_1017());
      }
      
      private function initBadgeImageManager() : void
      {
         if(var_2136 != null)
         {
            return;
         }
         var_2136 = new BadgeImageManager(assets,events,this);
      }
      
      private function initFurnitureData(param1:Boolean = true) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:String = null;
         if(var_1880)
         {
            var_1880.dispose();
            var_1880 = null;
         }
         var_1880 = new FurnitureDataParser(_floorItems,_wallItems,var_2304,var_2307,_localization,param1);
         var_1880.addEventListener("FDP_furniture_data_ready",onFurnitureReady);
         if(propertyExists("furnidata.load.url"))
         {
            _loc3_ = getProperty("furnidata.load.url");
            if(_newFurniDataHash != null)
            {
               _loc4_ = _loc3_.lastIndexOf("/");
               _loc2_ = _loc3_.substring(0,_loc4_);
               var_1880.loadData(_loc2_ + "/" + _newFurniDataHash);
            }
            else
            {
               var_1880.loadData(_loc3_);
            }
         }
      }
      
      private function initProductData() : void
      {
         if(var_2097)
         {
            var_2097.dispose();
            var_2097 = null;
         }
         var _loc1_:String = getProperty("productdata.load.url");
         var_2097 = new ProductDataParser(_loc1_,var_300);
         var_2097.addEventListener("PDP_product_data_ready",onProductsReady);
      }
      
      private function onFurnitureReady(param1:Event = null) : void
      {
         var_1880.removeEventListener("FDP_furniture_data_ready",onFurnitureReady);
         if(var_2545)
         {
            var_2545.dispose();
            var_2545 = null;
         }
         var_2545 = var_1880;
         var_1880 = null;
         var_4739 = true;
         if(!var_3439)
         {
            var_3439 = true;
            for each(var _loc2_ in _furniDataListeners)
            {
               _loc2_.furniDataReady();
            }
         }
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:UserRightsMessageEvent = UserRightsMessageEvent(param1);
         var_842 = _loc2_.clubLevel != 0 ? 2 : 0;
         var_1393 = _loc2_.securityLevel;
         var_4021 = Math.max(var_4021,_loc2_.securityLevel);
         _isAmbassador = _loc2_.isAmbassador;
      }
      
      private function onNoobnessLevelEvent(param1:NoobnessLevelMessageEvent) : void
      {
         var_1262 = param1.noobnessLevel;
         if(var_1262 != 0)
         {
            context.configuration.setProperty("new.identity","1");
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:UserObjectEvent = param1 as UserObjectEvent;
         var _loc3_:class_1267 = _loc2_.getParser();
         var_280 = _loc3_.id;
         _name = _loc3_.name;
         var_1501 = _loc3_.respectTotal;
         var_1524 = _loc3_.respectLeft;
         var_1569 = _loc3_.petRespectLeft;
         var_426 = _loc3_.figure;
         var_129 = _loc3_.sex;
         _realName = _loc3_.realName;
         var_1539 = _loc3_.nameChangeAllowed;
         var_1528 = _loc3_.accountSafetyLocked;
         try
         {
            if(context.displayObjectContainer && propertyExists("environment.id"))
            {
               _loc4_ = (_loc4_ = (_loc4_ = getProperty("environment.id")).replace("pt","br")).replace("en","com");
               context.displayObjectContainer.stage.nativeWindow.title = "Habbo " + _loc4_.toUpperCase() + " | " + _name;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserChangeMessageEvent = param1 as UserChangeMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.id == -1)
         {
            var_426 = _loc2_.figure;
            var_129 = _loc2_.sex;
         }
      }
      
      private function onFigureUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:FigureUpdateEvent = param1 as FigureUpdateEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var_426 = _loc2_.figure;
         var_129 = _loc2_.gender;
         HabboWebTools.updateFigure(var_426);
      }
      
      private function onNftChatStyles(param1:IMessageEvent) : void
      {
         var _loc2_:UserNftChatStylesMessageEvent = param1 as UserNftChatStylesMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var_4141 = _loc2_.getParser().chatStyleIds;
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserNameChangedMessageEvent = param1 as UserNameChangedMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:class_1297 = _loc2_.getParser();
         if(_loc3_.webId == var_280)
         {
            _name = _loc3_.newName;
            var_1539 = false;
            events.dispatchEvent(new UserNameUpdateEvent(_name));
         }
      }
      
      private function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:class_1162 = param1.getParser();
         if(_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_1586)
         {
            try
            {
               if(context.displayObjectContainer && propertyExists("environment.id"))
               {
                  _loc3_ = getProperty("environment.id");
                  _loc3_ = _loc3_.replace("pt","br");
                  _loc3_ = _loc3_.replace("en","com");
                  context.displayObjectContainer.stage.nativeWindow.title = "Habbo " + _loc3_.toUpperCase() + " | " + _loc2_.name;
               }
            }
            catch(e:Error)
            {
            }
            var_1539 = false;
            events.dispatchEvent(new UserNameUpdateEvent(_loc2_.name));
         }
      }
      
      private function onMysteryBoxKeys(param1:MysteryBoxKeysMessageEvent) : void
      {
         var _loc2_:class_1470 = param1.getParser();
         _mysteryBoxColor = _loc2_.boxColor;
         _mysteryKeyColor = _loc2_.keyColor;
         events.dispatchEvent(new MysteryBoxKeysUpdateEvent(_mysteryBoxColor,_mysteryKeyColor));
      }
      
      private function onInClientLink(param1:InClientLinkMessageEvent) : void
      {
         context.createLinkEvent(param1.link);
      }
      
      private function onAccountPreferences(param1:AccountPreferencesEvent) : void
      {
         var _loc2_:class_1413 = param1.getParser() as class_1413;
         var_3908 = _loc2_.roomCameraFollowDisabled;
         var_533 = _loc2_.uiFlags;
         events.dispatchEvent(new SessionDataPreferencesEvent(var_533));
      }
      
      private function onEmailStatus(param1:EmailStatusResultEvent) : void
      {
         var _loc2_:class_1127 = param1.getParser() as class_1127;
         var_4681 = _loc2_.isVerified;
      }

      private function onAvailabilityStatus(event: IMessageEvent): void {
         var parser: class_1579 = (event as AvailabilityStatusMessageEvent).getParser();
         if (parser == null) {
            return;
         }

         _systemOpen = parser.isOpen;
         var_4560 = parser.onShutDown;
         var_4739 = parser.isAuthenticHabbo;

         if (var_4739 && !var_3439) {
            var_3439 = true;
            for each (var listener: class_1813 in _furniDataListeners) {
               listener.furniDataReady();
            }
         }
      }

      private function onPetRespectFailed(param1:PetRespectFailedEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_1569++;
      }
      
      private function onAccountSafetyLockStatusChanged(param1:AccountSafetyLockStatusChangeMessageEvent) : void
      {
         var _loc2_:class_1585 = param1.getParser();
         var_1528 = _loc2_.status == 0;
      }
      
      public function get systemOpen() : Boolean
      {
         return _systemOpen;
      }
      
      public function get systemShutDown() : Boolean
      {
         return var_4560;
      }
      
      public function hasSecurity(param1:int) : Boolean
      {
         return var_1393 >= param1;
      }
      
      public function get topSecurityLevel() : int
      {
         return var_4021;
      }
      
      public function get clubLevel() : int
      {
         return var_842;
      }
      
      public function get hasVip() : Boolean
      {
         return HabboClubLevelEnum.HasVip(var_842);
      }
      
      public function get hasClub() : Boolean
      {
         return HabboClubLevelEnum.HasClub(var_842);
      }
      
      public function get isNoob() : Boolean
      {
         return var_1262 != 0;
      }
      
      public function get isRealNoob() : Boolean
      {
         return var_1262 == 2;
      }
      
      public function get userId() : int
      {
         return var_280;
      }
      
      public function get userName() : String
      {
         return _name;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return var_1393 >= 5;
      }
      
      public function get isAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function get isEmailVerified() : Boolean
      {
         return var_4681;
      }
      
      public function setRoomCameraFollowDisabled(param1:Boolean) : void
      {
         var_3908 = param1;
      }
      
      public function get isRoomCameraFollowDisabled() : Boolean
      {
         return var_3908;
      }
      
      public function setFriendBarState(param1:Boolean) : void
      {
         setUIFlag(1,param1);
      }
      
      public function setRoomToolsState(param1:Boolean) : void
      {
         setUIFlag(2,param1);
      }
      
      public function get uiFlags() : int
      {
         return var_533;
      }
      
      private function setUIFlag(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            if(var_533 & param1)
            {
               return;
            }
            var_533 |= param1;
         }
         else
         {
            if(!(var_533 & param1))
            {
               return;
            }
            var_533 &= ~param1;
         }
         _communication.connection.send(new class_433(var_533));
      }
      
      public function getBadgeImage(param1:String) : BitmapData
      {
         return var_2136.getBadgeImage(param1);
      }
      
      public function getBadgeSmallImage(param1:String) : BitmapData
      {
         return var_2136.getSmallBadgeImage(param1);
      }
      
      public function getBadgeImageAssetName(param1:String) : String
      {
         return var_2136.getBadgeImageAssetName(param1);
      }
      
      public function getBadgeImageSmallAssetName(param1:String) : String
      {
         return var_2136.getSmallScaleBadgeAssetName(param1);
      }
      
      public function requestBadgeImage(param1:String) : BitmapData
      {
         return var_2136.getBadgeImage(param1,"normal_badge",false);
      }
      
      public function getBadgeImageWithInfo(param1:String) : BadgeInfo
      {
         return var_2136.getBadgeImageWithInfo(param1);
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      public function getGroupBadgeId(param1:int) : String
      {
         return var_4518.getBadgeId(param1);
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getGroupBadgeImage(param1:String) : BitmapData
      {
         return var_2136.getBadgeImage(param1,"group_badge");
      }
      
      public function getGroupBadgeSmallImage(param1:String) : BitmapData
      {
         return var_2136.getSmallBadgeImage(param1,"group_badge");
      }
      
      public function getGroupBadgeAssetName(param1:String) : String
      {
         return var_2136.getBadgeImageAssetName(param1,"group_badge");
      }
      
      public function getGroupBadgeSmallAssetName(param1:String) : String
      {
         return var_2136.getSmallScaleBadgeAssetName(param1,"group_badge");
      }
      
      public function isAccountSafetyLocked() : Boolean
      {
         return var_1528;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function isIgnored(param1:int) : Boolean
      {
         return var_3416.isIgnored(param1);
      }
      
      public function ignoreUser(param1:int) : void
      {
         var_3416.ignoreUser(param1);
      }
      
      public function unignoreUser(param1:int) : void
      {
         var_3416.unignoreUser(param1);
      }
      
      public function get respectLeft() : int
      {
         return var_1524;
      }
      
      public function get petRespectLeft() : int
      {
         return var_1569;
      }
      
      public function giveStarGem(param1:int) : void
      {
         if(param1 >= 0)
         {
            send(new class_664(param1));
         }
      }
      
      public function giveRespectFailed() : void
      {
         var_1524 += 1;
      }
      
      public function getCreditVaultStatus() : void
      {
         send(new class_186());
      }
      
      public function getIncomeRewardStatus() : void
      {
         send(new class_763());
      }
      
      public function withdrawCreditVault() : void
      {
         send(new WithdrawCreditVaultMessageComposer());
      }
      
      public function claimReward(param1:int) : void
      {
         send(new class_982(param1));
      }
      
      public function givePetRespect(param1:int) : void
      {
         if(param1 >= 0 && var_1569 > 0)
         {
            send(new class_850(param1));
            var_1569 -= 1;
         }
      }
      
      public function getProductData(param1:String) : class_3423
      {
         if(!var_3682)
         {
            loadProductData();
         }
         return var_300[param1];
      }
      
      public function getFloorItemData(param1:int) : class_3365
      {
         if(_floorItems == null)
         {
            return null;
         }
         return _floorItems.getValue(param1.toString());
      }
      
      public function getFloorItemsDataByCategory(param1:int) : Array
      {
         var _loc2_:Array = [];
         if(_floorItems != null)
         {
            for each(var _loc3_ in _floorItems)
            {
               if(_loc3_.category == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getWallItemData(param1:int) : class_3365
      {
         if(_wallItems == null)
         {
            return null;
         }
         return _wallItems.getValue(param1.toString());
      }
      
      public function getFloorItemDataByName(param1:String, param2:int = 0) : class_3365
      {
         var _loc3_:int = 0;
         if(var_2304 == null)
         {
            return null;
         }
         var _loc4_:Array;
         if((_loc4_ = var_2304.getValue(param1)) != null && param2 <= _loc4_.length - 1)
         {
            _loc3_ = int(_loc4_[param2]);
            return getFloorItemData(_loc3_);
         }
         return null;
      }
      
      public function getWallItemDataByName(param1:String, param2:int = 0) : class_3365
      {
         var _loc3_:int = 0;
         if(var_2307 == null)
         {
            return null;
         }
         var _loc4_:Array;
         if((_loc4_ = var_2307.getValue(param1)) != null && param2 <= _loc4_.length - 1)
         {
            _loc3_ = int(_loc4_[param2]);
            return getWallItemData(_loc3_);
         }
         return null;
      }
      
      public function openHabboHomePage(param1:int, param2:String) : void
      {
         var _loc3_:String = null;
         if(propertyExists("link.format.userpage"))
         {
            _loc3_ = getProperty("link.format.userpage");
            _loc3_ = _loc3_.replace("%ID%",String(param1));
            _loc3_ = _loc3_.replace("%username%",param2);
            try
            {
               HabboWebTools.navigateToURL(_loc3_,"habboMain");
            }
            catch(e:Error)
            {
               class_14.log("Error occurred!");
            }
         }
      }
      
      public function pickAllFurniture(param1:int) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.pick_all}",0,function(param1:class_3441, param2:WindowEvent):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(":pickall");
               }
            });
         }
      }
      
      public function resetScores(param1:int) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.resetscores}",0,function(param1:class_3441, param2:WindowEvent):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(":resetscores");
               }
            });
         }
      }
      
      public function ejectAllFurniture(param1:int, param2:String) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         var message:String = param2;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.eject_all}",0,function(param1:class_3441, param2:WindowEvent):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(message);
               }
            });
         }
      }
      
      public function ejectPets(param1:int) : void
      {
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         var _loc2_:IRoomSession = _roomSessionManager.getSession(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.isRoomOwner || isAnyRoomController)
         {
            sendSpecialCommandMessage(":ejectpets");
         }
      }
      
      public function pickAllBuilderFurniture(param1:int) : void
      {
         var session:IRoomSession;
         var roomId:int = param1;
         if(_roomSessionManager == null || _windowManager == null)
         {
            return;
         }
         session = _roomSessionManager.getSession(roomId);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController || session.roomControllerLevel >= 1)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.pick_all_bc}",0,function(param1:class_3441, param2:WindowEvent):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  sendSpecialCommandMessage(":pickallbc");
               }
            });
         }
      }
      
      public function loadProductData(param1:class_1812 = null) : Boolean
      {
         if(var_3682)
         {
            return true;
         }
         if(param1 && _productDataListeners.indexOf(param1) == -1)
         {
            _productDataListeners.push(param1);
         }
         return false;
      }
      
      public function addProductsReadyEventListener(param1:class_1812) : void
      {
         if(var_3682)
         {
            param1.productDataReady();
            return;
         }
         if(param1 && _productDataListeners.indexOf(param1) == -1)
         {
            _productDataListeners.push(param1);
         }
      }
      
      private function onProductsReady(param1:Event) : void
      {
         var_2097.removeEventListener("PDP_product_data_ready",onProductsReady);
         var_3682 = true;
         for each(var _loc2_ in _productDataListeners)
         {
            if(_loc2_ != null && !_loc2_.disposed)
            {
               _loc2_.productDataReady();
            }
         }
         _productDataListeners = [];
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         var _loc3_:RoomReadyMessageEvent = param1 as RoomReadyMessageEvent;
         if(_loc3_ == null || _loc3_.getParser() == null || param1.connection == null)
         {
            return;
         }
         var _loc2_:class_1207 = _loc3_.getParser();
         HabboWebTools.roomVisited(_loc2_.roomId);
      }
      
      public function sendSpecialCommandMessage(param1:String) : void
      {
         send(new class_698(param1));
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get gender() : String
      {
         return var_129;
      }
      
      public function set newFurniDataHash(param1:String) : void
      {
         _newFurniDataHash = param1;
      }
      
      public function refreshFurniData() : void
      {
         _floorItems = new Map();
         _wallItems = new Map();
         var_2304 = new Map();
         var_2307 = new Map();
         initFurnitureData(false);
      }
      
      public function removeFurniDataListener(param1:class_1813) : void
      {
         if(!_furniDataListeners)
         {
            return;
         }
         var _loc2_:int = _furniDataListeners.indexOf(param1);
         if(_loc2_ > -1)
         {
            _furniDataListeners.splice(_loc2_,1);
         }
      }
      
      public function getFurniData(param1:class_1813) : Vector.<class_3365>
      {
         if(_floorItems == null || _floorItems.length == 0)
         {
            if(_furniDataListeners.indexOf(param1) == -1)
            {
               _furniDataListeners.push(param1);
            }
            return null;
         }
         return Vector.<class_3365>(_floorItems.getValues().concat(_wallItems.getValues()));
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
            _loc3_ = _windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get nameChangeAllowed() : Boolean
      {
         return var_1539;
      }
      
      public function get perksReady() : Boolean
      {
         return var_2547 != null && var_2547.isReady;
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         return var_2547.isPerkAllowed(param1);
      }
      
      public function getPerkErrorMessage(param1:String) : String
      {
         return var_2547.getPerkErrorMessage(param1);
      }
      
      public function get currentTalentTrack() : String
      {
         return getBoolean("talent.track.citizenship.enabled") && !isPerkAllowed("CITIZEN") ? "citizenship" : "helper";
      }
      
      public function get mysteryBoxColor() : String
      {
         return _mysteryBoxColor;
      }
      
      public function get mysteryKeyColor() : String
      {
         return _mysteryKeyColor;
      }
      
      public function hasNftChatStyle(param1:int) : Boolean
      {
         return var_4141 != null && var_4141.indexOf(param1) != -1;
      }
   }
}
