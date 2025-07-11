package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.groups.class_1880;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.handler.FurnitureContextMenuWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
   import com.sulake.habbo.ui.widget.contextmenu.class_3386;
   import com.sulake.habbo.ui.widget.furniture.effectbox.EffectBoxOpenDialogView;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu.GuildFurnitureContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxOpenDialogView;
   import com.sulake.habbo.ui.widget.furniture.mysterytrophy.MysteryTrophyOpenDialogView;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.object.IRoomObject;
   
   public class FurnitureContextMenuWidget extends RoomWidgetBase implements class_3386, IUpdateReceiver
   {
       
      
      private var var_1660:Component;
      
      private var var_1631:FurnitureContextInfoView;
      
      private var _selectedObject:IRoomObject = null;
      
      private var var_2422:GuildFurnitureContextMenuView;
      
      private var var_3186:RandomTeleportContextMenuView;
      
      private var var_3180:MonsterPlantSeedContextMenuView;
      
      private var var_2386:MonsterPlantSeedConfirmationView;
      
      private var var_2635:EffectBoxOpenDialogView;
      
      private var var_2350:MysteryBoxContextMenuView;
      
      private var var_2731:MysteryTrophyOpenDialogView;
      
      private var var_3526:MysteryBoxOpenDialogView;
      
      private var var_2406:FriendFurniContextMenuView;
      
      private var var_2395:GenericUsableFurnitureContextMenuView;
      
      private var _catalog:IHabboCatalog;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_2599:PurchasableClothingConfirmationView;
      
      public function FurnitureContextMenuWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:ICoreConfiguration, param5:IHabboLocalizationManager, param6:Component, param7:class_1880, param8:IHabboCatalog)
      {
         super(param1,param2,param3,param5);
         var_1660 = param6;
         var_2422 = new GuildFurnitureContextMenuView(this,param7,param2);
         var_3186 = new RandomTeleportContextMenuView(this);
         var_3180 = new MonsterPlantSeedContextMenuView(this);
         var_2350 = new MysteryBoxContextMenuView(this);
         var_2406 = new FriendFurniContextMenuView(this);
         var_2395 = new GenericUsableFurnitureContextMenuView(this);
         var_2386 = new MonsterPlantSeedConfirmationView(this);
         var_3526 = new MysteryBoxOpenDialogView(this);
         var_2635 = new EffectBoxOpenDialogView(this);
         var_2731 = new MysteryTrophyOpenDialogView(this);
         var_2599 = new PurchasableClothingConfirmationView(this);
         _catalog = param8;
         this.handler.widget = this;
         this.handler.roomEngine.events.addEventListener("REOE_REMOVED",onRoomObjectRemoved);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_1660.removeUpdateReceiver(this);
         removeView(var_1631,false);
         var_2422.dispose();
         var_2422 = null;
         var_3186.dispose();
         var_3186 = null;
         var_3180.dispose();
         var_3180 = null;
         var_2386.dispose();
         var_2386 = null;
         var_2350.dispose();
         var_2350 = null;
         var_3526.dispose();
         var_3526 = null;
         var_2406.dispose();
         var_2406 = null;
         var_2395.dispose();
         var_2395 = null;
         var_2635.dispose();
         var_2635 = null;
         var_2731.dispose();
         var_2731 = null;
         var_2599.dispose();
         var_2599 = null;
         _catalog = null;
         super.dispose();
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get handler() : FurnitureContextMenuWidgetHandler
      {
         return var_1653 as FurnitureContextMenuWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return !!_container ? _container.roomEngine : null;
      }
      
      public function hideContextMenu(param1:IRoomObject) : void
      {
         if(_selectedObject != null && _selectedObject.getId() == param1.getId())
         {
            removeView(var_1631,false);
            var_1660.removeUpdateReceiver(this);
            _selectedObject = null;
         }
      }
      
      public function showGuildFurnitureContextMenu(param1:IRoomObject, param2:int, param3:String, param4:int, param5:Boolean, param6:Boolean) : void
      {
         _selectedObject = param1;
         var_2422.var_364 = param2;
         var_2422.var_574 = param4;
         var_2422.var_500 = param5;
         var_2422.var_628 = param6;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         var_1631 = var_2422;
         FurnitureContextInfoView.setup(var_1631,param1,param3);
         var_1660.registerUpdateReceiver(this,10);
      }
      
      public function showRandomTeleportContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         var_3186.objectCategory = param2;
         var_1631 = var_3186;
         FurnitureContextInfoView.setup(var_1631,param1);
         var_1660.registerUpdateReceiver(this,10);
      }
      
      public function showMonsterPlantSeedContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         var_3180.objectCategory = param2;
         var_1631 = var_3180;
         FurnitureContextInfoView.setup(var_1631,param1);
         var_1660.registerUpdateReceiver(this,10);
      }
      
      public function showPlantSeedConfirmationDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         if(!var_2386)
         {
            var_2386 = new MonsterPlantSeedConfirmationView(this);
         }
         var_2386.open(param1.getId());
      }
      
      public function showPurchasableClothingConfirmationDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         if(!var_2599)
         {
            var_2599 = new PurchasableClothingConfirmationView(this);
         }
         var_2599.open(param1.getId());
      }
      
      public function showEffectBoxOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         if(!var_2635)
         {
            var_2635 = new EffectBoxOpenDialogView(this);
         }
         var_2635.open(param1.getId());
      }
      
      public function showMysteryTrophyOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         if(!var_2731)
         {
            var_2731 = new MysteryTrophyOpenDialogView(this);
         }
         var_2731.open(param1.getId());
      }
      
      private function removePlantSeedConfirmationView() : void
      {
         if(var_2386 != null)
         {
            var_2386.close();
         }
      }
      
      public function showMysteryBoxContextMenu(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         if(var_2350 == null)
         {
            var_2350 = new MysteryBoxContextMenuView(this);
         }
         var_2350.isOwnerMode = handler.container.isOwnerOfFurniture(param1);
         var_2350.show();
         var_1631 = var_2350;
         FurnitureContextInfoView.setup(var_1631,param1);
         var_1660.registerUpdateReceiver(this,10);
      }
      
      public function showFriendFurnitureContextMenu(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         if(var_2406 == null)
         {
            var_2406 = new FriendFurniContextMenuView(this);
         }
         var_2406.show();
         var_1631 = var_2406;
         FurnitureContextInfoView.setup(var_1631,param1);
         var_1660.registerUpdateReceiver(this,10);
      }
      
      public function showUsableFurnitureContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         if(var_2395 == null)
         {
            var_2395 = new GenericUsableFurnitureContextMenuView(this);
         }
         var_2395.show();
         var_2395.objectCategory = param2;
         var_1631 = var_2395;
         FurnitureContextInfoView.setup(var_1631,param1);
         var_1660.registerUpdateReceiver(this,10);
      }
      
      public function showMysteryBoxOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_1631 != null)
         {
            removeView(var_1631,false);
         }
         var_3526.startOpenFlow(param1);
      }
      
      public function removeView(param1:ContextInfoView, param2:Boolean) : void
      {
         if(param1)
         {
            param1.hide(false);
            if(param1 == var_1631)
            {
               var_1631 = null;
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_1631 && _selectedObject)
         {
            var_1631.update(this.handler.getObjectRectangle(_selectedObject.getId()),this.handler.getObjectScreenLocation(_selectedObject.getId()),param1);
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function onRoomObjectRemoved(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.category == 10)
         {
            _loc2_ = param1.objectId;
            if(_selectedObject != null && _selectedObject.getId() == _loc2_)
            {
               removeView(var_1631,false);
               removePlantSeedConfirmationView();
               var_1660.removeUpdateReceiver(this);
               _selectedObject = null;
            }
         }
      }
      
      public function get friendList() : IHabboFriendList
      {
         return null;
      }
   }
}
