package com.sulake.habbo.groups.badge
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.groups.*;
   import com.sulake.habbo.groups.events.HabboGroupsEditorData;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.users.class_1654;
   
   public class BadgeEditorCtrl implements IDisposable
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:IWindowContainer;
      
      private var var_3883:IWindowContainer;
      
      private var var_2421:Array;
      
      private var var_2175:BadgeSelectPartCtrl;
      
      private var _disposed:Boolean = false;
      
      private var _layers:Vector.<BadgeLayerCtrl>;
      
      private var var_2209:BadgeLayerOptions;
      
      private var var_1936:IWindowContainer;
      
      private var var_3073:IItemGridWindow;
      
      private var var_2267:IWindowContainer;
      
      private var var_2001:Vector.<IBitmapWrapperWindow>;
      
      public function BadgeEditorCtrl(param1:HabboGroupsManager)
      {
         super();
         var_480 = param1;
         var_480.events.addEventListener("HGE_EDIT_INFO",onHabboGroupsEditorData);
         var_2175 = new BadgeSelectPartCtrl(var_480,this);
         _layers = new Vector.<BadgeLayerCtrl>();
         _layers.push(new BadgeLayerCtrl(var_480,this,0));
         _layers.push(new BadgeLayerCtrl(var_480,this,1));
         _layers.push(new BadgeLayerCtrl(var_480,this,2));
         _layers.push(new BadgeLayerCtrl(var_480,this,3));
         _layers.push(new BadgeLayerCtrl(var_480,this,4));
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get partEditContainer() : IWindowContainer
      {
         return var_2267;
      }
      
      public function get partSelectContainer() : IWindowContainer
      {
         return var_1936;
      }
      
      public function get partSelectGrid() : IItemGridWindow
      {
         return var_3073;
      }
      
      public function get currentLayerOptions() : BadgeLayerOptions
      {
         return var_2209;
      }
      
      public function get badgeSelectPartCtrl() : BadgeSelectPartCtrl
      {
         return var_2175;
      }
      
      public function get isIntialized() : Boolean
      {
         return _window != null && var_2421 != null;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_layers)
            {
               for each(var _loc1_ in _layers)
               {
                  _loc1_.dispose();
               }
               _layers = null;
            }
            if(var_2175)
            {
               var_2175.dispose();
               var_2175 = null;
            }
            if(var_1936)
            {
               var_1936.dispose();
               var_1936 = null;
            }
            if(var_3073)
            {
               var_3073.dispose();
               var_3073 = null;
            }
            if(var_2267)
            {
               var_2267.dispose();
               var_2267 = null;
            }
            if(var_2001)
            {
               for each(var _loc2_ in var_2001)
               {
                  _loc2_.dispose();
               }
               var_2001 = null;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            var_2421 = null;
            var_2209 = null;
            _window = null;
            var_480 = null;
            _disposed = true;
         }
      }
      
      public function onHabboGroupsEditorData(param1:HabboGroupsEditorData) : void
      {
         var_2175.loadData();
         createWindow(null,null);
      }
      
      public function createWindow(param1:IWindowContainer, param2:Array) : void
      {
         var _loc3_:int = 0;
         if(_window != null || _disposed)
         {
            return;
         }
         if(param1 != null)
         {
            var_3883 = param1;
         }
         if(param2 != null)
         {
            var_2421 = param2;
         }
         if(var_3883 == null || var_2421 == null || var_480 == null || var_480.guildEditorData == null)
         {
            return;
         }
         _window = var_480.getXmlWindow("badge_editor") as IWindowContainer;
         var _loc4_:IWindowContainer = _window.findChildByName("guild_badge") as IWindowContainer;
         var_2001 = new Vector.<IBitmapWrapperWindow>();
         var_2001.push(_loc4_.findChildByName("layer_0") as IBitmapWrapperWindow);
         var_2001.push(_loc4_.findChildByName("layer_1") as IBitmapWrapperWindow);
         var_2001.push(_loc4_.findChildByName("layer_2") as IBitmapWrapperWindow);
         var_2001.push(_loc4_.findChildByName("layer_3") as IBitmapWrapperWindow);
         var_2001.push(_loc4_.findChildByName("layer_4") as IBitmapWrapperWindow);
         var_2267 = _window.findChildByName("part_edit") as IWindowContainer;
         var_1936 = _window.findChildByName("part_select") as IWindowContainer;
         var_1936.visible = false;
         var_3073 = var_1936.findChildByName("part_select_grid") as IItemGridWindow;
         _loc3_ = 0;
         while(_loc3_ < _layers.length)
         {
            _layers[_loc3_].createWindow();
            _loc3_++;
         }
         resetLayerOptions(var_2421);
         var_3883.addChild(_window);
      }
      
      public function resetLayerOptions(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(!this.isIntialized)
         {
            return;
         }
         if(var_1936.visible)
         {
            var_1936.visible = false;
            var_2267.visible = true;
         }
         var_2421 = param1;
         var_2209 = null;
         var_2267.visible = true;
         var_1936.visible = false;
         var_2175.loadData();
         _loc2_ = 0;
         while(_loc2_ < _layers.length)
         {
            _layers[_loc2_].setLayerOptions(createLayerOption(_loc2_));
            _layers[_loc2_].updateSelectedPart();
            _loc2_++;
         }
      }
      
      private function createLayerOption(param1:int) : BadgeLayerOptions
      {
         var _loc3_:int = 0;
         var _loc2_:class_1654 = var_2421[param1] as class_1654;
         var _loc4_:BadgeLayerOptions;
         (_loc4_ = new BadgeLayerOptions()).layerIndex = param1;
         _loc4_.colorIndex = 0;
         _loc4_.setGrid(_loc2_.position);
         _loc3_ = 0;
         while(_loc3_ < var_480.guildEditorData.badgeColors.length)
         {
            if(var_480.guildEditorData.badgeColors[_loc3_].id == _loc2_.colorId)
            {
               _loc4_.colorIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(param1 == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            _loc3_ = 0;
            while(_loc3_ < var_480.guildEditorData.baseParts.length)
            {
               if(var_480.guildEditorData.baseParts[_loc3_].id == _loc2_.partId)
               {
                  _loc4_.partIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < var_480.guildEditorData.layerParts.length)
            {
               if(var_480.guildEditorData.layerParts[_loc3_].id == _loc2_.partId)
               {
                  _loc4_.partIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc4_;
      }
      
      public function onPartSelected(param1:BadgeSelectPartCtrl) : void
      {
         var_2209.partIndex = param1.getSelectedPartIndex();
         _layers[var_2209.layerIndex].setLayerOptions(currentLayerOptions);
         var_2267.visible = true;
         var_1936.visible = false;
      }
      
      public function onPartHover(param1:BadgeSelectPartCtrl) : void
      {
         updatePreviewImage(param1.layerOptions);
      }
      
      public function onPartChanged(param1:BadgeLayerCtrl) : void
      {
         updatePreviewImage(param1.layerOptions);
      }
      
      public function updatePreviewImage(param1:BadgeLayerOptions) : void
      {
         var _loc2_:BitmapData = var_2175.getPartItemImage(param1);
         if(_loc2_ != null)
         {
            var_2001[param1.layerIndex].bitmap = _loc2_.clone();
            var_2001[param1.layerIndex].visible = true;
         }
         else
         {
            var_2001[param1.layerIndex].visible = false;
         }
      }
      
      public function onShowSelectPart(param1:BadgeLayerCtrl) : void
      {
         var _loc2_:BadgeLayerOptions = var_2209;
         var_2209 = param1.layerOptions.clone();
         if(!param1.layerOptions.equalVisuals(_loc2_))
         {
            var_2175.updateGrid();
         }
         else
         {
            var_2175.layerOptions = var_2209.clone();
         }
         var_2267.visible = false;
         var_1936.visible = true;
      }
      
      public function onViewChange() : void
      {
         if(isIntialized && Boolean(var_1936.visible))
         {
            updatePreviewImage(var_2209);
            var_2267.visible = true;
            var_1936.visible = false;
         }
      }
      
      public function getBadgeSettings() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         for each(var _loc4_ in _layers)
         {
            _loc2_ = getLayerPartId(_loc4_.layerOptions);
            if(_loc2_ >= 0)
            {
               _loc3_ = getLayerColorId(_loc4_.layerOptions);
               if(_loc3_ >= 0)
               {
                  _loc1_.push(_loc2_);
                  _loc1_.push(_loc3_);
                  _loc1_.push(_loc4_.layerOptions.position);
               }
            }
         }
         return _loc1_;
      }
      
      public function get primaryColorIndex() : int
      {
         if(_layers == null)
         {
            return 0;
         }
         var _loc1_:int = 0;
         for each(var _loc2_ in _layers)
         {
            if(!(getLayerPartId(_loc2_.layerOptions) < 0 || getLayerColorId(_loc2_.layerOptions) < 0))
            {
               _loc1_ = _loc2_.layerOptions.colorIndex;
            }
         }
         return _loc1_;
      }
      
      public function get secondaryColorIndex() : int
      {
         if(_layers != null)
         {
            return _layers[0].layerOptions.colorIndex;
         }
         return 0;
      }
      
      public function getBadgeBitmap() : BitmapData
      {
         var _loc1_:BitmapData = new BitmapData(BadgeEditorPartItem.IMAGE_WIDTH,BadgeEditorPartItem.IMAGE_HEIGHT,true,15329761);
         for each(var _loc2_ in var_2001)
         {
            if(_loc2_.visible)
            {
               _loc1_.copyPixels(_loc2_.bitmap,_loc1_.rect,new Point(),null,null,true);
            }
         }
         return _loc1_;
      }
      
      private function getLayerPartId(param1:BadgeLayerOptions) : int
      {
         if(param1.partIndex < 0)
         {
            return -1;
         }
         if(param1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            if(param1.partIndex >= var_480.guildEditorData.baseParts.length)
            {
               return -1;
            }
            return var_480.guildEditorData.baseParts[param1.partIndex].id;
         }
         if(param1.partIndex >= var_480.guildEditorData.layerParts.length)
         {
            return -1;
         }
         return var_480.guildEditorData.layerParts[param1.partIndex].id;
      }
      
      private function getLayerColorId(param1:BadgeLayerOptions) : int
      {
         if(param1.colorIndex < 0 || param1.colorIndex >= var_480.guildEditorData.badgeColors.length)
         {
            return -1;
         }
         return var_480.guildEditorData.badgeColors[param1.colorIndex].id;
      }
   }
}
