package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class WiredUIPreset
   {
       
      
      protected var _roomEvents:HabboUserDefinedRoomEvents;
      
      protected var var_4162:PresetManager;
      
      protected var var_3450:WiredStyle;
      
      public function WiredUIPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super();
         _roomEvents = param1;
         var_4162 = param2;
         var_3450 = param3;
      }
      
      public function get window() : IWindow
      {
         return null;
      }
      
      public function resizeToParent(param1:int) : void
      {
      }
   }
}
