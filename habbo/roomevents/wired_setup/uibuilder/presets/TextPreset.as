package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextPreset extends WiredUIPreset
   {
       
      
      private var var_3237:TextParam;
      
      private var _window:ITextWindow;
      
      public function TextPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:TextParam)
      {
         super(param1,param2,param3);
         var_3237 = param5;
         _window = param3.createTextView(param5.bold);
         _window.text = param4;
         if(param5.allowMultiline)
         {
            _window.multiline = true;
            _window.wordWrap = true;
         }
      }
      
      override public function get window() : IWindow
      {
         return _window;
      }
      
      override public function resizeToParent(param1:int) : void
      {
         super.resizeToParent(param1);
         if(var_3237.allowMultiline)
         {
            _window.width = param1;
         }
      }
   }
}
