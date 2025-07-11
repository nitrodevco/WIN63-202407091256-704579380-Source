package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CheckboxGroupPreset extends WiredUIPreset
   {
       
      
      private var _container:IItemListWindow;
      
      private var var_3896:Vector.<CheckboxOptionPreset>;
      
      public function CheckboxGroupPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         var _loc5_:CheckboxOptionPreset = null;
         super(param1,param2,param3);
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         var_3896 = new Vector.<CheckboxOptionPreset>();
         for each(var _loc6_ in param4)
         {
            _loc5_ = param2.createCheckboxOption(_loc6_);
            var_3896.push(_loc5_);
            _container.addListItem(_loc5_.window);
         }
      }
      
      public function method_20(param1:int) : CheckboxOptionPreset
      {
         return var_3896[param1];
      }
      
      override public function resizeToParent(param1:int) : void
      {
         super.resizeToParent(param1);
         _container.width = param1;
         for each(var _loc2_ in var_3896)
         {
            _loc2_.resizeToParent(param1);
         }
      }
      
      override public function get window() : IWindow
      {
         return _container;
      }
   }
}
