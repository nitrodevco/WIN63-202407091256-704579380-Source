package com.sulake.habbo.avatar.actions
{
   public class ActiveActionData implements class_3544
   {
       
      
      private var var_683:String = "";
      
      private var var_735:String = "";
      
      private var var_3066:class_3576;
      
      private var _startFrame:int = 0;
      
      private var _overridingAction:String;
      
      public function ActiveActionData(param1:String, param2:String = "", param3:int = 0)
      {
         super();
         var_683 = param1;
         var_735 = param2;
         _startFrame = param3;
      }
      
      public function get actionType() : String
      {
         return var_683;
      }
      
      public function get actionParameter() : String
      {
         return var_735;
      }
      
      public function get definition() : class_3576
      {
         return var_3066;
      }
      
      public function get id() : String
      {
         if(var_3066 == null)
         {
            return "";
         }
         return var_3066.id + "_" + var_735;
      }
      
      public function set actionParameter(param1:String) : void
      {
         var_735 = param1;
      }
      
      public function set definition(param1:class_3576) : void
      {
         var_3066 = param1;
      }
      
      public function dispose() : void
      {
         var_683 = null;
         var_735 = null;
         var_3066 = null;
      }
      
      public function get startFrame() : int
      {
         return _startFrame;
      }
      
      public function get overridingAction() : String
      {
         return _overridingAction;
      }
      
      public function set overridingAction(param1:String) : void
      {
         _overridingAction = param1;
      }
      
      public function toString() : String
      {
         return "Action: " + var_683 + "  param: " + var_735;
      }
   }
}
