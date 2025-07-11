package com.sulake.core.window.components
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.theme.IThemeManager;
   import flash.geom.Rectangle;
   
   public class TextLinkController extends TextController implements ITextLinkWindow
   {
       
      
      private var var_2993:uint;
      
      private var var_2184:String;
      
      private var var_3651:Boolean;
      
      protected var var_3612:Boolean;
      
      protected var var_2847:Map;
      
      public function TextLinkController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc12_:IThemeManager;
         var_2993 = int((_loc12_ = param5.getWindowFactory().getThemeManager()).getPropertyDefaults(param3).method_20("tool_tip_delay").value);
         var_2184 = String(_loc12_.getPropertyDefaults(param3).method_20("tool_tip_caption").value);
         var_3651 = _loc12_.getPropertyDefaults(param3).method_20("tool_tip_is_dynamic").value;
         var_3612 = _loc12_.getPropertyDefaults(param3).method_20("interactive_cursor_disabled").value;
         super(param1,param2,param3,(param4 | 1) & ~16,param5,param6,param7,param8,param9,param10,param11);
         immediateClickMode = true;
         mouseThreshold = 0;
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         if(param1 == this)
         {
            InteractiveController.processInteractiveWindowEvents(this,param2);
         }
         return _loc3_;
      }
      
      public function set mouseCursorType(param1:uint) : void
      {
      }
      
      public function get mouseCursorType() : uint
      {
         return 0;
      }
      
      public function set toolTipCaption(param1:String) : void
      {
         var_2184 = param1 == null ? "" : param1;
      }
      
      public function get toolTipCaption() : String
      {
         return var_2184;
      }
      
      public function set toolTipDelay(param1:uint) : void
      {
         var_2993 = param1;
      }
      
      public function get toolTipDelay() : uint
      {
         return var_2993;
      }
      
      public function setMouseCursorForState(param1:uint, param2:uint) : uint
      {
         if(!var_2847)
         {
            var_2847 = new Map();
         }
         var _loc3_:uint = uint(var_2847[param1]);
         if(param2 == 0 || param2 == -1)
         {
            var_2847.remove(param1);
         }
         else
         {
            var_2847[param1] = param2;
         }
         return _loc3_;
      }
      
      public function getMouseCursorByState(param1:uint) : uint
      {
         if(!var_2847)
         {
            return 0;
         }
         return var_2847.getValue(param1);
      }
      
      public function showToolTip(param1:IToolTipWindow) : void
      {
         throw new Error("Unimplemented method!");
      }
      
      public function hideToolTip() : void
      {
         throw new Error("Unimplemented method!");
      }
      
      override public function get properties() : Array
      {
         return InteractiveController.writeInteractiveWindowProperties(this,super.properties);
      }
      
      override public function set properties(param1:Array) : void
      {
         InteractiveController.readInteractiveWindowProperties(this,param1);
         super.properties = param1;
      }
      
      public function set toolTipIsDynamic(param1:Boolean) : void
      {
         var_3651 = param1;
      }
      
      public function get toolTipIsDynamic() : Boolean
      {
         return var_3651;
      }
      
      public function get interactiveCursorDisabled() : Boolean
      {
         return var_3612;
      }
      
      public function set interactiveCursorDisabled(param1:Boolean) : void
      {
         var_3612 = param1;
      }
   }
}
