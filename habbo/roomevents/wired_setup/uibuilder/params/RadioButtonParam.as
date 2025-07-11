package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class RadioButtonParam
   {
       
      
      private var var_280:int;
      
      private var _text:String;
      
      public function RadioButtonParam(param1:int, param2:String)
      {
         super();
         this.var_280 = param1;
         this._text = param2;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}
