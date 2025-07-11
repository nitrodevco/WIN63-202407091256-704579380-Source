package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.utils.class_3562;
   
   public class AlertDialogCaption implements class_3562
   {
       
      
      private var _text:String;
      
      private var var_3915:String;
      
      private var var_848:Boolean;
      
      public function AlertDialogCaption(param1:String, param2:String, param3:Boolean)
      {
         super();
         _text = param1;
         var_3915 = param2;
         var_848 = param3;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function get toolTip() : String
      {
         return var_3915;
      }
      
      public function set toolTip(param1:String) : void
      {
         var_3915 = param1;
      }
      
      public function get visible() : Boolean
      {
         return var_848;
      }
      
      public function set visible(param1:Boolean) : void
      {
         var_848 = param1;
      }
   }
}
