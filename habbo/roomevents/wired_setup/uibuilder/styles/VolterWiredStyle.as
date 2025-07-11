package com.sulake.habbo.roomevents.wired_setup.uibuilder.styles
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class VolterWiredStyle extends WiredStyle
   {
       
      
      private var var_4724:IWindowContainer;
      
      public function VolterWiredStyle(param1:HabboUserDefinedRoomEvents)
      {
         super(param1);
         var_4724 = IWindowContainer(param1.getXmlWindow("wired_style_volter"));
      }
      
      override protected function get styleTemplate() : IWindowContainer
      {
         return var_4724;
      }
      
      override public function get radioButtonSpacing() : int
      {
         return 4;
      }
      
      override public function get checkboxSpacing() : int
      {
         return 2;
      }
      
      override public function get sectionSpacing() : int
      {
         return 4;
      }
      
      override public function get sectionLeftRightMargin() : int
      {
         return 5;
      }
      
      override public function get minimumOptionHeight() : int
      {
         return 20;
      }
      
      override public function get minimumOptionSpacing() : int
      {
         return 3;
      }
      
      override public function get backgroundColor() : uint
      {
         return 4013373;
      }
   }
}
