package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SplitterPreset extends WiredUIPreset
   {
       
      
      private var _window:IWindowContainer;
      
      public function SplitterPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         _window = param3.createSplitterView();
      }
      
      override public function get window() : IWindow
      {
         return _window;
      }
      
      override public function resizeToParent(param1:int) : void
      {
         super.resizeToParent(param1);
         _window.width = param1;
      }
   }
}
