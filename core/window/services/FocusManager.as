package com.sulake.core.window.services
{
   import com.sulake.core.window.components.class_3403;
   import com.sulake.core.window.utils.*;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   
   public class FocusManager implements class_3694
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_1859:Stage;
      
      private var var_20:Vector.<class_3403>;
      
      public function FocusManager(param1:DisplayObject)
      {
         var_20 = new Vector.<class_3403>();
         var_1859 = param1.stage;
         var_1859.addEventListener("activate",onActivateEvent);
         var_1859.addEventListener("focusOut",onFocusEvent);
         var_1859.addEventListener("keyFocusChange",onFocusEvent);
         var_1859.addEventListener("mouseFocusChange",onFocusEvent);
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_1859.removeEventListener("activate",onActivateEvent);
            var_1859.removeEventListener("focusOut",onFocusEvent);
            var_1859.removeEventListener("keyFocusChange",onFocusEvent);
            var_1859.removeEventListener("mouseFocusChange",onFocusEvent);
            var_1859 = null;
            _disposed = true;
            var_20 = null;
         }
      }
      
      public function registerFocusWindow(param1:class_3403) : void
      {
         if(param1 != null)
         {
            if(var_20.indexOf(param1) == -1)
            {
               var_20.push(param1);
               if(var_1859.focus == null)
               {
                  param1.focus();
               }
            }
         }
      }
      
      public function removeFocusWindow(param1:class_3403) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = var_20.indexOf(param1);
            if(_loc2_ > -1)
            {
               var_20.splice(_loc2_,1);
            }
         }
         if(var_1859.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function resolveNextFocusTarget() : class_3403
      {
         var _loc1_:class_3403 = null;
         var _loc2_:uint = var_20.length;
         while(_loc2_-- != 0)
         {
            _loc1_ = var_20[_loc2_] as class_3403;
            if(!_loc1_.disposed)
            {
               _loc1_.focus();
               break;
            }
            var_20.splice(_loc2_,1);
         }
         return _loc1_;
      }
      
      private function onActivateEvent(param1:Event) : void
      {
         if(var_1859.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function onFocusEvent(param1:FocusEvent) : void
      {
         if(var_1859.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
   }
}
