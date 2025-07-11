package com.sulake.habbo.utils
{
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class InfoText
   {
       
      
      private var var_1730:ITextFieldWindow;
      
      private var _includeInfo:Boolean;
      
      private var var_3776:String = "";
      
      public function InfoText(param1:ITextFieldWindow, param2:String = null)
      {
         super();
         var_1730 = param1;
         if(param2 != null)
         {
            _includeInfo = true;
            var_3776 = param2;
            var_1730.text = param2;
         }
         var_1730.addEventListener("WE_FOCUSED",onFocus);
      }
      
      public function dispose() : void
      {
         if(var_1730)
         {
            var_1730.dispose();
            var_1730 = null;
         }
      }
      
      public function goBackToInitialState() : void
      {
         var_1730.text = var_3776;
         _includeInfo = true;
      }
      
      public function getText() : String
      {
         return _includeInfo ? "" : String(var_1730.text);
      }
      
      public function setText(param1:String) : void
      {
         _includeInfo = false;
         var_1730.text = param1;
      }
      
      public function get input() : ITextFieldWindow
      {
         return var_1730;
      }
      
      private function onFocus(param1:WindowEvent) : void
      {
         if(!_includeInfo)
         {
            return;
         }
         var_1730.text = "";
         _includeInfo = false;
      }
   }
}
