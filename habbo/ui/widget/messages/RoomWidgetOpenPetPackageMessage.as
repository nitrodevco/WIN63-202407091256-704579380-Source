package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetOpenPetPackageMessage extends RoomWidgetMessage
   {
      
      public static const WIDGET_MESSAGE_OPEN_PET_PACKAGE:String = "RWOPPM_OPEN_PET_PACKAGE";
       
      
      private var var_455:int;
      
      private var _name:String;
      
      public function RoomWidgetOpenPetPackageMessage(param1:String, param2:int, param3:String)
      {
         super(param1);
         var_455 = param2;
         _name = param3;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}
