package com.sulake.habbo.inventory.trading
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3404;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.ItemPopupCtrl;
   import com.sulake.habbo.inventory.Util;
   import com.sulake.habbo.inventory.items.CreditTradingItem;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_3393;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
   
   public class TradingView implements IInventoryView, IGetImageListener
   {
      
      private static const COLOR_LOCKED:uint = 4284532064;
      
      private static const COLOR_UNLOCKED:uint = 2577770;
      
      public static const ALERT_SCAM:int = 0;
      
      public static const ALERT_OTHER_CANCELLED:int = 1;
      
      public static const ALERT_ALREADY_OPEN:int = 2;
      
      private static const TRADE_UI_SPACING:int = 7;
       
      
      private var var_1635:TradingModel;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_2286:IAssetLibrary;
      
      private var var_2190:ItemPopupCtrl;
      
      private var _soundManager:class_2240;
      
      private var _disposed:Boolean = false;
      
      private var var_848:Boolean;
      
      private var var_1676:IWindowContainer;
      
      private var _windowMin:IWindowContainer;
      
      private var var_1883:Timer;
      
      private var _selection:GroupItem;
      
      private var var_1974:Boolean;
      
      private var _waitingSongInfo:Array;
      
      public function TradingView(param1:TradingModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IRoomEngine, param5:IHabboLocalizationManager, param6:class_2240)
      {
         _waitingSongInfo = [];
         super();
         var_1635 = param1;
         _windowManager = param2;
         _localization = param5;
         var_2286 = param3;
         _roomEngine = param4;
         _soundManager = param6;
         var_848 = false;
         var _loc8_:IAsset = var_2286.getAssetByName("item_popup_xml");
         var _loc7_:XmlAsset = XmlAsset(_loc8_);
         var _loc9_:IWindowContainer;
         (_loc9_ = _windowManager.buildFromXML(_loc7_.content as XML) as IWindowContainer).visible = false;
         var_2190 = new ItemPopupCtrl(_loc9_,var_2286,_windowManager,var_1635);
         _soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get visible() : Boolean
      {
         return var_848;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1676 && !var_1676.disposed)
            {
               var_1676.dispose();
               var_1676 = null;
            }
            if(var_1883)
            {
               var_1883.removeEventListener("timer",timerEventHandler);
               var_1883.stop();
               var_1883 = null;
            }
            if(var_2190 != null)
            {
               var_2190.dispose();
               var_2190 = null;
            }
            if(_soundManager)
            {
               if(_soundManager.events != null)
               {
                  _soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
               }
               _soundManager = null;
            }
            _waitingSongInfo = null;
            var_1635 = null;
            _windowManager = null;
            _roomEngine = null;
            _localization = null;
            var_2286 = null;
            _selection = null;
            var_848 = false;
            _disposed = true;
         }
      }
      
      public function setup(param1:int, param2:Boolean, param3:int, param4:Boolean) : void
      {
         setMinimized(false);
         hideOwnUserNotification();
         hideOtherUserNotification();
         if(!param2 && !param4)
         {
            showInfoMessage("${inventory.trading.warning.both_accounts_disabled}");
            showOwnUserNotification("");
            showOtherUserNotification("");
         }
         else
         {
            if(!param2)
            {
               showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
            }
            if(!param4)
            {
               showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
            }
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(var_1676 == null)
         {
            var_1676 = createNormalWindow();
            showHighlightInfo(null);
         }
         if(_windowMin == null)
         {
            _windowMin = createMinimizedWindow();
         }
         if(!var_1974)
         {
            resizeWindow(true);
            return var_1676;
         }
         return _windowMin;
      }
      
      public function setMinimized(param1:Boolean = false) : void
      {
         var_1974 = param1;
      }
      
      public function updateItemList(param1:int) : void
      {
         var _loc3_:GroupItem = null;
         var _loc9_:IWindowContainer = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(!var_1676)
         {
            return;
         }
         var _loc8_:uint = 0;
         var _loc11_:*;
         var _loc10_:Map = (_loc11_ = param1 == var_1635.otherUserId) ? var_1635.otherUserItems : var_1635.ownUserItems;
         var _loc6_:IItemGridWindow = _loc11_ ? getOtherUsersItemGrid() : getOwnUsersItemGrid();
         while(_loc8_ < _loc10_.length)
         {
            _loc3_ = _loc10_.getWithIndex(_loc8_) as GroupItem;
            if(_loc9_ = _loc6_.getGridItemAt(_loc8_) as IWindowContainer)
            {
               _loc9_.id = _loc8_;
               while(_loc9_.numChildren > 0)
               {
                  _loc9_.removeChildAt(0);
               }
               _loc9_.addChild(fixItemWindow(_loc3_.window));
               _loc3_.window.id = _loc8_;
               _loc3_.removeIntervalProcedure();
            }
            _loc8_++;
         }
         while(_loc8_ < _loc6_.numGridItems)
         {
            if(_loc9_ = _loc6_.getGridItemAt(_loc8_) as IWindowContainer)
            {
               _loc9_.id = _loc8_;
               _loc9_.removeChildAt(0);
               _loc9_.invalidate();
            }
            _loc8_++;
         }
         updateActionState();
      }
      
      private function fixItemWindow(param1:IWindowContainer) : IWindowContainer
      {
         var _loc2_:int = 0;
         var _loc3_:IWindow = null;
         param1.height = 40;
         param1.width = 40;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            _loc3_.rectangle = new Rectangle(0,0,40,40);
            _loc2_++;
         }
         return param1;
      }
      
      public function clearItemLists() : void
      {
         var _loc3_:IWindowContainer = null;
         var _loc2_:* = 0;
         var _loc1_:IItemGridWindow = null;
         _loc1_ = getOwnUsersItemGrid();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.numGridItems)
         {
            _loc3_ = _loc1_.getGridItemAt(_loc2_) as IWindowContainer;
            if(_loc3_)
            {
               _loc3_.id = _loc2_;
               _loc3_.removeChildAt(0);
            }
            _loc2_++;
         }
         _loc1_ = getOtherUsersItemGrid();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.numGridItems)
         {
            _loc3_ = _loc1_.getGridItemAt(_loc2_) as IWindowContainer;
            if(_loc3_)
            {
               _loc3_.id = _loc2_;
               _loc3_.removeChildAt(0);
            }
            _loc2_++;
         }
      }
      
      public function updateUserInterface() : void
      {
         var _loc2_:ITextWindow = null;
         var _loc1_:IStaticBitmapWrapperWindow = null;
         if(var_1676)
         {
            updateActionState();
            _loc2_ = var_1676.findChildByTag("OTHER_USER_NAME") as ITextWindow;
            if(_loc2_)
            {
               _loc2_.text = var_1635.otherUserName;
            }
            _loc1_ = var_1676.findChildByTag("OWN_USER_LOCK") as IStaticBitmapWrapperWindow;
            if(_loc1_)
            {
               _loc1_.assetUri = var_1635.ownUserAccepts ? "inventory_trading_trading_locked_icon" : "inventory_trading_trading_unlocked_icon";
            }
            _loc1_ = var_1676.findChildByTag("OTHER_USER_LOCK") as IStaticBitmapWrapperWindow;
            if(_loc1_)
            {
               _loc1_.assetUri = var_1635.otherUserAccepts ? "inventory_trading_trading_locked_icon" : "inventory_trading_trading_unlocked_icon";
            }
         }
      }
      
      public function updateActionState() : void
      {
         var _loc1_:IWindow = null;
         var _loc2_:IWindow = null;
         if(var_1676)
         {
            _loc1_ = var_1676.findChildByName("button_accept");
            _loc2_ = var_1676.findChildByName("button_cancel");
            if(var_1635.getInventory().getBoolean("trading.warning.enabled"))
            {
               if(var_1635.isCreditFurniPresent())
               {
                  showHighlightInfo(_localization.getLocalization("inventory.trading.warning.credits","inventory.trading.warning.credits"));
               }
               else
               {
                  showHighlightInfo(null);
               }
            }
            showSilverFeeInfo(var_1635.requiredSilverFee,var_1635.playerSilver,var_1635.otherPlayerSilver);
            showOwnOfferInfo(var_1635.ownUserNumItems,var_1635.ownUserNumCredits);
            showOtherOfferInfo(var_1635.otherUserNumItems,var_1635.otherUserNumCredits);
            switch(int(var_1635.state))
            {
               case 0:
                  if((var_1635.otherUserItems.length > 0 || var_1635.ownUserItems.length > 0) && var_1635.tradeFeeReached())
                  {
                     _loc1_.enable();
                  }
                  else
                  {
                     _loc1_.disable();
                  }
                  _loc1_.caption = "${inventory.trading.accept}";
                  break;
               case 1:
                  if((var_1635.otherUserItems.length > 0 || var_1635.ownUserItems.length > 0) && var_1635.tradeFeeReached())
                  {
                     _loc1_.enable();
                  }
                  else
                  {
                     _loc1_.disable();
                  }
                  _loc1_.caption = var_1635.ownUserAccepts ? "${inventory.trading.modify}" : "${inventory.trading.accept}";
                  showInfoMessage("${inventory.trading.info.add}");
                  break;
               case 2:
                  _loc1_.disable();
                  _loc1_.caption = "${inventory.trading.countdown}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 3:
                  _loc1_.enable();
                  _loc1_.caption = "${inventory.trading.confirm}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 4:
                  _loc1_.disable();
                  showInfoMessage("${inventory.trading.info.waiting}");
                  break;
               case 5:
                  _loc1_.disable();
                  _loc1_.caption = "${inventory.trading.accept}";
                  showInfoMessage("${inventory.trading.info.confirm}");
                  break;
               case 6:
                  break;
               default:
                  throw new Error("Unknown trading progress state: \"" + var_1635.state + "\"");
            }
            Util.disableButton(_loc2_,var_1635.isConfirmingWeb3Trade());
         }
      }
      
      public function showInfoMessage(param1:String) : void
      {
         var _loc2_:ITextWindow = var_1676.findChildByName("help_text") as ITextWindow;
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      private function showHighlightInfo(param1:String) : void
      {
         if(!var_1676)
         {
            return;
         }
         var _loc3_:IWindow = var_1676.findChildByName("info_border_highlighted");
         if(_loc3_)
         {
            _loc3_.visible = param1 != null;
         }
         var _loc2_:ITextWindow = var_1676.findChildByName("info_text_highlighted") as ITextWindow;
         if(_loc2_)
         {
            _loc2_.visible = param1 != null;
            if(param1)
            {
               _loc2_.text = param1;
            }
         }
         resizeWindow();
      }
      
      private function showSilverFeeInfo(param1:int, param2:int, param3:int) : void
      {
         silverFeeContainer.visible = param1 > 0;
         yourSilver.text = String(param2);
         otherSilver.text = String(param3);
         var _loc5_:int = param2 + param3;
         var _loc6_:String = param1 <= _loc5_ ? "000000" : "AC232A";
         silverProgress.text = "<font color=\"#" + _loc6_ + "\">" + _loc5_ + "</font>/" + param1;
         var _loc4_:Boolean = var_1635.state == 0 || var_1635.state == 1;
         Util.disableButton(feeMinusButton,param2 <= 0 || !_loc4_);
         Util.disableButton(feePlusButton,param2 + param3 >= param1 || param2 >= var_1635.getInventory().catalog.getPurse().silverBalance || !_loc4_);
         resizeWindow();
      }
      
      private function resizeWindow(param1:Boolean = true) : void
      {
         Util.moveAllChildrenToColumn(var_1676,7,!param1);
         var_1676.height = Util.getLowestPoint(var_1676);
         var_1635.getInventory().view.resizeToFitContents();
      }
      
      private function showOwnOfferInfo(param1:int, param2:int) : void
      {
         showOfferInfo("content_text_1_a",param1,"content_text_1_b",param2,true);
      }
      
      private function showOtherOfferInfo(param1:int, param2:int) : void
      {
         showOfferInfo("content_text_2_a",param1,"content_text_2_b",param2,false);
      }
      
      private function showOfferInfo(param1:String, param2:int, param3:String, param4:int, param5:Boolean) : void
      {
         var _loc6_:ITextWindow = null;
         if(!var_1635.getInventory().getBoolean("trading.warning.enabled"))
         {
            return;
         }
         if(_loc6_ = var_1676.findChildByName(param1) as ITextWindow)
         {
            _localization.registerParameter("inventory.trading.info.itemcount","value",param2.toString());
            _loc6_.text = _localization.getLocalization("inventory.trading.info.itemcount");
         }
         if(_loc6_ = var_1676.findChildByName(param3) as ITextWindow)
         {
            _localization.registerParameter("inventory.trading.info.creditvalue","value",param4.toString());
            _loc6_.text = _localization.getLocalization("inventory.trading.info.creditvalue");
         }
      }
      
      public function showOwnUserNotification(param1:String) : void
      {
         var _loc3_:ITextWindow = var_1676.findChildByName("info_text_0") as ITextWindow;
         _loc3_.text = param1;
         _loc3_.visible = true;
         var _loc2_:IItemGridWindow = var_1676.findChildByName("item_grid_0") as IItemGridWindow;
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function hideOwnUserNotification() : void
      {
         var _loc2_:ITextWindow = var_1676.findChildByName("info_text_0") as ITextWindow;
         _loc2_.visible = false;
         var _loc1_:IItemGridWindow = var_1676.findChildByName("item_grid_0") as IItemGridWindow;
         if(_loc1_)
         {
            _loc1_.visible = true;
         }
      }
      
      public function showOtherUserNotification(param1:String) : void
      {
         var _loc3_:ITextWindow = var_1676.findChildByName("info_text_1") as ITextWindow;
         _loc3_.text = param1;
         _loc3_.visible = true;
         var _loc2_:IItemGridWindow = var_1676.findChildByName("item_grid_1") as IItemGridWindow;
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function hideOtherUserNotification() : void
      {
         var _loc2_:ITextWindow = var_1676.findChildByName("info_text_1") as ITextWindow;
         _loc2_.visible = false;
         var _loc1_:IItemGridWindow = var_1676.findChildByName("item_grid_1") as IItemGridWindow;
         if(_loc1_)
         {
            _loc1_.visible = true;
         }
      }
      
      public function alertTradeOpenFailed(param1:TradeOpenFailedEvent) : void
      {
         var _loc2_:String = "inventory.trading.openfail." + param1.getParser().reason;
         _windowManager.registerLocalizationParameter(_loc2_,"otherusername",param1.getParser().otherUserName);
         _windowManager.simpleAlert("${inventory.trading.openfail.title}","${inventory.trading.openfail.caption}","${" + _loc2_ + "}");
      }
      
      public function alertPopup(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.warning.other_not_offering}",0,onTradingAlert);
               break;
            case 1:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.info.closed}",0,onTradingAlert);
               break;
            case 2:
               _windowManager.alert("${inventory.trading.notification.title}","${inventory.trading.info.already_open}",0,onTradingAlert);
         }
      }
      
      public function showAlertNotification(param1:String, param2:String, param3:Function) : void
      {
         var title:String = param1;
         var description:String = param2;
         var callback:Function = param3;
         _windowManager.alert(title,description,0,callback != null ? callback : function(param1:class_3348, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      public function startConfirmCountdown() : void
      {
         if(var_1883 == null)
         {
            var_1883 = new Timer(1000,3);
            var_1883.addEventListener("timer",timerEventHandler);
         }
         var_1883.reset();
         var_1883.repeatCount = 3;
         var_1883.start();
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter","3");
         updateUserInterface();
      }
      
      public function cancelConfirmCountdown() : void
      {
         if(var_1883 != null)
         {
            var_1883.reset();
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc4_:GroupItem = null;
         var _loc6_:Map = null;
         var _loc3_:Boolean = false;
         var _loc5_:* = 0;
         _loc6_ = var_1635.ownUserItems;
         _loc3_ = false;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            if((_loc4_ = _loc6_.getWithIndex(_loc5_) as GroupItem).iconCallbackId == param1)
            {
               _loc4_.iconImage = param2;
               _loc3_ = true;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            updateItemList(var_1635.ownUserId);
         }
         _loc6_ = var_1635.otherUserItems;
         _loc3_ = false;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            if((_loc4_ = _loc6_[_loc5_] as GroupItem).iconCallbackId == param1)
            {
               _loc4_.iconImage = param2;
               _loc3_ = true;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            updateItemList(var_1635.otherUserId);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function setSelection(param1:GroupItem) : void
      {
         removeSelection();
         if(param1)
         {
            _selection = param1;
            _selection.isSelected = true;
         }
      }
      
      public function removeSelection() : void
      {
         if(_selection)
         {
            _selection.isSelected = false;
            _selection = null;
         }
      }
      
      public function updateItemImage(param1:int, param2:BitmapData) : void
      {
      }
      
      public function onTradingAlert(param1:class_3348, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            param1.dispose();
         }
      }
      
      protected function getOwnUsersItemGrid() : IItemGridWindow
      {
         return var_1676.findChildByTag("OWN_USER_GRID") as IItemGridWindow;
      }
      
      protected function getOtherUsersItemGrid() : IItemGridWindow
      {
         return var_1676.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
      }
      
      protected function resolveItemThumbnail(param1:GroupItem) : BitmapData
      {
         var _loc3_:class_3499 = null;
         var _loc2_:BitmapData = param1.iconImage;
         if(_loc2_ == null)
         {
            if(param1.isWallItem)
            {
               _loc3_ = _roomEngine.getWallItemIcon(param1.type,this,param1.stuffData.getLegacyString());
            }
            else
            {
               _loc3_ = _roomEngine.getFurnitureIcon(param1.type,this,null,param1.stuffData);
            }
            if(_loc3_.id > 0)
            {
               param1.iconCallbackId = _loc3_.id;
            }
            _loc2_ = _loc3_.data;
            param1.iconImage = _loc2_;
         }
         return _loc2_;
      }
      
      protected function createThumbnailContainer() : IWindowContainer
      {
         var _loc1_:XML = XmlAsset(var_2286.getAssetByName("inventory_thumb_xml")).content as XML;
         return _windowManager.buildFromXML(_loc1_) as IWindowContainer;
      }
      
      protected function selectOwnTradeItem(param1:uint) : void
      {
         var _loc2_:GroupItem = null;
         if(var_1635 == null || var_1635.ownUserItems == null)
         {
            return;
         }
         if(param1 < var_1635.ownUserItems.length)
         {
            _loc2_ = var_1635.ownUserItems.getWithIndex(param1) as GroupItem;
            setSelection(_loc2_);
            if(_loc2_)
            {
               var_1635.getFurniInventoryModel().displayItemInfo(_loc2_);
            }
         }
      }
      
      protected function selectOthersTradeItem(param1:uint) : void
      {
         var _loc2_:GroupItem = null;
         if(var_1635 == null || var_1635.otherUserItems == null)
         {
            return;
         }
         if(param1 < var_1635.otherUserItems.length)
         {
            _loc2_ = var_1635.otherUserItems.getWithIndex(param1) as GroupItem;
            setSelection(_loc2_);
            if(_loc2_)
            {
               var_1635.getFurniInventoryModel().displayItemInfo(_loc2_);
            }
         }
      }
      
      private function createNormalWindow() : IWindowContainer
      {
         var _loc2_:IWindow = null;
         var _loc3_:* = null;
         var _loc5_:* = 0;
         var _loc4_:IItemGridWindow = null;
         var _loc1_:XML = XmlAsset(var_2286.getAssetByName("inventory_trading_xml")).content as XML;
         var _loc6_:IWindowContainer;
         _loc4_ = (_loc6_ = _windowManager.buildFromXML(_loc1_) as IWindowContainer).findChildByTag("OWN_USER_GRID") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.numGridItems)
         {
            _loc2_ = _loc4_.getGridItemAt(_loc5_);
            _loc2_.id = _loc5_;
            _loc2_.procedure = ownThumbEventProc;
            _loc2_.addEventListener("WME_OVER",ownThumbEventProc);
            _loc2_.addEventListener("WME_OUT",ownThumbEventProc);
            _loc5_++;
         }
         _loc4_ = _loc6_.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.numGridItems)
         {
            _loc2_ = _loc4_.getGridItemAt(_loc5_);
            _loc2_.id = _loc5_;
            _loc2_.procedure = othersThumbEventProc;
            _loc2_.addEventListener("WME_OVER",othersThumbEventProc);
            _loc2_.addEventListener("WME_OUT",othersThumbEventProc);
            _loc5_++;
         }
         _loc6_.procedure = windowEventProc;
         return _loc6_;
      }
      
      private function createMinimizedWindow() : IWindowContainer
      {
         var _loc1_:XML = XmlAsset(var_2286.getAssetByName("inventory_trading_minimized_xml")).content as XML;
         var _loc2_:IWindowContainer = _windowManager.buildFromXML(_loc1_) as IWindowContainer;
         _loc2_.procedure = windowMininizedEventProc;
         return _loc2_;
      }
      
      private function windowMininizedEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_continue":
                  var_1635.requestFurniViewOpen();
                  break;
               case "button_cancel":
                  var_1635.requestCancelTrading();
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_accept":
                  switch(int(var_1635.state) - 1)
                  {
                     case 0:
                        if(var_1635.otherUserItems.length == 0 && !var_1635.ownUserAccepts)
                        {
                           alertPopup(0);
                        }
                        if(var_1635.ownUserAccepts)
                        {
                           var_1635.requestUnacceptTrading();
                        }
                        else
                        {
                           var_1635.requestAcceptTrading();
                        }
                        break;
                     case 2:
                        param2.disable();
                        var_1635.requestConfirmAcceptTrading();
                  }
                  break;
               case "button_cancel":
                  switch(int(var_1635.state) - 1)
                  {
                     case 0:
                        var_1635.requestCancelTrading();
                        break;
                     case 2:
                        var_1635.requestConfirmDeclineTrading();
                  }
                  break;
               case "silver_minus_button":
                  var_1635.addSilverFee(false);
                  break;
               case "silver_plus_button":
                  var_1635.addSilverFee(true);
            }
         }
      }
      
      private function ownThumbEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         thumbEventProc(param1,param2,true);
      }
      
      private function othersThumbEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         thumbEventProc(param1,param2,false);
      }
      
      private function thumbEventProc(param1:WindowEvent, param2:IWindow, param3:Boolean) : void
      {
         var _loc8_:GroupItem = null;
         var _loc5_:FurnitureItem = null;
         var _loc4_:CreditTradingItem = null;
         var _loc6_:BitmapData = null;
         var _loc7_:String = null;
         var _loc10_:FurnitureItem = null;
         var _loc9_:Date = null;
         if(param3 && param1.type == "WME_CLICK")
         {
            var_1635.requestRemoveItemFromTrading(param2.id);
         }
         if(param1.type == "WME_OVER")
         {
            if(param3)
            {
               _loc8_ = var_1635.ownUserItems.getWithIndex(param2.id);
            }
            else
            {
               _loc8_ = var_1635.otherUserItems.getWithIndex(param2.id);
            }
            if(_loc8_ == null)
            {
               return;
            }
            if((_loc4_ = _loc8_ as CreditTradingItem) != null && !param3)
            {
               var_2190.updateContent(param2 as IWindowContainer,_loc4_.getItemTooltipText(),_loc4_.getItemIcon(),null,2,false);
               var_2190.show();
               return;
            }
            if((_loc5_ = _loc8_.peek()) == null)
            {
               return;
            }
            _loc6_ = var_1635.getItemImage(_loc5_);
            if(!_loc5_.isWallItem)
            {
               _loc7_ = "${roomItem.name." + _loc5_.type + "}";
            }
            else
            {
               _loc7_ = "${wallItem.name." + _loc5_.type + "}";
            }
            if(_loc5_.category == 6)
            {
               _loc7_ = "${poster_" + _loc5_.stuffData.getLegacyString() + "_name}";
            }
            if(_loc5_.category == 10)
            {
               _loc10_ = _loc5_ as FurnitureItem;
               _loc9_ = new Date(_loc10_.creationYear,_loc10_.creationMonth - 1,_loc10_.creationDay);
               _loc7_ = _localization.getLocalization("roomItem.name." + _loc5_.type) + " " + _loc9_.toLocaleDateString();
            }
            if(_loc5_.category == 8)
            {
               _loc7_ = getTraxSongFurniName(_loc8_,_loc7_,true,param2.id,param3);
            }
            var_2190.updateContent(param2 as IWindowContainer,_loc7_,_loc6_,_loc8_.peek().stuffData,2,isExternalImagetype(_loc5_));
            var_2190.show();
         }
         else if(param1.type == "WME_OUT")
         {
            var_2190.hideDelayed();
         }
      }
      
      private function isExternalImagetype(param1:FurnitureItem) : Boolean
      {
         if(!var_1635.getInventory())
         {
            return false;
         }
         var _loc2_:class_3365 = var_1635.getInventory().getFurnitureData(param1.type,"i");
         return _loc2_ && _loc2_.isExternalImageType;
      }
      
      private function getTraxSongFurniName(param1:GroupItem, param2:String, param3:Boolean, param4:int = -1, param5:Boolean = false) : String
      {
         var _loc6_:class_3393 = param1.peek();
         var _loc7_:ISongInfo;
         if((_loc7_ = _soundManager.musicController.getSongInfo(_loc6_.extra)) != null)
         {
            _localization.registerParameter("songdisc.info","name",_loc7_.name);
            _localization.registerParameter("songdisc.info","author",_loc7_.creator);
            param2 = String(_localization.getLocalization("songdisc.info"));
         }
         else if(param3)
         {
            if(_waitingSongInfo.length > 0)
            {
               _waitingSongInfo.pop();
               _waitingSongInfo.pop();
               _waitingSongInfo.pop();
            }
            _waitingSongInfo.push(param4);
            _waitingSongInfo.push(param1);
            _waitingSongInfo.push(param5);
            _soundManager.musicController.requestSongInfoWithoutSamples(_loc6_.extra);
         }
         return param2;
      }
      
      private function timerEventHandler(param1:TimerEvent) : void
      {
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter",String(3 - var_1883.currentCount));
         if(var_1883.currentCount == 3)
         {
            var_1635.confirmCountdownReady();
            var_1883.reset();
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc8_:Boolean = false;
         var _loc6_:GroupItem = null;
         var _loc7_:* = 0;
         var _loc3_:FurnitureItem = null;
         var _loc4_:String = null;
         var _loc5_:BitmapData = null;
         var _loc2_:IWindow = null;
         if(_waitingSongInfo.length > 0)
         {
            _loc8_ = _waitingSongInfo.pop();
            _loc6_ = _waitingSongInfo.pop();
            _loc7_ = _waitingSongInfo.pop();
            _loc3_ = _loc6_.peek();
            if(_loc3_.extra == param1.id)
            {
               if(_loc8_ && var_1635.ownUserItems.getWithIndex(_loc7_) == _loc6_ || !_loc8_ && var_1635.otherUserItems.getWithIndex(_loc7_) == _loc6_)
               {
                  _loc4_ = getTraxSongFurniName(_loc6_,"",false);
                  _loc5_ = var_1635.getItemImage(_loc3_);
                  _loc2_ = _loc8_ ? getOwnUsersItemGrid().getGridItemAt(_loc7_) : getOtherUsersItemGrid().getGridItemAt(_loc7_);
                  var_2190.updateContent(_loc2_ as IWindowContainer,_loc4_,_loc5_);
               }
            }
            else
            {
               _waitingSongInfo.push(_loc7_);
               _waitingSongInfo.push(_loc6_);
               _waitingSongInfo.push(_loc8_);
            }
         }
      }
      
      private function get silverFeeContainer() : IWindowContainer
      {
         return var_1676.findChildByName("silver_container") as IWindowContainer;
      }
      
      private function get yourSilver() : ITextWindow
      {
         return silverFeeContainer.findChildByName("your_silver") as ITextWindow;
      }
      
      private function get otherSilver() : ITextWindow
      {
         return silverFeeContainer.findChildByName("other_silver") as ITextWindow;
      }
      
      private function get silverProgress() : class_3404
      {
         return silverFeeContainer.findChildByName("silver_progress_html") as class_3404;
      }
      
      private function get feeMinusButton() : IIconButtonWindow
      {
         return silverFeeContainer.findChildByName("silver_minus_button") as IIconButtonWindow;
      }
      
      private function get feePlusButton() : IIconButtonWindow
      {
         return silverFeeContainer.findChildByName("silver_plus_button") as IIconButtonWindow;
      }
   }
}
