package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.clubcenter.util.BadgeResolver;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.catalog.purse.class_3378;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.Stage;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendKickbackInfoMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesEventParser;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1739;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendKickbackInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.ScrGetKickbackInfoMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
   
   public class HabboClubCenter extends Component implements ILinkEventTracker, IOfferExtension
   {
      
      private static const USE_FAKE_DATA:Boolean = false;
      
      private static const DATA_UPDATE_INTERVAL_MSEC:int = 10000;
       
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var _offerCenter:IOfferCenter;
      
      private var var_3780:Boolean = false;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_1631:ClubCenterView;
      
      private var var_3128:ClubSpecialInfoBubbleView;
      
      private var var_47:class_1739;
      
      private var var_4785:int = -10000;
      
      private var var_3230:Boolean = false;
      
      private var var_372:String;
      
      private var var_1388:int;
      
      private var var_3540:Vector.<Map>;
      
      public function HabboClubCenter(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new ClubGiftInfoEvent(onClubGiftInfo));
         addMessageEvent(new ScrSendKickbackInfoMessageEvent(onKickbackInfoMessageEvent));
         addMessageEvent(new BadgesEvent(onBadges));
         context.addLinkEventTracker(this);
         if(getBoolean("offers.enabled") && getBoolean("offers.habboclub.enabled"))
         {
            _offerCenter = catalog.getOfferCenter(this);
         }
      }
      
      override public function dispose() : void
      {
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(_sessionDataManager != null && _sessionDataManager.events)
         {
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeReady);
         }
         if(_offerCenter != null)
         {
            _offerCenter = null;
         }
         removeView();
         var_47 = null;
         _messageEvents = null;
         super.dispose();
      }
      
      public function get linkPattern() : String
      {
         return "habboUI/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 3)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            var _loc3_:* = _loc2_[2];
            if("hccenter" === _loc3_)
            {
               showClubCenter();
            }
         }
      }
      
      private function showClubCenter() : void
      {
         if(!var_1631)
         {
            var_1631 = new ClubCenterView(this,_windowManager,_sessionDataManager.figure);
         }
         if(updateNeeded())
         {
            updateData();
         }
         else
         {
            populate();
         }
         if(_offerCenter && var_1631 && var_3780)
         {
            var_3780 = false;
            indicateVideoAvailable(true);
         }
      }
      
      public function removeView() : void
      {
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         removeBreakdown();
         var_3230 = false;
      }
      
      public function removeBreakdown() : void
      {
         if(var_3128)
         {
            var_3128.dispose();
            var_3128 = null;
         }
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function onKickbackInfoMessageEvent(param1:ScrSendKickbackInfoMessageEvent) : void
      {
         var _loc2_:ScrSendKickbackInfoMessageEventParser = param1.getParser();
         var_47 = _loc2_.data;
         var_3230 = false;
         var_4785 = getTimer();
         populate();
      }
      
      private function onClubGiftInfo(param1:ClubGiftInfoEvent) : void
      {
         var_1388 = param1.getParser().giftsAvailable;
         populate();
      }
      
      private function onBadgeReady(param1:BadgeImageReadyEvent) : void
      {
         if(param1.badgeId != var_372 || !_sessionDataManager)
         {
            return;
         }
         _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeReady);
         populate();
      }
      
      public function onBadges(param1:IMessageEvent) : void
      {
         var _loc3_:BadgesEventParser = (param1 as BadgesEvent).getParser();
         if(var_3540 == null)
         {
            var_3540 = new Vector.<Map>(_loc3_.totalFragments,true);
         }
         var _loc4_:Map;
         (_loc4_ = new Map()).concatenate(_loc3_.currentFragment);
         var _loc2_:Map = addMessageFragment(_loc4_,_loc3_.totalFragments,_loc3_.fragmentNo,var_3540);
         if(!_loc2_)
         {
            return;
         }
         var_3540 = null;
         var_372 = BadgeResolver.resolveClubBadgeId(_loc2_.getKeys());
      }
      
      private function updateNeeded() : Boolean
      {
         return !var_3230 && getTimer() - var_4785 > 10000;
      }
      
      private function updateData() : void
      {
         var_3230 = true;
         _communicationManager.connection.send(new GetBadgesComposer());
         _communicationManager.connection.send(new GetClubGiftMessageComposer());
         if(true)
         {
            _communicationManager.connection.send(new ScrGetKickbackInfoMessageComposer());
         }
         else
         {
            var_47 = new class_1739();
            populate();
         }
      }
      
      private function populate() : void
      {
         if(var_1631)
         {
            var_1631.dataReceived(var_47,getPurse(),getGiftsAvailable(),BadgeResolver.resolveBadgeBitmap(var_372,onBadgeReady,_sessionDataManager));
         }
      }
      
      private function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function getPurse() : class_3378
      {
         return catalog != null ? catalog.getPurse() : null;
      }
      
      private function getGiftsAvailable() : int
      {
         return var_1388;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return catalog != null ? catalog.localization : null;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function resolveClubStatus() : String
      {
         if(!catalog)
         {
            return "none";
         }
         var _loc1_:class_3378 = getPurse();
         if(_loc1_.clubDays > 0)
         {
            return "active";
         }
         if(_loc1_.pastClubDays > 0 || _loc1_.pastVipDays > 0)
         {
            return "expired";
         }
         return "none";
      }
      
      public function openPurchasePage() : void
      {
         if(catalog)
         {
            catalog.openCatalogPage("hc_membership","NORMAL");
         }
      }
      
      public function openClubGiftPage() : void
      {
         if(catalog)
         {
            catalog.openCatalogPage("club_gifts","NORMAL");
         }
      }
      
      public function showPaydayBreakdownView() : void
      {
         if(var_3128)
         {
            removeBreakdown();
            return;
         }
         var_3128 = new ClubSpecialInfoBubbleView(this,_windowManager,var_47,var_1631.getSpecialCalloutAnchor());
      }
      
      public function openPaydayHelpPage() : void
      {
         context.createLinkEvent("habbopages/hcpayday");
      }
      
      public function openHelpPage() : void
      {
         context.createLinkEvent("habbopages/habboclub");
      }
      
      public function processHotelLink(param1:String) : void
      {
         context.createLinkEvent(param1);
      }
      
      public function isKickbackEnabled() : Boolean
      {
         var _loc1_:String = getProperty("hccenter.activity.enabled");
         if(_loc1_ == null || _loc1_ == "")
         {
            return true;
         }
         return _loc1_ == "1" || _loc1_ == "true";
      }
      
      public function get stage() : Stage
      {
         return context && context.displayObjectContainer ? context.displayObjectContainer.stage : null;
      }
      
      public function getOffers() : void
      {
         _catalog.getHabboClubOffers(3);
      }
      
      public function get offerCenter() : IOfferCenter
      {
         return _offerCenter;
      }
      
      public function indicateRewards() : void
      {
      }
      
      public function indicateVideoAvailable(param1:Boolean) : void
      {
         if(var_1631)
         {
            var_1631.setVideoOfferButtonVisibility(param1,_offerCenter != null && !_offerCenter.showingVideo);
         }
         else
         {
            var_3780 = param1;
         }
      }
      
      private function addMessageFragment(param1:Map, param2:int, param3:int, param4:Vector.<Map>) : Map
      {
         if(param2 == 1)
         {
            return param1;
         }
         param4[param3] = param1;
         for each(var _loc5_ in param4)
         {
            if(_loc5_ == null)
            {
               return null;
            }
         }
         var _loc6_:Map = new Map();
         for each(var _loc7_ in param4)
         {
            _loc6_.concatenate(_loc7_);
            _loc7_.dispose();
         }
         param4 = null;
         return _loc6_;
      }
   }
}
