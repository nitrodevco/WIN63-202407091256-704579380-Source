package com.sulake.habbo.inventory.trading
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_3393;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1604;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverFeeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverSetMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.SilverFeeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_376;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_409;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_511;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_519;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_669;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_720;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_791;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_822;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_845;
   
   public class TradingModel implements IInventoryModel, IGetImageListener
   {
      
      public static const MAX_ITEMS_TO_TRADE:uint = 9;
      
      public static const TRADING_STATE_READY:uint = 0;
      
      public static const TRADING_STATE_RUNNING:uint = 1;
      
      public static const TRADING_STATE_COUNTDOWN:uint = 2;
      
      public static const TRADING_STATE_CONFIRMING:uint = 3;
      
      public static const TRADING_STATE_CONFIRMED:uint = 4;
      
      public static const TRADING_STATE_COMPLETED:uint = 5;
      
      public static const TRADING_STATE_CANCELLED:uint = 6;
       
      
      private var _inventory:HabboInventory;
      
      private var var_2286:IAssetLibrary;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _soundManager:class_2240;
      
      private var var_1678:TradingView;
      
      private var _notifications:IHabboNotifications;
      
      private var _disposed:Boolean = false;
      
      private var var_92:Boolean = false;
      
      private var var_149:uint = 0;
      
      private var var_2877:int = -1;
      
      private var _ownUserName:String = "";
      
      private var _ownUserItems:Map;
      
      private var _ownUserNumItems:int = 0;
      
      private var var_3411:int = 0;
      
      private var var_2474:Boolean = false;
      
      private var var_4794:Boolean = false;
      
      private var var_3941:int = -1;
      
      private var _otherUserName:String = "";
      
      private var _otherUserItems:Map;
      
      private var _otherUserNumItems:int = 0;
      
      private var var_3330:int = 0;
      
      private var var_2978:Boolean = false;
      
      private var var_612:Boolean = false;
      
      private var var_3366:int = 0;
      
      private var var_563:int = 0;
      
      private var var_502:int = 0;
      
      public function TradingModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IRoomEngine, param6:IHabboLocalizationManager, param7:class_2240, param8:IHabboNotifications)
      {
         super();
         _inventory = param1;
         _communication = param3;
         var_2286 = param4;
         _roomEngine = param5;
         _localization = param6;
         _soundManager = param7;
         var_1678 = new TradingView(this,param2,param4,param5,param6,param7);
         _notifications = param8;
      }
      
      public static function getGuildFurniType(param1:int, param2:IStuffData) : String
      {
         var _loc5_:int = 0;
         var _loc4_:String = param1.toString();
         var _loc3_:StringArrayStuffData = param2 as StringArrayStuffData;
         if(!_loc3_)
         {
            return _loc4_;
         }
         _loc5_ = 1;
         while(_loc5_ < 5)
         {
            _loc4_ += "," + _loc3_.getValue(_loc5_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function get running() : Boolean
      {
         return var_149 != 0;
      }
      
      public function get state() : uint
      {
         return var_149;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get ownUserId() : int
      {
         return var_2877;
      }
      
      public function get ownUserName() : String
      {
         return _ownUserName;
      }
      
      public function get ownUserItems() : Map
      {
         return _ownUserItems;
      }
      
      public function get ownUserAccepts() : Boolean
      {
         return var_2474;
      }
      
      public function get ownUserCanTrade() : Boolean
      {
         return var_4794;
      }
      
      public function get otherUserId() : int
      {
         return var_3941;
      }
      
      public function get otherUserName() : String
      {
         return _otherUserName;
      }
      
      public function get otherUserItems() : Map
      {
         return _otherUserItems;
      }
      
      public function get otherUserAccepts() : Boolean
      {
         return var_2978;
      }
      
      public function get otherUserCanTrade() : Boolean
      {
         return var_612;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1678 && !var_1678.disposed)
            {
               var_1678.dispose();
               var_1678 = null;
            }
            _inventory = null;
            _communication = null;
            var_2286 = null;
            _roomEngine = null;
            _localization = null;
            _disposed = true;
         }
      }
      
      public function startTrading(param1:int, param2:String, param3:Boolean, param4:int, param5:String, param6:Boolean) : void
      {
         var_2877 = param1;
         _ownUserName = param2;
         _ownUserItems = new Map();
         var_2474 = false;
         var_4794 = param3;
         var_3941 = param4;
         _otherUserName = param5;
         _otherUserItems = new Map();
         var_2978 = false;
         var_612 = param6;
         var_3366 = 0;
         var_563 = 0;
         var_502 = 0;
         var_92 = true;
         state = 1;
         var_1678.setup(param1,param3,param4,param6);
         var_1678.updateItemList(var_2877);
         var_1678.updateItemList(var_3941);
         var_1678.updateUserInterface();
         var_1678.clearItemLists();
         _inventory.toggleInventoryPage("furni");
         _inventory.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_TRADING"));
      }
      
      public function close() : void
      {
         if(var_92)
         {
            if(var_149 != 0 && var_149 != 5)
            {
               requestCancelTrading();
               state = 6;
            }
            state = 0;
            _inventory.toggleInventorySubPage("empty");
            var_92 = false;
         }
         var_1678.setMinimized(false);
      }
      
      public function isConfirmingWeb3Trade() : Boolean
      {
         return requiredSilverFee > 0 && var_149 == 4;
      }
      
      public function categorySwitch(param1:String) : void
      {
         var_1678.setMinimized(param1 != "furni");
         _inventory.updateSubView();
      }
      
      public function set state(param1:uint) : void
      {
         class_14.log("OLD STATE: " + var_149 + " NEW STATE: " + param1 + " OWN: " + var_2474 + " OTHER: " + var_2978);
         var _loc2_:Boolean = false;
         if(var_149 == param1)
         {
            return;
         }
         switch(int(var_149))
         {
            case 0:
               if(param1 == 1 || param1 == 5)
               {
                  var_149 = param1;
                  _loc2_ = true;
               }
               break;
            case 1:
               if(param1 == 2)
               {
                  var_149 = param1;
                  _loc2_ = true;
                  startConfirmCountdown();
               }
               else if(param1 == 6)
               {
                  var_149 = param1;
                  var_1678.setMinimized(false);
                  _loc2_ = true;
               }
               break;
            case 2:
               if(param1 == 3)
               {
                  var_149 = param1;
                  _loc2_ = true;
               }
               else if(param1 == 6)
               {
                  var_149 = param1;
                  var_1678.setMinimized(false);
                  _loc2_ = true;
               }
               else if(param1 == 1)
               {
                  var_149 = param1;
                  _loc2_ = true;
                  cancelConfirmCountdown();
               }
               break;
            case 3:
               if(param1 == 4)
               {
                  var_149 = param1;
                  _loc2_ = true;
               }
               else if(param1 == 5)
               {
                  var_149 = param1;
                  _loc2_ = true;
                  close();
               }
               else if(param1 == 6)
               {
                  var_149 = param1;
                  var_1678.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               break;
            case 4:
               if(param1 == 5)
               {
                  var_149 = param1;
                  var_1678.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               else if(param1 == 6)
               {
                  var_149 = param1;
                  var_1678.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               break;
            case 5:
               if(param1 == 0)
               {
                  var_149 = param1;
                  _loc2_ = true;
               }
               break;
            case 6:
               if(param1 == 0)
               {
                  var_149 = param1;
                  _loc2_ = true;
               }
               else if(param1 == 1)
               {
                  var_149 = param1;
                  _loc2_ = true;
               }
               break;
            default:
               throw new Error("Unknown trading progress state: \"" + var_149 + "\"");
         }
         if(_loc2_)
         {
            var_1678.updateUserInterface();
            return;
         }
         throw new Error("Error assigning trading process status! States does not match: (from) " + var_149 + " (to) " + param1);
      }
      
      public function getFurniInventoryModel() : FurniModel
      {
         return _inventory.furniModel;
      }
      
      public function getInventory() : HabboInventory
      {
         return _inventory;
      }
      
      public function updateItemGroupMaps(param1:TradingItemListEvent, param2:Map, param3:Map) : void
      {
         if(_inventory == null)
         {
            return;
         }
         if(_ownUserItems != null)
         {
            _ownUserItems.dispose();
         }
         if(_otherUserItems != null)
         {
            _otherUserItems.dispose();
         }
         if(param1.firstUserID == var_2877)
         {
            _ownUserItems = param2;
            _ownUserNumItems = param1.firstUserNumItems;
            var_3411 = param1.firstUserNumCredits;
            _otherUserItems = param3;
            _otherUserNumItems = param1.secondUserNumItems;
            var_3330 = param1.secondUserNumCredits;
         }
         else
         {
            _ownUserItems = param3;
            _ownUserNumItems = param1.secondUserNumItems;
            var_3411 = param1.secondUserNumCredits;
            _otherUserItems = param2;
            _otherUserNumItems = param1.firstUserNumItems;
            var_3330 = param1.firstUserNumCredits;
         }
         var_2474 = false;
         var_2978 = false;
         var_1678.updateItemList(var_2877);
         var_1678.updateItemList(var_3941);
         var_1678.updateUserInterface();
         var _loc4_:FurniModel;
         if((_loc4_ = _inventory.furniModel) != null)
         {
            _loc4_.updateItemLocks();
         }
      }
      
      public function getOwnItemIdsInTrade() : Array
      {
         var _loc5_:GroupItem = null;
         var _loc2_:class_3393 = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         if(_ownUserItems == null || _ownUserItems.disposed)
         {
            return _loc1_;
         }
         _loc3_ = 0;
         while(_loc3_ < _ownUserItems.length)
         {
            if((_loc5_ = _ownUserItems.getWithIndex(_loc3_) as GroupItem) != null)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc5_.getTotalCount())
               {
                  _loc2_ = _loc5_.getAt(_loc4_);
                  if(_loc2_ != null)
                  {
                     _loc1_.push(_loc2_.ref);
                  }
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get ownUserNumItems() : int
      {
         return _ownUserNumItems;
      }
      
      public function get ownUserNumCredits() : int
      {
         return var_3411;
      }
      
      public function get otherUserNumItems() : int
      {
         return _otherUserNumItems;
      }
      
      public function get otherUserNumCredits() : int
      {
         return var_3330;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return var_1678.getWindowContainer();
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
         if(var_92)
         {
            if(var_149 != 0)
            {
               requestCancelTrading();
            }
         }
      }
      
      public function closingInventoryView() : void
      {
         if(var_92)
         {
            if(isConfirmingWeb3Trade())
            {
               _notifications.addItem(_localization.getLocalization("tradingdialog.minimize_web3"),"info","icon_curator_stamp_large_png");
            }
            else
            {
               close();
            }
         }
      }
      
      public function startConfirmCountdown() : void
      {
         var_1678.startConfirmCountdown();
      }
      
      public function cancelConfirmCountdown() : void
      {
         var_1678.cancelConfirmCountdown();
      }
      
      public function confirmCountdownReady() : void
      {
         if(var_149 == 2)
         {
            state = 3;
         }
      }
      
      public function getItemImage(param1:FurnitureItem) : BitmapData
      {
         var _loc2_:class_3499 = null;
         if(!param1.isWallItem)
         {
            _loc2_ = _roomEngine.getFurnitureImage(param1.type,new Vector3d(180,0,0),64,this,0,String(param1.extra),-1,-1,param1.stuffData);
         }
         else
         {
            _loc2_ = _roomEngine.getWallItemImage(param1.type,new Vector3d(180,0,0),64,this,0,param1.stuffData.getLegacyString());
         }
         return _loc2_.data as BitmapData;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var_1678.updateItemImage(param1,param2);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function handleMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:TradingCloseEvent = null;
         var _loc4_:TradeSilverSetMessageEvent = null;
         var _loc3_:class_1604 = null;
         var _loc5_:TradeSilverFeeMessageEvent = null;
         if(param1 is TradeOpenFailedEvent)
         {
            class_14.log("TRADING::TradingOpenFailedEvent");
            if(TradeOpenFailedEvent(param1).getParser().reason == 7 || TradeOpenFailedEvent(param1).getParser().reason == 8)
            {
               var_1678.alertPopup(2);
            }
            else
            {
               var_1678.alertTradeOpenFailed(TradeOpenFailedEvent(param1));
            }
         }
         else if(param1 is TradingAcceptEvent)
         {
            class_14.log("TRADING::TradingAcceptEvent");
            if(TradingAcceptEvent(param1).userID == var_2877)
            {
               var_2474 = TradingAcceptEvent(param1).userAccepts != 0;
            }
            else
            {
               var_2978 = TradingAcceptEvent(param1).userAccepts != 0;
            }
            var_1678.updateUserInterface();
         }
         else if(param1 is TradingConfirmationEvent)
         {
            class_14.log("TRADING::TradingConfirmationEvent");
            state = 2;
         }
         else if(param1 is TradingCompletedEvent)
         {
            class_14.log("TRADING::TradingCompletedEvent");
            if(isConfirmingWeb3Trade())
            {
               _notifications.addItem(_localization.getLocalization("tradingdialog.done_messsage"),"info","icon_curator_stamp_large_png");
            }
            state = 5;
         }
         else if(param1 is TradingCloseEvent)
         {
            class_14.log("TRADING::TradingCloseEvent");
            if(!var_92)
            {
               class_14.log("Received TradingCloseEvent, but trading already stopped!!!");
               return;
            }
            _loc2_ = param1 as TradingCloseEvent;
            if(_loc2_.getParser().reason == 1)
            {
               if(_inventory.getBoolean("trading.commiterror.enabled"))
               {
                  var_1678.windowManager.simpleAlert("${inventory.trading.notification.title}","${inventory.trading.notification.commiterror.caption}","${inventory.trading.notification.commiterror.info}");
               }
            }
            else if(_loc2_.getParser().userID != var_2877)
            {
               var_1678.alertPopup(1);
            }
            close();
         }
         else if(param1 is TradingNotOpenEvent)
         {
            class_14.log("TRADING::TradingNotOpenEvent");
         }
         else if(param1 is TradingOtherNotAllowedEvent)
         {
            var_1678.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
         }
         else if(param1 is TradingYouAreNotAllowedEvent)
         {
            var_1678.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
         }
         else if(param1 is TradeSilverSetMessageEvent)
         {
            _loc3_ = (_loc4_ = param1 as TradeSilverSetMessageEvent).getParser();
            var_563 = _loc3_.playerSilver;
            var_502 = _loc3_.otherPlayerSilver;
            var_1678.updateUserInterface();
         }
         else if(param1 is TradeSilverFeeMessageEvent)
         {
            var_3366 = (_loc5_ = param1 as TradeSilverFeeMessageEvent).getParser().silverFee;
            var_1678.updateUserInterface();
         }
         else
         {
            class_14.log("TRADING/Unknown message event: " + param1);
         }
      }
      
      public function tradeFeeReached() : Boolean
      {
         return var_563 + var_502 >= var_3366;
      }
      
      public function requestFurniViewOpen() : void
      {
         _inventory.toggleInventoryPage("furni");
      }
      
      public function requestOpenTrading(param1:int) : void
      {
         _communication.connection.send(new class_409(param1));
      }
      
      public function requestAddItemsToTrading(param1:Vector.<int>, param2:Boolean, param3:int, param4:int, param5:Boolean, param6:IStuffData) : void
      {
         var _loc8_:* = undefined;
         if(!param5 && param1.length > 0)
         {
            _communication.connection.send(new class_822(param1.pop()));
         }
         else
         {
            _loc8_ = new Vector.<int>();
            for each(var _loc7_ in param1)
            {
               if(canAddItemToTrade(param2,param3,param4,param5,param6))
               {
                  _loc8_.push(_loc7_);
               }
            }
            if(_loc8_.length > 0)
            {
               if(_loc8_.length == 1)
               {
                  _communication.connection.send(new class_822(_loc8_.pop()));
               }
               else
               {
                  _communication.connection.send(new class_376(_loc8_));
               }
            }
         }
      }
      
      public function canAddItemToTrade(param1:Boolean, param2:int, param3:int, param4:Boolean, param5:IStuffData) : Boolean
      {
         var _loc6_:String = null;
         if(var_2474)
         {
            return false;
         }
         if(_ownUserItems == null)
         {
            return false;
         }
         if(_ownUserItems.length < 9)
         {
            return true;
         }
         if(!param4)
         {
            return false;
         }
         _loc6_ = String(param2);
         if(param3 == 6)
         {
            _loc6_ = String(param2) + "poster" + param5.getLegacyString();
         }
         else if(param3 == 17)
         {
            _loc6_ = getGuildFurniType(param2,param5);
         }
         else
         {
            _loc6_ = (param1 ? "I" : "S") + _loc6_;
         }
         return _ownUserItems.getValue(_loc6_) != null;
      }
      
      public function requestRemoveItemFromTrading(param1:int) : void
      {
         var _loc2_:class_3393 = null;
         if(var_2474)
         {
            return;
         }
         var _loc3_:GroupItem = ownUserItems.getWithIndex(param1);
         if(_loc3_)
         {
            _loc2_ = _loc3_.peek();
            if(_loc2_)
            {
               _communication.connection.send(new class_669(_loc2_.id));
            }
         }
      }
      
      public function requestAcceptTrading() : void
      {
         _communication.connection.send(new class_845());
      }
      
      public function requestUnacceptTrading() : void
      {
         _communication.connection.send(new class_791());
      }
      
      public function requestConfirmAcceptTrading() : void
      {
         state = 4;
         _communication.connection.send(new class_511());
      }
      
      public function requestConfirmDeclineTrading() : void
      {
         _communication.connection.send(new class_720());
      }
      
      public function requestCancelTrading() : void
      {
         if(!isConfirmingWeb3Trade())
         {
            _communication.connection.send(new class_519());
         }
      }
      
      public function addSilverFee(param1:Boolean) : void
      {
         _communication.connection.send(new SilverFeeMessageComposer(param1));
      }
      
      public function isCreditFurniPresent() : Boolean
      {
         return var_3411 > 0 || var_3330 > 0;
      }
      
      private function get citizenshipTalentTrackEnabled() : Boolean
      {
         return _inventory.getBoolean("talent.track.citizenship.enabled");
      }
      
      public function updateView() : void
      {
      }
      
      public function selectItemById(param1:String) : void
      {
         class_14.log("NOT SUPPORTED: TRADING VIEW SELECT BY ID");
      }
      
      public function get requiredSilverFee() : int
      {
         return var_3366;
      }
      
      public function get playerSilver() : int
      {
         return var_563;
      }
      
      public function get otherPlayerSilver() : int
      {
         return var_502;
      }
   }
}
