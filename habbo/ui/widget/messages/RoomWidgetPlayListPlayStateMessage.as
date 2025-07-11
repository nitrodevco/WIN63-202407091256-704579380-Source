package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPlayListPlayStateMessage extends RoomWidgetMessage
   {
      
      public static const TOGGLE_PLAY_PAUSE:String = "RWPLPS_TOGGLE_PLAY_PAUSE";
       
      
      private var var_603:int;
      
      private var var_810:int;
      
      public function RoomWidgetPlayListPlayStateMessage(param1:String, param2:int, param3:int = -1)
      {
         super(param1);
         var_603 = param2;
         var_810 = param3;
      }
      
      public function get furniId() : int
      {
         return var_603;
      }
      
      public function get position() : int
      {
         return var_810;
      }
   }
}
