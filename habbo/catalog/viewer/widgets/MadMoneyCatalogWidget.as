package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   
   public class MadMoneyCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var var_3047:class_3357;
      
      public function MadMoneyCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_3047 != null)
         {
            var_3047.removeEventListener("WME_CLICK",eventProc);
            var_3047 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_3047 = _window.findChildByName("ctlg_madmoney_button") as class_3357;
         if(var_3047 != null)
         {
         }
         return true;
      }
      
      private function eventProc(param1:WindowMouseEvent) : void
      {
         var event:WindowMouseEvent = param1;
         page.viewer.catalog.windowManager.alert("TODO","Fix in MadMoneyCatalogWidget.as",0,function(param1:class_3348, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
   }
}
