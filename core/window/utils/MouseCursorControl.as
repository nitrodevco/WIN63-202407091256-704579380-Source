package com.sulake.core.window.utils
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   
   public class MouseCursorControl
   {
      
      private static var var_329:uint = 0;
      
      private static var var_1859:Stage;
      
      private static var var_848:Boolean = true;
      
      private static var _disposed:Boolean = false;
      
      private static var var_3806:Boolean = true;
      
      private static var var_1843:DisplayObject;
      
      private static var var_4118:Dictionary = new Dictionary();
       
      
      public function MouseCursorControl(param1:DisplayObject)
      {
         super();
         var_1859 = param1.stage;
      }
      
      public static function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1843)
            {
               var_1859.removeChild(var_1843);
               var_1859.removeEventListener("mouseLeave",onStageMouseLeave);
               var_1859.removeEventListener("mouseMove",onStageMouseMove);
               var_1859.removeEventListener("mouseOver",onStageMouseMove);
               var_1859.removeEventListener("mouseOut",onStageMouseMove);
            }
            _disposed = true;
         }
      }
      
      public static function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public static function get type() : uint
      {
         return var_329;
      }
      
      public static function set type(param1:uint) : void
      {
         if(var_329 != param1)
         {
            var_329 = param1;
            var_3806 = true;
         }
      }
      
      public static function get visible() : Boolean
      {
         return var_848;
      }
      
      public static function set visible(param1:Boolean) : void
      {
         var_848 = param1;
         if(var_848)
         {
            if(var_1843)
            {
               var_1843.visible = true;
            }
            else
            {
               Mouse.show();
            }
         }
         else if(var_1843)
         {
            var_1843.visible = false;
         }
         else
         {
            Mouse.hide();
         }
      }
      
      public static function change() : void
      {
         var _loc1_:DisplayObject = null;
         if(var_3806)
         {
            _loc1_ = var_4118[var_329];
            if(_loc1_)
            {
               if(var_1843)
               {
                  var_1859.removeChild(var_1843);
               }
               else
               {
                  var_1859.addEventListener("mouseLeave",onStageMouseLeave);
                  var_1859.addEventListener("mouseMove",onStageMouseMove);
                  var_1859.addEventListener("mouseOver",onStageMouseMove);
                  var_1859.addEventListener("mouseOut",onStageMouseMove);
                  Mouse.hide();
               }
               var_1843 = _loc1_;
               var_1859.addChild(var_1843);
            }
            else
            {
               if(var_1843)
               {
                  var_1859.removeChild(var_1843);
                  var_1859.removeEventListener("mouseLeave",onStageMouseLeave);
                  var_1859.removeEventListener("mouseMove",onStageMouseMove);
                  var_1859.removeEventListener("mouseOver",onStageMouseMove);
                  var_1859.removeEventListener("mouseOut",onStageMouseMove);
                  var_1843 = null;
                  Mouse.show();
               }
               switch(var_329)
               {
                  case 0:
                  case 1:
                     Mouse.cursor = "auto";
                     break;
                  case 2:
                     Mouse.cursor = "button";
                     break;
                  case 5:
                  case 6:
                  case 7:
                  case 8:
                     Mouse.cursor = "hand";
                     break;
                  case 4294967294:
                     Mouse.cursor = "auto";
                     Mouse.hide();
               }
            }
            var_3806 = false;
         }
      }
      
      public static function defineCustomCursorType(param1:uint, param2:DisplayObject) : void
      {
         var_4118[param1] = param2;
      }
      
      private static function onStageMouseMove(param1:MouseEvent) : void
      {
         if(var_1843)
         {
            var_1843.x = param1.stageX - 2;
            var_1843.y = param1.stageY;
            if(var_329 == 0)
            {
               var_848 = false;
               Mouse.show();
            }
            else
            {
               var_848 = true;
               Mouse.hide();
            }
         }
      }
      
      private static function onStageMouseLeave(param1:Event) : void
      {
         if(var_1843 && var_329 != 0)
         {
            Mouse.hide();
            var_848 = false;
         }
      }
   }
}
