package com.sulake.habbo.avatar.common
{
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.class_3418;
   import com.sulake.habbo.inventory.class_1814;
   
   public class CategoryData
   {
       
      
      private const MAX_PALETTES:int = 2;
      
      private var var_1891:Array;
      
      private var var_2002:Array;
      
      private var var_2710:int = -1;
      
      private var var_1913:Array;
      
      public function CategoryData(param1:Array, param2:Array)
      {
         super();
         var_1891 = param1;
         var_2002 = param2;
      }
      
      private static function defaultColorId(param1:Array, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:AvatarEditorGridColorItem = null;
         if(!param1 || param1.length == 0)
         {
            return -1;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if((_loc4_ = param1[_loc3_]).partColor && _loc4_.partColor.clubLevel <= param2)
            {
               return _loc4_.partColor.id;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function dispose() : void
      {
         if(var_1891)
         {
            for each(var _loc2_ in var_1891)
            {
               _loc2_.dispose();
            }
            var_1891 = null;
         }
         if(var_2002)
         {
            for each(var _loc3_ in var_2002 as Array)
            {
               if(_loc3_)
               {
                  for each(var _loc1_ in _loc3_)
                  {
                     _loc1_.dispose();
                  }
               }
            }
            var_2002 = null;
         }
         var_2710 = -1;
         var_1913 = null;
      }
      
      public function selectPartId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AvatarEditorGridPartItem = null;
         if(!var_1891)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < var_1891.length)
         {
            _loc2_ = var_1891[_loc3_];
            if(_loc2_.id == param1)
            {
               selectPartIndex(_loc3_);
               return;
            }
            _loc3_++;
         }
      }
      
      public function selectColorIds(param1:Array) : void
      {
         var _loc6_:AvatarEditorGridColorItem = null;
         var _loc7_:int = 0;
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:AvatarEditorGridColorItem = null;
         var _loc4_:int = 0;
         if(!var_2002)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         var_1913 = new Array(param1.length);
         _loc7_ = 0;
         while(_loc7_ < var_2002.length)
         {
            if(_loc5_ = getPalette(_loc7_))
            {
               if(param1.length > _loc7_)
               {
                  _loc3_ = int(param1[_loc7_]);
               }
               else
               {
                  _loc2_ = _loc5_[0] as AvatarEditorGridColorItem;
                  if(_loc2_ && _loc2_.partColor)
                  {
                     _loc3_ = _loc2_.partColor.id;
                  }
               }
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  if((_loc6_ = _loc5_[_loc4_] as AvatarEditorGridColorItem).partColor.id == _loc3_)
                  {
                     var_1913[_loc7_] = _loc4_;
                     _loc6_.isSelected = true;
                  }
                  else
                  {
                     _loc6_.isSelected = false;
                  }
                  _loc4_++;
               }
            }
            _loc7_++;
         }
         updatePartColors();
      }
      
      public function selectPartIndex(param1:int) : AvatarEditorGridPartItem
      {
         var _loc2_:AvatarEditorGridPartItem = null;
         var _loc3_:AvatarEditorGridPartItem = null;
         if(!var_1891)
         {
            return null;
         }
         if(var_2710 >= 0 && var_1891.length > var_2710)
         {
            _loc2_ = var_1891[var_2710];
            if(_loc2_)
            {
               _loc2_.isSelected = false;
            }
         }
         if(var_1891.length > param1)
         {
            _loc3_ = var_1891[param1] as AvatarEditorGridPartItem;
            if(_loc3_)
            {
               _loc3_.isSelected = true;
               var_2710 = param1;
               return _loc3_;
            }
         }
         return null;
      }
      
      public function selectColorIndex(param1:int, param2:int) : AvatarEditorGridColorItem
      {
         var _loc4_:Array;
         if(!(_loc4_ = getPalette(param2)))
         {
            return null;
         }
         if(_loc4_.length <= param1)
         {
            return null;
         }
         deselectColorIndex(var_1913[param2],param2);
         var_1913[param2] = param1;
         var _loc3_:AvatarEditorGridColorItem = _loc4_[param1] as AvatarEditorGridColorItem;
         if(!_loc3_)
         {
            return null;
         }
         _loc3_.isSelected = true;
         updatePartColors();
         return _loc3_;
      }
      
      public function getCurrentColorIndex(param1:int) : int
      {
         return var_1913[param1];
      }
      
      private function deselectColorIndex(param1:int, param2:int) : void
      {
         var _loc4_:Array;
         if(!(_loc4_ = getPalette(param2)))
         {
            return;
         }
         if(_loc4_.length <= param1)
         {
            return;
         }
         var _loc3_:AvatarEditorGridColorItem = _loc4_[param1] as AvatarEditorGridColorItem;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.isSelected = false;
      }
      
      public function getSelectedColorIds() : Array
      {
         var _loc8_:int = 0;
         var _loc7_:Array = null;
         var _loc5_:AvatarEditorGridColorItem = null;
         if(!var_1913 || var_1913.length == 0)
         {
            return null;
         }
         if(!var_2002 || var_2002.length == 0)
         {
            return null;
         }
         var _loc4_:Array;
         if(!(_loc4_ = var_2002[0] as Array) || _loc4_.length == 0)
         {
            return null;
         }
         var _loc3_:AvatarEditorGridColorItem = _loc4_[0] as AvatarEditorGridColorItem;
         if(!_loc3_ || !_loc3_.partColor)
         {
            return null;
         }
         var _loc1_:int = _loc3_.partColor.id;
         var _loc2_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < var_1913.length)
         {
            if(!(!(_loc7_ = var_2002[_loc8_]) || _loc7_.length <= _loc8_))
            {
               if(_loc7_.length > var_1913[_loc8_])
               {
                  if((_loc5_ = _loc7_[var_1913[_loc8_]] as AvatarEditorGridColorItem) && _loc5_.partColor)
                  {
                     _loc2_.push(_loc5_.partColor.id);
                  }
                  else
                  {
                     _loc2_.push(_loc1_);
                  }
               }
               else
               {
                  _loc2_.push(_loc1_);
               }
            }
            _loc8_++;
         }
         var _loc6_:AvatarEditorGridPartItem;
         if(!(_loc6_ = getCurrentPart()))
         {
            return null;
         }
         return _loc2_.slice(0,Math.max(_loc6_.colorLayerCount,1));
      }
      
      private function getSelectedColors() : Array
      {
         var _loc3_:AvatarEditorGridColorItem = null;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < var_1913.length)
         {
            _loc3_ = getSelectedColor(_loc2_);
            if(_loc3_)
            {
               _loc1_.push(_loc3_.partColor);
            }
            else
            {
               _loc1_.push(null);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getSelectedColor(param1:int) : AvatarEditorGridColorItem
      {
         var _loc2_:Array = getPalette(param1);
         if(!_loc2_ || _loc2_.length <= var_1913[param1])
         {
            return null;
         }
         return _loc2_[var_1913[param1]] as AvatarEditorGridColorItem;
      }
      
      public function getCurrentColorId(param1:int) : int
      {
         var _loc2_:AvatarEditorGridColorItem = getSelectedColor(param1);
         if(_loc2_ && _loc2_.partColor)
         {
            return _loc2_.partColor.id;
         }
         return 0;
      }
      
      public function get parts() : Array
      {
         return var_1891;
      }
      
      public function getPalette(param1:int) : Array
      {
         if(!var_1913)
         {
            return null;
         }
         if(!var_2002)
         {
            return null;
         }
         if(var_2002.length <= param1)
         {
            return null;
         }
         return var_2002[param1] as Array;
      }
      
      public function getCurrentPart() : AvatarEditorGridPartItem
      {
         return var_1891[var_2710] as AvatarEditorGridPartItem;
      }
      
      private function updatePartColors() : void
      {
         var _loc2_:Array = getSelectedColors();
         for each(var _loc1_ in var_1891)
         {
            if(_loc1_)
            {
               _loc1_.colors = _loc2_;
            }
         }
      }
      
      public function hasClubSelectionsOverLevel(param1:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc8_:IPartColor = null;
         var _loc2_:class_3418 = null;
         var _loc5_:Boolean = false;
         var _loc7_:Array;
         if(_loc7_ = getSelectedColors())
         {
            _loc6_ = 0;
            while(_loc6_ < _loc7_.length)
            {
               if((_loc8_ = _loc7_[_loc6_]) != null && _loc8_.clubLevel > param1)
               {
                  _loc5_ = true;
               }
               _loc6_++;
            }
         }
         var _loc3_:Boolean = false;
         var _loc4_:AvatarEditorGridPartItem;
         if((_loc4_ = getCurrentPart()) != null && _loc4_.partSet)
         {
            _loc2_ = _loc4_.partSet;
            if(_loc2_ != null && _loc2_.clubLevel > param1)
            {
               _loc3_ = true;
            }
         }
         return _loc5_ || _loc3_;
      }
      
      public function hasInvalidSellableItems(param1:class_1814) : Boolean
      {
         var _loc2_:class_3418 = null;
         var _loc3_:Boolean = false;
         var _loc4_:AvatarEditorGridPartItem;
         if((_loc4_ = getCurrentPart()) != null && _loc4_.partSet)
         {
            _loc2_ = _loc4_.partSet;
            if(_loc2_ != null && _loc2_.isSellable && !param1.hasFigureSetIdInInventory(_loc2_.id))
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function stripClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc3_:class_3418 = null;
         var _loc2_:AvatarEditorGridPartItem = null;
         var _loc4_:AvatarEditorGridPartItem;
         if((_loc4_ = getCurrentPart()) && _loc4_.partSet)
         {
            _loc3_ = _loc4_.partSet;
            if(_loc3_.clubLevel > param1)
            {
               _loc2_ = selectPartIndex(0);
               if(_loc2_ != null && _loc2_.partSet == null)
               {
                  selectPartIndex(1);
               }
               return true;
            }
         }
         return false;
      }
      
      public function stripClubColorsOverLevel(param1:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc8_:IPartColor = null;
         var _loc4_:Array = [];
         var _loc7_:Array = getSelectedColors();
         var _loc2_:Boolean = false;
         var _loc6_:Array = getPalette(0);
         var _loc3_:int = defaultColorId(_loc6_,param1);
         if(_loc3_ == -1)
         {
            return false;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            if((_loc8_ = _loc7_[_loc5_]) == null)
            {
               _loc4_.push(_loc3_);
               _loc2_ = true;
            }
            else if(_loc8_.clubLevel > param1)
            {
               _loc4_.push(_loc3_);
               _loc2_ = true;
            }
            else
            {
               _loc4_.push(_loc8_.id);
            }
            _loc5_++;
         }
         if(_loc2_)
         {
            selectColorIds(_loc4_);
         }
         return _loc2_;
      }
      
      public function stripInvalidSellableItems(param1:class_1814) : Boolean
      {
         var _loc3_:class_3418 = null;
         var _loc2_:AvatarEditorGridPartItem = null;
         var _loc4_:AvatarEditorGridPartItem;
         if((_loc4_ = getCurrentPart()) && _loc4_.partSet)
         {
            _loc3_ = _loc4_.partSet;
            if(_loc3_.isSellable && !param1.hasFigureSetIdInInventory(_loc3_.id))
            {
               _loc2_ = selectPartIndex(0);
               if(_loc2_ != null && _loc2_.partSet == null)
               {
                  selectPartIndex(1);
               }
               return true;
            }
         }
         return false;
      }
      
      public function get selectedPartIndex() : int
      {
         return var_2710;
      }
   }
}
