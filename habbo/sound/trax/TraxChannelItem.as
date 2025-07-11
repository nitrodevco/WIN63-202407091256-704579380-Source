package com.sulake.habbo.sound.trax
{
   public class TraxChannelItem
   {
       
      
      private var var_280:int;
      
      private var _length:int;
      
      public function TraxChannelItem(param1:int, param2:int)
      {
         super();
         var_280 = param1;
         _length = param2;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get length() : int
      {
         return _length;
      }
   }
}
