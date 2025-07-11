package com.sulake.habbo.ui.widget.furniture.mysterybox
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.contextmenu.class_3386;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextInfoView;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   
   public class MysteryBoxContextMenuView extends FurnitureContextInfoView
   {
       
      
      private var var_4770:Boolean;
      
      public function MysteryBoxContextMenuView(param1:class_3386)
      {
         super(param1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc2_:IWindow = null;
         if(var_1629 == null || var_1629.assets == null || var_1629.windowManager == null)
         {
            return;
         }
         if(var_1974)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(_window == null || Boolean(_window.disposed))
            {
               _loc1_ = var_1629.assets.getAssetByName("mysterybox_menu").content as XML;
               _window = var_1629.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
               if(_window == null)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _loc2_ = _window.findChildByName("minimize");
               if(_loc2_ != null)
               {
                  _loc2_.addEventListener("WME_CLICK",onMinimize);
                  _loc2_.addEventListener("WME_OVER",onMinimizeHover);
                  _loc2_.addEventListener("WME_OUT",onMinimizeHover);
               }
            }
            _window.findChildByName("buttons").procedure = buttonEventProc;
            _window.visible = false;
            activeView = _window;
            var_1762 = false;
            refreshOwnerMode();
         }
      }
      
      private function refreshOwnerMode() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.findChildByName("label").caption = "${mysterybox.context." + (var_4770 ? "owner" : "other") + ".use}";
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:FurnitureContextMenuWidget = null;
         if(disposed || _window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc5_:* = param2.parent.name;
               if("use" === _loc5_)
               {
                  if((_loc4_ = var_1629 as FurnitureContextMenuWidget) != null)
                  {
                     _loc4_.showMysteryBoxOpenDialog(var_2060);
                  }
               }
            }
            _loc3_ = true;
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
      
      public function set isOwnerMode(param1:Boolean) : void
      {
         var_4770 = param1;
         refreshOwnerMode();
      }
   }
}
