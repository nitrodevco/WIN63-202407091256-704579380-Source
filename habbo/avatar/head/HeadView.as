package com.sulake.habbo.avatar.head
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_3554;
   import com.sulake.habbo.avatar.common.class_3676;
   
   public class HeadView extends CategoryBaseView implements class_3676
   {
       
      
      public function HeadView(param1:class_3554)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_1644.controller.view.getCategoryContainer("head") as IWindowContainer;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         var_1618 = true;
         if(var_1644 && var_1713 == "")
         {
            var_1644.switchCategory("hr");
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         inactivateTab(_currentTabName);
         param1 = param1 == "" ? var_1713 : param1;
         switch(param1)
         {
            case "hr":
               _currentTabName = "tab_hair";
               break;
            case "ha":
               _currentTabName = "tab_hat";
               break;
            case "he":
               _currentTabName = "tab_accessories";
               break;
            case "ea":
               _currentTabName = "tab_eyewear";
               break;
            case "fa":
               _currentTabName = "tab_masks";
               break;
            default:
               throw new Error("[HeadView] Unknown item category: \"" + param1 + "\"");
         }
         var_1713 = param1;
         activateTab(_currentTabName);
         if(!var_1618)
         {
            init();
         }
         updateGridView(param1);
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_hair":
                  switchCategory("hr");
                  break;
               case "tab_hat":
                  switchCategory("ha");
                  break;
               case "tab_accessories":
                  switchCategory("he");
                  break;
               case "tab_eyewear":
                  switchCategory("ea");
                  break;
               case "tab_masks":
                  switchCategory("fa");
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_hair":
               case "tab_hat":
               case "tab_accessories":
               case "tab_eyewear":
               case "tab_masks":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_hair":
               case "tab_hat":
               case "tab_accessories":
               case "tab_eyewear":
               case "tab_masks":
                  if(_currentTabName != param2.name)
                  {
                     inactivateTab(param2.name);
                  }
            }
         }
      }
   }
}
