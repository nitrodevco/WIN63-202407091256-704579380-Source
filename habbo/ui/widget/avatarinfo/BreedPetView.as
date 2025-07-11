package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   
   public class BreedPetView extends AvatarContextInfoButtonView
   {
      
      private static const MODE_NORMAL:int = 0;
       
      
      private var var_1263:int;
      
      private var var_2119:UseProductItem;
      
      private var var_786:Boolean;
      
      public function BreedPetView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_1782 = false;
      }
      
      public static function setup(param1:BreedPetView, param2:int, param3:String, param4:int, param5:int, param6:UseProductItem, param7:Boolean) : void
      {
         param1.var_2119 = param6;
         param1.var_786 = param7;
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
         var _loc1_:int = widget.handler.roomSession.roomId;
         var_1263 = 0;
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
               _loc1_ = XmlAsset(var_1629.assets.getAssetByName("breed_pet_menu")).content as XML;
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
               if(var_786)
               {
                  showButton("breed");
                  break;
               }
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
               var _loc5_:* = param2.parent.name;
               if("breed" === _loc5_)
               {
                  widget.showBreedMonsterPlantsConfirmationView(var_2119.requestRoomObjectId,var_2119.targetRoomObjectId,false);
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
            widget.removeBreedPetViews();
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
