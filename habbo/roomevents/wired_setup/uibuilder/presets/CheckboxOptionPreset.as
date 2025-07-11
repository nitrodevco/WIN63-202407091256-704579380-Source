package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CheckboxOptionPreset extends WiredUIPreset
   {
       
      
      private var _container:IItemListWindow;
      
      private var _checkbox:class_3398;
      
      private var _textPreset:TextPreset;
      
      public function CheckboxOptionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:CheckboxOptionParam)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _checkbox = param3.createCheckboxView();
         _textPreset = param2.createText(param4.text);
         _container.addListItem(_checkbox);
         _container.addListItem(_textPreset.window);
         _container.spacing = param3.checkboxSpacing;
      }
      
      public function set selected(param1:Boolean) : void
      {
         Util.select(_checkbox,param1);
      }
      
      public function get selected() : Boolean
      {
         return _checkbox.isSelected;
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
