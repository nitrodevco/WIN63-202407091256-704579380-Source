package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class RoomToolsHistory
   {
      
      private static const PADDING:int = 5;
      
      private static const SPACING:int = 2;
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var _window:IWindowContainer;
      
      private var var_1653:RoomToolsWidgetHandler;
      
      private var _items:Vector.<IWindowContainer>;
      
      public function RoomToolsHistory(param1:IHabboWindowManager, param2:IAssetLibrary, param3:RoomToolsWidgetHandler)
      {
         _items = new Vector.<IWindowContainer>();
         super();
         var_1653 = param3;
         _assets = param2;
         _windowManager = param1;
         _window = param1.buildFromXML(param2.getAssetByName("room_tools_history_xml").content as XML) as IWindowContainer;
      }
      
      public function populate(param1:Vector.<class_1675>) : void
      {
         var _loc3_:IWindow = null;
         var _loc2_:IWindowContainer = null;
         for each(var _loc4_ in param1)
         {
            _loc2_ = _windowManager.buildFromXML(_assets.getAssetByName("room_tools_history_item_xml").content as XML) as IWindowContainer;
            _window.addChild(_loc2_);
            _loc2_.findChildByName("room_name").caption = _loc4_.roomName;
            if(_loc3_)
            {
               _loc2_.y = _loc3_.bottom + 2;
            }
            else
            {
               _loc2_.y = 5;
            }
            _loc2_.x = 5;
            _loc2_.id = _loc4_.flatId;
            _loc2_.procedure = onClick;
            _loc3_ = _loc2_;
            _items.push(_loc2_);
         }
         if(_loc3_)
         {
            _window.height = _loc3_.bottom + 2 * 5;
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _items)
         {
            _loc1_.procedure = null;
            _loc1_.dispose();
         }
         _items = null;
         _windowManager = null;
         var_1653 = null;
         _assets = null;
         _window.dispose();
         _window = null;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_1653.goToPrivateRoom(param2.id);
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
   }
}
