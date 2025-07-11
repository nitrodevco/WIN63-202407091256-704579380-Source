package com.sulake.room.renderer.utils
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   [SecureSWF(rename="true")]
   public class class_3815 extends BitmapData
   {
      
      private static const ZERO_POINT:Point = new Point(0,0);
       
      
      private var var_2403:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function class_3815(param1:int, param2:int, param3:Boolean = true, param4:uint = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get referenceCount() : int
      {
         return var_2403;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function addReference() : void
      {
         var_2403++;
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(--var_2403 <= 0)
         {
            super.dispose();
            _disposed = true;
         }
      }
      
      override public function clone() : BitmapData
      {
         var _loc1_:class_3815 = null;
         try
         {
            _loc1_ = new class_3815(width,height,true,16777215);
            _loc1_.copyPixels(this,rect,ZERO_POINT,null,null,true);
         }
         catch(e:Error)
         {
            _loc1_ = new class_3815(1,1,true,16777215);
         }
         return _loc1_;
      }
   }
}
