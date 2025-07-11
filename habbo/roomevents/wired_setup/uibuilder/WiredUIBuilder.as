package com.sulake.habbo.roomevents.wired_setup.uibuilder
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class WiredUIBuilder
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_3450:WiredStyle;
      
      private var var_4162:PresetManager;
      
      private var _container:IWindowContainer;
      
      private var var_19:IItemListWindow;
      
      private var var_216:Vector.<WiredUIPreset>;
      
      public function WiredUIBuilder(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         var_3450 = _roomEvents.userDefinedRoomEventsCtrl.wiredStyle;
         var_4162 = _roomEvents.userDefinedRoomEventsCtrl.presetManager;
         var_19 = var_4162.createLayout("vertical_list_view") as IItemListWindow;
         _container = var_4162.createLayout("growing_container_view") as IWindowContainer;
         _container.background = true;
         _container.color = 4278190080 | var_3450.backgroundColor;
         _container.addChild(var_19);
      }
      
      public function build(... rest) : void
      {
         var_216 = new Vector.<WiredUIPreset>();
         var_19.removeListItems();
         for each(var _loc2_ in rest)
         {
            var_216.push(_loc2_);
            var_19.addListItem(_loc2_.window);
         }
      }
      
      public function get container() : IWindowContainer
      {
         return _container;
      }
      
      public function initializeWidth() : void
      {
         var _loc1_:int = int(_container.width);
         _container.width = _loc1_;
         for each(var _loc2_ in var_216)
         {
            _loc2_.resizeToParent(_loc1_);
         }
      }
   }
}
