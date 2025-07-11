package com.sulake.habbo.avatar.generic
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_3554;
   import com.sulake.habbo.avatar.common.class_3676;
   
   public class BodyView extends CategoryBaseView implements class_3676
   {
       
      
      private const TAB_BOY_ID:String = "tab_boy";
      
      private const TAB_GIRL_ID:String = "tab_girl";
      
      public function BodyView(param1:class_3554)
      {
         super(param1);
         var_1713 = "hd";
      }
      
      override public function reset() : void
      {
         super.reset();
         var_1713 = "hd";
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_1644.controller.view.getCategoryContainer("generic") as IWindowContainer;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         updateGridView("hd");
         var_1618 = true;
         updateGenderTab();
      }
      
      override public function getWindowContainer() : IWindowContainer
      {
         if(!var_1618)
         {
            init();
         }
         updateGenderTab();
         return _window;
      }
      
      public function updateGenderTab() : void
      {
         if(var_1644 == null)
         {
            return;
         }
         switch(var_1644.controller.gender)
         {
            case "M":
               activateTab("tab_boy");
               inactivateTab("tab_girl");
               break;
            case "F":
               activateTab("tab_girl");
               inactivateTab("tab_boy");
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         updateGenderTab();
         updateGridView(param1 == "" ? var_1713 : param1);
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_boy":
                  var_1644.controller.gender = "M";
                  param1.stopPropagation();
                  break;
               case "tab_girl":
                  var_1644.controller.gender = "F";
                  param1.stopPropagation();
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_boy":
               case "tab_girl":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_boy":
               case "tab_girl":
                  updateGenderTab();
            }
         }
      }
   }
}
