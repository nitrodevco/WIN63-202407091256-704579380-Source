package com.sulake.habbo.ui.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const ROOM_VIEW_SIZE_CHANGED:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
      
      public static const ROOM_VIEW_SCALE_CHANGED:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
      
      public static const ROOM_VIEW_POSITION_CHANGED:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
       
      
      private var var_4216:Rectangle;
      
      private var var_4222:Point;
      
      private var var_911:Number = 0;
      
      public function RoomWidgetRoomViewUpdateEvent(param1:String, param2:Rectangle = null, param3:Point = null, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_4216 = param2;
         var_4222 = param3;
         var_911 = param4;
      }
      
      public function get rect() : Rectangle
      {
         if(var_4216 != null)
         {
            return var_4216.clone();
         }
         return null;
      }
      
      public function get positionDelta() : Point
      {
         if(var_4222 != null)
         {
            return var_4222.clone();
         }
         return null;
      }
      
      public function get scale() : Number
      {
         return var_911;
      }
   }
}
