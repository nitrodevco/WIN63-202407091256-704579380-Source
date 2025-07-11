package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomToolsCtrlBase
   {
      
      protected static const DISTANCE_FROM_BOTTOM:int = 55;
      
      protected static const TOOLBAR_X:int = -5;
      
      protected static const const_849:int = 100;
       
      
      protected var _window:IWindowContainer;
      
      protected var var_1629:RoomToolsWidget;
      
      protected var _windowManager:IHabboWindowManager;
      
      protected var _assets:IAssetLibrary;
      
      protected var var_1798:Boolean = true;
      
      protected var var_2118:Timer;
      
      protected var var_3204:Boolean;
      
      protected var var_4390:int;
      
      public function RoomToolsCtrlBase(param1:RoomToolsWidget, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super();
         var_1629 = param1;
         _windowManager = param2;
         _assets = param3;
         var_4390 = handler.container.config.getInteger("room.enter.info.collapse.delay",5000);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.procedure = null;
            _window.dispose();
            _window = null;
         }
         if(var_2118)
         {
            var_2118.reset();
            var_2118 = null;
            var_3204 = false;
         }
         var_1629 = null;
      }
      
      public function setElementVisible(param1:String, param2:Boolean) : void
      {
         if(!_window || !_window.findChildByName(param1))
         {
            return;
         }
         _window.findChildByName(param1).visible = param2;
      }
      
      protected function collapseAfterDelay() : void
      {
         clearCollapseTimer();
         var_2118 = new Timer(var_4390,1);
         var_2118.addEventListener("timer",collapseTimerEventHandler);
         var_2118.start();
      }
      
      protected function collapseIfPending() : void
      {
         if(var_3204)
         {
            collapseAfterDelay();
         }
      }
      
      protected function clearCollapseTimer() : void
      {
         if(var_2118 != null)
         {
            var_2118.reset();
            var_2118 = null;
         }
         var_3204 = false;
      }
      
      private function collapseTimerEventHandler(param1:TimerEvent) : void
      {
         clearCollapseTimer();
         setCollapsed(true);
      }
      
      protected function cancelWindowCollapse() : void
      {
         if(var_2118 != null)
         {
            clearCollapseTimer();
            var_3204 = true;
         }
      }
      
      public function setCollapsed(param1:Boolean) : void
      {
      }
      
      public function get isCollapsed() : Boolean
      {
         return var_1798;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function get handler() : RoomToolsWidgetHandler
      {
         return !!var_1629 ? var_1629.handler : null;
      }
   }
}
