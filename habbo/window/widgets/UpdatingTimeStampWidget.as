package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class UpdatingTimeStampWidget implements class_3614
   {
      
      public static const TYPE:String = "updating_timestamp";
      
      private static const UPDATE_TIMER:Timer = new Timer(60000);
      
      {
         UPDATE_TIMER.start();
      }
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:ILabelWindow;
      
      private var var_781:Number;
      
      public function UpdatingTimeStampWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.create("",12,100,16,new Rectangle()) as ILabelWindow;
         var_509.textColor = 5592405;
         var_1759.rootWindow = var_509;
         UPDATE_TIMER.addEventListener("timer",onTimerTick);
         reset();
      }
      
      public function reset() : void
      {
         var_781 = new Date().getTime();
         onTimerTick();
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function set align(param1:String) : void
      {
         var_509.defaultTextFormat.align = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UPDATE_TIMER.removeEventListener("timer",onTimerTick);
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get timeStamp() : Number
      {
         return var_781;
      }
      
      public function set timeStamp(param1:Number) : void
      {
         var_781 = param1;
         onTimerTick();
      }
      
      private function onTimerTick(param1:TimerEvent = null) : void
      {
         if(_disposed || !var_509 || !_windowManager || !_windowManager.localization)
         {
            return;
         }
         var_509.caption = FriendlyTime.getFriendlyTime(_windowManager.localization,(new Date().getTime() - Math.abs(var_781)) / 1000,".ago",1);
      }
   }
}
