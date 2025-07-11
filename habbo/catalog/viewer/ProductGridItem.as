package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.catalog.HabboCatalog;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ProductGridItem implements class_3517
   {
      
      public static const GRID_ITEM_BORDER:String = "bg";
       
      
      protected var var_1631:IWindowContainer;
      
      private var var_2176:IItemGrid;
      
      protected var _icon:IBitmapWrapperWindow;
      
      private var _disposed:Boolean = false;
      
      private var var_2039:Object;
      
      private var _catalog:HabboCatalog;
      
      public function ProductGridItem(param1:HabboCatalog)
      {
         _catalog = param1;
         super();
      }
      
      public function get view() : IWindowContainer
      {
         return var_1631;
      }
      
      public function set grid(param1:IItemGrid) : void
      {
         var_2176 = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_2176 = null;
         _icon = null;
         _catalog = null;
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function activate() : void
      {
         if(!var_1631)
         {
            return;
         }
         if(var_1631.findChildByTag("ITEM_HILIGHT"))
         {
            var_1631.findChildByTag("ITEM_HILIGHT").visible = true;
         }
         else
         {
            var_1631.getChildByName("bg").style = 0;
         }
      }
      
      public function deactivate() : void
      {
         if(!var_1631)
         {
            return;
         }
         if(var_1631.findChildByTag("ITEM_HILIGHT"))
         {
            var_1631.findChildByTag("ITEM_HILIGHT").visible = false;
         }
         else
         {
            var_1631.getChildByName("bg").style = 3;
         }
      }
      
      public function set view(param1:IWindowContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var_1631 = param1;
         var_1631.procedure = eventProc;
         _icon = var_1631.findChildByName("image") as IBitmapWrapperWindow;
         if(var_1631.findChildByTag("ITEM_HILIGHT"))
         {
            var_1631.findChildByTag("ITEM_HILIGHT").visible = false;
         }
         var _loc2_:IWindow = var_1631.findChildByName("multiContainer");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function setDraggable(param1:Boolean) : void
      {
         if(var_1631 as IInteractiveWindow && param1)
         {
            (var_1631 as IInteractiveWindow).setMouseCursorForState(4,5);
            (var_1631 as IInteractiveWindow).setMouseCursorForState(4 | 1,5);
         }
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Boolean = false;
         if(param1.type == "WME_UP")
         {
            var_2039 = null;
         }
         else if(param1.type == "WME_DOWN")
         {
            if(param2 == null)
            {
               return;
            }
            var_2176.select(this,true);
            var_2039 = param2;
         }
         else if(param1.type == "WME_OUT" && var_2039 != null && var_2039 == param2)
         {
            _loc3_ = var_2176.startDragAndDrop(this);
            if(_loc3_)
            {
               var_2039 = null;
            }
         }
         else if(param1.type == "WME_UP")
         {
            var_2039 = null;
         }
         else if(param1.type == "WME_CLICK")
         {
            var_2039 = null;
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            var_2039 = null;
         }
      }
      
      public function setIconImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(_icon != null && !_icon.disposed)
         {
            _loc3_ = (_icon.width - param1.width) / 2;
            _loc4_ = (_icon.height - param1.height) / 2;
            if(_icon.bitmap == null)
            {
               _icon.bitmap = new BitmapData(_icon.width,_icon.height,true,16777215);
            }
            else
            {
               _icon.bitmap.fillRect(_icon.bitmap.rect,16777215);
            }
            _icon.bitmap.copyPixels(param1,param1.rect,new Point(_loc3_,_loc4_),null,null,false);
            _icon.invalidate();
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      protected function renderAvatarImage(param1:String, param2:IAvatarImageListener) : BitmapData
      {
         var _loc4_:class_3374;
         var _loc3_:BitmapData = (_loc4_ = _catalog.avatarRenderManager.createAvatarImage(param1,"h",null,param2)).getCroppedImage("head",0.5);
         _loc4_.dispose();
         return _loc3_;
      }
   }
}
