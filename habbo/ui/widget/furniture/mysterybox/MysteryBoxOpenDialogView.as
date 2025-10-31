package com.sulake.habbo.ui.widget.furniture.mysterybox
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.mysterybox.ShowMysteryBoxWaitMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.mysterybox.CancelMysteryBoxWaitMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.mysterybox.GotMysteryBoxPrizeMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.mysterybox.MysteryBoxWaitingCanceledMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.parser.mysterybox.GotMysteryBoxPrizeMessageEventParser;
   
   public class MysteryBoxOpenDialogView implements IDisposable, IGetImageListener
   {
       
      
      private var _disposed:Boolean;
      
      private var var_1629:FurnitureContextMenuWidget;
      
      private var var_1907:IModalDialog;
      
      private var _window:IWindowContainer;
      
      private var var_2060:IRoomObject;
      
      private var var_3369:ShowMysteryBoxWaitMessageEvent;
      
      private var var_3414:CancelMysteryBoxWaitMessageEvent;
      
      private var var_3382:GotMysteryBoxPrizeMessageEvent;
      
      private var var_3115:int = -1;
      
      public function MysteryBoxOpenDialogView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_1629 = param1;
         var_3369 = new ShowMysteryBoxWaitMessageEvent(onShowMysteryBoxWait);
         var_3414 = new CancelMysteryBoxWaitMessageEvent(onCancelMysteryBoxWait);
         var_3382 = new GotMysteryBoxPrizeMessageEvent(onGotMysteryBoxPrize);
         connection.addMessageEvent(var_3369);
         connection.addMessageEvent(var_3414);
         connection.addMessageEvent(var_3382);
      }
      
      private function onShowMysteryBoxWait(param1:ShowMysteryBoxWaitMessageEvent) : void
      {
         showWaitWindow();
      }
      
      private function onCancelMysteryBoxWait(param1:CancelMysteryBoxWaitMessageEvent) : void
      {
         closeWindow();
      }
      
      private function onGotMysteryBoxPrize(param1:GotMysteryBoxPrizeMessageEvent) : void
      {
         var _loc2_:GotMysteryBoxPrizeMessageEventParser = param1.getParser();
         showRewardWindow(_loc2_.contentType,_loc2_.classId);
      }
      
      private function showWaitWindow() : void
      {
         closeWindow();
         var _loc1_:XML = var_1629.assets.getAssetByName("mystery_box_open_dialog").content as XML;
         var_1907 = var_1629.handler.container.windowManager.buildModalDialogFromXML(_loc1_);
         _window = var_1907.rootWindow as IWindowContainer;
         _window.procedure = waitWindowProcedure;
         var _loc4_:Boolean;
         var _loc5_:String = (_loc4_ = var_1629.handler.container.isOwnerOfFurniture(var_2060)) ? "mysterybox.dialog.owner." : "mysterybox.dialog.other.";
         _window.caption = "${" + _loc5_ + "title}";
         _window.findChildByName("subtitle_text").caption = "${" + _loc5_ + "subtitle}";
         _window.findChildByName("waiting_text").caption = "${" + _loc5_ + "waiting}";
         _window.findChildByName("cancel_button").caption = "${" + _loc5_ + "cancel}";
         IStaticBitmapWrapperWindow(_window.findChildByName("reward_base")).assetUri = _loc4_ ? "mysterybox_box_base" : "mysterybox_key_base";
         IStaticBitmapWrapperWindow(_window.findChildByName("reward_overlay")).assetUri = _loc4_ ? "mysterybox_box_overlay" : "mysterybox_key_overlay";
         IStaticBitmapWrapperWindow(_window.findChildByName("needed_base")).assetUri = _loc4_ ? "mysterybox_key_base" : "mysterybox_box_base";
         IStaticBitmapWrapperWindow(_window.findChildByName("needed_overlay")).assetUri = _loc4_ ? "mysterybox_key_overlay" : "mysterybox_box_overlay";
         var _loc6_:ISessionDataManager = var_1629.handler.container.sessionDataManager;
         var _loc2_:String = _loc4_ ? _loc6_.mysteryBoxColor : _loc6_.mysteryKeyColor;
         if(_loc2_ == null || _loc2_ == "")
         {
            return;
         }
         var _loc3_:uint = uint(MysteryBoxToolbarExtension.KEY_COLORS[_loc2_.toLowerCase()]);
         _window.findChildByName("reward_base").color = _loc3_;
         _window.findChildByName("needed_base").color = _loc3_;
      }
      
      private function waitWindowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               closeWindow();
               connection.send(new MysteryBoxWaitingCanceledMessageComposer(var_1629.handler.container.getFurnitureOwnerId(var_2060)));
         }
      }
      
      private function showRewardWindow(param1:String, param2:int) : void
      {
         closeWindow();
         var _loc3_:XML = var_1629.assets.getAssetByName("mystery_box_reward").content as XML;
         var_1907 = var_1629.handler.container.windowManager.buildModalDialogFromXML(_loc3_);
         _window = var_1907.rootWindow as IWindowContainer;
         _window.procedure = rewardWindowProcedure;
         var_3115 = -1;
         var _loc4_:class_3499 = null;
         switch(param1)
         {
            case "s":
               _loc4_ = var_1629.handler.container.roomEngine.getFurnitureImage(param2,new Vector3d(90,0,0),64,this,0);
               break;
            case "i":
               _loc4_ = var_1629.handler.container.roomEngine.getWallItemImage(param2,new Vector3d(90,0,0),64,this,0);
               break;
            case "e":
               rewardBitmap = var_1629.handler.container.catalog.getPixelEffectIcon(param2);
               break;
            case "h":
               rewardBitmap = var_1629.handler.container.catalog.getSubscriptionProductIcon(param2);
               break;
            default:
               return;
         }
         if(_loc4_ != null)
         {
            if(_loc4_.data != null)
            {
               rewardBitmap = _loc4_.data;
            }
            var_3115 = _loc4_.id;
         }
      }
      
      private function set rewardBitmap(param1:BitmapData) : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName("reward_image") as IBitmapWrapperWindow;
         var _loc2_:IWindow = _window.findChildByName("bitmap_container");
         _loc3_.bitmap = param1;
         _loc2_.width = param1.width;
         _loc2_.height = param1.height;
         _loc2_.width++;
      }
      
      private function rewardWindowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
            case "close_button":
               closeWindow();
         }
      }
      
      private function closeWindow() : void
      {
         if(var_1907 != null && !var_1907.disposed)
         {
            _window = null;
            var_1907.dispose();
            var_1907 = null;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeWindow();
         connection.removeMessageEvent(var_3369);
         connection.removeMessageEvent(var_3414);
         connection.removeMessageEvent(var_3382);
         var_3369 = null;
         var_3414 = null;
         var_3382 = null;
         var_2060 = null;
         var_1629 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function startOpenFlow(param1:IRoomObject) : void
      {
         var_2060 = param1;
         connection.send(new UseFurnitureMessageComposer(param1.getId()));
      }
      
      private function get connection() : IConnection
      {
         return var_1629.handler.container.connection;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == var_3115)
         {
            var_3115 = -1;
            rewardBitmap = param2;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}
