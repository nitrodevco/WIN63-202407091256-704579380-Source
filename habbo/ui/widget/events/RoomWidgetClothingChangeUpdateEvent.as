package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetClothingChangeUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const SHOW_GENDER_SELECTION:String = "RWCCUE_SHOW_GENDER_SELECTION";
      
      public static const SHOW_CLOTHING_EDITOR:String = "RWCCUE_SHOW_CLOTHING_EDITOR";
       
      
      private var var_455:int = -1;
      
      private var var_1114:int = -1;
      
      private var var_369:int = -1;
      
      public function RoomWidgetClothingChangeUpdateEvent(param1:String, param2:int = 0, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_455 = param2;
         var_1114 = param3;
         var_369 = param4;
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
   }
}
