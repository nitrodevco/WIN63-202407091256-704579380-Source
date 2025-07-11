package com.sulake.habbo.groups
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import com.sulake.habbo.communication.messages.incoming.users.class_1688;
   
   public class ColorGridCtrl
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var var_3883:IWindowContainer;
      
      private var _parentCallback:Function;
      
      private var var_2608:Vector.<class_1688>;
      
      private var var_2107:IItemGridWindow;
      
      private var var_2390:int = -1;
      
      private var var_3171:BitmapData;
      
      private var var_2170:BitmapData;
      
      private var var_3110:BitmapData;
      
      private var _disposed:Boolean = false;
      
      public function ColorGridCtrl(param1:HabboGroupsManager, param2:Function)
      {
         super();
         var_480 = param1;
         _parentCallback = param2;
      }
      
      public function get selectedColorIndex() : int
      {
         return var_2390;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_2608 != null && var_2107 != null;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_2107)
            {
               var_2107.destroyGridItems();
               var_2107 = null;
            }
            if(var_2170)
            {
               var_2170.dispose();
               var_2170 = null;
            }
            if(var_3110)
            {
               var_3110.dispose();
               var_3110 = null;
            }
            if(var_2170)
            {
               var_2170.dispose();
               var_2170 = null;
            }
            if(var_3171)
            {
               var_3171.dispose();
               var_3171 = null;
            }
            var_480 = null;
            var_3883 = null;
            _disposed = true;
         }
      }
      
      public function createAndAttach(param1:IWindowContainer, param2:String, param3:Vector.<class_1688>) : void
      {
         var _loc4_:IWindowContainer = null;
         if(var_2107 != null || param1 == null || param2 == null || param3 == null)
         {
            return;
         }
         var_3883 = param1;
         var_2608 = param3;
         var_2107 = var_3883.findChildByName(param2) as IItemGridWindow;
         var_2170 = getBitmap("color_chooser_bg");
         var_3110 = getBitmap("color_chooser_fg");
         var_3171 = getBitmap("color_chooser_selected");
         for each(var _loc5_ in var_2608)
         {
            (_loc4_ = var_480.getXmlWindow("badge_color_item") as IWindowContainer).procedure = onClick;
            _loc4_.background = true;
            _loc4_.color = 4290689957;
            _loc4_.width = var_2170.width;
            _loc4_.height = var_2170.height;
            setGridItemBitmap(_loc4_,"background",var_2170,true,null);
            setGridItemBitmap(_loc4_,"foreground",var_3110,true,_loc5_);
            setGridItemBitmap(_loc4_,"selected",var_3171,false,null);
            var_2107.addGridItem(_loc4_);
         }
      }
      
      private function setGridItemBitmap(param1:IWindowContainer, param2:String, param3:BitmapData, param4:Boolean, param5:class_1688 = null) : void
      {
         var _loc7_:BitmapData = null;
         var _loc6_:IBitmapWrapperWindow;
         if((_loc6_ = param1.findChildByName(param2) as IBitmapWrapperWindow) != null)
         {
            _loc7_ = param3.clone();
            if(param5 != null)
            {
               _loc7_.colorTransform(_loc7_.rect,new ColorTransform(param5.red / 255,param5.green / 255,param5.blue / 255));
            }
            _loc6_.bitmap = _loc7_;
            _loc6_.visible = param4;
         }
      }
      
      public function setSelectedColorIndex(param1:int, param2:Boolean = true) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(var_2390 != param1 && param1 < var_2107.numGridItems)
         {
            setSelectedItemVisibility(var_2390,false);
            var_2390 = param1;
            setSelectedItemVisibility(var_2390,true);
         }
         if(param2 && _parentCallback != null)
         {
            _parentCallback(this);
         }
      }
      
      public function setSelectedColorById(param1:int) : void
      {
         var _loc2_:int = 0;
         if(!isInitialized)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < var_2608.length)
         {
            if(var_2608[_loc2_].id == param1)
            {
               setSelectedColorIndex(_loc2_);
               return;
            }
            _loc2_++;
         }
         setSelectedColorIndex(0);
      }
      
      public function getSelectedColorId() : int
      {
         var _loc1_:class_1688 = getSelectedColorData();
         if(_loc1_ != null)
         {
            return _loc1_.id;
         }
         return 0;
      }
      
      public function getSelectedColorData() : class_1688
      {
         if(var_2608 != null && var_2390 >= 0 && var_2390 < var_2608.length)
         {
            return var_2608[var_2390];
         }
         return null;
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc2_:BitmapDataAsset = var_480.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_)
         {
            _loc3_ = _loc2_.content as BitmapData;
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         throw new Exception("Failed to load bitmap asset " + param1 + " in ColorGridWidget");
      }
      
      private function setSelectedItemVisibility(param1:int, param2:Boolean) : void
      {
         var _loc3_:IWindow = null;
         if(param1 < 0 || param1 >= var_2107.numGridItems)
         {
            return;
         }
         var _loc4_:IWindowContainer;
         if((_loc4_ = var_2107.getGridItemAt(param1) as IWindowContainer) != null)
         {
            _loc3_ = _loc4_.findChildByName("selected") as IWindow;
            if(_loc3_ != null)
            {
               _loc3_.visible = param2;
            }
         }
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         setSelectedColorIndex(var_2107.getGridItemIndex(param2));
      }
   }
}
