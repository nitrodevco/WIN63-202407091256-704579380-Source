package com.sulake.habbo.navigator.cache
{
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_3439;
   
   public class NavigatorCacheEntry
   {
       
      
      private var _key:String;
      
      private var var_4753:class_3439;
      
      private var var_4901:Number;
      
      private var var_4826:Number;
      
      public function NavigatorCacheEntry(param1:String, param2:class_3439, param3:Number, param4:Number)
      {
         super();
         _key = param1;
         var_4753 = param2;
         var_4901 = param3;
         var_4826 = param4;
      }
      
      public function hasExpired(param1:Number) : Boolean
      {
         return param1 >= var_4826;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get payload() : class_3439
      {
         return var_4753;
      }
   }
}
