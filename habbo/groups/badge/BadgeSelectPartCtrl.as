package com.sulake.habbo.groups.badge
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.users.class_1684;
   
   public class BadgeSelectPartCtrl implements IDisposable
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var var_1823:BadgeEditorCtrl;
      
      private var var_2072:Vector.<BadgeEditorPartItem>;
      
      private var var_2125:Vector.<BadgeEditorPartItem>;
      
      private var var_1812:BadgeLayerOptions;
      
      private var var_1741:IWindowContainer;
      
      private var var_2352:IBitmapWrapperWindow;
      
      private var _disposed:Boolean = false;
      
      public function BadgeSelectPartCtrl(param1:HabboGroupsManager, param2:BadgeEditorCtrl)
      {
         super();
         var_480 = param1;
         var_1823 = param2;
      }
      
      public function get layerOptions() : BadgeLayerOptions
      {
         return var_1812;
      }
      
      public function set layerOptions(param1:BadgeLayerOptions) : void
      {
         var_1812 = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(!_disposed)
         {
            if(var_1823.partSelectGrid != null && var_1823.partSelectGrid.numGridItems > 0)
            {
               var_1823.partSelectGrid.destroyGridItems();
            }
            if(var_2125)
            {
               for each(_loc1_ in var_2125)
               {
                  _loc1_.dispose();
               }
               var_2125 = null;
            }
            if(var_2072)
            {
               for each(_loc1_ in var_2072)
               {
                  _loc1_.dispose();
               }
               var_2072 = null;
            }
            var_1812 = null;
            var_2352 = null;
            var_1741 = null;
            var_1823 = null;
            var_480 = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getSelectedPartIndex() : int
      {
         var _loc1_:int = -1;
         if(var_1812 != null && var_1823.partSelectGrid != null && var_1741 != null)
         {
            _loc1_ = var_1823.partSelectGrid.getGridItemIndex(var_1741);
            if(_loc1_ != -1 && var_1812.layerIndex != BadgeLayerCtrl.BASE_LAYER_INDEX)
            {
               _loc1_ -= 1;
            }
         }
         return _loc1_;
      }
      
      public function loadData() : void
      {
         var _loc1_:* = null;
         if(var_2125 != null || var_2072 != null)
         {
            return;
         }
         var_2125 = new Vector.<BadgeEditorPartItem>();
         for each(_loc1_ in var_480.guildEditorData.baseParts)
         {
            var_2125.push(new BadgeEditorPartItem(var_480,this,var_2125.length,BadgeEditorPartItem.BASE_PART,_loc1_));
         }
         var_2072 = new Vector.<BadgeEditorPartItem>();
         var_2072.push(new BadgeEditorPartItem(var_480,this,-1,BadgeEditorPartItem.LAYER_PART));
         for each(_loc1_ in var_480.guildEditorData.layerParts)
         {
            var_2072.push(new BadgeEditorPartItem(var_480,this,var_2072.length - 1,BadgeEditorPartItem.LAYER_PART,_loc1_));
         }
      }
      
      public function updateGrid() : void
      {
         var _loc1_:* = null;
         var_1741 = null;
         var_2352 = null;
         var_1812 = var_1823.currentLayerOptions.clone();
         var_1823.partSelectGrid.destroyGridItems();
         if(var_1812.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            for each(_loc1_ in var_2125)
            {
               var_1823.partSelectGrid.addGridItem(createGridItem(_loc1_));
            }
         }
         else
         {
            for each(_loc1_ in var_2072)
            {
               var_1823.partSelectGrid.addGridItem(createGridItem(_loc1_));
            }
         }
      }
      
      private function createGridItem(param1:BadgeEditorPartItem) : IWindowContainer
      {
         var _loc2_:IWindowContainer = var_480.getXmlWindow("badge_part_item") as IWindowContainer;
         _loc2_.procedure = onPartMouseEvent;
         setGridItemImage(_loc2_,param1);
         return _loc2_;
      }
      
      public function onBaseImageLoaded(param1:BadgeEditorPartItem) : void
      {
         var _loc2_:IWindowContainer = null;
         if(var_1812 != null && var_1812.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX && Boolean(var_1823.partSelectContainer.visible))
         {
            _loc2_ = var_1823.partSelectGrid.getGridItemAt(param1.partIndex) as IWindowContainer;
            setGridItemImage(_loc2_,param1);
         }
      }
      
      public function onLayerImageLoaded(param1:BadgeEditorPartItem) : void
      {
         var _loc2_:IWindowContainer = null;
         if(var_1812 != null && var_1812.layerIndex != BadgeLayerCtrl.BASE_LAYER_INDEX && Boolean(var_1823.partSelectContainer.visible))
         {
            _loc2_ = var_1823.partSelectGrid.getGridItemAt(param1.partIndex + 1) as IWindowContainer;
            setGridItemImage(_loc2_,param1);
         }
      }
      
      private function setGridItemImage(param1:IWindowContainer, param2:BadgeEditorPartItem) : void
      {
         var _loc5_:IBitmapWrapperWindow = null;
         var _loc4_:BitmapData;
         if((_loc4_ = param2.getComposite(var_1812)) != null)
         {
            (_loc5_ = param1.findChildByName("part") as IBitmapWrapperWindow).bitmap = new BitmapData(_loc4_.width,_loc4_.height);
            _loc5_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point());
         }
         var _loc3_:IBitmapWrapperWindow = param1.findChildByName("selected") as IBitmapWrapperWindow;
         _loc3_.bitmap = var_480.getButtonImage("badge_part_picker");
         if(param2.partIndex == var_1812.partIndex)
         {
            _loc3_.visible = true;
            var_2352 = _loc3_;
         }
         else
         {
            _loc3_.visible = false;
         }
      }
      
      private function onPartMouseEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:class_3437 = null;
         var _loc4_:IWindowContainer = null;
         if(param1.type == "WME_OVER")
         {
            if(var_1741 != param2)
            {
               if(var_1741 != null)
               {
                  _loc3_ = var_1741.findChildByName("background") as class_3437;
                  if(_loc3_ != null)
                  {
                     _loc3_.color = 15329761;
                  }
               }
               var_1741 = param2 as IWindowContainer;
               if(var_1741 != null)
               {
                  _loc3_ = var_1741.findChildByName("background") as class_3437;
                  if(_loc3_ != null)
                  {
                     _loc3_.color = 14210761;
                  }
                  var_1812.partIndex = getSelectedPartIndex();
                  var_1823.onPartHover(this);
               }
            }
         }
         if(param1.type == "WME_CLICK")
         {
            if(var_2352 != null)
            {
               var_2352.visible = false;
            }
            if((_loc4_ = param2 as IWindowContainer) != null)
            {
               var_2352 = _loc4_.findChildByName("selected") as IBitmapWrapperWindow;
               var_2352.visible = true;
            }
            var_1823.onPartSelected(this);
         }
      }
      
      public function getPartItemImage(param1:BadgeLayerOptions) : BitmapData
      {
         if(param1 == null || param1.partIndex < 0)
         {
            return null;
         }
         if(param1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            if(var_2125 != null && param1.partIndex < var_2125.length)
            {
               return var_2125[param1.partIndex].getComposite(param1);
            }
         }
         else if(var_2072 != null && param1.partIndex + 1 < var_2072.length)
         {
            return var_2072[param1.partIndex + 1].getComposite(param1);
         }
         return null;
      }
   }
}
