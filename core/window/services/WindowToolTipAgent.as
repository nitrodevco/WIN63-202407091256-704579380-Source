package com.sulake.core.window.services
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IToolTipWindow;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService
   {
       
      
      protected var var_2184:String;
      
      protected var var_1783:IToolTipWindow;
      
      protected var var_2168:Timer;
      
      protected var _toolTipOffset:Point;
      
      protected var _pointerOffset:Point;
      
      protected var var_2993:uint;
      
      public function WindowToolTipAgent(param1:DisplayObject)
      {
         _pointerOffset = new Point();
         _toolTipOffset = new Point(20,20);
         var_2993 = 500;
         super(param1);
      }
      
      override public function begin(param1:IWindow, param2:uint = 0) : IWindow
      {
         if(param1 && !param1.disposed)
         {
            if(param1 is IInteractiveWindow)
            {
               var_2184 = IInteractiveWindow(param1).toolTipCaption;
               var_2993 = IInteractiveWindow(param1).toolTipDelay;
            }
            else
            {
               var_2184 = param1.caption;
               var_2993 = 500;
            }
            _mouse.x = var_509.mouseX;
            _mouse.y = var_509.mouseY;
            getMousePositionRelativeTo(param1,_mouse,_pointerOffset);
            if(var_2168 == null)
            {
               var_2168 = new Timer(var_2993,1);
               var_2168.addEventListener("timer",showToolTip);
            }
            var_2168.reset();
            var_2168.start();
         }
         return super.begin(param1,param2);
      }
      
      override public function end(param1:IWindow) : IWindow
      {
         if(var_2168 != null)
         {
            var_2168.stop();
            var_2168.removeEventListener("timer",showToolTip);
            var_2168 = null;
         }
         hideToolTip();
         return super.end(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         if(_window && !_window.disposed)
         {
            _mouse.x = param1;
            _mouse.y = param2;
            getMousePositionRelativeTo(_window,_mouse,_pointerOffset);
            if(var_1783 != null && !var_1783.disposed)
            {
               var_1783.x = param1 + _toolTipOffset.x;
               var_1783.y = param2 + _toolTipOffset.y;
            }
         }
      }
      
      protected function showToolTip(param1:TimerEvent) : void
      {
         var _loc2_:Point = null;
         if(var_2168 != null)
         {
            var_2168.reset();
         }
         if(_window && !_window.disposed)
         {
            if(_window is IInteractiveWindow)
            {
               var_2184 = IInteractiveWindow(_window).toolTipCaption;
            }
            else
            {
               var_2184 = _window.caption;
            }
            if(var_1783 == null || Boolean(var_1783.disposed))
            {
               var_1783 = _window.context.create(_window.name + "::ToolTip",var_2184,8,_window.style,32 | 0,null,null,null,0,null,null) as IToolTipWindow;
            }
            _loc2_ = new Point();
            _window.getGlobalPosition(_loc2_);
            var_1783.x = _loc2_.x + _pointerOffset.x + _toolTipOffset.x;
            var_1783.y = _loc2_.y + _pointerOffset.y + _toolTipOffset.y;
            var_1783.visible = var_1783.caption.length > 0;
         }
      }
      
      protected function hideToolTip() : void
      {
         if(var_1783 != null && !var_1783.disposed)
         {
            var_1783.destroy();
            var_1783 = null;
         }
      }
      
      public function updateCaption(param1:IWindow) : void
      {
         var _loc2_:String = null;
         if(param1 == null || Boolean(param1.disposed) || var_1783 == null || Boolean(var_1783.disposed))
         {
            return;
         }
         if(param1 is IInteractiveWindow)
         {
            _loc2_ = String(IInteractiveWindow(param1).toolTipCaption);
         }
         else
         {
            _loc2_ = param1.caption;
         }
         if(_loc2_ != var_2184)
         {
            var_2184 = _loc2_;
            if(_loc2_ == null || _loc2_.length == 0)
            {
               var_1783.visible = false;
            }
            else
            {
               var_1783.caption = _loc2_;
               var_1783.visible = true;
            }
         }
      }
   }
}
