package com.sulake.habbo.friendlist
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Point;
   
   public class RelationshipStatusSelector implements IDisposable
   {
       
      
      private var _friendList:HabboFriendList;
      
      private var _window:class_3437;
      
      private var var_1358:int;
      
      private var _disposed:Boolean = false;
      
      public function RelationshipStatusSelector(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            destroyWindow();
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function appearAt(param1:IWindow, param2:IWindow) : void
      {
         var _loc3_:Point = new Point();
         param1.getGlobalPosition(_loc3_);
         _window.x = _loc3_.x;
         _window.y = _loc3_.y;
         _window.visible = true;
         _window.activate();
      }
      
      public function disappear() : void
      {
         _window.visible = false;
      }
      
      public function set friendId(param1:int) : void
      {
         var_1358 = param1;
      }
      
      private function createWindow() : void
      {
         _window = class_3437(_friendList.windowManager.buildFromXML(XML(_friendList.assets.getAssetByName("relationship_chooser_xml").content)));
         _window.procedure = onWindowEvent;
         _window.visible = false;
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "item_none":
                  _friendList.setRelationshipStatus(var_1358,0);
                  break;
               case "item_heart":
                  _friendList.setRelationshipStatus(var_1358,1);
                  break;
               case "item_smile":
                  _friendList.setRelationshipStatus(var_1358,2);
                  break;
               case "item_bobba":
                  _friendList.setRelationshipStatus(var_1358,3);
            }
            _window.visible = false;
         }
         if(param1.type == "WE_UNFOCUSED")
         {
            _window.visible = false;
         }
      }
   }
}
