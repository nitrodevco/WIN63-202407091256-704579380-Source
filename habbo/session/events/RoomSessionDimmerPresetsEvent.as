package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionDimmerPresetsEvent extends RoomSessionEvent
   {
      
      public static const ROOM_DIMMER_PRESETS:String = "RSDPE_PRESETS";
       
      
      private var var_1136:int = 0;
      
      private var var_216:Array;
      
      private var var_517:int;
      
      private var var_1149:Boolean;
      
      public function RoomSessionDimmerPresetsEvent(param1:String, param2:IRoomSession, param3:Boolean = false, param4:Boolean = false)
      {
         var_216 = [];
         super(param1,param2,param3,param4);
      }
      
      public function get selectedPresetId() : int
      {
         return var_1136;
      }
      
      public function get presetCount() : int
      {
         return var_216.length;
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
         var _loc5_:RoomSessionDimmerPresetsEventPresetItem = new RoomSessionDimmerPresetsEventPresetItem(param1,param2,param3,param4);
         var_216[param1 - 1] = _loc5_;
      }
      
      public function getPreset(param1:int) : RoomSessionDimmerPresetsEventPresetItem
      {
         if(param1 < 0 || param1 >= var_216.count)
         {
            return null;
         }
         return var_216[param1];
      }
   }
}
