package com.sulake.habbo.window.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SeparatorWidget implements ISeparatorWidget
   {
      
      public static const TYPE:String = "separator";
      
      private static const VERTICAL_KEY:String = "separator:vertical";
      
      private static const VERTICAL_DEFAULT:PropertyStruct = new PropertyStruct("separator:vertical",false,"Boolean");
      
      private static const BORDER_IMAGE_HORIZONTAL:String = "illumina_light_separator_horizontal";
      
      private static const BORDER_IMAGE_VERTICAL:String = "illumina_light_separator_vertical";
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var var_1696:IBitmapWrapperWindow;
      
      private var var_1875:BitmapData;
      
      private var _children:IWindowContainer;
      
      private var var_2786:Boolean;
      
      public function SeparatorWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_2786 = Boolean(VERTICAL_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("separator_xml").content as XML) as IWindowContainer;
         var_1696 = var_509.getChildByName("canvas") as IBitmapWrapperWindow;
         _children = var_509.getChildByName("children") as IWindowContainer;
         var_1696.addEventListener("WE_RESIZE",onChange);
         var_1696.addEventListener("WE_RESIZED",onChange);
         _children.addEventListener("WE_CHILD_ADDED",onChange);
         _children.addEventListener("WE_CHILD_REMOVED",onChange);
         _children.addEventListener("WE_CHILD_RELOCATED",onChange);
         _children.addEventListener("WE_CHILD_RESIZED",onChange);
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
      }
      
      private function onChange(param1:WindowEvent) : void
      {
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1875 != null)
            {
               var_1875.dispose();
               var_1875 = null;
            }
            if(var_1696 != null)
            {
               var_1696.removeEventListener("WE_RESIZE",onChange);
               var_1696.removeEventListener("WE_RESIZED",onChange);
               var_1696 = null;
            }
            if(_children != null)
            {
               _children.removeEventListener("WE_CHILD_ADDED",onChange);
               _children.removeEventListener("WE_CHILD_REMOVED",onChange);
               _children.removeEventListener("WE_CHILD_RELOCATED",onChange);
               _children.removeEventListener("WE_CHILD_RESIZED",onChange);
               _children = null;
            }
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return _children.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(VERTICAL_DEFAULT.withValue(var_2786));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("separator:vertical" === _loc3_)
            {
               vertical = Boolean(_loc2_.value);
            }
         }
      }
      
      public function get vertical() : Boolean
      {
         return var_2786;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         var_2786 = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:BitmapData = null;
         var _loc4_:Point = null;
         if(_disposed)
         {
            return;
         }
         if(var_1875 == null || var_1875.width != var_1696.width || var_1875.height != var_1696.height)
         {
            if(var_1875 != null)
            {
               var_1875.dispose();
            }
            var_1875 = new BitmapData(Math.max(1,var_1696.width),Math.max(1,var_1696.height),true,0);
            var_1696.bitmap = var_1875;
         }
         var_1875.lock();
         var_1875.fillRect(new Rectangle(0,0,var_1696.width,var_1696.height),0);
         var _loc3_:BitmapDataAsset = _windowManager.assets.getAssetByName(var_2786 ? "illumina_light_separator_vertical" : "illumina_light_separator_horizontal") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            _loc1_ = _loc3_.content as BitmapData;
            if(var_2786)
            {
               _loc4_ = new Point(var_1696.width / 2 - 1,0);
               while(_loc4_.y < var_1696.height)
               {
                  var_1875.copyPixels(_loc1_,_loc3_.rectangle,_loc4_);
                  _loc4_.y += _loc3_.rectangle.height;
               }
            }
            else
            {
               _loc4_ = new Point(0,var_1696.height / 2 - 1);
               while(_loc4_.x < var_1696.width)
               {
                  var_1875.copyPixels(_loc1_,_loc3_.rectangle,_loc4_);
                  _loc4_.x += _loc3_.rectangle.width;
               }
            }
         }
         for each(var _loc2_ in _children.iterator)
         {
            if(_loc2_.visible)
            {
               var_1875.fillRect(_loc2_.rectangle,0);
            }
         }
         var_1875.unlock();
         var_1696.invalidate();
      }
   }
}
