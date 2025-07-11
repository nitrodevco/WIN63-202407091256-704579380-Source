package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class TextParam
   {
      
      public static const DEFAULT:TextParam = new TextParam(true,false);
       
      
      private var var_4533:Boolean;
      
      private var var_4849:Boolean;
      
      public function TextParam(param1:Boolean, param2:Boolean)
      {
         super();
         var_4533 = param1;
         var_4849 = param2;
      }
      
      public function get allowMultiline() : Boolean
      {
         return var_4533;
      }
      
      public function get bold() : Boolean
      {
         return var_4849;
      }
   }
}
