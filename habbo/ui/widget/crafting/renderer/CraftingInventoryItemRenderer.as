package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingInventoryItemRenderer extends FurniThumbnailRendererBase
   {
       
      
      public function CraftingInventoryItemRenderer(param1:CraftingFurnitureItem, param2:IWindowContainer, param3:CraftingWidget)
      {
         super(param1,param2,param3);
      }
      
      override protected function onTriggered() : void
      {
         if(!var_1629 || var_1629.craftingInProgress || var_1629.inventoryDirty)
         {
            return;
         }
         if(!var_1629.mixerCtrl.canAdd())
         {
            return;
         }
         var _loc1_:int = content.getItemToMixer();
         if(_loc1_ == 0)
         {
            return;
         }
         var_1629.showSecretRecipeView();
         var_1629.mixerCtrl.addItemToMixer(content,_loc1_);
         var_1629.inventoryCtrl.updateItemCounts();
      }
      
      override public function updateItemCount() : void
      {
         if(content)
         {
            updateGroupItemCount(content.countInInventory);
            updateBitmapBlend(content.countInInventory > 0);
         }
      }
   }
}
