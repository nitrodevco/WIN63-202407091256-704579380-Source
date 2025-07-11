package com.sulake.room.messages
{
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectUpdateMessage
   {
       
      
      protected var var_501:IVector3d;
      
      protected var var_643:IVector3d;
      
      public function RoomObjectUpdateMessage(param1:IVector3d, param2:IVector3d)
      {
         super();
         var_501 = param1;
         var_643 = param2;
      }
      
      public function get loc() : IVector3d
      {
         return var_501;
      }
      
      public function get dir() : IVector3d
      {
         return var_643;
      }
   }
}
