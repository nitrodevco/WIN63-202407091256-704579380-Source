package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class DecorateModeView extends AvatarContextInfoButtonView
   {
       
      
      public function DecorateModeView(param1:AvatarInfoWidget, param2:int, param3:String, param4:int)
      {
         super(param1);
         var_1782 = false;
         AvatarContextInfoButtonView.setup(this,param2,param3,param4,1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_1629 || !var_1629.assets || !var_1629.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = XmlAsset(var_1629.assets.getAssetByName("own_avatar_decorating")).content as XML;
            _window = var_1629.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
            if(!_window)
            {
               return;
            }
            _window.addEventListener("WME_OVER",onMouseHoverEvent);
            _window.addEventListener("WME_OUT",onMouseHoverEvent);
            var_1640 = _window.findChildByName("buttons") as IItemListWindow;
            var_1640.procedure = eventProc;
            updateButtons();
         }
         activeView = _window;
      }
      
      override public function show() : void
      {
         if(var_1701 != null)
         {
            var_1701.visible = true;
            var_1701.activate();
         }
      }
      
      override public function hide(param1:Boolean) : void
      {
         if(var_1701 != null)
         {
            var_1701.visible = false;
         }
         var_1762 = false;
      }
      
      override protected function set activeView(param1:IWindowContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var_1701 = param1;
      }
      
      public function isVisible() : Boolean
      {
         return var_1701 && var_1701.visible;
      }
      
      public function updateButtons() : void
      {
         showButton("decorate");
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc3_:* = param2.parent.name;
               if("decorate" === _loc3_)
               {
                  widget.isUserDecorating = false;
               }
            }
         }
         else if(param1.type == "WME_OVER")
         {
            super.buttonEventProc(param1,param2);
            var_1762 = true;
         }
         else if(param1.type == "WME_OUT")
         {
            super.buttonEventProc(param1,param2);
            var_1762 = false;
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
      }
      
      override public function get maximumBlend() : Number
      {
         return 0.8;
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_1629 as AvatarInfoWidget;
      }
   }
}
