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
   import com.sulake.habbo.catalog.collectibles.renderer.model.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.widget.subviews.CollectibleProductPreviewer;
   
   public class AbstractCollectibleItemRenderer
   {
       
      
      protected var var_319:CollectiblesController;
      
      private var var_325:IRenderableCollectibleItem;
      
      private var var_2524:IWindowContainer;
      
      private var var_2992:CollectibleProductPreviewer;
      
      private var _active:Boolean = false;
      
      private var _hovered:Boolean = false;
      
      public function AbstractCollectibleItemRenderer(param1:CollectiblesController, param2:IRenderableCollectibleItem, param3:IWindowContainer)
      {
         super();
         var_319 = param1;
         var_325 = param2;
         var_2524 = param3;
         var_2524.addEventListener("WME_CLICK",onClick);
         var_2524.addEventListener("WME_OVER",onOver);
         var_2524.addEventListener("WME_OUT",onOut);
         var_2992 = new CollectibleProductPreviewer(bitmapWindow,badgeImageWindow,petImageWindow,unknownImageWindow);
         var_319.previewIcon(var_325,var_2992);
         updateVisuals();
         updateColoring();
      }
      
      public function updateVisuals() : void
      {
      }
      
      protected function onClick(param1:WindowMouseEvent) : void
      {
      }
      
      private function updateColoring() : void
      {
         var _loc2_:Object = isComplete ? completeColoring() : incompleteColoring();
         var _loc1_:Object = _hovered ? _loc2_.hovered : (_active ? _loc2_.active : _loc2_.normal);
         borderOutline.color = _loc1_.outline;
         borderBackground.color = _loc1_.background;
      }
      
      protected function incompleteColoring() : Object
      {
         return {
            "active":{
               "background":15132390,
               "outline":16777215
            },
            "hovered":{
               "background":14409183,
               "outline":16119544
            },
            "normal":{
               "background":13159891,
               "outline":9412017
            }
         };
      }
      
      protected function completeColoring() : Object
      {
         return {
            "active":{
               "background":14872032,
               "outline":16777215
            },
            "hovered":{
               "background":14346200,
               "outline":16119544
            },
            "normal":{
               "background":13820623,
               "outline":8823170
            }
         };
      }
      
      protected function get isComplete() : Boolean
      {
         return var_325.amount > 0;
      }
      
      public function activate() : void
      {
         _active = true;
         updateColoring();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateColoring();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         _hovered = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         _hovered = true;
         updateColoring();
      }
      
      public function dispose() : void
      {
         if(var_2524)
         {
            var_2524.dispose();
            var_2524 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get renderableItem() : IRenderableCollectibleItem
      {
         return var_325;
      }
      
      public function get container() : IWindowContainer
      {
         return var_2524;
      }
      
      protected function get borderOutline() : class_3437
      {
         return null;
      }
      
      protected function get borderBackground() : class_3437
      {
         return null;
      }
      
      protected function get amountText() : ITextWindow
      {
         return null;
      }
      
      protected function get amountTextBorder() : class_3437
      {
         return null;
      }
      
      protected function get bitmapWindow() : IBitmapWrapperWindow
      {
         return null;
      }
      
      protected function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return null;
      }
      
      protected function get badgeImageWindow() : IWidgetWindow
      {
         return null;
      }
      
      protected function get petImageWindow() : IWidgetWindow
      {
         return null;
      }
   }
}
