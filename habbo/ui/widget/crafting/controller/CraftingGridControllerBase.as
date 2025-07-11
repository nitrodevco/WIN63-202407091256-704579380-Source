package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   
   public class CraftingGridControllerBase
   {
       
      
      protected var var_1629:CraftingWidget;
      
      public function CraftingGridControllerBase(param1:CraftingWidget)
      {
         super();
         var_1629 = param1;
      }
      
      public function dispose() : void
      {
         var_1629 = null;
      }
      
      public function get mainWindow() : IWindowContainer
      {
         return var_1629.window;
      }
      
      public function getItemTemplate() : IWindowContainer
      {
         return var_1629.itemTemplate;
      }
   }
}
