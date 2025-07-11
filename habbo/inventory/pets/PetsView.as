package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1657;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1679;
   
   public class PetsView implements IInventoryView, IGetImageListener
   {
      
      private static const UNSEEN_SYMBOL_MARGIN:int = 4;
       
      
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2286:IAssetLibrary;
      
      private var var_1631:IWindowContainer;
      
      private var var_1644:PetsModel;
      
      private var _disposed:Boolean = false;
      
      private var var_2176:IItemGridWindow;
      
      private var _roomEngine:IRoomEngine;
      
      private var _gridItems:Map;
      
      private var var_2003:PetsGridItem;
      
      private var var_3249:int = 0;
      
      private var var_3640:int;
      
      private var var_1618:Boolean = false;
      
      public function PetsView(param1:PetsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IRoomEngine)
      {
         super();
         var_1644 = param1;
         var_2286 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _gridItems = new Map();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return var_1631 && var_1631.parent != null && var_1631.visible;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            var_1644 = null;
            var_1631 = null;
            _disposed = true;
         }
      }
      
      public function update() : void
      {
         if(!var_1618)
         {
            return;
         }
         updateGrid();
         updatePreview(var_2003);
         updateContainerVisibility();
      }
      
      public function removePet(param1:int) : void
      {
         if(!var_1618)
         {
            return;
         }
         var _loc2_:PetsGridItem = _gridItems.remove(param1) as PetsGridItem;
         if(_loc2_ == null)
         {
            return;
         }
         var_2176.removeGridItem(_loc2_.window);
         if(var_2003 == _loc2_)
         {
            var_2003 = null;
            selectFirst();
         }
      }
      
      public function addPet(param1:class_1679) : void
      {
         if(!var_1618)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(_gridItems.getValue(param1.id) != null)
         {
            return;
         }
         var _loc2_:PetsGridItem = new PetsGridItem(this,param1,_windowManager,var_2286,var_1644.isUnseen(param1.id));
         if(_loc2_ != null)
         {
            var_2176.addGridItem(_loc2_.window);
            _gridItems.add(param1.id,_loc2_);
            if(var_2003 == null)
            {
               selectFirst();
            }
         }
      }
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : void
      {
         var_1644.placePetToRoom(param1,param2);
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!var_1618)
         {
            init();
         }
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
      
      public function setSelectedGridItem(param1:PetsGridItem) : void
      {
         if(!var_1618)
         {
            return;
         }
         if(var_2003 != null)
         {
            var_2003.setSelected(false);
         }
         var_2003 = param1;
         if(var_2003 != null)
         {
            var_2003.setSelected(true);
         }
         updatePreview(param1);
      }
      
      public function updateState() : void
      {
         var _loc2_:int = 0;
         if(!var_1618)
         {
            return;
         }
         var _loc1_:Map = var_1644.pets;
         if(!var_1644.isListInitialized())
         {
            _loc2_ = 1;
         }
         else if(!_loc1_ || _loc1_.length == 0)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 3;
         }
         if(var_3249 == _loc2_)
         {
            return;
         }
         var_3249 = _loc2_;
         updateContainerVisibility();
         if(var_3249 == 3)
         {
            updateGrid();
            updatePreview();
         }
      }
      
      public function getPetImage(param1:class_1679, param2:int, param3:Boolean, param4:PetsGridItem = null, param5:int = 64, param6:String = null) : BitmapData
      {
         var _loc9_:int = 0;
         var _loc10_:class_1657 = param1.figureData;
         var _loc7_:BitmapData = null;
         var _loc8_:uint = parseInt(_loc10_.color,16);
         var _loc11_:uint = 0;
         var _loc13_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc10_.customPartCount * 3)
         {
            _loc13_.push(new PetCustomPart(_loc10_.customParts[_loc9_],_loc10_.customParts[_loc9_ + 1],_loc10_.customParts[_loc9_ + 2]));
            _loc9_ += 3;
         }
         var _loc12_:class_3499;
         if((_loc12_ = _roomEngine.getPetImage(_loc10_.typeId,_loc10_.paletteId,_loc8_,new Vector3d(param2 * 45),param5,this,param3,_loc11_,_loc13_,param6)) != null)
         {
            _loc7_ = _loc12_.data;
            if(param4 != null)
            {
               param4.imageDownloadId = _loc12_.id;
            }
            else if(param3)
            {
               var_3640 = _loc12_.id;
            }
         }
         if(_loc7_ == null)
         {
            _loc7_ = new BitmapData(30,30,false,4289374890);
         }
         return _loc7_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == var_3640)
         {
            updatePreview(var_2003);
            return;
         }
         for each(var _loc3_ in _gridItems)
         {
            if(_loc3_.imageDownloadId == param1)
            {
               _loc3_.setPetImage(param2);
               return;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function selectFirst() : void
      {
         if(_gridItems == null || _gridItems.length == 0)
         {
            updatePreview();
            return;
         }
         setSelectedGridItem(_gridItems.getWithIndex(0));
      }
      
      public function selectById(param1:int) : void
      {
         setSelectedGridItem(_gridItems.getValue(param1));
      }
      
      private function updateGrid() : void
      {
         var _loc4_:int = 0;
         var _loc3_:PetsGridItem = null;
         if(var_1631 == null)
         {
            return;
         }
         var _loc1_:Array = _gridItems.getKeys();
         var _loc2_:Array = !!var_1644.pets ? var_1644.pets.getKeys() : [];
         var_2176.lock();
         for each(_loc4_ in _loc1_)
         {
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               removePet(_loc4_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc1_.indexOf(_loc4_) == -1)
            {
               addPet(var_1644.pets.getValue(_loc4_));
            }
            _loc3_ = _gridItems.getValue(_loc4_);
            _loc3_.setUnseen(var_1644.isUnseen(_loc4_));
         }
         var_2176.unlock();
      }
      
      private function startPlacingHandler(param1:WindowMouseEvent) : void
      {
         if(var_2003 == null)
         {
            return;
         }
         var _loc2_:class_1679 = var_2003.pet;
         if(_loc2_ == null)
         {
            return;
         }
         placePetToRoom(_loc2_.id);
      }
      
      private function updateContainerVisibility() : void
      {
         if(var_1644.controller.currentCategoryId != "pets")
         {
            return;
         }
         var _loc1_:IWindowContainer = var_1644.controller.view.loadingContainer;
         var _loc3_:IWindowContainer = var_1644.controller.view.emptyContainer;
         var _loc4_:IWindow = var_1631.findChildByName("grid");
         var _loc2_:IWindow = var_1631.findChildByName("preview_container");
         switch(var_3249 - 1)
         {
            case 0:
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
               _loc4_.visible = false;
               _loc2_.visible = false;
               break;
            case 1:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc3_)
               {
                  _loc3_.visible = true;
               }
               _loc4_.visible = false;
               _loc2_.visible = false;
               break;
            case 2:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
               _loc4_.visible = true;
               _loc2_.visible = true;
         }
      }
      
      private function updatePreview(param1:PetsGridItem = null) : void
      {
         var _loc15_:BitmapData = null;
         var _loc8_:String = null;
         var _loc7_:String = null;
         var _loc11_:Boolean = false;
         var _loc16_:class_1679 = null;
         var _loc3_:BitmapData = null;
         if(var_1631 == null)
         {
            return;
         }
         var _loc5_:int = 64;
         var _loc17_:int = 4;
         var _loc14_:Boolean = true;
         var _loc4_:String = null;
         var_3640 = -1;
         if(param1 == null || param1.pet == null)
         {
            _loc15_ = new BitmapData(1,1);
            _loc8_ = "";
            _loc7_ = "";
            _loc11_ = false;
         }
         else
         {
            _loc8_ = (_loc16_ = param1.pet).name;
            if(_loc16_.typeId == 16)
            {
               _loc17_ = 2;
               _loc14_ = true;
               if(_loc16_.level >= 7)
               {
                  _loc4_ = "std";
               }
               else
               {
                  _loc4_ = "grw" + _loc16_.level;
               }
            }
            _loc15_ = getPetImage(_loc16_,_loc17_,_loc14_,null,_loc5_,_loc4_);
            _loc11_ = true;
         }
         var _loc10_:IBitmapWrapperWindow;
         if((_loc10_ = var_1631.findChildByName("preview_image") as IBitmapWrapperWindow) != null)
         {
            _loc3_ = new BitmapData(_loc10_.width,_loc10_.height);
            _loc3_.fillRect(_loc3_.rect,0);
            _loc3_.copyPixels(_loc15_,_loc15_.rect,new Point(_loc3_.width / 2 - _loc15_.width / 2,_loc3_.height / 2 - _loc15_.height / 2));
            _loc10_.bitmap = _loc3_;
         }
         _loc15_.dispose();
         var _loc6_:ITextWindow;
         if((_loc6_ = var_1631.findChildByName("preview_text") as ITextWindow) != null)
         {
            _loc6_.caption = _loc8_;
         }
         if((_loc6_ = var_1631.findChildByName("preview_description") as ITextWindow) != null)
         {
            _loc6_.caption = _loc7_;
         }
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         if(var_1644.roomSession != null)
         {
            _loc12_ = var_1644.roomSession.arePetsAllowed;
            _loc13_ = var_1644.roomSession.isRoomOwner;
         }
         var _loc2_:String = "";
         if(!_loc13_)
         {
            if(_loc12_)
            {
               _loc2_ = "${inventory.pets.allowed}";
            }
            else
            {
               _loc2_ = "${inventory.pets.forbidden}";
            }
         }
         if((_loc6_ = var_1631.findChildByName("preview_info") as ITextWindow) != null)
         {
            _loc6_.caption = _loc2_;
         }
         var _loc9_:class_3357;
         if((_loc9_ = var_1631.findChildByName("place_button") as class_3357) != null)
         {
            if(_loc11_ && (_loc13_ || _loc12_))
            {
               _loc9_.enable();
            }
            else
            {
               _loc9_.disable();
            }
         }
      }
      
      private function init() : void
      {
         var _loc1_:class_3357 = null;
         var_1631 = var_1644.controller.view.getView("pets");
         var_1631.visible = false;
         var_2176 = var_1631.findChildByName("grid") as IItemGridWindow;
         _loc1_ = var_1631.findChildByName("place_button") as class_3357;
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",startPlacingHandler);
         }
         var _loc2_:IBitmapWrapperWindow = var_1631.findChildByName("preview_image") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_DOWN",startPlacingHandler);
         }
         updatePreview();
         updateState();
         var_1618 = true;
      }
   }
}
