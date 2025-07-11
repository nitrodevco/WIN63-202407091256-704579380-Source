package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDimmerStateUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_453:String = "RWDSUE_DIMMER_STATE";
       
      
      private var var_149:int;
      
      private var var_4736:int;
      
      private var var_580:int;
      
      private var _color:uint;
      
      private var var_3376:int;
      
      private var var_455:int;
      
      public function RoomWidgetDimmerStateUpdateEvent(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:uint, param7:Boolean = false, param8:Boolean = false)
      {
         super("RWDSUE_DIMMER_STATE",param7,param8);
         var_455 = param1;
         var_149 = param2;
         var_4736 = param3;
         var_580 = param4;
         _color = param5;
         var_3376 = param6;
      }
      
      public function get state() : int
      {
         return var_149;
      }
      
      public function get presetId() : int
      {
         return var_4736;
      }
      
      public function get effectId() : int
      {
         return var_580;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : uint
      {
         return var_3376;
      }
      
      public function get objectId() : uint
      {
         return var_455;
      }
   }
}
