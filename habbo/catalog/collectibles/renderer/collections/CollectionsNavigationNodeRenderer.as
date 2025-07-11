package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.widget.CollectionsWidget;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1692;
   
   public class CollectionsNavigationNodeRenderer implements IDisposable
   {
       
      
      private var var_1900:CollectionsWidget;
      
      private var var_1734:class_1692;
      
      private var _window:IWindowContainer;
      
      private var _active:Boolean;
      
      private var _itemNormalColor:uint;
      
      private var _itemSelectedEtchingColor:uint;
      
      private var _hovered:Boolean = false;
      
      public function CollectionsNavigationNodeRenderer(param1:CollectionsWidget, param2:class_1692)
      {
         super();
         var_1900 = param1;
         var_1734 = param2;
         createWindow();
      }
      
      private function createWindow() : void
      {
         _window = var_1900.navigationItemTemplate.clone() as IWindowContainer;
         var _loc1_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.caption = var_1900.controller.localizationManager.getLocalization("collectibles.set." + var_1734.collectionId,nftCollection.collectionName);
            _itemNormalColor = _loc1_.textColor;
            _itemSelectedEtchingColor = _loc1_.etchingColor;
         }
         var _loc2_:IWindow = _window.findChildByTag("SELECTION_HILIGHT");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
         setProgressLook(false);
         _window.addEventListener("WME_CLICK",onButtonClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      private function setProgressLook(param1:Boolean = false) : void
      {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc2_:int = var_1734.collectedItemCount;
         var _loc3_:int = var_1734.totalItemCount;
         progressContainer.visible = _loc2_ > 0 && param1;
         progressColorHint.visible = _loc2_ > 0;
         if(_loc2_ > 0)
         {
            _loc4_ = class_3861.getColor(_loc2_,_loc3_);
            progressColorHint.color = _loc4_ | 4278190080;
            if(param1)
            {
               _loc5_ = var_1734.collectedItemCount * 100 / var_1734.totalItemCount;
               progressColor.color = _loc4_;
               progressText.caption = _loc5_ + "%";
            }
         }
      }
      
      public function get nftCollection() : class_1692
      {
         return var_1734;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function activate() : void
      {
         _active = true;
         updateLook();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateLook();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         _hovered = false;
         updateLook();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         _hovered = true;
         updateLook();
      }
      
      private function updateLook() : void
      {
         if(_active || _hovered)
         {
            setActiveLook();
         }
         else
         {
            setInactiveLook();
         }
         setProgressLook(_hovered);
      }
      
      private function setInactiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:IWindow = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = _itemNormalColor;
               _loc1_.etchingColor = 0;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
      }
      
      private function setActiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:IWindowContainer = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = 4294967295;
               _loc1_.etchingColor = _itemSelectedEtchingColor;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT") as IWindowContainer;
            if(_loc2_ != null)
            {
               _loc2_.visible = true;
            }
         }
      }
      
      private function get progressContainer() : IWindowContainer
      {
         return IWindowContainer(_window.findChildByName("progress_container"));
      }
      
      private function get progressColor() : class_3437
      {
         return class_3437(progressContainer.getChildByName("progress_color"));
      }
      
      private function get progressText() : ITextWindow
      {
         return ITextWindow(progressContainer.getChildByName("progress_text"));
      }
      
      private function get progressColorHint() : IWindowContainer
      {
         return IWindowContainer(_window.findChildByName("progress_color_hint"));
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var_1900.activateCollection(this);
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
   }
}
