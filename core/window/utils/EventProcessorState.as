package com.sulake.core.window.utils
{
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.graphics.class_3354;
   
   public class EventProcessorState
   {
       
      
      public var renderer:class_3354;
      
      public var desktop:class_3460;
      
      public var var_3892:IWindow;
      
      public var lastClickTarget:IWindow;
      
      public var lastMouseDownTarget:IWindow;
      
      public var var_4720:IWindow;
      
      public var eventTrackers:Vector.<IInputEventTracker>;
      
      public function EventProcessorState(param1:class_3354, param2:class_3460, param3:IWindow, param4:IWindow, param5:IWindow, param6:IWindow, param7:Vector.<IInputEventTracker>)
      {
         super();
         this.renderer = param1;
         this.desktop = param2;
         this.var_3892 = param3;
         this.lastClickTarget = param4;
         this.lastMouseDownTarget = param5;
         this.var_4720 = param6;
         this.eventTrackers = param7;
      }
   }
}
