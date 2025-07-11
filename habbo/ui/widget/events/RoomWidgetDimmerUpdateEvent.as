package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDimmerUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_819:String = "RWDUE_PRESETS";
      
      public static const DIMMER_HIDE:String = "RWDUE_HIDE";
       
      
      private var var_1136:int = 0;
      
      private var var_216:Array;
      
      private var var_517:int = 0;
      
      private var var_1149:Boolean = false;
      
      public function RoomWidgetDimmerUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         var_216 = [];
         super(param1,param2,param3);
      }
      
      public function get selectedPresetId() : int
      {
         return var_1136;
      }
      
      public function get presetCount() : int
      {
         return var_216.length;
      }
      
      public function get presets() : Array
      {
         return var_216;
      }
      
      public function set selectedPresetId(param1:int) : void
      {
         var_1136 = param1;
      }
      
      public function get itemId() : int
      {
         return var_517;
      }
      
      public function set itemId(param1:int) : void
      {
         var_517 = param1;
      }
      
      public function get isOn() : Boolean
      {
         return var_1149;
      }
      
      public function set isOn(param1:Boolean) : void
      {
         var_1149 = param1;
      }
      
      public function storePreset(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:RoomWidgetDimmerUpdateEventPresetItem = new RoomWidgetDimmerUpdateEventPresetItem(param1,param2,param3,param4);
         var_216[param1 - 1] = _loc5_;
      }
      
      public function getPreset(param1:int) : RoomWidgetDimmerUpdateEventPresetItem
      {
         if(param1 < 0 || param1 >= var_216.count)
         {
            return null;
         }
         return var_216[param1];
      }
   }
}
