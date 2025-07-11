package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetClothingChangeMessage extends RoomWidgetMessage
   {
      
      public static const REQUEST_EDITOR:String = "RWCCM_REQUEST_EDITOR";
       
      
      private var var_455:int = 0;
      
      private var var_1114:int = 0;
      
      private var var_369:int = 0;
      
      private var var_129:String = "";
      
      public function RoomWidgetClothingChangeMessage(param1:String, param2:String, param3:int, param4:int, param5:int)
      {
         super(param1);
         var_129 = param2;
         var_455 = param3;
         var_1114 = param4;
         var_369 = param5;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get objectCategory() : int
      {
         return var_1114;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function get gender() : String
      {
         return var_129;
      }
   }
}
