package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1373;
   
   public class CatalogNodeRenderable extends CatalogNode
   {
      
      private static const ITEM_SELECTION_COLOR:Number = 4294967295;
       
      
      private var _window:IWindowContainer;
      
      private var var_1703:IItemListWindow;
      
      private var _isOpen:Boolean = false;
      
      private var _active:Boolean;
      
      private var _itemNormalColor:uint;
      
      private var _itemSelectedEtchingColor:uint;
      
      public function CatalogNodeRenderable(param1:class_3341, param2:class_1373, param3:int, param4:class_3411)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      override public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      override public function get visible() : Boolean
      {
         return true;
      }
      
      override public function dispose() : void
      {
         if(_isOpen)
         {
            close();
            deactivate();
         }
         _window = null;
         var_1703 = null;
         super.dispose();
      }
      
      public function addToList(param1:IItemListWindow, param2:Boolean = true) : void
      {
         if(_window == null)
         {
            createWindow();
            setInactiveLook();
         }
         param1.addListItem(_window);
         if(isBranch)
         {
            if(var_1703 == null)
            {
               createChildList();
            }
            param1.addListItem(var_1703);
            refreshChildren();
         }
         param1.arrangeListItems();
      }
      
      public function removeFromList(param1:IItemListWindow) : void
      {
         param1.removeListItem(_window);
         if(isBranch)
         {
            param1.removeListItem(var_1703);
         }
      }
      
      override public function activate() : void
      {
         setActiveLook();
         _active = true;
      }
      
      override public function deactivate() : void
      {
         setInactiveLook();
         _active = false;
      }
      
      override public function open() : void
      {
         var _loc1_:IWindow = null;
         showChildren();
         _isOpen = true;
         if(isBranch && _window != null)
         {
            _loc1_ = _window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = 7;
            }
         }
      }
      
      override public function close() : void
      {
         var _loc1_:IWindow = null;
         removeChildren();
         _isOpen = false;
         if(isBranch && _window != null)
         {
            _loc1_ = _window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = 5;
            }
         }
      }
      
      private function refreshChildren() : void
      {
         var _loc1_:CatalogNodeRenderable = null;
         if(var_1703 == null)
         {
            return;
         }
         for each(var _loc2_ in children)
         {
            _loc1_ = _loc2_ as CatalogNodeRenderable;
            if(_loc1_ != null)
            {
               if(_loc1_.visible)
               {
                  _loc1_.addToList(var_1703);
                  _loc1_.setInactiveLook();
               }
               else
               {
                  _loc1_.removeFromList(var_1703);
               }
            }
         }
         var_1703.arrangeListItems();
      }
      
      private function showChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(var_1703 == null)
         {
            createChildList();
         }
         for each(var _loc3_ in children)
         {
            if(_loc3_.visible)
            {
               (_loc3_ as CatalogNodeRenderable).addToList(var_1703);
            }
         }
         if(var_1703 != null)
         {
            var_1703.visible = true;
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < var_1703.numListItems)
            {
               if(var_1703.getListItemAt(_loc2_).visible)
               {
                  _loc1_++;
               }
               _loc2_++;
            }
            var_1703.height = _loc1_ * 21;
         }
      }
      
      private function removeChildren() : void
      {
         for each(var _loc1_ in children)
         {
            if(_loc1_.visible)
            {
               (_loc1_ as CatalogNodeRenderable).removeFromList(var_1703);
            }
         }
         if(var_1703 != null)
         {
            var_1703.height = 0;
            var_1703.visible = false;
            var_1703.x = 0;
         }
      }
      
      private function createChildList() : void
      {
         var_1703 = navigator.listTemplate.clone() as IItemListWindow;
         removeChildren();
      }
      
      private function createWindow() : void
      {
         _window = navigator.getItemTemplate(depth).clone() as IWindowContainer;
         var _loc2_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         var _loc1_:IWindow = _window.findChildByTag("DOWNBTN");
         if(_loc2_ != null)
         {
            _loc2_.caption = localization;
            _itemNormalColor = _loc2_.textColor;
            _itemSelectedEtchingColor = _loc2_.etchingColor;
         }
         var _loc3_:IWindow = _window.findChildByTag("SELECTION_HILIGHT");
         if(_loc3_)
         {
            _loc3_.visible = false;
         }
         if(_loc1_ != null)
         {
            _loc1_.visible = !isLeaf;
         }
         IStaticBitmapWrapperWindow(_window.findChildByName("icon")).assetUri = navigator.catalog.imageGalleryHost + iconName + ".png";
         if(navigator.isDeepHierarchy)
         {
            if(depth == 1)
            {
               _window.findChildByName("icon").visible = false;
               _window.findChildByTag("ITEM_TITLE").x = 0;
            }
            if(depth > 3)
            {
               _window.findChildByName("icon").visible = true;
               _window.findChildByName("icon").x = 15 + 6 * (depth - 3);
               _window.findChildByTag("ITEM_TITLE").x = 42 + 6 * (depth - 3);
            }
         }
         _window.addEventListener("WME_CLICK",onButtonClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onButtonClicked);
         }
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         if(!_active)
         {
            setInactiveLook();
         }
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         if(!_active)
         {
            setActiveLook();
         }
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
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         navigator.activateNode(this);
      }
      
      public function updateChildListHeight() : void
      {
         var _loc2_:int = 0;
         if(var_1703 == null)
         {
            return;
         }
         var_1703.height = 0;
         if(var_1703 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_1703.numListItems)
            {
               if(var_1703.getListItemAt(_loc2_).visible)
               {
                  var_1703.height += var_1703.getListItemAt(_loc2_).height;
               }
               _loc2_++;
            }
         }
         var _loc1_:CatalogNodeRenderable = parent as CatalogNodeRenderable;
         if(_loc1_)
         {
            _loc1_.updateChildListHeight();
         }
      }
      
      override public function get offsetV() : int
      {
         return _window.y + 21;
      }
   }
}
