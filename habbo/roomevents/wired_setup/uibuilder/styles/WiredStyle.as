package com.sulake.habbo.roomevents.wired_setup.uibuilder.styles
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class WiredStyle
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function WiredStyle(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
      }
      
      protected function get styleTemplate() : IWindowContainer
      {
         return null;
      }
      
      public function get radioButtonSpacing() : int
      {
         return 0;
      }
      
      public function get checkboxSpacing() : int
      {
         return 0;
      }
      
      public function get sectionSpacing() : int
      {
         return 0;
      }
      
      public function get sectionLeftRightMargin() : int
      {
         return 5;
      }
      
      public function get backgroundColor() : uint
      {
         return 0;
      }
      
      public function get minimumOptionHeight() : int
      {
         return 0;
      }
      
      public function get minimumOptionSpacing() : int
      {
         return 0;
      }
      
      public function createSplitterView() : IWindowContainer
      {
         return recreateElement("ruler_view") as IWindowContainer;
      }
      
      public function createTextView(param1:Boolean = true) : ITextWindow
      {
         return recreateElement(param1 ? "text_bold_view" : "text_view") as ITextWindow;
      }
      
      public function createTextInputView() : ITextFieldWindow
      {
         return recreateElement("input_template") as ITextFieldWindow;
      }
      
      public function createCheckboxView() : class_3398
      {
         return recreateElement("checkbox_view") as class_3398;
      }
      
      public function createRadioButtonView() : IRadioButtonWindow
      {
         return recreateElement("radiobutton_view") as IRadioButtonWindow;
      }
      
      private function recreateElement(param1:String) : IWindow
      {
         var _loc2_:IWindow = styleTemplate.findChildByName(param1);
         _loc2_ = _loc2_.clone();
         _loc2_.visible = true;
         return _loc2_;
      }
   }
}
