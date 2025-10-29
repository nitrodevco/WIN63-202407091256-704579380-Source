package com.sulake.habbo.catalog
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.class_79;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.class_1881;
   import com.sulake.habbo.catalog.club.ClubBuyController;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.club.ClubExtendController;
   import com.sulake.habbo.catalog.club.ClubGiftController;
   import com.sulake.habbo.catalog.clubcenter.HabboClubCenter;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.class_3479;
   import com.sulake.habbo.catalog.collectibles.widget.MintTokenPurchaseOffer;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.event.CatalogUserEvent;
   import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
   import com.sulake.habbo.catalog.marketplace.IMarketPlace;
   import com.sulake.habbo.catalog.marketplace.MarketPlaceLogic;
   import com.sulake.habbo.catalog.marketplace.class_3453;
   import com.sulake.habbo.catalog.navigation.CatalogNavigator;
   import com.sulake.habbo.catalog.navigation.RequestedPage;
   import com.sulake.habbo.catalog.navigation.class_3341;
   import com.sulake.habbo.catalog.navigation.class_3411;
   import com.sulake.habbo.catalog.navigation.events.CatalogFurniPurchaseEvent;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.catalog.offers.OfferCenter;
   import com.sulake.habbo.catalog.purchase.GiftWrappingConfiguration;
   import com.sulake.habbo.catalog.purchase.PlacedObjectPurchaseData;
   import com.sulake.habbo.catalog.purchase.PurchaseConfirmationDialog;
   import com.sulake.habbo.catalog.purchase.RentConfirmationWindow;
   import com.sulake.habbo.catalog.purchase.RoomAdPurchaseData;
   import com.sulake.habbo.catalog.purse.Purse;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
   import com.sulake.habbo.catalog.purse.class_3378;
   import com.sulake.habbo.catalog.targetedoffers.OfferController;
   import com.sulake.habbo.catalog.vault.VaultController;
   import com.sulake.habbo.catalog.viewer.CatalogViewer;
   import com.sulake.habbo.catalog.viewer.GameTokensOffer;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.PageLocalization;
   import com.sulake.habbo.catalog.viewer.Product;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3440;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import com.sulake.habbo.catalog.viewer.class_3458;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBuilderSubscriptionUpdatedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetRoomChangedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetPalettesEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.friendbar.events.FriendBarSelectionEvent;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.quest.class_2197;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedOnUserEvent;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.furniture.class_1813;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_1812;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.*;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.RedeemMarketplaceOfferCreditsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.class_127;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.class_370;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.class_403;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.class_406;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.class_802;
   import com.sulake.habbo.communication.messages.incoming.inventory.purse.CreditBalanceEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.class_1121;
   import com.sulake.habbo.communication.messages.parser.marketplace.class_1445;
   import com.sulake.habbo.communication.messages.parser.marketplace.class_1518;
   import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokenOffer;
   import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokensMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1123;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1126;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1222;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1273;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1291;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1294;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1358;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1372;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1474;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1565;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1586;
   import com.sulake.habbo.communication.messages.parser.users.class_1328;
   import com.sulake.habbo.communication.messages.parser.users.class_1359;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_663;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1502;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1520;
   import com.sulake.habbo.communication.messages.parser.inventory.purse.class_1192;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseSnowWarGameTokensOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_1099;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_156;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_270;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetRoomAdPurchaseInfoComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_428;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetSellablePetPalettesComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_503;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_512;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_520;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_521;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_594;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_801;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_852;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_855;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_881;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetProductOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_887;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_933;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_939;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_976;
   import com.sulake.habbo.communication.messages.incoming.collectibles.EmeraldBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.SilverBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_985;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ApproveNameMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.class_984;
   import com.sulake.habbo.communication.messages.outgoing.users.class_304;
   import com.sulake.habbo.communication.messages.incoming.catalog.SnowWarGameTokensMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_149;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1501;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1639;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1671;
   import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubSubscriptionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1718;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemOkMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.SellablePetPalettesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.LimitedEditionSoldOutEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemErrorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftReceiverNotFoundEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRulesetMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.ProductOfferEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
   
   public class HabboCatalog extends Component implements IHabboCatalog, class_1812, IUpdateReceiver, ILinkEventTracker, class_1813
   {
      
      public static const GET_SNOWWAR_TOKENS:String = "GET_SNOWWAR_TOKENS";
      
      public static const GET_SNOWWAR_TOKENS2:String = "GET_SNOWWAR_TOKENS2";
      
      public static const GET_SNOWWAR_TOKENS3:String = "GET_SNOWWAR_TOKENS3";
      
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const DEFAULT_VIEW_LOCATION:Point = new Point(100,20);
      
      private static const DEFAULT_VIEW_LOCATION_LARGE:Point = new Point(100,5);
      
      private static const MAX_SEARCH_RESULTS_LENGTH:uint = 200;
      
      private static const NO_KNOWN_OFFER:int = -1;
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var var_2300:IRoomSession;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _notifications:IHabboNotifications;
      
      private var _inventory:class_1814;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _soundManager:class_2240;
      
      private var _friendList:IHabboFriendList;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _avatarEditor:class_1881;
      
      private var _questEngine:class_2197;
      
      private var var_3117:VideoOfferManager;
      
      private var var_78:Boolean = false;
      
      private var var_3682:Boolean = false;
      
      private var var_3723:Boolean = false;
      
      private var var_1690:CatalogViewer;
      
      private var _catalogNavigators:Dictionary;
      
      private var var_1714:Purse;
      
      private var var_1811:IMarketPlace;
      
      private var var_1647:IWindowContainer;
      
      private var var_1715:PurchaseConfirmationDialog;
      
      private var var_4054:String;
      
      private var var_3436:Boolean;
      
      private var var_4378:Boolean = true;
      
      private var var_3877:Boolean = false;
      
      private var var_4321:GiftWrappingConfiguration;
      
      private var var_3444:ClubGiftController;
      
      private var var_2362:ClubBuyController;
      
      private var var_2420:ClubExtendController;
      
      private var var_2614:Map;
      
      private var var_2052:Boolean = false;
      
      private var _offerInFurniPlacing:class_3377;
      
      private var _offerPlacingCallbackReceiver:class_3458;
      
      private var var_1725:PlacedObjectPurchaseData;
      
      private var var_825:Boolean;
      
      private var var_4382:Boolean;
      
      private var var_1799:RoomPreviewer;
      
      private var var_2201:GuildMembershipsController;
      
      private var var_3399:OfferController;
      
      private var _utils:HabboCatalogUtils;
      
      private var var_3130:Boolean = false;
      
      private var var_2393:String = null;
      
      private var var_2329:GameTokensOffer;
      
      private var var_2278:GameTokensOffer;
      
      private var var_2381:GameTokensOffer;
      
      private var _bundleDiscountRuleset:class_1639 = null;
      
      private var var_2054:RequestedPage;
      
      private var var_4238:int;
      
      private var var_1946:RoomAdPurchaseData;
      
      private var var_2794:RentConfirmationWindow;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_395:String = "NORMAL";
      
      private var var_2047:Vector.<class_3365>;
      
      private var _frontPageItems:Vector.<class_1671>;
      
      private var var_2716:Timer;
      
      private var var_4250:Dictionary;
      
      private var var_4817:Boolean;
      
      private var var_4155:int = -1;
      
      private var var_4126:int;
      
      private var var_4660:int;
      
      private var var_3757:int;
      
      private var var_4109:int;
      
      private var _builderMembershipUpdateTime:int;
      
      private var _builderMembershipDisplayUpdateTime:int;
      
      private var var_3787:Boolean;
      
      private var var_3753:Boolean;
      
      private var _offerCenter:OfferCenter;
      
      private var var_1754:CollectiblesController;
      
      public function HabboCatalog(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var_2614 = new Map();
         super(param1,param2,param3);
         var_1714 = new Purse();
         _utils = new HabboCatalogUtils(this);
         registerUpdateReceiver(this,1);
         var_2054 = new RequestedPage();
         param1.attachComponent(new HabboClubCenter(param1,0,param3),[new IIDHabboClubCenter()]);
         param1.attachComponent(new VaultController(param1,0,param3),[new IIDVaultController()]);
         var_1754 = new CollectiblesController(param1,0,param3);
         param1.attachComponent(var_1754,[new IIDCollectiblesController()]);
      }
      
      public static function setElementImageCentered(param1:IWindow, param2:BitmapData, param3:int = 0) : void
      {
         var _loc7_:IBitmapWrapperWindow = null;
         var _loc4_:class_3431 = null;
         if(param2 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.disposed)
         {
            return;
         }
         var _loc8_:int = param3 > 0 ? param3 : param1.height;
         var _loc5_:int = (param1.width - param2.width) / 2;
         var _loc6_:int = (_loc8_ - param2.height) / 2;
         if(param1 as IBitmapWrapperWindow != null)
         {
            if((_loc7_ = IBitmapWrapperWindow(param1)).bitmap == null || param3 > 0)
            {
               _loc7_.bitmap = new BitmapData(param1.width,_loc8_,true,16777215);
            }
            _loc7_.bitmap.fillRect(_loc7_.bitmap.rect,16777215);
            _loc7_.bitmap.copyPixels(param2,param2.rect,new Point(_loc5_,_loc6_),null,null,false);
            param1.invalidate();
         }
         else if(param1 as class_3431 != null)
         {
            (_loc4_ = class_3431(param1)).setDisplayObject(new Bitmap(param2));
            param1.invalidate();
         }
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get connection() : IConnection
      {
         return _communication.connection;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get giftWrappingConfiguration() : GiftWrappingConfiguration
      {
         return var_4321;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get soundManager() : class_2240
      {
         return _soundManager;
      }
      
      public function get roomPreviewer() : RoomPreviewer
      {
         if(var_1799 == null)
         {
            initializeRoomPreviewer();
         }
         return var_1799;
      }
      
      public function get navigator() : IHabboNavigator
      {
         return _newNavigator.legacyNavigator;
      }
      
      public function get utils() : HabboCatalogUtils
      {
         return _utils;
      }
      
      public function get questEngine() : class_2197
      {
         return _questEngine;
      }
      
      public function get videoOffers() : IVideoOfferManager
      {
         return var_3117;
      }
      
      public function get frontPageItems() : Vector.<class_1671>
      {
         return _frontPageItems;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         },false),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REOE_PLACED",
            "callback":onObjectPlacedInRoom
         },{
            "type":"REOE_PLACED_ON_USER",
            "callback":onObjectPlaceOnUser
         },{
            "type":"REOE_SELECTED",
            "callback":onObjectSelected
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         },false),new ComponentDependency(new IIDHabboInventory(),function(param1:class_1814):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_2240):void
         {
            _soundManager = param1;
         },false),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         }]),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         },false),new ComponentDependency(new IIDHabboFriendBar(),null,false,[{
            "type":"FBVE_FRIEND_SELECTED",
            "callback":onFriendBarSelectionEvent
         }]),new ComponentDependency(new IIDHabboGroupsManager(),null,false,[{
            "type":"GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",
            "callback":onGuildVisualSettingsChanged
         }]),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:class_1881):void
         {
            _avatarEditor = param1;
         },false),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_2197):void
         {
            _questEngine = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new GiftReceiverNotFoundEvent(onGiftReceiverNotFound));
         addMessageEvent(new BundleDiscountRulesetMessageEvent(onBundleDiscountRulesetMessageEvent));
         addMessageEvent(new NotEnoughBalanceMessageEvent(onNotEnoughBalance));
         addMessageEvent(new SellablePetPalettesMessageEvent(onSellablePalettes));
         addMessageEvent(new ApproveNameMessageEvent(onApproveNameResult));
         addMessageEvent(new CatalogPublishedMessageEvent(onCatalogPublished));
         addMessageEvent(new LimitedEditionSoldOutEvent(onLimitedEditionSoldOut));
         addMessageEvent(new MarketPlaceOwnOffersEvent(onMarketPlaceOwnOffers));
         addMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointNotification));
         addMessageEvent(new MarketplaceBuyOfferResultEvent(onMarketPlaceBuyResult));
         addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         addMessageEvent(new SnowWarGameTokensMessageEvent(onSnowWarGameTokenOffer));
         addMessageEvent(new MarketplaceCancelOfferResultEvent(onMarketPlaceCancelResult));
         addMessageEvent(new HabboClubOffersMessageEvent(onHabboClubOffers));
         addMessageEvent(new PurchaseOKMessageEvent(onPurchaseOK));
         addMessageEvent(new class_149(onBuildersClubFurniCount));
         addMessageEvent(new HabboClubExtendOfferMessageEvent(onHabboClubExtendOffer));
         addMessageEvent(new MarketplaceConfigurationEvent(onMarketplaceConfiguration));
         addMessageEvent(new VoucherRedeemOkMessageEvent(onVoucherRedeemOk));
         addMessageEvent(new MarketplaceItemStatsEvent(onMarketplaceItemStats));
         addMessageEvent(new VoucherRedeemErrorMessageEvent(onVoucherRedeemError));
         addMessageEvent(new ClubGiftInfoEvent(onClubGiftInfo));
         addMessageEvent(new ProductOfferEvent(onProductOffer));
         addMessageEvent(new CreditBalanceEvent(onCreditBalance));
         addMessageEvent(new MarketPlaceOffersEvent(onMarketPlaceOffers));
         addMessageEvent(new CatalogPageMessageEvent(onCatalogPage));
         addMessageEvent(new PurchaseErrorMessageEvent(onPurchaseError));
         addMessageEvent(new PurchaseNotAllowedMessageEvent(onPurchaseNotAllowed));
         addMessageEvent(new ActivityPointsMessageEvent(onActivityPoints));
         addMessageEvent(new GuildMembershipsMessageEvent(onGuildMemberships));
         addMessageEvent(new CatalogIndexMessageEvent(onCatalogIndex));
         addMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
         addMessageEvent(new EmeraldBalanceMessageEvent(onEmeraldBalance));
         addMessageEvent(new BuildersClubSubscriptionStatusMessageEvent(onBuildersClubSubscriptionStatus));
         addMessageEvent(new SilverBalanceMessageEvent(onSilverBalance));
         addMessageEvent(new MarketplaceMakeOfferResult(onMarketplaceMakeOfferResult));
         addMessageEvent(new GiftWrappingConfigurationEvent(onGiftWrappingConfiguration));
         context.addLinkEventTracker(this);
         _sessionDataManager.loadProductData(this);
         var_4382 = isNewItemsNotificationEnabled();
         var_3117 = new VideoOfferManager(this);
         var_3399 = new OfferController(this);
         var_2047 = _sessionDataManager.getFurniData(this);
         var_4250 = null;
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         removeUpdateReceiver(this);
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(var_3117)
         {
            var_3117.dispose();
            var_3117 = null;
         }
         if(_offerCenter != null)
         {
            _offerCenter.dispose();
            _offerCenter = null;
         }
         reset(true);
         context.removeLinkEventTracker(this);
         if(var_1715 != null)
         {
            var_1715.dispose();
            var_1715 = null;
         }
         var_1714 = null;
         var_1811 = null;
         if(var_2362 != null)
         {
            var_2362.dispose();
            var_2362 = null;
         }
         if(var_2420 != null)
         {
            var_2420.dispose();
            var_2420 = null;
         }
         if(var_2614 != null)
         {
            var_2614.dispose();
            var_2614 = null;
         }
         var_2300 = null;
         if(var_2794 != null)
         {
            var_2794.dispose();
            var_2794 = null;
         }
         resetPlacedOfferData();
         var_2052 = false;
         _offerPlacingCallbackReceiver = null;
         if(var_1799 != null)
         {
            var_1799.dispose();
            var_1799 = null;
         }
         if(var_2201 != null)
         {
            var_2201.dispose();
            var_2201 = null;
         }
         if(_utils != null)
         {
            _utils.dispose();
            _utils = null;
         }
         disposeSnowWarTokens();
         if(var_2054)
         {
            var_2054 = null;
         }
         if(var_3399)
         {
            var_3399.dispose();
            var_3399 = null;
         }
         super.dispose();
      }
      
      private function disposeSnowWarTokens() : void
      {
         if(var_2329 != null)
         {
            var_2329.dispose();
            var_2329 = null;
         }
         if(var_2278 != null)
         {
            var_2278.dispose();
            var_2278 = null;
         }
         if(var_2381 != null)
         {
            var_2381.dispose();
            var_2381 = null;
         }
      }
      
      private function init() : Boolean
      {
         if(!var_78 && var_3682)
         {
            if(var_3723)
            {
               refreshFurniData();
            }
            createMainWindow();
            createCatalogNavigators();
            createCatalogViewer();
            var_78 = true;
            updatePurse();
            createMarketPlace();
            createClubGiftController();
            getGiftWrappingConfiguration();
            createClubBuyController();
            createClubExtendController();
            createGroupMembershipsController();
            initBundleDiscounts();
            events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
            send(new class_156());
            return true;
         }
         return false;
      }
      
      private function reset(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = false;
         var_78 = false;
         if(var_1690 != null)
         {
            var_1690.dispose();
            var_1690 = null;
         }
         if(_catalogNavigators != null)
         {
            for each(var _loc3_ in _catalogNavigators)
            {
               _loc3_.dispose();
            }
            _catalogNavigators = null;
         }
         if(var_1647 != null)
         {
            var_1647.dispose();
            var_1647 = null;
         }
         if(!param1)
         {
            if(_sessionDataManager == null)
            {
               class_79.crash("Could not reload product data after reset() because _sessionDataManager was null",7);
               return;
            }
            _loc2_ = _sessionDataManager.loadProductData(this);
            if(!_loc2_)
            {
               events.dispatchEvent(new CatalogEvent("CATALOG_NOT_READY"));
            }
         }
      }
      
      private function send(param1:IMessageComposer) : void
      {
         if(connection == null)
         {
            return;
         }
         connection.send(param1);
      }
      
      public function loadCatalogPage(param1:int, param2:int, param3:String) : void
      {
         isBusy = true;
         var_4238 = param1;
         send(new class_976(param1,param2,param3));
      }
      
      public function purchaseGameTokensOffer(param1:String) : void
      {
         if(param1 == "GET_SNOWWAR_TOKENS" && var_2329)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(var_2329.offerId));
         }
         else if(param1 == "GET_SNOWWAR_TOKENS2" && var_2278)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(var_2278.offerId));
         }
         else if(param1 == "GET_SNOWWAR_TOKENS3" && var_2381)
         {
            send(new PurchaseSnowWarGameTokensOfferComposer(var_2381.offerId));
         }
      }
      
      public function purchaseMintTokens(param1:int, param2:String) : void
      {
         send(new class_985(param1,param2));
      }
      
      public function purchaseOffer(param1:int, param2:String = "", param3:int = 1) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:class_3341;
         if((_loc5_ = getCatalogNavigator("NORMAL")) != null)
         {
            if((_loc4_ = _loc5_.getNodesByOfferId(param1,true)) != null)
            {
               purchaseProduct(_loc4_[0].pageId,param1,param2,param3);
            }
         }
      }
      
      public function purchaseProduct(param1:int, param2:int, param3:String = "", param4:int = 1) : void
      {
         if(roomAdPurchaseData == null || roomAdPurchaseData.offerId != param2)
         {
            send(new class_855(param1,param2,param3,param4));
         }
         else
         {
            if(var_1946.extended && var_1946.expirationTime.getTime() < new Date().getTime())
            {
               var_1946.extended = false;
            }
            send(new class_503(param1,param2,roomAdPurchaseData.flatId,roomAdPurchaseData.name,roomAdPurchaseData.extended,roomAdPurchaseData.description,roomAdPurchaseData.categoryId));
         }
      }
      
      public function purchaseVipMembershipExtension(param1:int) : void
      {
         send(new class_939(param1));
      }
      
      public function purchaseBasicMembershipExtension(param1:int) : void
      {
         send(new class_594(param1));
      }
      
      public function purchaseProductAsGift(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int, param7:int, param8:int, param9:Boolean = false) : void
      {
         send(new class_933(param1,param2,param3,param4,param5,param6,param7,param8,param9));
      }
      
      public function get roomAdPurchaseData() : RoomAdPurchaseData
      {
         return var_1946;
      }
      
      public function set roomAdPurchaseData(param1:RoomAdPurchaseData) : void
      {
         var_1946 = param1;
      }
      
      public function approveName(param1:String, param2:int) : void
      {
         send(new class_304(param1,param2));
      }
      
      public function set giftReceiver(param1:String) : void
      {
         var_4054 = param1;
      }
      
      public function getSeasonalCurrencyActivityPointType() : int
      {
         return getInteger("seasonalcurrencyindicator.currency",1);
      }
      
      public function showPurchaseConfirmation(param1:class_3377, param2:int, param3:String = "", param4:int = 1, param5:IStuffData = null, param6:String = null, param7:Boolean = true, param8:BitmapData = null) : void
      {
         var _loc14_:* = undefined;
         var _loc11_:Array = null;
         var _loc9_:* = null;
         var _loc13_:class_3411 = null;
         if(param2 == -12345678)
         {
            if((_loc14_ = currentCatalogNavigator.getNodesByOfferId(param1.offerId,true)) != null)
            {
               param2 = _loc14_[0].pageId;
            }
         }
         class_14.log("buy: " + [param4,param1.offerId,param3]);
         var _loc12_:int = param1.priceInCredits;
         var _loc15_:int = param1.priceInActivityPoints;
         if(multiplePurchaseEnabled)
         {
            _loc12_ = _utils.calculateBundlePrice(true,param1.priceInCredits,param4);
            _loc15_ = _utils.calculateBundlePrice(true,param1.priceInActivityPoints,param4);
         }
         var _loc10_:* = param1 is GameTokensOffer;
         if(_loc12_ > 0 && _loc12_ > var_1714.credits && !_loc10_)
         {
            showNotEnoughCreditsAlert();
            return;
         }
         if(_loc15_ > 0 && _loc15_ > var_1714.getActivityPointsForType(param1.activityPointType) && !_loc10_)
         {
            showNotEnoughActivityPointsAlert(param1.activityPointType);
            return;
         }
         if(param1 is Offer || var_3436 || param1 is GameTokensOffer || param1 is MintTokenPurchaseOffer)
         {
            if(var_1715 == null || var_1715.disposed)
            {
               var_1715 = new PurchaseConfirmationDialog(_localization,assets);
            }
            _loc11_ = [];
            if(_friendList != null)
            {
               _loc11_ = _friendList.getFriendNames();
            }
            if((_loc9_ = param6) == null)
            {
               if(var_4054 != null)
               {
                  _loc9_ = var_4054;
               }
            }
            var_1715.showOffer(this,_roomEngine,param1,param2,param3,param4,param5,_loc11_,_loc9_,param8);
         }
         else if(param1 is ClubBuyOfferData)
         {
            if(param2 == -1)
            {
               if((_loc13_ = currentCatalogNavigator.getNodeByName("hc_membership")) != null)
               {
                  param2 = _loc13_.pageId;
               }
            }
            if(param2 >= 0)
            {
               var_2362.showConfirmation(param1 as ClubBuyOfferData,param2);
            }
         }
         if(var_3436)
         {
            var_3436 = false;
            var_1715.turnIntoGifting();
         }
      }
      
      public function purchaseWillBeGift(param1:Boolean) : void
      {
         var_3436 = param1;
      }
      
      private function initializeRoomPreviewer() : void
      {
         if(_roomEngine != null && _roomEngine.isInitialized && getBoolean("catalog.furniture.animation"))
         {
            if(var_1799 == null)
            {
               var_1799 = new RoomPreviewer(_roomEngine);
               var_1799.createRoomForPreviews();
            }
         }
      }
      
      private function isNewItemsNotificationEnabled() : Boolean
      {
         return getBoolean("toolbar.new_additions.notification.enabled");
      }
      
      public function openCatalog() : void
      {
         cancelFurniInMover();
         toggleCatalog("NORMAL",true);
      }
      
      public function openCatalogPage(param1:String, param2:String = null) : void
      {
         cancelFurniInMover();
         toggleCatalog(param2 == null ? "NORMAL" : param2,true,false);
         if(!var_78 || _catalogNavigators == null || !currentCatalogNavigator.initialized)
         {
            var_2054.requestByName = param1;
            return;
         }
         currentCatalogNavigator.openPage(param1);
      }
      
      public function openRoomAdCatalogPageInExtendedMode(param1:String, param2:String, param3:String, param4:String, param5:Date, param6:int) : void
      {
         var _loc8_:int = var_4238;
         var_1946 = new RoomAdPurchaseData();
         var_1946.name = param2;
         var_1946.extended = true;
         var_1946.extendedFlatId = _roomEngine.activeRoomId;
         var_1946.description = param3;
         var_1946.flatId = _roomEngine.activeRoomId;
         var_1946.roomName = param4;
         var_1946.expirationTime = param5;
         var_1946.categoryId = param6;
         openCatalogPage(param1);
         var _loc7_:class_3411;
         if((_loc7_ = currentCatalogNavigator.getNodeByName(param1)) != null && _loc7_.pageId == _loc8_)
         {
            getRoomAdsPurchaseInfo();
         }
      }
      
      public function openCatalogPageByOfferId(param1:int, param2:String) : void
      {
         openCatalogPageById(-12345678,param1,param2);
      }
      
      public function openCatalogPageById(param1:int, param2:int, param3:String) : void
      {
         if(var_78 && _catalogNavigators != null && getCatalogNavigator(param3).initialized)
         {
            toggleCatalog(param3,true,false);
            var_1690.setForceRefresh();
            currentCatalogNavigator.openPageById(param1,param2);
         }
         else
         {
            toggleCatalog(param3);
            var_2054.requestById = param1;
            var_2054.requestedOfferId = param2;
         }
      }
      
      public function openInventoryCategory(param1:String) : void
      {
         if(_inventory == null)
         {
            return;
         }
         _inventory.toggleInventoryPage(param1);
      }
      
      public function openCreditsHabblet() : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
      }
      
      public function get privateRoomSessionActive() : Boolean
      {
         return var_3877;
      }
      
      public function get tradingActive() : Boolean
      {
         if(_inventory == null)
         {
            return false;
         }
         return _inventory.tradingActive;
      }
      
      public function getProductData(param1:String) : class_3423
      {
         return _sessionDataManager.getProductData(param1);
      }
      
      public function getFurnitureData(param1:int, param2:String) : class_3365
      {
         var _loc3_:class_3365 = null;
         if(param2 == "s")
         {
            _loc3_ = _sessionDataManager.getFloorItemData(param1);
         }
         if(param2 == "i")
         {
            _loc3_ = _sessionDataManager.getWallItemData(param1);
         }
         return _loc3_;
      }
      
      public function getFurnitureDataByName(param1:String, param2:String, param3:int = 0) : class_3365
      {
         var _loc4_:class_3365 = null;
         if(_sessionDataManager == null)
         {
            return null;
         }
         if(param2 == "s")
         {
            _loc4_ = _sessionDataManager.getFloorItemDataByName(param1);
         }
         if(param2 == "i")
         {
            _loc4_ = _sessionDataManager.getWallItemDataByName(param1);
         }
         return _loc4_;
      }
      
      public function getPurse() : class_3378
      {
         return var_1714;
      }
      
      public function getMarketPlace() : IMarketPlace
      {
         return var_1811;
      }
      
      public function getClubGiftController() : ClubGiftController
      {
         return var_3444;
      }
      
      public function getClubBuyController() : ClubBuyController
      {
         return var_2362;
      }
      
      public function getClubExtendController() : ClubExtendController
      {
         return var_2420;
      }
      
      public function getPublicMarketPlaceOffers(param1:int, param2:int, param3:String, param4:int) : void
      {
         send(new class_127(param1,param2,param3,param4));
      }
      
      public function getRoomAdsPurchaseInfo() : void
      {
         send(new GetRoomAdPurchaseInfoComposer());
      }
      
      public function sendRoomAdPurchaseInitiatedEvent() : void
      {
         send(new class_801());
      }
      
      public function getOwnMarketPlaceOffers() : void
      {
         send(new class_406());
      }
      
      public function buyMarketPlaceOffer(param1:int) : void
      {
         send(new class_802(param1));
      }
      
      public function redeemSoldMarketPlaceOffers() : void
      {
         send(new RedeemMarketplaceOfferCreditsMessageComposer());
      }
      
      public function redeemExpiredMarketPlaceOffer(param1:int) : void
      {
         send(new class_370(param1));
      }
      
      public function getMarketplaceItemStats(param1:int, param2:int) : void
      {
         if(!_communication)
         {
            return;
         }
         send(new class_403(param1,param2));
      }
      
      public function getGroupMembershipsController() : GuildMembershipsController
      {
         return var_2201;
      }
      
      public function getPixelEffectIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapDataAsset = (_inventory as Component).findAssetByName("fx_icon_" + param1 + "_png") as BitmapDataAsset;
         if(_loc2_ != null && _loc2_.content != null)
         {
            return (_loc2_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getSubscriptionProductIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapDataAsset = this.findAssetByName("icon_hc") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            return (_loc2_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getMintTokenProductIcon() : BitmapData
      {
         var _loc1_:BitmapDataAsset = this.findAssetByName("minting_token_large") as BitmapDataAsset;
         if(_loc1_ != null)
         {
            return (_loc1_.content as BitmapData).clone();
         }
         return new BitmapData(1,1,true,16777215);
      }
      
      public function getSellablePetPalettes(param1:String) : Array
      {
         var _loc2_:Array = var_2614.getValue(param1);
         if(_loc2_ != null)
         {
            return _loc2_.slice();
         }
         send(new GetSellablePetPalettesComposer(param1));
         return null;
      }
      
      private function updatePurse() : void
      {
         var _loc4_:String = null;
         if(var_1647 == null)
         {
            return;
         }
         _localization.registerParameter("catalog.purse.creditbalance","balance",String(var_1714.credits));
         _localization.registerParameter("catalog.purse.pixelbalance","balance",String(var_1714.getActivityPointsForType(0)));
         var _loc3_:uint = 11;
         if(!var_1714.hasClubLeft)
         {
            _loc4_ = "catalog.purse.club.join";
         }
         else
         {
            if(var_1714.isVIP)
            {
               _loc4_ = "catalog.purse.vipdays";
               _loc3_ = 12;
            }
            else
            {
               _loc4_ = "catalog.purse.clubdays";
            }
            _localization.registerParameter(_loc4_,"days",String(var_1714.clubDays));
            _localization.registerParameter(_loc4_,"months",String(var_1714.clubPeriods));
         }
         var _loc2_:IIconWindow = var_1647.findChildByName("clubIcon") as IIconWindow;
         if(_loc2_)
         {
            _loc2_.style = _loc3_;
         }
         var _loc1_:ITextWindow = var_1647.findChildByName("clubText") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.caption = _localization.getLocalization(_loc4_);
         }
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type != "HTE_TOOLBAR_CLICK")
         {
            return;
         }
         switch(param1.iconId)
         {
            case "HTIE_ICON_CATALOGUE":
               toggleCatalog("NORMAL");
               break;
            case "HTIE_ICON_BUILDER":
               toggleCatalog("BUILDERS_CLUB");
         }
      }
      
      private function setElementColour(param1:String, param2:int) : void
      {
         if(var_1647 == null)
         {
            return;
         }
         var _loc3_:IWindow = var_1647.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.color = param2;
         }
      }
      
      public function get buildersClubEnabled() : Boolean
      {
         return getBoolean("builders.club.enabled");
      }
      
      public function toggleCatalog(param1:String, param2:Boolean = false, param3:Boolean = true) : void
      {
         var _loc4_:ITextFieldWindow = null;
         if(!_sessionDataManager.hasSecurity(5) && !buildersClubEnabled)
         {
            param1 = "NORMAL";
         }
         var _loc5_:* = param1 != var_395;
         var_395 = param1;
         cancelFurniInMover();
         if(var_1647 == null)
         {
            if(init() == false)
            {
               return;
            }
         }
         if(currentCatalogNavigator == null || !currentCatalogNavigator.initialized)
         {
            refreshCatalogIndex(var_395);
         }
         if(!mainWindowVisible() || param2 || _loc5_)
         {
            if(var_825)
            {
               var_825 = false;
               events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_HIDE"));
               markNewAdditionPageOpened();
            }
            showMainWindow();
         }
         else if(!WindowToggle.isHiddenByOtherWindows(var_1647))
         {
            hideMainWindow();
         }
         if(mainWindowVisible())
         {
            if(var_1647 != null)
            {
               var_1647.activate();
               if(_loc4_ = var_1647.findChildByName("search.input") as ITextFieldWindow)
               {
                  _loc4_.focus();
                  _loc4_.setSelection(0,_loc4_.text.length);
               }
            }
            else
            {
               class_14.log("[Catalog] No main container!");
            }
            HabboTracking.getInstance().trackGoogle("catalogue","open");
         }
         if(var_1647 != null)
         {
            var_1647.color = param1 == "NORMAL" ? 4296112 : 16758076;
            var_1647.caption = param1 == "NORMAL" ? "${catalog.title}" : "${builder.catalog.title}";
            var_1647.findChildByName("catalog.header.background.border").color = param1 == "NORMAL" ? 4281819765 : 4283320388;
            var_1647.findChildByName("catalog.header.background.body").color = param1 == "NORMAL" ? 4279123794 : 4281149220;
            var_1647.findChildByName("catalog.mode.header").visible = param1 == "NORMAL";
            var_1647.findChildByName("builder.mode.header").visible = param1 == "BUILDERS_CLUB";
            refreshBuilderStatus();
         }
         if(mainWindowVisible())
         {
            events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_OPEN"));
         }
         else
         {
            events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_CLOSE"));
         }
         if(_loc5_ && currentCatalogNavigator != null)
         {
            if(param3)
            {
               currentCatalogNavigator.deactivateCurrentNode();
               currentCatalogNavigator.loadFrontPage();
            }
            currentCatalogNavigator.showIndex();
            if(var_1690 != null)
            {
               var_1690.setForceRefresh();
            }
         }
      }
      
      private function getCurrentLayoutCode() : String
      {
         if(var_1690 == null)
         {
            return "";
         }
         return var_1690.getCurrentLayoutCode();
      }
      
      private function refreshCatalogIndex(param1:String) : void
      {
         send(new class_521(param1));
      }
      
      private function markNewAdditionPageOpened() : void
      {
         send(new class_881());
      }
      
      private function createCatalogNavigators() : void
      {
         _catalogNavigators = new Dictionary();
         _catalogNavigators["NORMAL"] = new CatalogNavigator(this,var_1647,"NORMAL");
         _catalogNavigators["BUILDERS_CLUB"] = new CatalogNavigator(this,var_1647,"BUILDERS_CLUB");
         var _loc1_:BitmapDataAsset = this.findAssetByName("purse_coins_small") as BitmapDataAsset;
         setElementImage("creditsIcon",_loc1_.content as BitmapData);
         var _loc3_:BitmapDataAsset = this.findAssetByName("purse_pixels_small") as BitmapDataAsset;
         setElementImage("pixelsIcon",_loc3_.content as BitmapData);
         var _loc2_:BitmapDataAsset = this.findAssetByName("purse_club_small") as BitmapDataAsset;
         setElementImage("clubIcon",_loc2_.content as BitmapData);
      }
      
      private function createCatalogViewer() : void
      {
         var _loc1_:IWindowContainer = var_1647.findChildByName("layoutContainer") as IWindowContainer;
         var_1690 = new CatalogViewer(this,_loc1_);
      }
      
      private function createMainWindow() : void
      {
         var _loc4_:String = null;
         var _loc2_:IWindow = null;
         if(useNonTabbedCatalog())
         {
            _loc4_ = "catalog_ubuntu";
         }
         else
         {
            _loc4_ = "catalog_ubuntu_with_tabs";
         }
         var _loc5_:XmlAsset = this.findAssetByName(_loc4_) as XmlAsset;
         var_1647 = _windowManager.buildFromXML(_loc5_.content as XML,1) as IWindowContainer;
         var_1647.tags.push("habbo_catalog");
         var_1647.position = DEFAULT_VIEW_LOCATION_LARGE;
         hideMainWindow();
         var _loc3_:IWindow = var_1647.findChildByName("titlebar_close_button");
         if(_loc3_ == null)
         {
            _loc3_ = var_1647.findChildByTag("close");
         }
         if(_loc3_ != null)
         {
            _loc3_.procedure = onWindowClose;
         }
         var _loc1_:ITextFieldWindow = var_1647.findChildByName("search.input") as ITextFieldWindow;
         if(_loc1_)
         {
            _loc1_.addEventListener("WKE_KEY_DOWN",onSearchInputEvent);
            _loc1_.addEventListener("WKE_KEY_UP",onSearchInputEvent);
            _loc1_.setSelection(0,_loc1_.text.length);
            _loc1_.focus();
            _loc2_ = var_1647.findChildByName("clear_search_button");
            if(_loc2_)
            {
               _loc2_.addEventListener("WME_CLICK",onClearSearch);
            }
         }
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         var _loc2_:IWindow = null;
         if(var_1647)
         {
            var_1647.caption = param1 ? "${generic.loading}" : "${catalog.title}";
            _loc2_ = var_1647.findChildByName("search_waiting_for_results_mask");
            if(_loc2_)
            {
               _loc2_.visible = param1;
            }
         }
      }
      
      private function onSelectSearch(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc2_)
         {
            _loc2_.setSelection(0,_loc2_.text.length);
            _loc2_.focus();
         }
      }
      
      private function onClearSearch(param1:WindowMouseEvent = null) : void
      {
         var _loc2_:ITextFieldWindow = var_1647.findChildByName("search.input") as ITextFieldWindow;
         _loc2_.caption = "";
         _loc2_.setSelection(0,_loc2_.text.length);
         _loc2_.focus();
         var _loc3_:IStaticBitmapWrapperWindow = var_1647.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc3_.assetUri = "common_small_pen";
         if(var_1690.previousPageId > 0)
         {
            currentCatalogNavigator.openPageById(var_1690.previousPageId,-1);
         }
         var_1647.findChildByName("search.helper").visible = true;
      }
      
      private function onSearchInputEvent(param1:WindowKeyboardEvent) : void
      {
         if(param1.type == "WKE_KEY_DOWN")
         {
            if(var_2716)
            {
               var_2716.stop();
            }
            return;
         }
         if(var_2716 == null)
         {
            var_2716 = new Timer(50,1);
         }
         if(param1.target.caption.length >= 3)
         {
            var_2716.addEventListener("timer",onKeyUpSearchTimer);
            var_2716.start();
         }
         var _loc2_:IWindow = var_1647.findChildByName("search.helper");
         _loc2_.visible = param1.target.caption.length == 0;
         var _loc3_:IStaticBitmapWrapperWindow = var_1647.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc3_.assetUri = param1.target.caption.length > 0 ? "icons_close" : "common_small_pen";
         if(param1.target.caption.length == 0)
         {
            onClearSearch();
         }
         else if(param1.keyCode == 13)
         {
            performSearch(param1.target.caption);
         }
      }
      
      private function onKeyUpSearchTimer(param1:TimerEvent) : void
      {
         var _loc2_:ITextFieldWindow = var_1647.findChildByName("search.input") as ITextFieldWindow;
         performSearch(_loc2_.caption);
      }
      
      private function performSearch(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc8_:* = undefined;
         var _loc5_:* = undefined;
         if(var_2716)
         {
            var_2716.stop();
         }
         if(var_2047 == null || param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc4_:Vector.<class_3365> = new Vector.<class_3365>(0);
         var _loc7_:String = param1.toLocaleLowerCase().replace(" ","");
         for each(var _loc6_ in var_2047)
         {
            if(!(var_395 == "BUILDERS_CLUB" && !_loc6_.availableForBuildersClub))
            {
               if(!(var_395 == "NORMAL" && _loc6_.excludedFromDynamic))
               {
                  _loc3_ = [_loc6_.localizedName,_loc6_.description,_loc6_.className].join(" ");
                  _loc3_ = _loc3_.replace(/ /gi,"");
                  if(var_395 == "BUILDERS_CLUB" && _loc6_.purchaseOfferId == -1 && _loc6_.rentOfferId == -1)
                  {
                     if(_loc6_.furniLine != "" && _loc2_.indexOf(_loc6_.furniLine) < 0)
                     {
                        if(_loc3_.toLocaleLowerCase().indexOf(_loc7_) >= 0)
                        {
                           _loc2_.push(_loc6_.furniLine);
                        }
                     }
                  }
                  else
                  {
                     _loc8_ = currentCatalogNavigator.getNodesByOfferId(_loc6_.purchaseOfferId,true);
                     _loc5_ = currentCatalogNavigator.getNodesByOfferId(_loc6_.rentOfferId,true);
                     if(_loc8_ != null || var_395 == "NORMAL" && _loc5_ != null)
                     {
                        if(_loc3_.toLocaleLowerCase().indexOf(_loc7_) >= 0)
                        {
                           _loc4_.push(_loc6_);
                           if(_loc4_.length >= 200)
                           {
                              break;
                           }
                        }
                     }
                  }
               }
            }
         }
         localization.registerParameter("catalog.search.results","count",_loc4_.length.toString());
         localization.registerParameter("catalog.search.results","needle",param1);
         var_1647.findChildByName("catalog.header.title").caption = "${catalog.search.header}";
         currentCatalogNavigator.deactivateCurrentNode();
         var_1690.showSearchResults(_loc4_);
         currentCatalogNavigator.filter(_loc7_,_loc2_);
      }
      
      public function furniDataReady() : void
      {
         var_2047 = _sessionDataManager.getFurniData(this);
         var_4250 = null;
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_STARTED":
               var_3877 = param1.session.isPrivateRoom;
               var_2300 = param1.session;
               break;
            case "RSE_ENDED":
               var_3877 = false;
               var_2300 = null;
         }
         if(currentPage != null)
         {
            currentPage.dispatchWidgetEvent(new CatalogWidgetRoomChangedEvent());
         }
      }
      
      private function createMarketPlace() : void
      {
         if(var_1811 == null)
         {
            var_1811 = new MarketPlaceLogic(this,_windowManager,_roomEngine);
         }
      }
      
      private function createClubGiftController() : void
      {
         if(var_3444 == null)
         {
            var_3444 = new ClubGiftController(this);
         }
      }
      
      private function createClubBuyController() : void
      {
         if(var_2362 == null)
         {
            var_2362 = new ClubBuyController(this,connection);
         }
      }
      
      private function createClubExtendController() : void
      {
         if(var_2420 == null)
         {
            var_2420 = new ClubExtendController(this);
         }
      }
      
      private function createGroupMembershipsController() : void
      {
         if(var_2201 == null)
         {
            var_2201 = new GuildMembershipsController(this);
         }
      }
      
      private function getGiftWrappingConfiguration() : void
      {
         send(new class_887());
      }
      
      public function getHabboClubOffers(param1:int) : void
      {
         send(new class_1099(param1));
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideMainWindow();
         if(var_1690 != null)
         {
            var_1690.catalogWindowClosed();
         }
      }
      
      private function onCatalogIndex(param1:CatalogIndexMessageEvent) : void
      {
         var _loc2_:class_3341 = getCatalogNavigator(param1.catalogType);
         if(_loc2_ == null)
         {
            return;
         }
         var_825 = param1.newAdditionsAvailable;
         _loc2_.buildCatalogIndex(param1.root);
         if(param1.catalogType == var_395)
         {
            _loc2_.showIndex();
         }
         switch(var_2054.requestType)
         {
            case 0:
               if(var_825 && var_4382 && !newAdditionsPageOpenDisabled && param1.catalogType == "NORMAL")
               {
                  events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_SHOW"));
                  openCatalogPage("new_additions");
               }
               else
               {
                  _loc2_.loadFrontPage();
               }
               break;
            case 1:
               _loc2_.openPageById(var_2054.requestId,var_2054.requestedOfferId);
               var_2054.resetRequest();
               break;
            case 2:
               _loc2_.openPage(var_2054.requestName);
               var_2054.resetRequest();
         }
      }
      
      private function onCatalogPage(param1:CatalogPageMessageEvent) : void
      {
         var _loc10_:* = undefined;
         var _loc11_:class_3423 = null;
         var _loc8_:class_3365 = null;
         var _loc12_:Offer = null;
         var _loc13_:class_1294;
         if((_loc13_ = param1.getParser()).catalogType != var_395)
         {
            return;
         }
         var _loc9_:int = _loc13_.pageId;
         var _loc4_:String = _loc13_.layoutCode;
         var _loc5_:Array = _loc13_.localization.images.concat();
         var _loc14_:Array = _loc13_.localization.texts.concat();
         var _loc2_:class_3440 = new PageLocalization(_loc5_,_loc14_);
         var _loc15_:int = _loc13_.offerId;
         var _loc6_:Boolean = _loc13_.acceptSeasonCurrencyAsCredits;
         var _loc3_:Vector.<class_3377> = new Vector.<class_3377>(0);
         for each(var _loc16_ in _loc13_.offers)
         {
            _loc10_ = new Vector.<class_3388>(0);
            _loc11_ = getProductData(_loc16_.localizationId);
            for each(var _loc7_ in _loc16_.products)
            {
               _loc8_ = getFurnitureData(_loc7_.furniClassId,_loc7_.productType);
               _loc10_.push(new Product(_loc7_.productType,_loc7_.furniClassId,_loc7_.extraParam,_loc7_.productCount,_loc11_,_loc8_,this,_loc7_.uniqueLimitedItem,_loc7_.uniqueLimitedItemSeriesSize,_loc7_.uniqueLimitedItemsLeft));
            }
            if(!(_loc10_.length == 0 && !HabboCatalogUtils.buildersClub(_loc16_.localizationId)))
            {
               if((_loc12_ = new Offer(_loc16_.offerId,_loc16_.localizationId,_loc16_.isRent,_loc16_.priceInCredits,_loc16_.priceInActivityPoints,_loc16_.activityPointType,_loc16_.priceInSilver,_loc16_.giftable,_loc16_.clubLevel,_loc10_,_loc16_.bundlePurchaseAllowed,this)).productContainer != null && isOfferCompatibleWithCurrentMode(_loc12_))
               {
                  _loc3_.push(_loc12_);
               }
               else
               {
                  _loc12_.dispose();
               }
            }
         }
         if(_loc13_.frontPageItems != null && _loc13_.frontPageItems.length > 0)
         {
            _frontPageItems = _loc13_.frontPageItems;
         }
         if(var_1690 != null && var_4238 == _loc9_)
         {
            var_1690.showCatalogPage(_loc9_,_loc4_,_loc2_,_loc3_,_loc15_,_loc6_);
         }
         isBusy = false;
      }
      
      private function isOfferCompatibleWithCurrentMode(param1:Offer) : Boolean
      {
         return var_395 == "NORMAL" || param1.pricingModel != "pricing_model_bundle" && param1.pricingModel != "pricing_model_multi";
      }
      
      private function onCatalogPublished(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:CatalogPublishedMessageEvent = param1 as CatalogPublishedMessageEvent;
         if(_loc2_.newFurniDataHash)
         {
            sessionDataManager.newFurniDataHash = _loc2_.newFurniDataHash;
         }
         var_3723 = true;
         var _loc3_:Boolean = mainWindowVisible();
         reset();
         if(_loc3_)
         {
            _windowManager.alert("${catalog.alert.published.title}","${catalog.alert.published.description}",0,alertDialogEventProcessor);
         }
         else if(_notifications)
         {
            _loc4_ = String(localization.getLocalization("catalog.alert.published.description"));
            _notifications.addItem(_loc4_,"info","if_icon_temp_png");
         }
      }
      
      private function refreshFurniData() : void
      {
         sessionDataManager.refreshFurniData();
         var_3723 = false;
      }
      
      private function onPurchaseError(param1:IMessageEvent) : void
      {
         var _loc3_:PurchaseErrorMessageEvent = param1 as PurchaseErrorMessageEvent;
         var _loc2_:class_1291 = _loc3_.getParser();
         var _loc4_:int;
         var _loc5_:String = (_loc4_ = _loc2_.errorCode) > 0 ? "${catalog.alert.purchaseerror.description." + _loc4_ + "}" : "${catalog.alert.purchaseerror.description}";
         _windowManager.alert("${catalog.alert.purchaseerror.title}",_loc5_,0,alertDialogEventProcessor);
         if(var_1715 != null)
         {
            var_1715.dispose();
            var_1715 = null;
         }
      }
      
      private function onPurchaseNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:PurchaseNotAllowedMessageEvent = param1 as PurchaseNotAllowedMessageEvent;
         var _loc3_:class_1273 = _loc2_.getParser();
         var _loc4_:int = _loc3_.errorCode;
         var _loc5_:String = "";
         switch(_loc4_ - 1)
         {
            case 0:
               _loc5_ = "${catalog.alert.purchasenotallowed.hc.description}";
               break;
            default:
               _loc5_ = "${catalog.alert.purchasenotallowed.unknown.description}";
         }
         _windowManager.alert("${catalog.alert.purchasenotallowed.title}",_loc5_,0,alertDialogEventProcessor);
      }
      
      private function onPurchaseOK(param1:IMessageEvent) : void
      {
         var _loc6_:IBitmapWrapperWindow = null;
         var _loc2_:BitmapData = null;
         var _loc7_:Point = null;
         var _loc5_:String = null;
         var _loc3_:PurchaseOKMessageEvent = param1 as PurchaseOKMessageEvent;
         var _loc4_:class_1372 = _loc3_.getParser();
         events.dispatchEvent(new CatalogFurniPurchaseEvent(_loc4_.offer.localizationId));
         if(var_1715 != null)
         {
            if(!var_2052 && !var_1715.isGiftPurchase())
            {
               if(_loc6_ = var_1715.getIconWrapper())
               {
                  _loc2_ = _loc6_.bitmap;
                  if(_loc2_)
                  {
                     _loc7_ = new Point();
                     _loc6_.getGlobalPosition(_loc7_);
                     _loc5_ = "HTIE_ICON_INVENTORY";
                     if(var_1715.productType == "e")
                     {
                        _loc5_ = "HTIE_ICON_MEMENU";
                     }
                     _toolbar.createTransitionToIcon(_loc5_,_loc2_.clone(),_loc7_.x,_loc7_.y);
                  }
               }
            }
            var_1715.dispose();
         }
         var_1715 = null;
      }
      
      private function onGiftReceiverNotFound(param1:GiftReceiverNotFoundEvent) : void
      {
         if(var_1715 != null)
         {
            var_1715.receiverNotFound();
         }
      }
      
      private function onNotEnoughBalance(param1:IMessageEvent) : void
      {
         var _loc3_:NotEnoughBalanceMessageEvent = param1 as NotEnoughBalanceMessageEvent;
         var _loc2_:class_1126 = _loc3_.getParser();
         if(_loc2_.notEnoughCredits)
         {
            showNotEnoughCreditsAlert();
         }
         else if(_loc2_.notEnoughActivityPoints)
         {
            showNotEnoughActivityPointsAlert(_loc2_.activityPointType);
         }
         if(var_1715 != null)
         {
            var_1715.notEnoughCredits();
         }
      }
      
      public function setLeftPaneVisibility(param1:Boolean) : void
      {
         if(!var_1647)
         {
            return;
         }
         var _loc2_:IWindow = var_1647.findChildByName("navigationContainer");
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = var_1647.findChildByName("searchContainer");
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function showNotEnoughCreditsAlert() : void
      {
         if(!_windowManager)
         {
            return;
         }
         _windowManager.confirm("${catalog.alert.notenough.title}","${catalog.alert.notenough.credits.description}",0,noCreditsConfirmDialogEventProcessor);
      }
      
      public function showNotEnoughActivityPointsAlert(param1:int) : void
      {
         var _loc2_:String = getActivityPointName(param1);
         var _loc3_:String = String(localization.getLocalizationWithParams("catalog.alert.notenough.activitypoints.title","","currencyname",_loc2_));
         var _loc4_:String = String(localization.getLocalizationWithParams("catalog.alert.notenough.activitypoints.description","","currencyname",_loc2_));
         if(param1 == 0)
         {
            _windowManager.confirm(_loc3_,_loc4_,0,noDucketsConfirmDialogEventProcessor);
         }
         else
         {
            _windowManager.alert(_loc3_,_loc4_,0,alertDialogEventProcessor);
         }
      }
      
      public function getActivityPointName(param1:int) : String
      {
         var _loc2_:String = getProperty("activitypoint.name." + param1);
         return localization.getLocalization(_loc2_,_loc2_);
      }
      
      private function onSilverBalance(param1:SilverBalanceMessageEvent) : void
      {
         var _loc2_:class_1520 = param1.getParser();
         var_1714.silverBalance = _loc2_.silverBalance;
         events.dispatchEvent(new PurseEvent("catalog_purse_silver_balance",var_1714.silverBalance,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onEmeraldBalance(param1:EmeraldBalanceMessageEvent) : void
      {
         var _loc2_:class_1502 = param1.getParser();
         var_1714.emeraldBalance = _loc2_.emeraldBalance;
         events.dispatchEvent(new PurseEvent("catalog_purse_emerald_balance",var_1714.emeraldBalance,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onVoucherRedeemOk(param1:VoucherRedeemOkMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = "${catalog.alert.voucherredeem.ok.description}";
         if(param1.productName != "")
         {
            _loc2_ = "catalog.alert.voucherredeem.ok.description.furni";
            _localization.registerParameter(_loc2_,"productName",param1.productName);
            _localization.registerParameter(_loc2_,"productDescription",param1.productDescription);
            _loc2_ = "${" + _loc2_ + "}";
         }
         _windowManager.alert("${catalog.alert.voucherredeem.ok.title}",_loc2_,0,alertDialogEventProcessor);
      }
      
      private function onVoucherRedeemError(param1:VoucherRedeemErrorMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = "${catalog.alert.voucherredeem.error.title}";
         var _loc3_:String = "${catalog.alert.voucherredeem.error.description." + param1.errorCode + "}";
         _windowManager.alert(_loc2_,_loc3_,0,alertDialogEventProcessor);
      }
      
      private function onApproveNameResult(param1:ApproveNameMessageEvent) : void
      {
         if(param1 == null || var_1690 == null)
         {
            return;
         }
         var _loc2_:class_1328 = param1.getParser();
         var_1690.dispatchWidgetEvent(new CatalogWidgetApproveNameResultEvent(_loc2_.result,_loc2_.nameValidationInfo));
      }
      
      private function onCreditBalance(param1:IMessageEvent) : void
      {
         var _loc3_:CreditBalanceEvent = param1 as CreditBalanceEvent;
         var _loc2_:class_1192 = _loc3_.getParser();
         var_1714.credits = _loc2_.balance;
         updatePurse();
         if(!var_4378 && _soundManager != null)
         {
            _soundManager.playSound("HBST_purchase");
         }
         var_4378 = false;
         events.dispatchEvent(new PurseEvent("catalog_purse_credit_balance",var_1714.credits,0));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onActivityPointNotification(param1:IMessageEvent) : void
      {
         var _loc2_:HabboActivityPointNotificationMessageEvent = param1 as HabboActivityPointNotificationMessageEvent;
         var_1714.activityPoints[_loc2_.type] = _loc2_.amount;
         updatePurse();
         if(_soundManager != null && _loc2_.type == 0)
         {
            _soundManager.playSound("HBST_pixels");
         }
         events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance",_loc2_.amount,_loc2_.type));
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onActivityPoints(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ActivityPointsMessageEvent = param1 as ActivityPointsMessageEvent;
         var_1714.activityPoints = _loc3_.points;
         updatePurse();
         for(var _loc2_ in _loc3_.points)
         {
            _loc4_ = int(_loc2_);
            events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance",_loc3_.points[_loc4_],_loc4_));
         }
         events.dispatchEvent(new PurseUpdateEvent());
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:class_1359 = (param1 as ScrSendUserInfoEvent).getParser();
         var_1714.clubDays = Math.max(0,_loc2_.daysToPeriodEnd);
         var_1714.clubPeriods = Math.max(0,_loc2_.periodsSubscribedAhead);
         var_1714.isVIP = _loc2_.isVIP;
         var_1714.pastClubDays = _loc2_.pastClubDays;
         var_1714.pastVipDays = _loc2_.pastVipDays;
         var_1714.isExpiring = _loc2_.responseType == 3 ? true : false;
         var_1714.minutesUntilExpiration = _loc2_.minutesUntilExpiration;
         var_1714.minutesSinceLastModified = _loc2_.minutesSinceLastModified;
         if(ExternalInterface.available)
         {
            if(_loc2_.productName == "habbo_club" || _loc2_.productName == "club_habbo")
            {
               _loc3_ = _loc2_.isVIP && _loc2_.minutesUntilExpiration > 0;
               ExternalInterface.call("FlashExternalInterface.subscriptionUpdated",_loc3_);
            }
         }
         updatePurse();
         if(_loc2_.responseType == 2)
         {
            reset();
            if(var_2393 != null)
            {
               openCatalogPage(var_2393);
               var_2393 = null;
            }
         }
      }
      
      private function onClubGiftInfo(param1:ClubGiftInfoEvent) : void
      {
         if(!param1 || !var_3444)
         {
            return;
         }
         var _loc2_:class_1586 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var_3444.setInfo(_loc2_.daysUntilNextGift,_loc2_.giftsAvailable,_loc2_.offers,_loc2_.giftData);
      }
      
      private function onMarketPlaceOffers(param1:IMessageEvent) : void
      {
         if(var_1811 != null)
         {
            var_1811.onOffers(param1);
         }
      }
      
      private function onMarketPlaceOwnOffers(param1:IMessageEvent) : void
      {
         if(var_1811 != null)
         {
            var_1811.onOwnOffers(param1);
         }
      }
      
      private function onMarketPlaceBuyResult(param1:IMessageEvent) : void
      {
         if(var_1811 != null)
         {
            var_1811.onBuyResult(param1);
         }
      }
      
      private function onMarketPlaceCancelResult(param1:IMessageEvent) : void
      {
         if(var_1811 != null)
         {
            var_1811.onCancelResult(param1);
         }
      }
      
      private function onGiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_4321 = new GiftWrappingConfiguration(param1);
      }
      
      private function onMarketplaceItemStats(param1:MarketplaceItemStatsEvent) : void
      {
         if(!param1 || !var_1811)
         {
            return;
         }
         var _loc2_:class_1121 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:class_3453 = new class_3453();
         _loc3_.averagePrice = _loc2_.averagePrice;
         _loc3_.offerCount = _loc2_.offerCount;
         _loc3_.historyLength = _loc2_.historyLength;
         _loc3_.dayOffsets = _loc2_.dayOffsets;
         _loc3_.averagePrices = _loc2_.averagePrices;
         _loc3_.soldAmounts = _loc2_.soldAmounts;
         _loc3_.furniCategoryId = _loc2_.furniCategoryId;
         _loc3_.furniTypeId = _loc2_.furniTypeId;
         var_1811.itemStats = _loc3_;
      }
      
      private function onMarketplaceConfiguration(param1:MarketplaceConfigurationEvent) : void
      {
         if(!param1 || !var_1811)
         {
            return;
         }
         var _loc2_:class_1445 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var_1811.averagePricePeriod = _loc2_.averagePricePeriod;
      }
      
      private function onMarketplaceMakeOfferResult(param1:MarketplaceMakeOfferResult) : void
      {
         if(!param1 || !var_1811)
         {
            return;
         }
         var _loc2_:class_1518 = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.result == 1)
         {
            var_1811.refreshOffers();
         }
      }
      
      private function onHabboClubOffers(param1:HabboClubOffersMessageEvent) : void
      {
         var _loc2_:class_1474 = param1.getParser();
         if(var_2362 != null && (_loc2_.source == 0 || _loc2_.source == 1 || _loc2_.source == 2 || _loc2_.source == 6))
         {
            var_2362.onOffers(_loc2_);
         }
      }
      
      private function onHabboClubExtendOffer(param1:HabboClubExtendOfferMessageEvent) : void
      {
         if(!var_78)
         {
            init();
         }
         if(var_2420)
         {
            var_2420.onOffer(param1);
         }
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
      }
      
      private function onSellablePalettes(param1:SellablePetPalettesMessageEvent) : void
      {
         var _loc2_:class_1358 = param1.getParser();
         var_2614.remove(_loc2_.productCode);
         var _loc3_:Array = _loc2_.sellablePalettes;
         if(_loc3_ != null)
         {
            var_2614.add(_loc2_.productCode,_loc3_.slice());
            var_1690.dispatchWidgetEvent(new CatalogWidgetSellablePetPalettesEvent(_loc2_.productCode,_loc3_.slice()));
         }
      }
      
      private function setElementImage(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperWindow = var_1647.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc3_ != null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
         else
         {
            class_14.log("Could not find element: " + param1);
         }
      }
      
      private function alertDialogEventProcessor(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
         resetPlacedOfferData();
      }
      
      private function noCreditsConfirmDialogEventProcessor(param1:class_3441, param2:WindowEvent) : void
      {
         param1.dispose();
         resetPlacedOfferData();
         if(param2.type == "WE_OK")
         {
            HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
         }
      }
      
      private function noDucketsConfirmDialogEventProcessor(param1:class_3441, param2:WindowEvent) : void
      {
         var _loc3_:String = null;
         param1.dispose();
         resetPlacedOfferData();
         if(param2.type == "WE_OK")
         {
            _loc3_ = getProperty("link.format.duckets");
            if(_loc3_ != "")
            {
               _windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
               HabboWebTools.navigateToURL(_loc3_,"habboMain");
            }
         }
      }
      
      private function onExternalLink(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      public function redeemVoucher(param1:String) : void
      {
         var _loc2_:IMessageComposer = new class_428(param1);
         send(_loc2_);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      public function productDataReady() : void
      {
         var_3682 = true;
         events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
      }
      
      public function isDraggable(param1:class_3377) : Boolean
      {
         return getBoolean("catalog.drag_and_drop") && var_2300 != null && (var_1690.currentPage == null || var_1690.currentPage.allowDragging) && (var_395 == "NORMAL" && (var_2300.isRoomOwner || var_2300.isGuildRoom && var_2300.roomControllerLevel >= 2) || var_395 == "BUILDERS_CLUB" && getBuilderFurniPlaceableStatus(param1) == 0) && param1.pricingModel != "pricing_model_bundle" && param1.pricingModel != "pricing_model_multi" && param1.product != null && param1.product.productType != "e" && param1.product.productType != "h";
      }
      
      public function getBuilderFurniPlaceableStatus(param1:class_3377) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:IRoomObject = null;
         var _loc2_:class_3490 = null;
         if(param1 == null)
         {
            return 1;
         }
         if(builderFurniCount < 0 || builderFurniCount >= builderFurniLimit)
         {
            return 2;
         }
         if(roomSession == null)
         {
            return 3;
         }
         if(roomSession.isGuildRoom && !getBoolean("builders.club.furniture.placement.group.room.enabled"))
         {
            return 5;
         }
         if(roomSession.roomControllerLevel < 3)
         {
            return 4;
         }
         if(builderSecondsLeft <= 0)
         {
            _loc3_ = roomEngine.getRoomObjectCount(roomSession.roomId,100);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = roomEngine.getRoomObjectWithIndex(roomSession.roomId,_loc4_,100);
               _loc2_ = roomSession.userDataManager.getUserDataByIndex(_loc5_.getId());
               if(_loc2_ != null && _loc2_.type == 1 && _loc2_.roomObjectId != roomSession.ownUserRoomId && !_loc2_.isModerator)
               {
                  return 6;
               }
               _loc4_++;
            }
         }
         return 0;
      }
      
      private function updateRoom(param1:String, param2:String) : void
      {
         var _loc4_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
         var _loc5_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
         var _loc3_:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
         _loc4_ = _loc4_ && _loc4_.length > 0 ? _loc4_ : "101";
         _loc5_ = _loc5_ && _loc5_.length > 0 ? _loc5_ : "101";
         _loc3_ = _loc3_ && _loc3_.length > 0 ? _loc3_ : "1.1";
         switch(param1)
         {
            case "floor":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,param2,_loc4_,_loc3_,true);
               break;
            case "wallpaper":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,param2,_loc3_,true);
               break;
            case "landscape":
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,_loc4_,param2,true);
               break;
            default:
               _roomEngine.updateObjectRoom(_roomEngine.activeRoomId,_loc5_,_loc4_,_loc3_,true);
         }
      }
      
      public function requestSelectedItemToMover(param1:class_3458, param2:class_3377, param3:Boolean = false) : void
      {
         var _loc6_:int = 0;
         if(!isDraggable(param2))
         {
            return;
         }
         var _loc4_:class_3388;
         switch((_loc4_ = param2.product).productType)
         {
            case "s":
               _loc6_ = 10;
               break;
            case "i":
               _loc6_ = 20;
         }
         var _loc5_:Boolean;
         if(_loc5_ = _roomEngine.initializeRoomObjectInsert("catalog",-param2.offerId,_loc6_,_loc4_.productClassId,!!_loc4_.extraParam ? _loc4_.extraParam.toString() : null,null,-1,-1,null,param3))
         {
            _offerInFurniPlacing = param2;
            _offerPlacingCallbackReceiver = param1;
            hideMainWindow();
            var_2052 = true;
            var_4817 = param3;
         }
      }
      
      private function onObjectSelected(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:class_3490 = null;
         if(param1 == null)
         {
            return;
         }
         if(buildersClubEnabled && (!var_78 || !getCatalogNavigator("BUILDERS_CLUB").initialized))
         {
            init();
            refreshCatalogIndex("BUILDERS_CLUB");
         }
         if(param1.type == "REOE_SELECTED" && param1.category == 100)
         {
            _loc2_ = getUserDataForEvent(param1);
            if(_loc2_ != null)
            {
               events.dispatchEvent(new CatalogUserEvent("CATALOG_USER_SELECTED",_loc2_.webID,_loc2_.name));
            }
         }
      }
      
      private function onFriendBarSelectionEvent(param1:FriendBarSelectionEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc4_:class_3458 = null;
         if(var_2052 && param1.type == "FBVE_FRIEND_SELECTED")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc3_ = param1.friendId;
            _loc2_ = param1.friendName;
            if((_loc4_ = _offerPlacingCallbackReceiver) != null)
            {
               _loc4_.onDragAndDropDone(true,_loc2_);
            }
            resetObjectMover(false);
            cancelFurniInMover();
         }
      }
      
      private function getUserDataForEvent(param1:RoomEngineObjectEvent) : class_3490
      {
         var _loc3_:IRoomSession = null;
         var _loc2_:class_3490 = null;
         if(_roomSessionManager != null)
         {
            _loc3_ = _roomSessionManager.getSession(param1.roomId);
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.userDataManager.getUserDataByIndex(param1.objectId);
            }
         }
         return _loc2_;
      }
      
      private function onObjectPlaceOnUser(param1:RoomEngineObjectPlacedOnUserEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:class_3490 = null;
         var _loc3_:class_3458 = null;
         if(var_2052 && param1.type == "REOE_PLACED_ON_USER")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc4_ = null;
            _loc2_ = getUserDataForEvent(param1);
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.name;
            }
            _loc3_ = _offerPlacingCallbackReceiver;
            if(_loc3_ != null)
            {
               _loc3_.onDragAndDropDone(true,_loc4_);
            }
            resetObjectMover(false);
            cancelFurniInMover();
         }
      }
      
      private function onObjectPlacedInRoom(param1:RoomEngineObjectPlacedEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:class_3388 = null;
         var _loc5_:Boolean = false;
         var _loc6_:class_3458 = null;
         var _loc4_:IRoomObjectController = null;
         var _loc8_:int = 0;
         var _loc3_:* = undefined;
         if(var_2052 && param1.type == "REOE_PLACED")
         {
            resetPlacedOfferData(true);
            if(_offerInFurniPlacing == null || Boolean(_offerInFurniPlacing.disposed))
            {
               resetObjectMover();
               return;
            }
            _loc7_ = param1.category;
            _loc2_ = _offerInFurniPlacing.product;
            _loc5_ = false;
            if(_loc7_ == 20)
            {
               switch(_loc2_.furnitureData.className)
               {
                  case "floor":
                  case "wallpaper":
                  case "landscape":
                     _loc5_ = param1.placedOnFloor || param1.placedOnWall;
                     break;
                  default:
                     _loc5_ = param1.placedInRoom;
               }
            }
            else
            {
               _loc5_ = param1.placedInRoom;
            }
            if(!_loc5_)
            {
               resetObjectMover();
               return;
            }
            var_1725 = new PlacedObjectPurchaseData(param1.roomId,param1.objectId,param1.category,param1.wallLocation,param1.x,param1.y,param1.direction,_offerInFurniPlacing);
            if((_loc6_ = _offerPlacingCallbackReceiver) != null)
            {
               _loc6_.onDragAndDropDone(true,null);
            }
            switch(var_395)
            {
               case "NORMAL":
                  if(_loc7_ == 10)
                  {
                     _roomEngine.addObjectFurniture(param1.roomId,param1.objectId,_loc2_.productClassId,new Vector3d(param1.x,param1.y,param1.z),new Vector3d(param1.direction,0,0),0,new LegacyStuffData());
                  }
                  else if(_loc7_ == 20)
                  {
                     switch(_loc2_.furnitureData.className)
                     {
                        case "floor":
                        case "wallpaper":
                        case "landscape":
                           updateRoom(_loc2_.furnitureData.className,_loc2_.extraParam);
                           break;
                        default:
                           _roomEngine.addObjectWallItem(param1.roomId,param1.objectId,_loc2_.productClassId,new Vector3d(param1.x,param1.y,param1.z),new Vector3d(param1.direction * 45,0,0),0,param1.instanceData,0);
                     }
                  }
                  if(_loc4_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category) as IRoomObjectController)
                  {
                     _loc4_.getModelController().setNumber("furniture_alpha_multiplier",0.5);
                  }
                  break;
               case "BUILDERS_CLUB":
                  if((_loc8_ = _offerInFurniPlacing.page.pageId) == -12345678)
                  {
                     _loc3_ = currentCatalogNavigator.getNodesByOfferId(_offerInFurniPlacing.offerId,true);
                     if(_loc3_ != null)
                     {
                        _loc8_ = _loc3_[0].pageId;
                     }
                  }
                  switch(_loc7_ - 10)
                  {
                     case 0:
                        send(new class_270(_loc8_,_offerInFurniPlacing.offerId,_loc2_.extraParam,param1.x,param1.y,param1.direction));
                        break;
                     case 10:
                        send(new class_852(_loc8_,_offerInFurniPlacing.offerId,_loc2_.extraParam,param1.wallLocation));
                  }
                  if(var_4817)
                  {
                     requestSelectedItemToMover(_loc6_,_offerInFurniPlacing,true);
                  }
                  else
                  {
                     toggleBuilderCatalog();
                  }
            }
         }
      }
      
      private function resetObjectMover(param1:Boolean = true) : void
      {
         if(param1 && var_2052)
         {
            showMainWindow();
         }
         var_2052 = false;
         _offerPlacingCallbackReceiver = null;
      }
      
      public function syncPlacedOfferWithPurchase(param1:class_3377) : void
      {
         if(var_1725)
         {
            if(var_1725.offerId != param1.offerId)
            {
               resetPlacedOfferData();
            }
         }
      }
      
      public function resetPlacedOfferData(param1:Boolean = false) : void
      {
         if(!param1)
         {
            resetObjectMover();
         }
         if(var_1725 != null)
         {
            if(var_1725.category == 10)
            {
               _roomEngine.disposeObjectFurniture(var_1725.roomId,var_1725.objectId);
            }
            else if(var_1725.category == 20)
            {
               switch(var_1725.furniData.className)
               {
                  case "floor":
                  case "wallpaper":
                  case "landscape":
                     updateRoom("reset","");
                     break;
                  default:
                     _roomEngine.disposeObjectWallItem(var_1725.roomId,var_1725.objectId);
               }
            }
            else
            {
               _roomEngine.deleteRoomObject(var_1725.objectId,var_1725.category);
            }
            var_1725.dispose();
            var_1725 = null;
         }
      }
      
      public function cancelFurniInMover() : void
      {
         if(_offerInFurniPlacing != null)
         {
            _roomEngine.cancelRoomObjectInsert();
            var_2052 = false;
            _offerInFurniPlacing = null;
         }
      }
      
      public function get collectorHub() : class_3479
      {
         return var_1754;
      }
      
      public function itemAddedToInventory(param1:int, param2:int, param3:int) : void
      {
         var _loc8_:* = 0;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         if(var_1725 != null && var_1725.productClassId == param1)
         {
            if(var_1725.roomId == _roomEngine.activeRoomId)
            {
               _loc8_ = param2;
               param3 = var_1725.category;
               _loc6_ = var_1725.wallLocation;
               _loc5_ = var_1725.x;
               _loc7_ = var_1725.y;
               _loc10_ = var_1725.direction;
               switch(param3 - 2)
               {
                  case 0:
                     _loc9_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
                     if(var_1725.extraParameter != _loc9_)
                     {
                        send(new class_984(_loc8_));
                     }
                     break;
                  case 1:
                     _loc11_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
                     if(var_1725.extraParameter != _loc11_)
                     {
                        send(new class_984(_loc8_));
                     }
                     break;
                  case 2:
                     _loc4_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
                     if(var_1725.extraParameter != _loc4_)
                     {
                        send(new class_984(_loc8_));
                     }
                     break;
                  default:
                     send(new class_663(_loc8_,param3,_loc6_,_loc5_,_loc7_,_loc10_));
               }
               resetPlacedOfferData();
            }
         }
      }
      
      public function setImageFromAsset(param1:IWindow, param2:String, param3:Function) : void
      {
         if(!param2 || !assets)
         {
            return;
         }
         var _loc4_:BitmapDataAsset;
         if((_loc4_ = this.findAssetByName(param2) as BitmapDataAsset) == null)
         {
            retrievePreviewAsset(param2,param3);
            return;
         }
         if(param1)
         {
            HabboCatalog.setElementImageCentered(param1,_loc4_.content as BitmapData);
         }
      }
      
      public function get imageGalleryHost() : String
      {
         return getProperty("image.library.catalogue.url");
      }
      
      private function retrievePreviewAsset(param1:String, param2:Function) : void
      {
         if(!param1 || !assets)
         {
            return;
         }
         var _loc5_:String = imageGalleryHost + param1 + ".png";
         var _loc3_:URLRequest = new URLRequest(_loc5_);
         var _loc4_:AssetLoaderStruct;
         if(!(_loc4_ = this.loadAssetFromFile(param1,_loc3_,"image/png")))
         {
            return;
         }
         if(param2 != null)
         {
            _loc4_.addEventListener("AssetLoaderEventComplete",param2);
         }
      }
      
      private function showMainWindow() : void
      {
         var _loc1_:class_3460 = null;
         if(_windowManager != null && var_1647 != null && var_1647.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(var_1647);
            }
         }
      }
      
      private function hideMainWindow() : void
      {
         var _loc1_:class_3460 = null;
         if(_windowManager != null && var_1647 != null && var_1647.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null && !var_3130)
            {
               _loc1_.removeChild(var_1647);
               if(var_1690 != null)
               {
                  var_1690.catalogWindowClosed();
               }
            }
            var_3130 = false;
         }
      }
      
      private function mainWindowVisible() : Boolean
      {
         return _windowManager != null && var_1647 != null && var_1647.parent != null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(var_1799 != null)
         {
            var_1799.updatePreviewRoomView();
         }
         if(getTimer() - _builderMembershipDisplayUpdateTime > 500)
         {
            _loc3_ = builderSecondsLeft;
            _loc2_ = builderSecondsLeftWithGrace;
            if(_loc3_ > -3 && _loc3_ < 200 || _loc2_ > -3 && _loc2_ < 200)
            {
               refreshBuilderStatus();
            }
         }
      }
      
      public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         if(var_2201)
         {
            var_2201.onGuildMembershipsMessageEvent(param1);
         }
      }
      
      private function onSnowWarGameTokenOffer(param1:SnowWarGameTokensMessageEvent) : void
      {
         var _loc3_:SnowWarGameTokensMessageParser = param1.getParser();
         disposeSnowWarTokens();
         for each(var _loc2_ in _loc3_.offers)
         {
            if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS")
            {
               var_2329 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
            else if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS2")
            {
               var_2278 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
            else if(_loc2_.localizationId == "GET_SNOWWAR_TOKENS3")
            {
               var_2381 = new GameTokensOffer(_loc2_.offerId,_loc2_.localizationId,_loc2_.priceInCredits,_loc2_.priceInActivityPoints,_loc2_.activityPointType);
            }
         }
      }
      
      public function buySnowWarTokensOffer(param1:String) : void
      {
         if(param1 == "GET_SNOWWAR_TOKENS" && var_2329)
         {
            showPurchaseConfirmation(var_2329,-1,var_2329.localizationId);
         }
         else if(param1 == "GET_SNOWWAR_TOKENS2" && var_2278)
         {
            showPurchaseConfirmation(var_2278,-1,var_2278.localizationId);
         }
         else if(param1 == "GET_SNOWWAR_TOKENS3" && var_2381)
         {
            showPurchaseConfirmation(var_2381,-1,var_2381.localizationId);
         }
         else
         {
            _communication.connection.send(new GetSnowWarGameTokensOfferComposer());
         }
      }
      
      public function verifyClubLevel(param1:int = 1) : Boolean
      {
         if(_sessionDataManager.clubLevel >= param1)
         {
            return true;
         }
         openClubCenter();
         return false;
      }
      
      public function openClubCenter() : void
      {
         context.createLinkEvent("habboUI/open/hccenter");
      }
      
      public function openVault() : void
      {
         context.createLinkEvent("habboUI/open/vault");
      }
      
      private function onGuildVisualSettingsChanged(param1:GuildSettingsChangedInManageEvent) : void
      {
         if(var_2201)
         {
            var_2201.onGuildVisualSettingsChanged(param1.guildId);
         }
      }
      
      public function get avatarEditor() : class_1881
      {
         return _avatarEditor;
      }
      
      public function checkGiftable(param1:class_3377) : void
      {
         send(new class_512(param1.offerId));
      }
      
      public function rememberPageDuringVipPurchase(param1:int) : void
      {
         var _loc2_:class_3411 = currentCatalogNavigator.getNodeById(param1);
         if(_loc2_)
         {
            var_2393 = _loc2_.pageName;
         }
         else
         {
            var_2393 = "frontpage";
         }
      }
      
      public function forgetPageDuringVipPurchase() : void
      {
         var_2393 = null;
         var_3130 = false;
      }
      
      public function doNotCloseAfterVipPurchase() : void
      {
         var_3130 = var_2393 != null;
      }
      
      private function initBundleDiscounts() : void
      {
         sendGetBundleDiscountRuleset();
      }
      
      private function sendGetBundleDiscountRuleset() : void
      {
         send(new class_520());
      }
      
      public function sendGetProductOffer(param1:int) : void
      {
         send(new GetProductOfferComposer(param1));
      }
      
      private function onBundleDiscountRulesetMessageEvent(param1:BundleDiscountRulesetMessageEvent) : void
      {
         var _loc2_:class_1222 = param1.getParser();
         _bundleDiscountRuleset = _loc2_.bundleDiscountRuleset;
         _utils.resolveBundleDiscountFlatPriceSteps();
      }
      
      private function onLimitedEditionSoldOut(param1:LimitedEditionSoldOutEvent) : void
      {
         _windowManager.alert("${catalog.alert.limited_edition_sold_out.title}","${catalog.alert.limited_edition_sold_out.message}",0,alertDialogEventProcessor);
         if(var_1715 != null)
         {
            var_1715.dispose();
            var_1715 = null;
         }
      }
      
      private function onProductOffer(param1:ProductOfferEvent) : void
      {
         var _loc6_:class_3365 = null;
         var _loc3_:class_1123 = param1.getParser();
         var _loc4_:class_1501;
         if(!(_loc4_ = _loc3_.offerData) || _loc4_.products.length == 0)
         {
            return;
         }
         var _loc5_:class_1718;
         if((_loc5_ = _loc4_.products[0]).uniqueLimitedItem)
         {
            var_1690.currentPage.updateLimitedItemsLeft(_loc4_.offerId,_loc5_.uniqueLimitedItemsLeft);
         }
         var _loc7_:Vector.<class_3388> = new Vector.<class_3388>(0);
         var _loc8_:class_3423 = getProductData(_loc4_.localizationId);
         for each(_loc5_ in _loc4_.products)
         {
            _loc6_ = getFurnitureData(_loc5_.furniClassId,_loc5_.productType);
            _loc7_.push(new Product(_loc5_.productType,_loc5_.furniClassId,_loc5_.extraParam,_loc5_.productCount,_loc8_,_loc6_,this,_loc5_.uniqueLimitedItem,_loc5_.uniqueLimitedItemSeriesSize,_loc5_.uniqueLimitedItemsLeft));
         }
         var _loc2_:Offer = new Offer(_loc4_.offerId,_loc4_.localizationId,_loc4_.isRent,_loc4_.priceInCredits,_loc4_.priceInActivityPoints,_loc4_.activityPointType,_loc4_.priceInSilver,_loc4_.giftable,_loc4_.clubLevel,_loc7_,_loc4_.bundlePurchaseAllowed,this);
         if(!isOfferCompatibleWithCurrentMode(_loc2_))
         {
            _loc2_.dispose();
            return;
         }
         if(var_1690 && var_1690.currentPage)
         {
            _loc2_.page = var_1690.currentPage;
            var_1690.currentPage.dispatchWidgetEvent(new SelectProductEvent(_loc2_));
            if(_loc2_.product && _loc2_.product.productType == "i")
            {
               var_1690.currentPage.dispatchWidgetEvent(new SetExtraPurchaseParameterEvent(_loc2_.product.extraParam));
            }
            if(var_2052 && _offerInFurniPlacing)
            {
               _offerInFurniPlacing = _loc2_;
            }
         }
      }
      
      private function onBuildersClubSubscriptionStatus(param1:BuildersClubSubscriptionStatusMessageEvent) : void
      {
         var _loc2_:class_1565 = param1.getParser();
         var_4126 = _loc2_.furniLimit;
         var_4660 = _loc2_.maxFurniLimit;
         var_3757 = _loc2_.secondsLeft;
         _builderMembershipUpdateTime = getTimer();
         var_4109 = _loc2_.secondsLeftWithGrace;
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.updateBuildersClub",var_3757 > 0);
         }
         if(currentPage != null)
         {
            currentPage.dispatchWidgetEvent(new CatalogWidgetBuilderSubscriptionUpdatedEvent());
         }
         refreshBuilderStatus();
      }
      
      private function onBuildersClubFurniCount(param1:class_149) : void
      {
         var_4155 = param1.getParser().furniCount;
         if(currentPage != null)
         {
            currentPage.dispatchWidgetEvent(new CatalogWidgetBuilderSubscriptionUpdatedEvent());
         }
         refreshBuilderStatus();
      }
      
      private function refreshBuilderStatus() : void
      {
         var _loc4_:Number = var_3757 - (getTimer() - _builderMembershipUpdateTime) / 1000;
         var _loc2_:Number = var_4109 - (getTimer() - _builderMembershipUpdateTime) / 1000;
         if(var_3787 && _loc4_ <= 0 && _loc2_ > 0)
         {
            events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_IN_GRACE"));
         }
         else if(var_3753 && _loc2_ <= 0)
         {
            events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_EXPIRED"));
         }
         var_3787 = _loc4_ > 0;
         var_3753 = _loc2_ > 0;
         var _loc3_:String = "builder.header.status." + (var_3787 ? "member" : (var_3753 ? "grace" : "trial"));
         var _loc5_:String = String(_localization.getLocalization(_loc3_));
         _localization.registerParameter("builder.header.title","bcstatus",_loc5_);
         var _loc1_:String = var_3787 ? FriendlyTime.getFriendlyTime(_localization,_loc4_) : (var_3753 ? FriendlyTime.getFriendlyTime(_localization,_loc2_) : _loc5_);
         _localization.registerParameter("builder.header.status.membership","duration","<font color=\"#ff8d00\"><b>" + _loc1_ + "</b></font>");
         _localization.registerParameter("builder.header.status.limit","count","<font color=\"#ff8d00\"><b>" + var_4155 + "</b></font>");
         _localization.registerParameter("builder.header.status.limit","limit","<font color=\"#ff8d00\"><b>" + var_4126 + "</b></font>");
         _builderMembershipDisplayUpdateTime = getTimer();
      }
      
      public function get bundleDiscountEnabled() : Boolean
      {
         return var_395 != "BUILDERS_CLUB";
      }
      
      public function get bundleDiscountRuleset() : class_1639
      {
         return _bundleDiscountRuleset;
      }
      
      public function get multiplePurchaseEnabled() : Boolean
      {
         return getBoolean("catalog.multiple.purchase.enabled") && var_395 != "BUILDERS_CLUB";
      }
      
      public function get newAdditionsPageOpenDisabled() : Boolean
      {
         return getBoolean("catalog.new.additions.page.open.disabled");
      }
      
      public function showVipBenefits() : void
      {
         if(!_utils)
         {
            init();
         }
         if(_utils)
         {
            if(!getCatalogNavigator("NORMAL").initialized)
            {
               refreshCatalogIndex("NORMAL");
            }
            _utils.showVipBenefits();
         }
      }
      
      public function get currentPage() : class_3455
      {
         return var_1690 == null ? null : var_1690.currentPage;
      }
      
      public function displayProductIcon(param1:String, param2:int, param3:IBitmapWrapperWindow) : void
      {
         _utils.displayProductIcon(param1,param2,param3);
      }
      
      public function openRentConfirmationWindow(param1:class_3365, param2:Boolean, param3:int = -1, param4:int = -1, param5:Boolean = false) : void
      {
         if(var_2794 == null)
         {
            var_2794 = new RentConfirmationWindow(this);
         }
         var_2794.show(param1,param2,param3,param4,param5);
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_2300;
      }
      
      public function get linkPattern() : String
      {
         return "catalog/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "open":
               if(_loc2_.length > 2)
               {
                  openCatalogPage(_loc2_[2]);
               }
               else
               {
                  openCatalog();
               }
               break;
            case "warehouse":
               if(_loc2_.length > 2)
               {
                  openCatalogPage(_loc2_[2],"BUILDERS_CLUB");
               }
               else
               {
                  toggleCatalog("BUILDERS_CLUB",true);
               }
               break;
            case "club_buy":
               openClubCenter();
               break;
            default:
               class_14.log("Catalog unknown link-type receive: " + _loc2_[1]);
         }
      }
      
      public function get inventory() : class_1814
      {
         return _inventory;
      }
      
      public function get mainContainer() : IWindowContainer
      {
         return var_1647;
      }
      
      public function toggleBuilderCatalog() : void
      {
         toggleCatalog("BUILDERS_CLUB");
      }
      
      public function get catalogType() : String
      {
         return var_395;
      }
      
      public function getCatalogNavigator(param1:String) : class_3341
      {
         return _catalogNavigators != null ? _catalogNavigators[param1] : null;
      }
      
      public function get currentCatalogNavigator() : class_3341
      {
         return getCatalogNavigator(var_395);
      }
      
      public function get builderFurniLimit() : int
      {
         return var_4126;
      }
      
      public function get builderFurniCount() : int
      {
         return var_4155;
      }
      
      public function get builderMaxFurniLimit() : int
      {
         return var_4660;
      }
      
      public function get builderSecondsLeft() : Number
      {
         return var_3757 - (getTimer() - _builderMembershipUpdateTime) / 1000;
      }
      
      public function get builderSecondsLeftWithGrace() : Number
      {
         return var_4109 - (getTimer() - _builderMembershipUpdateTime) / 1000;
      }
      
      public function getOfferCenter(param1:IOfferExtension) : IOfferCenter
      {
         if(_offerCenter == null)
         {
            _offerCenter = new OfferCenter(windowManager,assets,this);
         }
         _offerCenter.offerExtension = param1;
         return _offerCenter;
      }
      
      public function isNewIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function useNonTabbedCatalog() : Boolean
      {
         return getBoolean("client.desktop.use.non.tabbed.catalog");
      }
   }
}
