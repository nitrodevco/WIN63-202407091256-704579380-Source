package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   
   public class AvatarEditorGridView implements class_3643
   {
      
      public static const REMOVE_ITEM:String = "REMOVE_ITEM";
      
      public static const GET_MORE:String = "GET_MORE";
       
      
      private const MAX_COLOR_LAYERS:int = 2;
      
      private var var_1631:IWindowContainer;
      
      private var var_1644:class_3554;
      
      private var var_2133:IItemGridWindow;
      
      private var var_2215:Array;
      
      private var var_634:String;
      
      private var var_3274:IWindow;
      
      private var var_617:IWindow;
      
      public function AvatarEditorGridView(param1:IWindowContainer)
      {
         super();
         var_1631 = param1;
         var_2133 = var_1631.findChildByName("thumbs") as IItemGridWindow;
         var_2215 = [];
         var_2215.push(var_1631.findChildByName("palette0") as IItemGridWindow);
         var_2215.push(var_1631.findChildByName("palette1") as IItemGridWindow);
         var_3274 = var_1631.findChildByName("content_notification");
         var_617 = var_1631.findChildByName("content_title");
         var_3274.visible = false;
         var_617.visible = false;
      }
      
      public function dispose() : void
      {
         if(var_2133)
         {
            var_2133.dispose();
            var_2133 = null;
         }
         if(var_2215)
         {
            for each(var _loc1_ in var_2215)
            {
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
                  _loc1_ = null;
               }
            }
            var_2215 = null;
         }
         var_1644 = null;
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      public function get window() : IWindowContainer
      {
         if(var_1631 == null)
         {
            return null;
         }
         if(var_1631.disposed)
         {
            return null;
         }
         return var_1631;
      }
      
      public function initFromList(param1:class_3554, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc4_:CategoryData;
         if(!(_loc4_ = param1.getCategoryData(param2)))
         {
            return;
         }
         var_1631.visible = true;
         var_1644 = param1;
         var_634 = param2;
         var_2133.removeGridItems();
         if(_loc4_.parts.length == 0)
         {
            var_617.visible = true;
            var_3274.visible = true;
         }
         else
         {
            var_617.visible = false;
            var_3274.visible = false;
            for each(var _loc8_ in var_2215)
            {
               _loc8_.removeGridItems();
            }
            for each(var _loc5_ in _loc4_.parts)
            {
               if(_loc5_)
               {
                  var_2133.addGridItem(_loc5_.view);
                  _loc5_.view.addEventListener("WME_CLICK",onGridItemClicked);
                  if(_loc5_.isSelected)
                  {
                     showPalettes(_loc5_.colorLayerCount);
                  }
               }
            }
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc6_ = _loc4_.getPalette(_loc3_);
               _loc8_ = var_2215[_loc3_] as IItemGridWindow;
               if(!(!_loc6_ || !_loc8_))
               {
                  for each(var _loc7_ in _loc6_)
                  {
                     _loc8_.addGridItem(_loc7_.view);
                     _loc7_.view.procedure = paletteEventProc;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function showPalettes(param1:int) : void
      {
         var _loc4_:IScrollableGridWindow = var_1631.findChildByName("palette0") as IScrollableGridWindow;
         var _loc3_:IScrollableGridWindow = var_1631.findChildByName("palette1") as IScrollableGridWindow;
         var _loc5_:int = int(var_2133.width);
         var _loc2_:int = (var_2133.width - 10) / 2;
         if(param1 <= 1)
         {
            _loc4_.width = _loc5_;
            _loc4_.visible = true;
            _loc3_.visible = false;
         }
         else
         {
            _loc4_.width = _loc2_;
            _loc3_.width = _loc2_;
            _loc3_.x = _loc4_.right + 10;
            _loc4_.visible = true;
            _loc3_.visible = true;
         }
      }
      
      public function updatePart(param1:int, param2:IWindowContainer) : void
      {
         var _loc3_:IWindow = var_2133.getGridItemAt(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_ = param2;
      }
      
      private function onGridItemClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.target.name)
         {
            case "REMOVE_ITEM":
               _loc2_ = var_2133.getGridItemIndex(param1.window);
               var_1644.selectPart(var_634,_loc2_);
               break;
            case "GET_MORE":
               var_1644.controller.manager.catalog.openCatalogPage(var_1644.controller.manager.getProperty("catalog.clothes.page"));
               break;
            default:
               _loc2_ = var_2133.getGridItemIndex(param1.window);
               var_1644.selectPart(var_634,_loc2_);
         }
      }
      
      private function paletteEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc5_:int = 0;
         var _loc4_:IItemGridWindow = null;
         var _loc7_:int = 0;
         var _loc3_:IWindow = null;
         var _loc6_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = param1.window;
            _loc6_ = 0;
            while(_loc6_ < 2)
            {
               if(var_2215.length > _loc6_)
               {
                  if((_loc7_ = (_loc4_ = var_2215[_loc6_] as IItemGridWindow).getGridItemIndex(_loc3_)) > -1)
                  {
                     var_1644.selectColor(var_634,_loc7_,_loc6_);
                     return;
                  }
               }
               _loc6_++;
            }
         }
      }
   }
}
