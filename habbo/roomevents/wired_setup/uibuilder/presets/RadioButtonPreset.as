package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RadioButtonPreset extends WiredUIPreset
   {
      
      public static var OPTION_PREFIX:String = "option_";
       
      
      private var _container:IItemListWindow;
      
      private var _textPreset:TextPreset;
      
      public function RadioButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:RadioButtonParam)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("horizontal_list_view") as IItemListWindow;
         var _loc5_:IRadioButtonWindow = param3.createRadioButtonView();
         _textPreset = param2.createText(param4.text);
         _loc5_.name = OPTION_PREFIX + param4.id;
         _loc5_.id = param4.id;
         _container.addListItem(_loc5_);
         _container.addListItem(_textPreset.window);
         _container.spacing = param3.radioButtonSpacing;
      }
      
      override public function resizeToParent(param1:int) : void
      {
         super.resizeToParent(param1);
         _container.width = param1;
         _textPreset.resizeToParent(param1 - _textPreset.window.x);
         _container.height = Math.max(var_3450.minimumOptionHeight,_textPreset.window.height + var_3450.minimumOptionSpacing);
      }
      
      override public function get window() : IWindow
      {
         return _container;
      }
   }
}
