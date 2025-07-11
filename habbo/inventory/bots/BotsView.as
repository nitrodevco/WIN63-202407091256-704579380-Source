package com.sulake.habbo.inventory.bots
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
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.class_1726;
   
   public class BotsView implements IInventoryView, IAvatarImageListener
   {
       
      
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2286:IAssetLibrary;
      
      private var var_1631:IWindowContainer;
      
      private var var_1644:BotsModel;
      
      private var _disposed:Boolean = false;
      
      private var var_2176:IItemGridWindow;
      
      private var _roomEngine:IRoomEngine;
      
      private var _avatarRenderer:IAvatarRenderManager;
      
      private var _gridItems:Map;
      
      private var var_2003:BotGridItem;
      
      private var var_3249:int = 0;
      
      private var var_3640:int;
      
      private var var_1618:Boolean = false;
      
      public function BotsView(param1:BotsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IRoomEngine, param5:IAvatarRenderManager)
      {
         super();
         var_1644 = param1;
         var_2286 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _avatarRenderer = param5;
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
         _windowManager = null;
         _avatarRenderer = null;
         _roomEngine = null;
         var_2286 = null;
         var_1644 = null;
         var_1631 = null;
         _disposed = true;
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
      
      public function removeItem(param1:int) : void
      {
         if(!var_1618)
         {
            return;
         }
         var _loc2_:BotGridItem = _gridItems.remove(param1) as BotGridItem;
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
      
      public function addItem(param1:class_1726) : void
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
         var _loc2_:BotGridItem = new BotGridItem(this,param1,_windowManager,var_2286,var_1644.isUnseen(param1.id));
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
      
      public function placeItemToRoom(param1:int, param2:Boolean = false) : void
      {
         var_1644.placeItemToRoom(param1,param2);
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
      
      public function setSelectedGridItem(param1:BotGridItem) : void
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
         var _loc1_:int = 0;
         if(!var_1618)
         {
            return;
         }
         var _loc2_:Map = var_1644.items;
         if(!var_1644.isListInitialized())
         {
            _loc1_ = 1;
         }
         else if(!_loc2_ || _loc2_.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(var_3249 == _loc1_)
         {
            return;
         }
         var_3249 = _loc1_;
         updateContainerVisibility();
         if(var_3249 == 3)
         {
            updateGrid();
            updatePreview();
         }
      }
      
      public function getGridItemImage(param1:class_1726) : BitmapData
      {
         var _loc2_:int = 3;
         return getItemImage(param1,_loc2_,false,"h");
      }
      
      public function getItemImage(param1:class_1726, param2:int, param3:Boolean, param4:String) : BitmapData
      {
         var _loc5_:BitmapData = null;
         var _loc6_:class_3374;
         (_loc6_ = _avatarRenderer.createAvatarImage(param1.figure,param4,param1.gender,this)).setDirection("full",param2);
         if(param3)
         {
            _loc5_ = _loc6_.getCroppedImage("full");
         }
         else
         {
            _loc5_ = _loc6_.getCroppedImage("head");
         }
         _loc6_.dispose();
         return _loc5_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc2_ in _gridItems)
         {
            if(_loc2_.data.figure == param1)
            {
               _loc2_.setImage(getGridItemImage(_loc2_.data));
            }
         }
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
         var _loc3_:BotGridItem = null;
         if(var_1631 == null)
         {
            return;
         }
         var _loc1_:Array = _gridItems.getKeys();
         var _loc2_:Array = !!var_1644.items ? var_1644.items.getKeys() : [];
         var_2176.lock();
         for each(_loc4_ in _loc1_)
         {
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               removeItem(_loc4_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc1_.indexOf(_loc4_) == -1)
            {
               addItem(var_1644.items.getValue(_loc4_));
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
         var _loc2_:class_1726 = var_2003.data;
         if(_loc2_ == null)
         {
            return;
         }
         placeItemToRoom(_loc2_.id);
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
      }
      
      private function updateContainerVisibility() : void
      {
         if(var_1644.controller.currentCategoryId != "bots")
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
      
      private function updatePreview(param1:BotGridItem = null) : void
      {
         var _loc3_:BitmapData = null;
         var _loc11_:String = null;
         var _loc13_:String = null;
         var _loc10_:Boolean = false;
         var _loc4_:class_1726 = null;
         var _loc5_:BitmapData = null;
         if(var_1631 == null)
         {
            return;
         }
         var_3640 = -1;
         if(param1 == null || param1.data == null)
         {
            _loc3_ = new BitmapData(1,1);
            _loc11_ = "";
            _loc13_ = "";
            _loc10_ = false;
         }
         else
         {
            _loc11_ = (_loc4_ = param1.data).name;
            _loc13_ = _loc4_.motto;
            _loc3_ = getItemImage(_loc4_,4,true,"h");
            _loc10_ = true;
         }
         var _loc9_:IBitmapWrapperWindow;
         if((_loc9_ = var_1631.findChildByName("preview_image") as IBitmapWrapperWindow) != null)
         {
            _loc5_ = new BitmapData(_loc9_.width,_loc9_.height);
            _loc5_.fillRect(_loc5_.rect,0);
            _loc5_.copyPixels(_loc3_,_loc3_.rect,new Point(_loc5_.width / 2 - _loc3_.width / 2,_loc5_.height / 2 - _loc3_.height / 2));
            _loc9_.bitmap = _loc5_;
         }
         _loc3_.dispose();
         var _loc6_:ITextWindow;
         if((_loc6_ = var_1631.findChildByName("bot_name") as ITextWindow) != null)
         {
            _loc6_.caption = _loc11_;
         }
         if((_loc6_ = var_1631.findChildByName("bot_description") as ITextWindow) != null)
         {
            _loc6_.caption = _loc13_;
         }
         var _loc8_:Boolean = false;
         var _loc12_:Boolean = false;
         if(var_1644.roomSession != null)
         {
            _loc8_ = var_1644.roomSession.areBotsAllowed;
            _loc12_ = var_1644.roomSession.isRoomOwner;
         }
         var _loc2_:String = "";
         if(!_loc12_)
         {
            if(_loc8_)
            {
               _loc2_ = "${inventory.bots.allowed}";
            }
            else
            {
               _loc2_ = "${inventory.bots.forbidden}";
            }
         }
         if((_loc6_ = var_1631.findChildByName("preview_info") as ITextWindow) != null)
         {
            _loc6_.caption = _loc2_;
         }
         var _loc7_:class_3357;
         if((_loc7_ = var_1631.findChildByName("place_button") as class_3357) != null)
         {
            if(_loc10_ && (_loc12_ || _loc8_))
            {
               _loc7_.enable();
            }
            else
            {
               _loc7_.disable();
            }
         }
      }
      
      private function addUnseenItemSymbols() : void
      {
      }
      
      private function init() : void
      {
         var _loc1_:class_3357 = null;
         var_1631 = var_1644.controller.view.getView("bots");
         var_1631.visible = false;
         var_1631.procedure = windowEventHandler;
         addUnseenItemSymbols();
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
         selectFirst();
         var_1618 = true;
      }
   }
}
