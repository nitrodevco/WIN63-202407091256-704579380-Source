package com.sulake.habbo.catalog.collectibles.renderer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.renderer.model.MintableItemWrapper;
   import com.sulake.habbo.catalog.collectibles.widget.MintInventoryListWidget;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1661;
   
   public class MintInventoryItemRenderer extends AbstractCollectibleItemRenderer
   {
       
      
      protected var var_2135:MintInventoryListWidget;
      
      public function MintInventoryItemRenderer(param1:CollectiblesController, param2:class_1661, param3:IWindowContainer, param4:MintInventoryListWidget, param5:int)
      {
         super(param1,new MintableItemWrapper(param2,param5),param3);
         var_2135 = param4;
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
         var_2135.selectItem(this);
      }
      
      override public function updateVisuals() : void
      {
         amountText.caption = isComplete ? "x" + renderableItem.amount : "-";
         amountTextBorder.color = isComplete ? 3374080 : 7441834;
      }
      
      public function get item() : class_1661
      {
         return (renderableItem as MintableItemWrapper).productItem;
      }
      
      override protected function completeColoring() : Object
      {
         return incompleteColoring();
      }
      
      override protected function get borderOutline() : class_3437
      {
         return container.findChildByName("border_outline") as class_3437;
      }
      
      override protected function get borderBackground() : class_3437
      {
         return container.findChildByName("border_background") as class_3437;
      }
      
      override protected function get amountText() : ITextWindow
      {
         return container.findChildByName("number") as ITextWindow;
      }
      
      override protected function get amountTextBorder() : class_3437
      {
         return container.findChildByName("text_border") as class_3437;
      }
      
      private function get checkmarkIcon() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("checkmark_icon") as IStaticBitmapWrapperWindow;
      }
      
      override protected function get bitmapWindow() : IBitmapWrapperWindow
      {
         return container.findChildByTag("BITMAP") as IBitmapWrapperWindow;
      }
      
      override protected function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
      
      override protected function get badgeImageWindow() : IWidgetWindow
      {
         return container.findChildByName("badge_image_widget") as IWidgetWindow;
      }
      
      override protected function get petImageWindow() : IWidgetWindow
      {
         return container.findChildByName("pet_image_widget") as IWidgetWindow;
      }
   }
}
