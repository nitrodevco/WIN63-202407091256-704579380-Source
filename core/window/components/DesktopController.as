package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class DesktopController extends ActivatorController implements class_3460, class_3431
   {
       
      
      public function DesktopController(param1:String, param2:WindowContext, param3:Rectangle)
      {
         super(param1,0,0,0,param2,param3,null,defaultProcedure,null,null,0);
      }
      
      public function get mouseX() : int
      {
         return getDisplayObject().stage.mouseX;
      }
      
      public function get mouseY() : int
      {
         return getDisplayObject().stage.mouseY;
      }
      
      override public function set parent(param1:IWindow) : void
      {
         throw new Error("Desktop window doesn\'t have parent!");
      }
      
      override public function set procedure(param1:Function) : void
      {
         var_2374 = param1 != null ? param1 : defaultProcedure;
      }
      
      override public function get host() : IWindow
      {
         return this;
      }
      
      override public function get desktop() : class_3460
      {
         return this;
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !var_1650)
         {
            var_1650 = new GraphicContext("GC {" + _name + "}",256,rectangle);
            GraphicContext(var_1650).mouseEnabled = true;
            GraphicContext(var_1650).doubleClickEnabled = true;
         }
         return var_1650;
      }
      
      public function getActiveWindow() : IWindow
      {
         return getActiveChild();
      }
      
      public function setActiveWindow(param1:IWindow) : IWindow
      {
         return setActiveChild(param1);
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return getGraphicContext(true) as DisplayObject;
      }
      
      public function setDisplayObject(param1:DisplayObject) : void
      {
         getGraphicContext(true).setDisplayObject(param1);
      }
      
      override public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      private function defaultProcedure(param1:WindowEvent, param2:IWindow) : void
      {
      }
   }
}
