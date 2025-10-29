package com.sulake.habbo.nux
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.nux.class_1215;
   import com.sulake.habbo.communication.messages.outgoing.nux.class_1232;
   import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.nux.class_1714;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceNotCompleteEvent;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOfferEvent;
   
   public class HabboNuxDialogs extends Component implements ILinkEventTracker
   {
       
      
      protected var _communicationManager:IHabboCommunicationManager;
      
      protected var _navigator:IHabboNavigator;
      
      protected var _windowManager:IHabboWindowManager;
      
      protected var _localizationManager:IHabboLocalizationManager;
      
      protected var _catalog:IHabboCatalog;
      
      protected var _sessionDataManager:ISessionDataManager;
      
      protected var _roomSessionManager:IRoomSessionManager;
      
      private var var_26:IConnection;
      
      private var var_3466:NuxOfferOldUserView;
      
      private var var_3579:NuxGiftSelectionView;
      
      private var var_3393:NuxNoobRoomOfferView;
      
      private var var_2912:Timer;
      
      public function HabboNuxDialogs(param1:IContext, param2:uint, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         }])]);
      }
      
      override public function dispose() : void
      {
         context.removeLinkEventTracker(this);
         if(_windowManager)
         {
            _windowManager = null;
         }
         destroyGiftSelectionView();
         destroyNoobRoomOfferView();
         destroyNuxOfferView();
         super.dispose();
      }
      
      override protected function initComponent() : void
      {
         var_26 = _communicationManager.connection;
         if(var_26)
         {
            var_26.addMessageEvent(new NewUserExperienceNotCompleteEvent(onNewUserExperienceNotCompleteMessage));
            var_26.addMessageEvent(new NewUserExperienceGiftOfferEvent(onNewUserExperienceGiftOfferMessage));
         }
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "nux/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("lobbyoffer" !== _loc3_)
         {
            class_14.log("HabboNuxDialogs unknown link-type received: " + _loc2_[1]);
         }
         else if(_loc2_.length > 2 && _loc2_[2] == "show")
         {
            createNoobRoomOfferView();
         }
         else
         {
            destroyNoobRoomOfferView();
         }
      }
      
      public function onVerify() : void
      {
         var_26.send(new SetPhoneNumberVerificationStatusMessageComposer(0));
      }
      
      public function onReject() : void
      {
         _windowManager.confirm("${phone.number.never.again.confirm.title}","${phone.number.never.again.confirm.text}",0,onNeverAgainConfirmClose);
      }
      
      private function onNeverAgainConfirmClose(param1:class_3441, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK" && var_26)
         {
            destroyNuxOfferView();
            var_26.send(new SetPhoneNumberVerificationStatusMessageComposer(2));
         }
      }
      
      public function onSendGetGifts(param1:Vector.<class_1232>) : void
      {
         destroyGiftSelectionView();
         var_26.send(new NewUserExperienceGetGiftsMessageComposer(param1));
      }
      
      private function onNewUserExperienceNotCompleteMessage(param1:NewUserExperienceNotCompleteEvent) : void
      {
         createNuxOfferView();
      }
      
      private function onNewUserExperienceGiftOfferMessage(param1:NewUserExperienceGiftOfferEvent) : void
      {
         var _loc2_:class_1215 = param1.getParser();
         createGiftSelectionView(_loc2_.giftOptions);
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         var _loc2_:* = 0;
         if(!getBoolean("nux.lobbies.enabled") || !_sessionDataManager.isRealNoob)
         {
            return;
         }
         if(param1.type == "RSE_STARTED" && param1.session && param1.session.roomId == _navigator.homeRoomId)
         {
            _loc2_ = uint(getInteger("nux.noob.lobby.popup.delay",70) * 1000);
            var_2912 = new Timer(_loc2_,1);
            var_2912.addEventListener("timer",createNoobRoomOfferView);
            var_2912.start();
         }
         else
         {
            destroyNoobRoomOfferView();
         }
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get configuration() : ICoreConfiguration
      {
         return this;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function createNuxOfferView() : void
      {
         destroyNuxOfferView();
         var_3466 = new NuxOfferOldUserView(this);
      }
      
      public function destroyNuxOfferView() : void
      {
         if(var_3466)
         {
            var_3466.dispose();
            var_3466 = null;
         }
      }
      
      private function createGiftSelectionView(param1:Vector.<class_1714>) : void
      {
         destroyGiftSelectionView();
         var_3579 = new NuxGiftSelectionView(this,param1);
      }
      
      private function destroyGiftSelectionView() : void
      {
         if(var_3579)
         {
            var_3579.dispose();
            var_3579 = null;
         }
      }
      
      private function startNoobRoomOfferTimer() : void
      {
      }
      
      private function createNoobRoomOfferView(param1:TimerEvent = null) : void
      {
         if(!getBoolean("nux.lobbies.enabled") || !_sessionDataManager.isRealNoob)
         {
            return;
         }
         destroyNoobRoomOfferView();
         var_3393 = new NuxNoobRoomOfferView(this);
         var_26.send(new EventLogMessageComposer("NewNavigator","nux.offer.lobby","nux.offer.lobby"));
      }
      
      public function destroyNoobRoomOfferView() : void
      {
         if(var_2912)
         {
            var_2912.reset();
            var_2912 = null;
         }
         if(var_3393)
         {
            var_3393.dispose();
            var_3393 = null;
         }
      }
   }
}
