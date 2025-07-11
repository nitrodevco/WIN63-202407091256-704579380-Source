package com.sulake.habbo.avatar.torso
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_3676;
   
   public class TorsoView extends CategoryBaseView implements class_3676
   {
       
      
      public function TorsoView(param1:TorsoModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_1644.controller.view.getCategoryContainer("torso") as IWindowContainer;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         var_1618 = true;
         if(var_1644 && var_1713 == "")
         {
            var_1644.switchCategory("ch");
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1644 = null;
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
         param1 = param1 == "" ? var_1713 : param1;
         inactivateTab(_currentTabName);
         switch(param1)
         {
            case "ch":
               _currentTabName = "tab_shirt";
               break;
            case "cc":
               _currentTabName = "tab_jacket";
               break;
            case "cp":
               _currentTabName = "tab_prints";
               break;
            case "ca":
               _currentTabName = "tab_accessories";
               break;
            default:
               throw new Error("[TorsoView] Unknown item category: \"" + param1 + "\"");
         }
         var_1713 = param1;
         activateTab(_currentTabName);
         if(!var_1618)
         {
            init();
         }
         updateGridView(var_1713);
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_jacket":
                  switchCategory("cc");
                  break;
               case "tab_shirt":
                  switchCategory("ch");
                  break;
               case "tab_accessories":
                  switchCategory("ca");
                  break;
               case "tab_prints":
                  switchCategory("cp");
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_jacket":
               case "tab_prints":
               case "tab_shirt":
               case "tab_accessories":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_jacket":
               case "tab_prints":
               case "tab_shirt":
               case "tab_accessories":
                  if(_currentTabName != param2.name)
                  {
                     inactivateTab(param2.name);
                  }
            }
         }
      }
   }
}
