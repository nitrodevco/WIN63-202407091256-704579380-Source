package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChatHistoryTray implements IDisposable, IUpdateReceiver
   {
       
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var var_1985:Stage;
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_1966:ChatHistoryScrollView;
      
      private var _tab:Sprite;
      
      private var var_1955:Bitmap;
      
      private var var_1763:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _openedWidth:int;
      
      private var _flagUpdateDisableRoomMouseEvents:Boolean = false;
      
      public function ChatHistoryTray(param1:HabboFreeFlowChat, param2:ChatHistoryScrollView)
      {
         super();
         var_1660 = param1;
         var_1966 = param2;
         _rootDisplayObject = new Sprite();
         var_1955 = new Bitmap();
         var_1955.bitmapData = BitmapData(var_1660.assets.getAssetByName("tray_bar").content);
         var_1955.width = var_1955.bitmapData.width;
         var_1955.height = 0;
         var_1955.scaleX = 1;
         var_1955.x = -var_1955.bitmapData.width;
         var_1763 = new Bitmap();
         var_1763.bitmapData = BitmapData(var_1660.assets.getAssetByName("tray_handle_open").content);
         var_1763.scaleX = 1;
         var_1763.scaleY = 1;
         var_1763.x = -0;
         var_1763.y = 350;
         var_1763.visible = false;
         _tab = new Sprite();
         _tab.scaleX = 1;
         _tab.scaleY = 1;
         _tab.visible = true;
         _tab.addChild(var_1955);
         _tab.addChild(var_1763);
         _rootDisplayObject.addChild(_tab);
         _bg = new Bitmap();
         _bg.bitmapData = new BitmapData(1,1,true,2720277278);
         _bg.width = 0;
         _bg.height = 0;
         _rootDisplayObject.addChild(_bg);
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
         _openedWidth = 350 + 62 + 1;
      }
      
      public function dispose() : void
      {
         var_1660.disableRoomMouseEventsLeftOfX(0);
         if(_rootDisplayObject)
         {
            var_1966.deactivateScrolling();
            if(var_1985)
            {
               var_1985.removeEventListener("mouseDown",stageMouseClickedEventHandler);
            }
         }
         _rootDisplayObject = null;
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         _tab.height = param2 - 50;
         var_1955.height = param2 - 50;
         _bg.height = param2 - 50;
         _tab.scaleY = 1;
         var_1763.scaleY = 1;
         var_1763.y = param2 - 215;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         resize(_rootDisplayObject.stage.stageWidth,_rootDisplayObject.stage.stageHeight);
         _rootDisplayObject.stage.addEventListener("click",stageMouseClickedEventHandler);
         var_1985 = _rootDisplayObject.stage;
      }
      
      public function toggleHistoryVisibility() : void
      {
         if(var_1966.isActive)
         {
            var_1966.deactivateScrolling();
            _rootDisplayObject.removeChild(var_1966.rootDisplayObject);
            var_1966.deactivateView();
            _bg.width = 0;
            var_1955.x = -var_1955.bitmapData.width;
            var_1763.x = -0;
            var_1763.visible = false;
            var_1966.viewWidth = 0;
            var_1763.bitmapData = BitmapData(var_1660.assets.getAssetByName("tray_handle_open").content);
         }
         else
         {
            _rootDisplayObject.addChild(var_1966.rootDisplayObject);
            var_1966.scrollToBottom();
            var_1966.activateScrolling();
            var_1966.activateView();
            _bg.width = _openedWidth;
            var_1955.x = _openedWidth;
            var_1763.visible = true;
            var_1763.x = _openedWidth - 0 + var_1955.bitmapData.width;
            var_1966.viewWidth = _openedWidth;
            var_1763.bitmapData = BitmapData(var_1660.assets.getAssetByName("tray_handle_close").content);
         }
         _flagUpdateDisableRoomMouseEvents = true;
      }
      
      private function stageMouseClickedEventHandler(param1:Event) : void
      {
         if(!_rootDisplayObject || !_rootDisplayObject.stage)
         {
            return;
         }
         var _loc2_:MouseEvent = MouseEvent(param1);
         if(var_1966.isActive && var_1763.x <= _loc2_.stageX && _loc2_.stageX <= var_1763.x + var_1763.width && var_1763.y <= _loc2_.stageY && _loc2_.stageY <= var_1763.y + var_1763.height)
         {
            toggleHistoryVisibility();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(_flagUpdateDisableRoomMouseEvents && param1 > 20)
         {
            var_1660.disableRoomMouseEventsLeftOfX(!var_1966.isActive ? 0 : _openedWidth + var_1955.bitmapData.width);
            _flagUpdateDisableRoomMouseEvents = false;
         }
      }
   }
}
