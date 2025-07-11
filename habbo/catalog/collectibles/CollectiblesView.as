package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3404;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.collectibles.widget.CollectionsWidget;
   import com.sulake.habbo.catalog.collectibles.widget.MintInventoryListWidget;
   import com.sulake.habbo.catalog.collectibles.widget.TransferNftsWidget;
   import com.sulake.habbo.catalog.purse.class_3378;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1278;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1484;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_1074;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_981;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_405;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_643;
   
   public class CollectiblesView implements IDisposable
   {
      
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      public static const STARDUST_WALLET_DISPLAY_NAME:String = "Collector Wallet";
      
      private static const TAB_COLLECTIONS:String = "top_view_collections_button";
      
      private static const TAB_MINT:String = "top_view_minting_button";
      
      private static const TAB_INFO:String = "top_view_info_button";
      
      private static const TAB_TRANSFER:String = "top_view_transfer_button";
      
      private static const TAB_COLLECTOR_PROFILE:String = "top_view_profile_button";
      
      private static const TAB_LEVELS:String = "top_view_levels_button";
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_319:CollectiblesController;
      
      private var _window:IWindowContainer;
      
      private var _currentTab:String = "top_view_collections_button";
      
      private var var_2135:MintInventoryListWidget;
      
      private var var_1900:CollectionsWidget;
      
      private var var_1991:TransferNftsWidget;
      
      private var var_3829:Boolean = false;
      
      private var var_228:Array = null;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2778:String;
      
      private var var_4219:String;
      
      public function CollectiblesView(param1:CollectiblesController, param2:IHabboWindowManager)
      {
         super();
         var_319 = param1;
         _windowManager = param2;
         _window = param2.buildFromXML(XML(var_319.assets.getAssetByName("collectible_view_xml").content),1) as IWindowContainer;
         _window.findChildByName("top_view_profile_button").procedure = onTab;
         _window.findChildByName("top_view_collections_button").procedure = onTab;
         _window.findChildByName("top_view_levels_button").procedure = onTab;
         _window.findChildByName("top_view_minting_button").procedure = onTab;
         _window.findChildByName("top_view_info_button").procedure = onTab;
         _window.findChildByName("top_view_transfer_button").procedure = onTab;
         addMessageEvents();
         refresh();
         requestWalletAddresses();
         var _loc5_:Boolean = Boolean(param1.context.configuration.getBoolean("nft.minting.enabled"));
         _window.findChildByName("top_view_minting_button").visible = _loc5_;
         var _loc3_:Boolean = Boolean(param1.context.configuration.getBoolean("collectibles.transfer.enabled"));
         _window.findChildByName("top_view_transfer_button").visible = _loc3_;
         levelTitle.caption = param1.localizationManager.getLocalization("collectibles.level").toUpperCase();
         centerTabLayout();
         initWidgets();
         var _loc4_:IWindow;
         if((_loc4_ = _window.findChildByName("header_button_close")) != null)
         {
            _loc4_.addEventListener("WME_CLICK",onWindowClose);
         }
         infoLink.addEventListener("WE_LINK",onClickHtmlLink);
         infoLink.initializeLinkStyle();
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideWindow();
      }
      
      private function hideWindow() : void
      {
         var _loc1_:class_3460 = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function showWindow() : void
      {
         var _loc1_:class_3460 = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
      }
      
      private function centerTabLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:IWindow = null;
         var _loc4_:ISelectorListWindow = ITabContextWindow(_window.findChildByName("top_view_select_tab_context")).selector;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.numSelectables)
         {
            _loc1_ = _loc4_.getSelectableAt(_loc3_);
            if(_loc1_.visible)
            {
               _loc2_ += _loc1_.width;
            }
            _loc3_++;
         }
         _loc4_.x = _window.width / 2 - _loc2_ / 2;
         window.findChildByName("tab_bg").visible = _loc2_ > 350;
      }
      
      private function addMessageEvents() : void
      {
         if(!var_319)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new class_981(onCollectableWalletAddressMessage));
         _messageEvents.push(new class_1074(onCollectionsScoreMessage));
         for each(var _loc1_ in _messageEvents)
         {
            var_319.addMessageEvent(_loc1_);
         }
      }
      
      public function updateBalances(param1:class_3378) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:IWindow = _window.findChildByName("emerald_currency_value");
         if(_loc2_)
         {
            _loc2_.caption = "" + param1.emeraldBalance;
         }
         var _loc3_:IWindow = _window.findChildByName("silver_currency_value");
         if(_loc3_)
         {
            _loc3_.caption = "" + param1.silverBalance;
         }
         if(var_1991)
         {
            var_1991.onSilverBalanceUpdated();
         }
      }
      
      private function onCollectionsScoreMessage(param1:class_1074) : void
      {
         var _loc3_:* = 0;
         var _loc2_:class_1484 = param1.getParser();
         levelValue.caption = String(_loc2_.level);
         scoreValue.caption = String(_loc2_.score);
         hiscoreValue.caption = String(_loc2_.highestScore);
         var _loc4_:int;
         switch(_loc4_ = Math.max(0,(_loc2_.level - 1) / 5))
         {
            case 0:
               _loc3_ = 8162450;
               break;
            case 1:
               _loc3_ = 2529547;
               break;
            case 2:
               _loc3_ = 32234;
               break;
            case 3:
               _loc3_ = 13828339;
               break;
            default:
               _loc3_ = 15571457;
         }
         collectorLevelBg.color = _loc3_;
         collectorLevelBg2.color = _loc3_;
      }
      
      private function onCollectableWalletAddressMessage(param1:class_981) : void
      {
         var_3829 = false;
         var _loc2_:class_1278 = param1.getParser();
         var_228 = _loc2_.walletAddresses;
         var_4219 = _loc2_.stardustWalletAddress;
         if(var_1900)
         {
            var_1900.onWalletsAddressesUpdated(var_228);
         }
         if(var_1991)
         {
            var_1991.onWalletsAddressesUpdated(nonStardustWallets);
         }
         setActiveWalletIndex(0);
      }
      
      public function get nonStardustWallets() : Array
      {
         if(var_228 == null)
         {
            return null;
         }
         var _loc2_:Array = [];
         for each(var _loc1_ in var_228)
         {
            if(_loc1_ != var_4219)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function walletsLoaded() : Boolean
      {
         return var_228 != null;
      }
      
      public function setActiveWalletIndex(param1:int) : void
      {
         if(var_228.length > 0 && (param1 < 0 || param1 >= var_228.length || var_228[param1] == var_2778))
         {
            return;
         }
         var_2778 = var_228.length > 0 ? var_228[param1] : null;
         if(var_1900)
         {
            var_1900.activeWallet = var_2778;
         }
         if(var_2135)
         {
            var_2135.activeWallet = var_2778;
         }
         if(var_2778 != null)
         {
            var_319.send(new class_643(var_2778));
         }
      }
      
      private function requestWalletAddresses() : void
      {
         if(var_3829)
         {
            return;
         }
         var_3829 = true;
         var_319.send(new class_405());
      }
      
      public function get walletAddresses() : Array
      {
         return var_228;
      }
      
      private function refresh() : void
      {
         var _loc1_:ITabContextWindow = ITabContextWindow(_window.findChildByName("top_view_select_tab_context"));
         _loc1_.selector.setSelected(ISelectableWindow(_window.findChildByName(_currentTab)));
         hideAllTabContainers();
         switch(_currentTab)
         {
            case "top_view_profile_button":
               _window.findChildByName("collectorProfileContainer").visible = true;
               break;
            case "top_view_collections_button":
               _window.findChildByName("collectionsContainer").visible = true;
               if(!var_1900)
               {
                  var_1900 = new CollectionsWidget(this,var_319);
               }
               break;
            case "top_view_levels_button":
               _window.findChildByName("levelsContainer").visible = true;
               break;
            case "top_view_minting_button":
               _window.findChildByName("mintingContainer").visible = true;
               if(!var_2135)
               {
                  var_2135 = new MintInventoryListWidget(this,var_319);
               }
               break;
            case "top_view_transfer_button":
               _window.findChildByName("transferContainer").visible = true;
               if(!var_1991)
               {
                  var_1991 = new TransferNftsWidget(this,var_319);
               }
               break;
            case "top_view_info_button":
               _window.findChildByName("infoContainer").visible = true;
         }
      }
      
      private function initWidgets() : void
      {
         if(!var_1900)
         {
            var_1900 = new CollectionsWidget(this,var_319);
         }
         if(!var_2135)
         {
            var_2135 = new MintInventoryListWidget(this,var_319);
         }
         if(!var_1991)
         {
            var_1991 = new TransferNftsWidget(this,var_319);
         }
      }
      
      public function get activeWallet() : String
      {
         return var_2778;
      }
      
      private function hideAllTabContainers() : void
      {
         _window.findChildByName("collectorProfileContainer").visible = false;
         _window.findChildByName("collectionsContainer").visible = false;
         _window.findChildByName("levelsContainer").visible = false;
         _window.findChildByName("mintingContainer").visible = false;
         _window.findChildByName("transferContainer").visible = false;
         _window.findChildByName("infoContainer").visible = false;
      }
      
      private function onTab(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _currentTab = param2.name;
         refresh();
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function onClickHtmlLink(param1:WindowEvent) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            HabboWebTools.openWebPageAndMinimizeClient(_loc2_.link);
         }
      }
      
      private function removeMessageEvents() : void
      {
         if(!var_319 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            var_319.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function get stardustWallet() : String
      {
         return var_4219;
      }
      
      public function dispose() : void
      {
         removeMessageEvents();
         if(var_1900)
         {
            var_1900.dispose();
            var_1900 = null;
         }
         if(var_2135)
         {
            var_2135.dispose();
            var_2135 = null;
         }
         if(var_1991)
         {
            var_1991.dispose();
            var_1991 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get mintInventoryListWidget() : MintInventoryListWidget
      {
         return var_2135;
      }
      
      public function get transferWidget() : TransferNftsWidget
      {
         return var_1991;
      }
      
      public function get collectionsWidget() : CollectionsWidget
      {
         return var_1900;
      }
      
      private function get scoreValue() : ITextWindow
      {
         return _window.findChildByName("current_score_value") as ITextWindow;
      }
      
      private function get hiscoreValue() : ITextWindow
      {
         return _window.findChildByName("current_hiscore_value") as ITextWindow;
      }
      
      private function get levelValue() : ITextWindow
      {
         return _window.findChildByName("collector_level") as ITextWindow;
      }
      
      private function get levelTitle() : ITextWindow
      {
         return _window.findChildByName("level_title") as ITextWindow;
      }
      
      private function get collectorLevelBg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("collector_level_bg") as IStaticBitmapWrapperWindow;
      }
      
      private function get collectorLevelBg2() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("collector_level_bg2") as IStaticBitmapWrapperWindow;
      }
      
      private function get infoLink() : class_3404
      {
         return _window.findChildByName("info_desc") as class_3404;
      }
   }
}
