package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPresentEvent extends RoomSessionEvent
   {
      
      public static const ROOM_SESSION_PRESENT_OPENED:String = "RSPE_PRESENT_OPENED";
       
      
      private var var_390:int = 0;
      
      private var var_125:String = "";
      
      private var var_394:String;
      
      private var var_1155:int = 0;
      
      private var var_1103:String = "";
      
      private var _placedInRoom:Boolean;
      
      private var _petFigureString:String;
      
      public function RoomSessionPresentEvent(param1:String, param2:IRoomSession, param3:int, param4:String, param5:String, param6:int, param7:String, param8:Boolean, param9:String, param10:Boolean = false, param11:Boolean = false)
      {
         super(param1,param2,param10,param11);
         var_390 = param3;
         var_125 = param4;
         var_394 = param5;
         var_1155 = param6;
         var_1103 = param7;
         _placedInRoom = param8;
         _petFigureString = param9;
      }
      
      public function get classId() : int
      {
         return var_390;
      }
      
      public function get itemType() : String
      {
         return var_125;
      }
      
      public function get productCode() : String
      {
         return var_394;
      }
      
      public function get placedItemId() : int
      {
         return var_1155;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function get placedItemType() : String
      {
         return var_1103;
      }
      
      public function get petFigureString() : String
      {
         return _petFigureString;
      }
   }
}
