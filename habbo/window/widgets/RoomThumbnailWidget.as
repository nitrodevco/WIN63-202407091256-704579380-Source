package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RoomThumbnailWidget implements IRoomThumbnailWidget
   {
      
      public static const TYPE:String = "room_thumbnail";
       
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      public function RoomThumbnailWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("room_thumbnail_xml").content as XML) as IWindowContainer;
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
      }
      
      public function reset() : void
      {
      }
      
      public function set flatId(param1:int) : void
      {
      }
      
      public function get properties() : Array
      {
         return null;
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get iterator() : IIterator
      {
         return null;
      }
   }
}
