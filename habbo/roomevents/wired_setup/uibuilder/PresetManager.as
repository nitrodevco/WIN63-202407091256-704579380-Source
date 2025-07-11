package com.sulake.habbo.roomevents.wired_setup.uibuilder
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SplitterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PresetManager
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_3875:Map;
      
      public function PresetManager(param1:HabboUserDefinedRoomEvents)
      {
         var_3875 = new Map();
         super();
         _roomEvents = param1;
      }
      
      public function createRadioButton(param1:RadioButtonParam) : RadioButtonPreset
      {
         return new RadioButtonPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createRadioGroup(param1:Array) : RadioGroupPreset
      {
         return new RadioGroupPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createCheckboxOption(param1:CheckboxOptionParam) : CheckboxOptionPreset
      {
         return new CheckboxOptionPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createCheckboxGroup(param1:Array) : CheckboxGroupPreset
      {
         return new CheckboxGroupPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createSection(param1:String, param2:WiredUIPreset) : SectionPreset
      {
         return new SectionPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createSplitter() : SplitterPreset
      {
         return new SplitterPreset(_roomEvents,this,wiredStyle);
      }
      
      public function createText(param1:String, param2:TextParam = null) : TextPreset
      {
         if(param2 == null)
         {
            param2 = TextParam.DEFAULT;
         }
         return new TextPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      private function get wiredStyle() : WiredStyle
      {
         return _roomEvents.userDefinedRoomEventsCtrl.wiredStyle;
      }
      
      public function createLayout(param1:String) : IWindow
      {
         if(var_3875.hasKey(param1))
         {
            return var_3875.getValue(param1).clone();
         }
         var _loc2_:IWindow = _roomEvents.getXmlWindow(param1);
         var_3875.add(param1,_loc2_);
         return _loc2_.clone();
      }
   }
}
