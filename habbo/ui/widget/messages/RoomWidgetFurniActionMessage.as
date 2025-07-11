package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetFurniActionMessage extends RoomWidgetMessage
   {
      
      public static const ROTATE:String = "RWFUAM_ROTATE";
      
      public static const MOVE:String = "RWFAM_MOVE";
      
      public static const const_576:String = "RWFAM_PICKUP";
      
      public static const const_892:String = "RWFAM_EJECT";
      
      public static const USE:String = "RWFAM_USE";
      
      public static const SAVE_STUFF_DATA:String = "RWFAM_SAVE_STUFF_DATA";
      
      public static const const_471:String = "RWFAM_WIRED_INSPECT";
       
      
      private var var_603:int = 0;
      
      private var var_4763:int = 0;
      
      private var _offerId:int;
      
      private var var_4320:String;
      
      public function RoomWidgetFurniActionMessage(param1:String, param2:int, param3:int, param4:int = -1, param5:String = null)
      {
         super(param1);
         var_603 = param2;
         var_4763 = param3;
         _offerId = param4;
         var_4320 = param5;
      }
      
      public function get furniId() : int
      {
         return var_603;
      }
      
      public function get furniCategory() : int
      {
         return var_4763;
      }
      
      public function get objectData() : String
      {
         return var_4320;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
   }
}
