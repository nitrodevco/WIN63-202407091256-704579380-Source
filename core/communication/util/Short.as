package com.sulake.core.communication.util
{
   import flash.utils.ByteArray;
   
   public class Short
   {
       
      
      private var var_2832:ByteArray;
      
      public function Short(param1:int)
      {
         super();
         var_2832 = new ByteArray();
         var_2832.writeShort(param1);
         var_2832.position = 0;
      }
      
      public function get value() : int
      {
         var _loc1_:int = 0;
         var_2832.position = 0;
         if(var_2832.bytesAvailable)
         {
            _loc1_ = var_2832.readShort();
            var_2832.position = 0;
         }
         return _loc1_;
      }
   }
}
