package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingRecipeItemRenderer extends FurniThumbnailRendererBase
   {
       
      
      public function CraftingRecipeItemRenderer(param1:CraftingFurnitureItem, param2:IWindowContainer, param3:CraftingWidget)
      {
         super(param1,param2,param3);
         hideItemCount();
      }
      
      override protected function onTriggered() : void
      {
         if(!var_1629 || !content || var_1629.craftingInProgress)
         {
            return;
         }
         var_1629.showCraftableProduct(content);
      }
   }
}
