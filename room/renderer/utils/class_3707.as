package com.sulake.room.renderer.utils
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.ISortableSprite;
   
   [SecureSWF(rename="true")]
   public class class_3707 implements ISortableSprite
   {
      
      public static const const_1190:Number = 100000000;
       
      
      private var var_31:int = 0;
      
      private var var_28:int = 0;
      
      private var var_30:Number = 0;
      
      public var name:String = "";
      
      private var var_2342:IRoomObjectSprite = null;
      
      public function class_3707()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_2342 = null;
         var_30 = -100000000;
      }
      
      public function get x() : int
      {
         return var_31;
      }
      
      public function set x(param1:int) : void
      {
         var_31 = param1;
      }
      
      public function get y() : int
      {
         return var_28;
      }
      
      public function set y(param1:int) : void
      {
         var_28 = param1;
      }
      
      public function get z() : Number
      {
         return var_30;
      }
      
      public function set z(param1:Number) : void
      {
         var_30 = param1;
      }
      
      public function get sprite() : IRoomObjectSprite
      {
         return var_2342;
      }
      
      public function set sprite(param1:IRoomObjectSprite) : void
      {
         var_2342 = param1;
      }
   }
}
