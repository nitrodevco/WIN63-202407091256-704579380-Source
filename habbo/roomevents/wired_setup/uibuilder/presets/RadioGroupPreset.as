package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ItemListController;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RadioGroupPreset extends WiredUIPreset
   {
       
      
      private var _container:ISelectorWindow;
      
      private var var_4213:Vector.<RadioButtonPreset>;
      
      public function RadioGroupPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         var _loc5_:RadioButtonPreset = null;
         super(param1,param2,param3);
         _container = param2.createLayout("radio_group_view") as ISelectorWindow;
         var_4213 = new Vector.<RadioButtonPreset>();
         for each(var _loc6_ in param4)
         {
            _loc5_ = param2.createRadioButton(_loc6_);
            var_4213.push(_loc5_);
            itemList.addListItem(_loc5_.window);
         }
      }
      
      public function get selected() : int
      {
         return _container.getSelected().id;
      }
      
      public function set selected(param1:int) : void
      {
         var _loc2_:IRadioButtonWindow = _container.findChildByName(RadioButtonPreset.OPTION_PREFIX + param1) as IRadioButtonWindow;
         _container.setSelected(_loc2_);
      }
      
      override public function resizeToParent(param1:int) : void
      {
         super.resizeToParent(param1);
         _container.width = param1;
         itemList.width = param1;
         for each(var _loc2_ in var_4213)
         {
            _loc2_.resizeToParent(param1);
         }
      }
      
      private function get itemList() : ItemListController
      {
         return _container.findChildByName("radio_button_list") as ItemListController;
      }
      
      override public function get window() : IWindow
      {
         return _container;
      }
   }
}
