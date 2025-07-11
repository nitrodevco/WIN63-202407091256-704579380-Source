package com.sulake.habbo.ui.widget.crafting.utils
{
   import com.sulake.habbo.session.furniture.class_3365;
   import flash.events.EventDispatcher;
   
   public class CraftingFurnitureItem extends EventDispatcher
   {
       
      
      private var var_1334:String;
      
      private var var_394:String;
      
      private var var_2047:class_3365;
      
      private var var_2808:Vector.<int>;
      
      private var var_3687:Vector.<int>;
      
      public function CraftingFurnitureItem(param1:String, param2:String, param3:class_3365)
      {
         super();
         var_1334 = param1;
         var_394 = param2;
         var_2047 = param3;
         var_2808 = new Vector.<int>(0);
         var_3687 = new Vector.<int>(0);
      }
      
      public function get recipeCode() : String
      {
         return var_1334;
      }
      
      public function get furnitureData() : class_3365
      {
         return var_2047;
      }
      
      public function get productCode() : String
      {
         return var_394;
      }
      
      public function get typeId() : int
      {
         return !!var_2047 ? var_2047.id : -1;
      }
      
      public function get countInInventory() : int
      {
         return !!var_2808 ? var_2808.length : 0;
      }
      
      public function set inventoryIds(param1:Vector.<int>) : void
      {
         var_2808 = param1;
      }
      
      public function getItemToMixer() : int
      {
         if(countInInventory == 0)
         {
            return 0;
         }
         var _loc1_:int = var_2808.shift();
         var_3687.push(_loc1_);
         return _loc1_;
      }
      
      public function returnItemToInventory(param1:int) : void
      {
         var_2808.push(param1);
         var_3687.splice(var_3687.indexOf(param1),1);
      }
   }
}
