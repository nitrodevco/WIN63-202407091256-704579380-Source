package com.sulake.habbo.catalog.collectibles.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftTransferFeeMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftTransferAssetsResultMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferFeeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferAssetsResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftTransferFeeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftTransferAssetsMessageComposer;
   
   public class TransferNftsWidget implements IUpdateReceiver
   {
       
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2396:CollectiblesView;
      
      private var var_1704:IWindowContainer;
      
      private var var_1754:CollectiblesController;
      
      private var var_3804:Boolean;
      
      private var var_3917:Boolean;
      
      private var var_3502:int;
      
      private var _isTransferring:Boolean;
      
      private var var_3643:Array;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      public function TransferNftsWidget(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_2396 = param1;
         var_1754 = param2;
         var_1704 = var_2396.window.findChildByName("transferContainer") as IWindowContainer;
         _loadingIcon = IStaticBitmapWrapperWindow(var_1704.findChildByName("loading_icon"));
         addMessageEvents();
         initializeData();
         updateReadyState();
         updateTransferButtonState();
         param2.registerUpdateReceiver(this,1);
         transferButton.addEventListener("WME_CLICK",onTransferClicked);
         transferWalletSelection.addEventListener("WE_SELECTED",onSelectWallet);
      }
      
      private function onSelectWallet(param1:WindowEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = transferWalletSelection.selection;
         if(_loc3_ >= 0)
         {
            _loc2_ = String(transferWalletSelection.enumerateSelection()[_loc3_]);
            if(_loc2_.length > 32)
            {
               transferWalletSelection.caption = _loc2_.substring(0,32) + "...";
            }
         }
         updateReadyState();
      }
      
      private function addMessageEvents() : void
      {
         if(!var_1754)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new NftTransferFeeMessageEvent(onNftTransferFeeMessage));
         _messageEvents.push(new NftTransferAssetsResultMessageEvent(onNftTransferResultMessage));
         for each(var _loc1_ in _messageEvents)
         {
            var_1754.addMessageEvent(_loc1_);
         }
      }
      
      private function onNftTransferFeeMessage(param1:NftTransferFeeMessageEvent) : void
      {
         var_3804 = false;
         var _loc2_:NftTransferFeeMessageEventParser = param1.getParser();
         var_3502 = _loc2_.transferFee;
         silverFeeText.text = String(var_3502);
         silverFeeText.visible = var_3502 > 0;
         silverIcon.visible = var_3502 > 0;
         updateReadyState();
         updateTransferButtonState();
      }
      
      private function updateReadyState() : void
      {
         loadedContainer.visible = isReady;
         loadingContainer.visible = !isReady;
      }
      
      private function updateTransferButtonState() : void
      {
         var _loc1_:* = var_3502 <= var_1754.catalog.getPurse().silverBalance;
         var _loc2_:Boolean = var_2396.stardustWallet != null && var_2396.stardustWallet != "";
         var _loc4_:* = !_isTransferring;
         var _loc3_:* = selectedWallet != null;
         if(_loc1_ && _loc2_ && _loc4_ && _loc3_)
         {
            transferButton.enable();
         }
         else
         {
            transferButton.disable();
         }
      }
      
      public function onSilverBalanceUpdated() : void
      {
         updateTransferButtonState();
      }
      
      private function onTransferClicked(param1:WindowMouseEvent) : void
      {
         transferButton.disable();
         var _loc2_:class_3441 = var_1754.windowManager.confirm("${collectibles.transfer}","${collectibles.transfer.confirm}",0,onTransferConfirm);
         _loc2_.titleBarColor = 2763306;
      }
      
      private function onTransferConfirm(param1:class_3441, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _isTransferring = true;
            var_1754.send(new NftTransferAssetsMessageComposer(selectedWallet));
         }
         updateTransferButtonState();
      }
      
      private function onNftTransferResultMessage(param1:NftTransferAssetsResultMessageEvent) : void
      {
         var _loc2_:NftTransferAssetsResultMessageEventParser = param1.getParser();
         var_1754.notifications.addItem(_loc2_.success ? localization.getLocalization("collectibles.transfer.success") : String(localization.getLocalizationWithParams("collectibles.transfer.error","","id",_loc2_.resultCode)),"info","icon_curator_stamp_large_png");
         _isTransferring = false;
         updateTransferButtonState();
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         initializeTransferWallets(param1);
      }
      
      private function initializeTransferWallets(param1:Array) : void
      {
         transferWalletSelection.populate(param1);
         var_3643 = param1;
         if(param1.length == 0)
         {
            transferWalletSelection.color = 13421772;
            transferWalletSelection.disable();
         }
         else
         {
            transferWalletSelection.color = 16777215;
            transferWalletSelection.enable();
            transferWalletSelection.selection = 0;
         }
         var_3917 = false;
         updateReadyState();
         updateTransferButtonState();
      }
      
      private function get selectedWallet() : String
      {
         if(var_3643 == null)
         {
            return null;
         }
         var _loc1_:int = transferWalletSelection.selection;
         if(_loc1_ < 0 || _loc1_ >= var_3643.length)
         {
            return null;
         }
         return var_3643[_loc1_];
      }
      
      private function initializeData() : void
      {
         var_3804 = true;
         var_1754.send(new GetNftTransferFeeMessageComposer());
         var _loc1_:Array = var_2396.walletAddresses;
         if(_loc1_)
         {
            initializeTransferWallets(_loc1_);
         }
         var_3917 = _loc1_ == null;
      }
      
      private function get isReady() : Boolean
      {
         return !var_3917 && !var_3804;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return var_1754.localizationManager;
      }
      
      private function removeMessageEvents() : void
      {
         if(!var_1754 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            var_1754.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         removeMessageEvents();
         var_1754.removeUpdateReceiver(this);
         super.dispose();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         if(!isReady)
         {
            _loc2_ = CollectionsWidget.var_4332 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      private function get loadingContainer() : IWindowContainer
      {
         return var_1704.findChildByName("loading_contents") as IWindowContainer;
      }
      
      private function get loadedContainer() : IWindowContainer
      {
         return var_1704.findChildByName("loaded_content") as IWindowContainer;
      }
      
      private function get silverFeeText() : ITextWindow
      {
         return var_1704.findChildByName("transfer_fee_text") as ITextWindow;
      }
      
      private function get transferButton() : class_3357
      {
         return var_1704.findChildByName("transfer_button") as class_3357;
      }
      
      private function get transferWalletSelection() : class_3520
      {
         return var_1704.findChildByName("transfer_wallet_selection") as class_3520;
      }
      
      private function get silverIcon() : IStaticBitmapWrapperWindow
      {
         return var_1704.findChildByName("transfer_fee_icon") as IStaticBitmapWrapperWindow;
      }
   }
}
