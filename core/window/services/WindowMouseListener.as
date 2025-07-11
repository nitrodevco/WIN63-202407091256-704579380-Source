package com.sulake.core.window.services
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class WindowMouseListener extends WindowMouseOperator implements IMouseListenerService
   {
       
      
      private var var_3326:Array;
      
      private var var_3243:uint;
      
      public function WindowMouseListener(param1:DisplayObject)
      {
         var_3326 = [];
         var_3243 = 0;
         super(param1);
      }
      
      public function get eventTypes() : Array
      {
         return var_3326;
      }
      
      public function get areaLimit() : uint
      {
         return var_3243;
      }
      
      public function set areaLimit(param1:uint) : void
      {
         var_3243 = param1;
      }
      
      override public function end(param1:IWindow) : IWindow
      {
         var _loc2_:int = 0;
         _loc2_ = int(var_3326.length);
         while(_loc2_ > 0)
         {
            var_3326.pop();
            _loc2_--;
         }
         return super.end(param1);
      }
      
      override protected function handler(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if(var_2669 && !_window.disposed)
         {
            if(var_3326.indexOf(param1.type) >= 0)
            {
               if(param1 is WindowMouseEvent)
               {
                  _loc2_ = _window.hitTestGlobalPoint(new Point(WindowMouseEvent(param1).stageX,WindowMouseEvent(param1).stageY));
                  if(var_3243 == 1 && !_loc2_)
                  {
                     return;
                  }
                  if(var_3243 == 3 && _loc2_)
                  {
                     return;
                  }
               }
               _window.update(null,WindowMouseEvent(param1));
            }
         }
      }
      
      override public function operate(param1:int, param2:int) : void
      {
      }
   }
}
