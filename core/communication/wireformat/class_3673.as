package com.sulake.core.communication.wireformat
{
   import com.hurlant.util.class_23;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.ByteArray;
   
   [SecureSWF(rename="true")]
   internal final class class_3673 implements IMessageDataWrapper
   {
       
      
      private var var_280:int;
      
      private var var_47:ByteArray;
      
      public function class_3673(param1:int, param2:ByteArray)
      {
         super();
         var_280 = param1;
         var_47 = param2;
      }
      
      public function getID() : int
      {
         return var_280;
      }
      
      public function readString() : String
      {
         return var_47.readUTF();
      }
      
      public function readInteger() : int
      {
         return var_47.readInt();
      }
      
      public function readLong() : Number
      {
         var _loc2_:uint = var_47.readUnsignedInt();
         var _loc3_:uint = var_47.readUnsignedInt();
         var _loc1_:* = !!(_loc2_ & 2147483648);
         if(_loc1_)
         {
            _loc2_ = uint(~_loc2_ & 2147483647);
            _loc3_ = uint(~_loc3_ + 1);
            if(_loc3_ == 0)
            {
               _loc2_ += 1;
            }
         }
         var _loc4_:Number = _loc2_ * 4294967296 + _loc3_;
         if(_loc1_)
         {
            _loc4_ = -_loc4_;
         }
         return _loc4_;
      }
      
      public function readBoolean() : Boolean
      {
         return var_47.readBoolean();
      }
      
      public function readShort() : int
      {
         return var_47.readShort();
      }
      
      public function readByte() : int
      {
         return var_47.readByte();
      }
      
      public function readFloat() : Number
      {
         return var_47.readFloat();
      }
      
      public function readDouble() : Number
      {
         return var_47.readDouble();
      }
      
      public function get bytesAvailable() : uint
      {
         return var_47.bytesAvailable;
      }
      
      public function toString() : String
      {
         return "id=" + var_280 + ", pos=" + var_47.position + ", data=" + class_23.fromArray(var_47,true);
      }
   }
}
