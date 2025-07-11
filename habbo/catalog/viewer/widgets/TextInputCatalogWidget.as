package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
   
   public class TextInputCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var var_3576:ITextFieldWindow;
      
      public function TextInputCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_3576 = _window.findChildByName("input_text") as ITextFieldWindow;
         if(var_3576 != null)
         {
            var_3576.addEventListener("WKE_KEY_UP",onKey);
         }
         return true;
      }
      
      private function onKey(param1:WindowKeyboardEvent) : void
      {
         if(var_3576 == null)
         {
            return;
         }
         events.dispatchEvent(new TextInputEvent(var_3576.text));
      }
   }
}
