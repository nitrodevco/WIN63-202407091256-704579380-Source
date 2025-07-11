package com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.groups.class_1880;
   import com.sulake.habbo.ui.widget.contextmenu.class_3386;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextInfoView;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class GuildFurnitureContextMenuView extends FurnitureContextInfoView
   {
       
      
      protected var var_3260:class_1880;
      
      protected var _windowManager:IHabboWindowManager;
      
      public var var_364:int = -1;
      
      public var var_574:int = -1;
      
      public var var_500:Boolean = false;
      
      public var var_628:Boolean = false;
      
      public function GuildFurnitureContextMenuView(param1:class_3386, param2:class_1880, param3:IHabboWindowManager)
      {
         super(param1);
         var_1782 = false;
         var_3260 = param2;
         _windowManager = param3;
      }
      
      override public function dispose() : void
      {
         var_3260 = null;
         _windowManager = null;
         super.dispose();
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc2_:IRegionWindow = null;
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
               _loc1_ = XmlAsset(var_1629.assets.getAssetByName("guild_furni_menu")).content as XML;
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
            _loc2_ = _window.findChildByName("profile_link") as IRegionWindow;
            if(_loc2_)
            {
               _loc2_.procedure = buttonEventProc;
               _loc2_.toolTipCaption = widget.localizations.getLocalization("infostand.profile.link.tooltip","Click to view profile");
               _loc2_.toolTipDelay = 100;
            }
            _window.findChildByName("name").caption = var_617;
            _window.visible = false;
            activeView = _window;
            updateButtons();
            var_1762 = false;
         }
      }
      
      protected function updateButtons() : void
      {
         if(!_window || !var_1640)
         {
            return;
         }
         var_1640.autoArrangeItems = false;
         showButton("join",!var_500,true);
         showButton("open_forum",var_628,true);
         var_1640.autoArrangeItems = true;
         var_1640.visible = true;
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:Component = null;
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
               switch(param2.parent.name)
               {
                  case "join":
                     widget.handler.sendJoinToGroupMessage(var_364);
                     showButton("join",!var_500,false);
                     break;
                  case "home_room":
                     widget.handler.sendGoToHomeRoomMessage(var_574);
                     break;
                  case "open_forum":
                     if(widget != null && widget.roomEngine != null)
                     {
                        if((_loc4_ = widget.roomEngine as Component).context != null)
                        {
                           _loc4_.context.createLinkEvent("groupforum/" + var_364);
                           break;
                        }
                     }
               }
            }
            if(param2.name == "profile_link")
            {
               var_3260.openGroupInfo(var_364);
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
      
      private function get widget() : FurnitureContextMenuWidget
      {
         return var_1629 as FurnitureContextMenuWidget;
      }
   }
}
