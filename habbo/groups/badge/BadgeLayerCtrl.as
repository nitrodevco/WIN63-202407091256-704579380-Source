package com.sulake.habbo.groups.badge
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.groups.ColorGridCtrl;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BadgeLayerCtrl
   {
      
      public static var BASE_LAYER_INDEX:int = 0;
      
      public static var PARENT_CONTAINER_NAME:String = "part_edit_list";
       
      
      private var var_480:HabboGroupsManager;
      
      private var var_1823:BadgeEditorCtrl;
      
      private var var_3241:int = 0;
      
      private var var_1812:BadgeLayerOptions;
      
      private var var_2197:IWindowContainer;
      
      private var var_2746:ColorGridCtrl;
      
      private var _disposed:Boolean = false;
      
      private var var_4860:BitmapData;
      
      private var var_2798:IBitmapWrapperWindow;
      
      private var var_3702:class_3357;
      
      private var var_3377:IWindowContainer;
      
      private var var_2732:IBitmapWrapperWindow;
      
      private var var_3227:IBitmapWrapperWindow;
      
      public function BadgeLayerCtrl(param1:HabboGroupsManager, param2:BadgeEditorCtrl, param3:int)
      {
         super();
         var_480 = param1;
         var_1823 = param2;
         var_3241 = param3;
         var_1812 = new BadgeLayerOptions();
         var_1812.layerIndex = param3;
         var_4860 = var_480.getButtonImage("badge_part_add");
      }
      
      public function createWindow() : void
      {
         if(var_2197 != null)
         {
            return;
         }
         var _loc1_:IItemListWindow = var_1823.partEditContainer.findChildByName(PARENT_CONTAINER_NAME) as IItemListWindow;
         var_2197 = var_480.getXmlWindow("badge_layer") as IWindowContainer;
         var _loc2_:IWindowContainer = var_2197.findChildByName("preview_container") as IWindowContainer;
         var_2798 = _loc2_.findChildByName("part_preview") as IBitmapWrapperWindow;
         var_2798.bitmap = var_480.getButtonImage("badge_part_add");
         var_3702 = _loc2_.findChildByName("part_button") as class_3357;
         var_3702.procedure = onPartPreviewButtonClick;
         var_3377 = var_2197.findChildByName("position_container") as IWindowContainer;
         var_2732 = var_3377.findChildByName("position_picker") as IBitmapWrapperWindow;
         var_2732.bitmap = var_480.getButtonImage("position_picker");
         var_3227 = var_3377.findChildByName("position_grid") as IBitmapWrapperWindow;
         var_3227.bitmap = var_480.getButtonImage("position_grid");
         if(var_3241 == 0)
         {
            var_3227.visible = false;
            var_2732.visible = false;
         }
         else
         {
            var_3227.procedure = onPositionGridClick;
         }
         var_2746 = new ColorGridCtrl(var_480,onColorSelected);
         var_2746.createAndAttach(var_2197,"color_selector",var_480.guildEditorData.badgeColors);
         if(var_1812.layerIndex == BASE_LAYER_INDEX)
         {
            _loc1_.addListItem(var_2197);
         }
         else
         {
            _loc1_.addListItemAt(var_2197,0);
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_2746)
            {
               var_2746.dispose();
               var_2746 = null;
            }
            if(var_2197)
            {
               var_2197.dispose();
               var_2197 = null;
            }
            var_2798 = null;
            var_3702 = null;
            var_3377 = null;
            var_2732 = null;
            var_3227 = null;
            var_480 = null;
            _disposed = true;
         }
      }
      
      public function setLayerOptions(param1:BadgeLayerOptions) : void
      {
         if(param1.layerIndex != var_1812.layerIndex)
         {
            throw new Error("Tried to set layer option with invalid layerIndex value");
         }
         var _loc2_:Boolean = false;
         var _loc3_:BadgeLayerOptions = var_1812;
         var_1812 = param1.clone();
         if(!var_1812.isGridEqual(_loc3_))
         {
            updatePositionPicker(false);
            _loc2_ = true;
         }
         if(_loc3_.colorIndex != var_1812.colorIndex)
         {
            var_2746.setSelectedColorIndex(var_1812.colorIndex,false);
            var_1812.colorIndex = var_2746.selectedColorIndex;
            _loc2_ = true;
         }
         if(_loc2_ || _loc3_.partIndex != var_1812.partIndex)
         {
            updateSelectedPart();
         }
      }
      
      public function get layerOptions() : BadgeLayerOptions
      {
         return var_1812;
      }
      
      public function updateSelectedPart() : void
      {
         var _loc1_:BitmapData = null;
         if(var_1823.badgeSelectPartCtrl)
         {
            _loc1_ = var_1823.badgeSelectPartCtrl.getPartItemImage(layerOptions);
         }
         if(_loc1_ == null)
         {
            _loc1_ = var_4860;
         }
         var_2798.bitmap.dispose();
         var_2798.bitmap = new BitmapData(_loc1_.width,_loc1_.height);
         var_2798.bitmap.copyPixels(_loc1_,_loc1_.rect,new Point());
         var_1823.onPartChanged(this);
      }
      
      private function updatePositionPicker(param1:Boolean = true) : void
      {
         var_2732.x = var_1812.gridX * 14 + 1;
         var_2732.y = var_1812.gridY * 14 + 1;
         if(param1)
         {
            updateSelectedPart();
         }
      }
      
      private function onPositionGridClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK" || !var_2732)
         {
            return;
         }
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         var_1812.gridX = Math.min(2,Math.max(0,Math.floor(_loc3_.localX / 14)));
         var_1812.gridY = Math.min(2,Math.max(0,Math.floor(_loc3_.localY / 14)));
         updatePositionPicker();
      }
      
      private function onPartPreviewButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_1823.onShowSelectPart(this);
      }
      
      public function onColorSelected(param1:ColorGridCtrl) : void
      {
         if(var_1812.colorIndex != param1.selectedColorIndex)
         {
            var_1812.colorIndex = param1.selectedColorIndex;
            updateSelectedPart();
         }
      }
   }
}
