package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingMixerItemRenderer extends FurniThumbnailRendererBase
   {
       
      
      private var var_3022:int;
      
      public function CraftingMixerItemRenderer(param1:CraftingFurnitureItem, param2:IWindowContainer, param3:CraftingWidget)
      {
         super(param1,param2,param3);
      }
      
      override protected function onTriggered() : void
      {
         if(!var_1629 || var_1629.craftingInProgress || var_1629.inventoryDirty)
         {
            return;
         }
         if(var_3022 == 0)
         {
            var_1629.setInfoState(9,furnitureData);
            return;
         }
         if(var_1629.inSecretRecipeMode)
         {
            var_1629.mixerCtrl.removeListItem(this);
         }
      }
      
      public function returnItemToInventory() : void
      {
         if(var_3022 != 0)
         {
            var_47.returnItemToInventory(var_3022);
         }
         this.dispose();
      }
      
      override public function updateItemCount() : void
      {
         updateBitmapBlend(var_3022 != 0);
      }
      
      public function get inventoryId() : int
      {
         return var_3022;
      }
      
      public function set inventoryId(param1:int) : void
      {
         var_3022 = param1;
         updateItemCount();
      }
   }
}
