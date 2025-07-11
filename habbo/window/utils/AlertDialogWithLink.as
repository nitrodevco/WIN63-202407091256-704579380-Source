package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3401;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class AlertDialogWithLink extends AlertDialog implements class_3401
   {
       
      
      protected var _linkTitle:String = "";
      
      protected var var_4039:String = "";
      
      public function AlertDialogWithLink(param1:IHabboWindowManager, param2:XML, param3:String, param4:String, param5:String, param6:String, param7:uint, param8:Function)
      {
         super(param1,param2,param3,param4,param7,param8,false);
         this.linkTitle = param5;
         this.linkUrl = param6;
      }
      
      override protected function dialogEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:* = param2.name;
            if("_alert_button_link" === _loc3_)
            {
               HabboWebTools.navigateToURL(var_4039,"_empty");
               return;
            }
         }
         super.dialogEventProc(param1,param2);
      }
      
      public function set linkTitle(param1:String) : void
      {
         _linkTitle = param1;
         if(_window)
         {
            class_3357(_window.findChildByTag("LINK")).caption = _linkTitle;
         }
      }
      
      public function get linkTitle() : String
      {
         return _linkTitle;
      }
      
      public function set linkUrl(param1:String) : void
      {
         var_4039 = param1;
      }
      
      public function get linkUrl() : String
      {
         return var_4039;
      }
   }
}
