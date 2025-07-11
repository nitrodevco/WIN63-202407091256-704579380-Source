package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class class_3664 extends DefaultActionType
   {
       
      
      public function class_3664()
      {
         super();
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.users.title.bots";
         }
         return super.userSelectionTitle(param1);
      }
   }
}
