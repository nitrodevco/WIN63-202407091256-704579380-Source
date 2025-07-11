package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.inventory.class_1814;
   
   public interface class_3554
   {
       
      
      function dispose() : void;
      
      function reset() : void;
      
      function get controller() : HabboAvatarEditor;
      
      function getWindowContainer() : IWindow;
      
      function switchCategory(param1:String = "") : void;
      
      function getCategoryData(param1:String) : CategoryData;
      
      function selectPart(param1:String, param2:int) : void;
      
      function selectColor(param1:String, param2:int, param3:int) : void;
      
      function hasClubItemsOverLevel(param1:int) : Boolean;
      
      function hasInvalidSellableItems(param1:class_1814) : Boolean;
      
      function stripClubItemsOverLevel(param1:int) : Boolean;
      
      function stripInvalidSellableItems() : Boolean;
   }
}
