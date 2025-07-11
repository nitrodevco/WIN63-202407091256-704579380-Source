package com.sulake.habbo.ui.widget.avatarinfo
{
    import assets.class_14

    import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.room.object.IRoomObject;
   
   public class OwnPetMenuView extends AvatarContextInfoButtonView
   {
      
      private static const MODE_NORMAL:int = 0;
      
      private static const MODE_SADDLED_UP:int = 1;
      
      private static const MODE_RIDING:int = 2;
      
      private static const MODE_MONSTERPLANT:int = 3;
       
      
      private var var_47:PetInfoData;
      
      private var var_1263:int;
      
      private var var_2925:class_3365;
      
      private var var_3956:class_3365;
      
      protected var _catalog:IHabboCatalog;
      
      protected var _habboTracking:IHabboTracking;
      
      public function OwnPetMenuView(param1:AvatarInfoWidget, param2:IHabboCatalog)
      {
         super(param1);
         var_1782 = false;
         _habboTracking = HabboTracking.getInstance();
         _catalog = param2;
      }
      
      public static function setup(param1:OwnPetMenuView, param2:int, param3:String, param4:int, param5:int, param6:PetInfoData) : void
      {
         param1.var_47 = param6;
         var _loc7_:Boolean = param1.widget.hasFreeSaddle;
         var _loc8_:Boolean = param1.widget.isRiding;
         if(param1.widget.isMonsterPlant())
         {
            param1.var_1263 = 3;
         }
         else if(_loc7_ && !_loc8_)
         {
            param1.var_1263 = 1;
         }
         else if(_loc8_)
         {
            param1.var_1263 = 2;
         }
         else
         {
            param1.var_1263 = 0;
         }
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         var_47 = null;
         var_2925 = null;
         var_3956 = null;
         _catalog = null;
         _habboTracking = null;
         super.dispose();
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_1629 || !var_1629.assets || !var_1629.windowManager)
         {
            return;
         }
         if(var_1974)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_1629.assets.getAssetByName("own_pet_menu")).content as XML;
               _window = var_1629.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            var_1640 = _window.findChildByName("buttons") as IItemListWindow;
            var_1640.procedure = buttonEventProc;
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      public function updateButtons() : void
      {
         var _loc6_:int = 0;
         var _loc2_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:int = 0;
         var _loc8_:IRoomObject = null;
         var _loc4_:int = 0;
         if(!_window || !var_47 || !var_1640)
         {
            return;
         }
         var_1640.autoArrangeItems = false;
         var _loc5_:int = var_1640.numListItems;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            var_1640.getListItemAt(_loc6_).visible = false;
            _loc6_++;
         }
         var_2925 = null;
         var _loc1_:AvatarInfoWidgetHandler = widget.handler;
         switch(var_1263)
         {
            case 0:
               showButton("respect",var_47.petRespectLeft > 0);
               showButton("train");
               showButton("pick_up");
               if(var_47.petType == 15)
               {
                  var_2925 = findFurnitureData(16,15);
                  if(var_2925 != null)
                  {
                     showButton("buy_saddle");
                  }
               }
               if(widget.configuration.getBoolean("nest.breeding.bear.enabled"))
               {
                  if(var_47.petType == 4)
                  {
                     showButton("breed");
                  }
               }
               if(widget.configuration.getBoolean("nest.breeding.terrier.enabled"))
               {
                  if(var_47.petType == 3)
                  {
                     showButton("breed");
                  }
               }
               if(widget.configuration.getBoolean("nest.breeding.cat.enabled"))
               {
                  if(var_47.petType == 1)
                  {
                     showButton("breed");
                  }
               }
               if(widget.configuration.getBoolean("nest.breeding.dog.enabled"))
               {
                  if(var_47.petType == 0)
                  {
                     showButton("breed");
                  }
               }
               if(widget.configuration.getBoolean("nest.breeding.pig.enabled"))
               {
                  if(var_47.petType == 5)
                  {
                     showButton("breed");
                  }
               }
               break;
            case 1:
               showButton("mount");
               if(widget.configuration.getBoolean("sharedhorseriding.enabled"))
               {
                  showButton("toggle_riding_permission");
                  enableCheckbox("toggle_riding_permission",var_47 != null ? var_47.accessRights == 1 : false);
               }
               showButton("respect",var_47.petRespectLeft > 0);
               showButton("train");
               showButton("pick_up");
               showButton("saddle_off");
               break;
            case 2:
               showButton("dismount");
               showButton("respect",var_47.petRespectLeft > 0);
               break;
            case 3:
               showButton("pick_up");
               if(var_47.canRevive)
               {
                  var_3956 = findFurnitureData(20,16);
                  showButton("revive");
                  if(widget.configuration.getBoolean("monsterplants.composting.enabled") && _loc1_.container.roomSession.isRoomOwner)
                  {
                     showButton("compost");
                  }
                  break;
               }
               _loc2_ = var_47.energy as Number;
               _loc7_ = var_47.energyMax as Number;
               showButton("treat",true,_loc2_ / _loc7_ < 0.98);
               if(var_47.level == var_47.levelMax)
               {
                  if(var_47.canBreed)
                  {
                     showButton("toggle_breeding_permission");
                     enableCheckbox("toggle_breeding_permission",var_47.hasBreedingPermission);
                     showButton("breed");
                  }
               }
               break;
         }
         if(widget.configuration.getBoolean("handitem.give.pet.enabled"))
         {
            _loc3_ = _loc1_.container.roomSession.ownUserRoomId;
            if((_loc8_ = _loc1_.container.roomEngine.getRoomObject(_loc1_.roomSession.roomId,_loc3_,100)) != null)
            {
               if((_loc4_ = int(_loc8_.getModel().getNumber("figure_carry_object"))) > 0 && _loc4_ < 999999)
               {
                  showButton("pass_handitem");
               }
            }
         }
         showButton("wired_inspect",_loc1_.container.userDefinedRoomEvents.showInspectButton());
         widget.localizations.registerParameter("infostand.button.petrespect","count",var_47.petRespectLeft.toString());
         var_1640.autoArrangeItems = true;
         var_1640.visible = true;
      }
      
      private function findFurnitureData(param1:int, param2:int) : class_3365
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc7_:Array = widget.handler.container.sessionDataManager.getFloorItemsDataByCategory(param1);
         for each(var _loc5_ in _loc7_)
         {
            _loc3_ = _loc5_.customParams.split(" ");
            if((_loc6_ = _loc3_ && _loc3_.length >= 1 ? parseInt(_loc3_[0]) : -1) == param2)
            {
               _loc4_ = _loc5_;
               break;
            }
         }
         return _loc4_;
      }
      
      private function openCatalogPage(param1:class_3365) : Boolean
      {
         if(_catalog == null || param1 == null || param1.purchaseOfferId < 0)
         {
            return false;
         }
         _catalog.openCatalogPageByOfferId(param1.purchaseOfferId,"NORMAL");
         if(_habboTracking && !_habboTracking.disposed)
         {
            _habboTracking.trackGoogle("infostandCatalogButton","offer",param1.purchaseOfferId);
         }
         return true;
      }
      
      private function findRoomObject(param1:class_3365) : IRoomObject
      {
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = null;
         var _loc7_:int = 0;
         if(widget == null || param1 == null)
         {
            return null;
         }
         var _loc2_:IRoomWidgetHandlerContainer = widget.handler.container;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc6_:IRoomEngine;
         if((_loc6_ = _loc2_.roomEngine) == null)
         {
            return null;
         }
         var _loc8_:int = _loc2_.roomSession.roomId;
         var _loc4_:int = _loc6_.getRoomObjectCount(_loc8_,10);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc6_.getRoomObjectWithIndex(_loc8_,_loc5_,10);
            if(_loc3_ != null)
            {
               if((_loc7_ = int(_loc3_.getModel().getNumber("furniture_type_id"))) == param1.id)
               {
                  return _loc3_;
               }
            }
            _loc5_++;
         }
         return null;
      }
      
      private function enableCheckbox(param1:String, param2:Boolean) : void
      {
         var _loc3_:class_3398 = getCheckbox(param1);
         if(!_loc3_)
         {
            return;
         }
         if(param2)
         {
            _loc3_.select();
         }
         else
         {
            _loc3_.unselect();
         }
      }
      
      private function getCheckbox(param1:String) : class_3398
      {
         if(!var_1640)
         {
            return null;
         }
         var _loc2_:IWindowContainer = var_1640.getListItemByName(param1) as IWindowContainer;
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.findChildByName(param1 + "_checkbox") as class_3398;
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc8_:RoomWidgetMessage = null;
         var _loc5_:class_3398 = null;
         var _loc9_:int = 0;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc7_:Boolean = false;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               class_14.log("Own pet menu was clicked: " + param2.parent.name);
               switch(param2.parent.name)
               {
                  case "respect":
                     var_47.petRespectLeft -= 1;
                     updateButtons();
                     _loc8_ = new RoomWidgetUserActionMessage(" RWUAM_RESPECT_PET",petId);
                     break;
                  case "treat":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_TREAT_PET",petId);
                     break;
                  case "pass_handitem":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_GIVE_CARRY_ITEM_TO_PET",petId);
                     break;
                  case "wired_inspect":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_WIRED_INSPECT_PET",petId);
                     break;
                  case "train":
                     widget.openTrainingView();
                     break;
                  case "pick_up":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_PICKUP_PET",petId);
                     widget.closeTrainingView();
                     break;
                  case "mount":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_MOUNT_PET",petId);
                     break;
                  case "toggle_riding_permission":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_RIDING_PERMISSION",petId);
                     if((_loc5_ = getCheckbox("toggle_riding_permission")) != null)
                     {
                        enableCheckbox("toggle_riding_permission",!_loc5_.isSelected);
                     }
                     break;
                  case "toggle_breeding_permission":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_BREEDING_PERMISSION",petId);
                     if((_loc5_ = getCheckbox("toggle_breeding_permission")) != null)
                     {
                        enableCheckbox("toggle_breeding_permission",!_loc5_.isSelected);
                     }
                     break;
                  case "dismount":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_DISMOUNT_PET",petId);
                     break;
                  case "saddle_off":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_SADDLE_OFF",petId);
                     break;
                  case "breed":
                     if(var_1263 == 0)
                     {
                        _loc9_ = 46;
                        _loc6_ = "pet.command." + _loc9_;
                        _loc4_ = String(var_1629.catalog.localization.getLocalization(_loc6_));
                        _loc8_ = new RoomWidgetPetCommandMessage("RWPCM_PET_COMMAND",var_47.id,var_47.name + " " + _loc4_);
                     }
                     else if(var_1263 == 3)
                     {
                        _loc8_ = new RoomWidgetUserActionMessage("RWUAM_REQUEST_BREED_PET",petId);
                     }
                     break;
                  case "harvest":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_HARVEST_PET",petId);
                     break;
                  case "revive":
                     if(_loc7_ = openCatalogPage(var_3956))
                     {
                     }
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_REVIVE_PET",petId);
                     break;
                  case "compost":
                     _loc8_ = new RoomWidgetUserActionMessage("RWUAM_COMPOST_PLANT",petId);
                     break;
                  case "buy_saddle":
                     openCatalogPage(var_2925);
               }
            }
            else if(param2.name == "profile_link")
            {
               _loc8_ = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",petId,"ownPetContextMenu");
            }
            else if(param2.name == "toggle_riding_permission_checkbox")
            {
               _loc3_ = true;
               _loc8_ = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_RIDING_PERMISSION",petId);
            }
            else if(param2.name == "toggle_breeding_permission_checkbox")
            {
               _loc3_ = true;
               _loc8_ = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_BREEDING_PERMISSION",petId);
            }
            if(_loc8_)
            {
               var_1629.messageListener.processWidgetMessage(_loc8_);
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            var_1629.removeView(this,false);
         }
      }
      
      public function get widget() : AvatarInfoWidget
      {
         return var_1629 as AvatarInfoWidget;
      }
      
      private function changeMode(param1:int) : void
      {
         var_1263 = param1;
         updateButtons();
      }
      
      public function get petId() : int
      {
         return userId;
      }
   }
}
