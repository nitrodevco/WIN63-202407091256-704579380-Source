package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetUpdateRoomPreviewEvent extends Event
   {
       
      
      private var var_444:String = "default";
      
      private var var_551:String = "default";
      
      private var var_370:String = "1.1";
      
      private var var_4437:int = 64;
      
      public function CatalogWidgetUpdateRoomPreviewEvent(param1:String, param2:String, param3:String, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super("UPDATE_ROOM_PREVIEW",param5,param6);
         var_551 = param1;
         var_444 = param2;
         var_370 = param3;
         var_4437 = param4;
      }
      
      public function get wallType() : String
      {
         return var_444;
      }
      
      public function get floorType() : String
      {
         return var_551;
      }
      
      public function get landscapeType() : String
      {
         return var_370;
      }
      
      public function get tileSize() : int
      {
         return var_4437;
      }
   }
}
