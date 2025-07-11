package com.sulake.habbo.freeflowchat.history.visualization.entry
{
   import flash.display.Bitmap;
   
   public class class_3536 extends Bitmap
   {
       
      
      private var var_418:int;
      
      private var var_369:int;
      
      private var var_4742:Boolean;
      
      private var _userName:String;
      
      public function class_3536()
      {
         super();
      }
      
      public function get canIgnore() : Boolean
      {
         return var_4742;
      }
      
      public function set canIgnore(param1:Boolean) : void
      {
         var_4742 = param1;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function set userId(param1:int) : void
      {
         var_418 = param1;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function set roomId(param1:int) : void
      {
         var_369 = param1;
      }
   }
}
