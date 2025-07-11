package com.sulake.habbo.ui.widget.events
{
   public class UseProductItem
   {
       
      
      private var var_280:int;
      
      private var var_638:int;
      
      private var _name:String;
      
      private var var_3307:int;
      
      private var var_3076:int;
      
      private var var_4293:int;
      
      private var var_4704:Boolean;
      
      public function UseProductItem(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int = -1, param7:Boolean = false)
      {
         super();
         var_280 = param1;
         var_638 = param2;
         _name = param3;
         var_3307 = param4;
         var_3076 = param5;
         var_4293 = param6;
         var_4704 = param7;
      }
      
      public function dispose() : void
      {
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get requestRoomObjectId() : int
      {
         return var_3307;
      }
      
      public function get targetRoomObjectId() : int
      {
         return var_3076;
      }
      
      public function get requestInventoryStripId() : int
      {
         return var_4293;
      }
      
      public function get replace() : Boolean
      {
         return var_4704;
      }
   }
}
