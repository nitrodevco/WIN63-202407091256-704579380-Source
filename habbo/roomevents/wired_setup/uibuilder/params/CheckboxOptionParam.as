package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class CheckboxOptionParam
   {
       
      
      private var _text:String;
      
      public function CheckboxOptionParam(param1:String)
      {
         super();
         this._text = param1;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}
