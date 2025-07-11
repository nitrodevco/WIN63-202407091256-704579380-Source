package com.sulake.habbo.ui.widget.avatarinfo
{
    import assets.class_14

    import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   import com.sulake.room.object.IRoomObject;
   
   public class UseProductView extends AvatarContextInfoButtonView
   {
      
      private static const MODE_NORMAL:int = 0;
      
      private static const MODE_SHAMPOO:int = 1;
      
      private static const MODE_CUSTOM_PART:int = 2;
      
      private static const MODE_CUSTOM_PART_SHAMPOO:int = 3;
      
      private static const MODE_SADDLE:int = 4;
      
      private static const MODE_REVIVE:int = 5;
      
      private static const MODE_REBREED:int = 6;
      
      private static const MODE_FERTILIZE:int = 7;
       
      
      private var var_1263:int;
      
      private var var_2119:UseProductItem;
      
      public function UseProductView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_1782 = false;
      }
      
      public static function setup(param1:UseProductView, param2:int, param3:String, param4:int, param5:int, param6:UseProductItem) : void
      {
         param1.var_2119 = param6;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      public function get objectId() : int
      {
         return var_2119.id;
      }
      
      public function get requestRoomObjectId() : int
      {
         return var_2119.requestRoomObjectId;
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         if(var_2119)
         {
            var_2119.dispose();
         }
         var_2119 = null;
         super.dispose();
      }
      
      private function resolveMode() : void
      {
         var _loc1_:class_3365 = null;
         var _loc2_:int = widget.handler.roomSession.roomId;
         var _loc3_:IRoomObject = widget.handler.roomEngine.getRoomObject(_loc2_,var_2119.requestRoomObjectId,10);
         if(_loc3_ != null)
         {
            _loc1_ = widget.handler.getFurniData(_loc3_);
         }
         else
         {
            _loc1_ = widget.handler.container.sessionDataManager.getFloorItemData(var_2119.requestRoomObjectId);
         }
         if(!_loc1_)
         {
            return;
         }
         var_1263 = 0;
         switch(_loc1_.category - 13)
         {
            case 0:
               var_1263 = 1;
               break;
            case 1:
               var_1263 = 2;
               break;
            case 2:
               var_1263 = 3;
               break;
            case 3:
               var_1263 = 4;
               break;
            case 7:
               var_1263 = 5;
               break;
            case 8:
               var_1263 = 6;
               break;
            case 9:
               var_1263 = 7;
               break;
            default:
               class_14.log("[UseProductView.open()] Unsupported furniture category: " + _loc1_.category);
         }
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_1629 || !var_1629.assets || !var_1629.windowManager)
         {
            return;
         }
         resolveMode();
         if(var_1974)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_1629.assets.getAssetByName("use_product_menu")).content as XML;
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
         var _loc2_:int = 0;
         if(!_window || !var_1640)
         {
            return;
         }
         var_1640.autoArrangeItems = false;
         var _loc1_:int = var_1640.numListItems;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            var_1640.getListItemAt(_loc2_).visible = false;
            _loc2_++;
         }
         switch(var_1263)
         {
            case 0:
               showButton("use_product");
               break;
            case 1:
               showButton("use_product_shampoo");
               break;
            case 2:
               showButton("use_product_custom_part");
               break;
            case 3:
               showButton("use_product_custom_part_shampoo");
               break;
            case 4:
               if(var_2119.replace)
               {
                  showButton("replace_product_saddle");
               }
               else
               {
                  showButton("use_product_saddle");
               }
               break;
            case 5:
               showButton("revive_monsterplant");
               break;
            case 6:
               showButton("rebreed_monsterplant");
               break;
            case 7:
               showButton("fertilize_monsterplant");
         }
         var_1640.autoArrangeItems = true;
         var_1640.visible = true;
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
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
               switch(param2.parent.name)
               {
                  case "use_product":
                  case "use_product_shampoo":
                  case "use_product_custom_part":
                  case "use_product_custom_part_shampoo":
                  case "use_product_saddle":
                  case "replace_product_saddle":
                  case "revive_monsterplant":
                  case "rebreed_monsterplant":
                  case "fertilize_monsterplant":
                     widget.showUseProductConfirmation(var_2119.requestRoomObjectId,var_2119.targetRoomObjectId,var_2119.requestInventoryStripId);
               }
            }
            if(_loc4_)
            {
               var_1629.messageListener.processWidgetMessage(_loc4_);
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            widget.removeUseProductViews();
         }
      }
      
      private function changeMode(param1:int) : void
      {
         var_1263 = param1;
         updateButtons();
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_1629 as AvatarInfoWidget;
      }
   }
}
