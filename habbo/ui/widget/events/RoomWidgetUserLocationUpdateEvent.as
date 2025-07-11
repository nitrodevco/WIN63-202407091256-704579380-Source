package com.sulake.habbo.ui.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetUserLocationUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const USER_LOCATION_UPDATE:String = "RWULUE_USER_LOCATION_UPDATE";
       
      
      private var var_418:int;
      
      private var var_3496:Rectangle;
      
      private var var_4460:Point;
      
      public function RoomWidgetUserLocationUpdateEvent(param1:int, param2:Rectangle, param3:Point, param4:Boolean = false, param5:Boolean = false)
      {
         super("RWULUE_USER_LOCATION_UPDATE",param4,param5);
         var_418 = param1;
         var_3496 = param2;
         var_4460 = param3;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get rectangle() : Rectangle
      {
         return var_3496;
      }
      
      public function get screenLocation() : Point
      {
         return var_4460;
      }
   }
}
