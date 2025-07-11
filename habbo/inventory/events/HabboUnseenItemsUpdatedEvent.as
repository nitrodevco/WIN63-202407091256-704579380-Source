package com.sulake.habbo.inventory.events
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class HabboUnseenItemsUpdatedEvent extends Event
   {
      
      public static const const_669:String = "HUIUE_UNSEEN_ITEMS_CHANGED";
       
      
      private var var_4865:int;
      
      private var var_4003:Dictionary;
      
      public function HabboUnseenItemsUpdatedEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("HUIUE_UNSEEN_ITEMS_CHANGED");
         var_4003 = new Dictionary();
      }
      
      public function setCategoryCount(param1:int, param2:int) : void
      {
         var_4003[param1.toString()] = param2;
      }
      
      public function getCategoryCount(param1:int) : int
      {
         return var_4003[param1.toString()];
      }
      
      public function set inventoryCount(param1:int) : void
      {
         var_4865 = param1;
      }
      
      public function get inventoryCount() : int
      {
         return var_4865;
      }
   }
}
