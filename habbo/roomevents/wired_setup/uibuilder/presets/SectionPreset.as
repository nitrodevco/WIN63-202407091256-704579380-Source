package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SectionPreset extends WiredUIPreset
   {
       
      
      private var _container:IItemListWindow;
      
      private var _sectionWithMargin:IItemListWindow;
      
      private var _splitter:SplitterPreset;
      
      private var var_617:TextPreset;
      
      private var var_4002:WiredUIPreset;
      
      public function SectionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:WiredUIPreset)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         _sectionWithMargin = param2.createLayout("vertical_list_view") as IItemListWindow;
         _container.spacing = param3.sectionSpacing;
         _sectionWithMargin.spacing = param3.sectionSpacing;
         _sectionWithMargin.x = param3.sectionLeftRightMargin;
         var _loc6_:TextParam = new TextParam(true,true);
         var_617 = param2.createText(param4,_loc6_);
         _splitter = param2.createSplitter();
         var_4002 = param5;
         _container.addListItem(_splitter.window);
         _sectionWithMargin.addListItem(var_617.window);
         _sectionWithMargin.addListItem(var_4002.window);
         _container.addListItem(_sectionWithMargin);
      }
      
      override public function resizeToParent(param1:int) : void
      {
         super.resizeToParent(param1);
         _container.width = param1;
         var _loc2_:int = int(_sectionWithMargin.width);
         _sectionWithMargin.width = _loc2_;
         _splitter.resizeToParent(param1);
         var_617.resizeToParent(_loc2_);
         var_4002.resizeToParent(_loc2_);
      }
      
      override public function get window() : IWindow
      {
         return _container;
      }
   }
}
