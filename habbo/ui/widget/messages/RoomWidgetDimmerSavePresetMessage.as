package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage
   {
      
      public static const WIDGET_MESSAGE_SAVE_DIMMER_PRESET:String = "RWSDPM_SAVE_PRESET";
       
      
      private var _presetNumber:int;
      
      private var var_1485:int;
      
      private var _color:uint;
      
      private var var_3376:int;
      
      private var var_4413:Boolean;
      
      private var var_455:int;
      
      public function RoomWidgetDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean, param6:int)
      {
         super("RWSDPM_SAVE_PRESET");
         _presetNumber = param1;
         var_1485 = param2;
         _color = param3;
         var_3376 = param4;
         var_4413 = param5;
         var_455 = param6;
      }
      
      public function get presetNumber() : int
      {
         return _presetNumber;
      }
      
      public function get effectTypeId() : int
      {
         return var_1485;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : int
      {
         return var_3376;
      }
      
      public function get apply() : Boolean
      {
         return var_4413;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
   }
}
