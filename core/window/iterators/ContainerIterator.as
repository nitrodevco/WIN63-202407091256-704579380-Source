package com.sulake.core.window.iterators
{
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class ContainerIterator extends Proxy implements IIterator
   {
       
      
      private var var_2105:WindowController;
      
      public function ContainerIterator(param1:WindowController)
      {
         super();
         var_2105 = param1;
      }
      
      public function get length() : uint
      {
         return var_2105.numChildren;
      }
      
      public function indexOf(param1:*) : int
      {
         return var_2105.getChildIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return var_2105.getChildAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:IWindow = null;
         _loc3_ = param2 as IWindow;
         var _loc4_:int;
         if((_loc4_ = var_2105.getChildIndex(_loc3_)) == param1)
         {
            return;
         }
         if(_loc4_ > -1)
         {
            var_2105.removeChild(_loc3_);
         }
         var_2105.addChildAt(_loc3_,param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < var_2105.numChildren ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return var_2105.getChildAt(uint(param1) - 1);
      }
   }
}
