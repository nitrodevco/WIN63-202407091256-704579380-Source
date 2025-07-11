package com.sulake.habbo.ui.widget.furniture.effectbox
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   
   public class EffectBoxOpenDialogView implements IDisposable
   {
      
      private static const const_533:String = "header_button_close";
      
      private static const const_613:String = "cancel";
      
      private static const const_510:String = "ok";
       
      
      private var _window:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_1629:FurnitureContextMenuWidget;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var var_3307:int;
      
      public function EffectBoxOpenDialogView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_1629 = param1;
         _windowManager = param1.windowManager;
         _assets = var_1629.assets;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function open(param1:int) : void
      {
         var_3307 = param1;
         setWindowContent();
         _window.visible = true;
      }
      
      private function setWindowContent() : void
      {
         var _loc1_:String = null;
         if(!_window)
         {
            _loc1_ = "effectbox_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc1_).content as XML) as IWindowContainer;
            addClickListener("ok");
            addClickListener("cancel");
            addClickListener("header_button_close");
            _window.center();
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = null;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel":
               close();
               break;
            case "ok":
               connection.send(new UseFurnitureMessageComposer(var_3307));
               close();
         }
         if(_loc2_)
         {
            var_1629.messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      private function get connection() : IConnection
      {
         return var_1629.handler.container.connection;
      }
   }
}
