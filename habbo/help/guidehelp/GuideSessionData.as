package com.sulake.habbo.help.guidehelp
{
   public class GuideSessionData
   {
      
      public static const ROLE_UNDECIDED:uint = 0;
      
      public static const ROLE_GUIDE:uint = 1;
      
      public static const ROLE_USER:uint = 2;
      
      public static const const_785:int = 0;
      
      public static const const_569:int = 1;
      
      public static const const_1073:int = 2;
       
      
      private var var_4015:uint = 0;
      
      private var var_2222:String = "";
      
      private var var_2579:uint = 0;
      
      private var var_4635:String = "";
      
      private var var_418:uint = 0;
      
      private var _userName:String = "";
      
      private var var_4606:String = "";
      
      private var var_3120:uint = 0;
      
      private var _guideName:String = "";
      
      private var var_1030:String = "";
      
      public function GuideSessionData()
      {
         super();
      }
      
      public function isActiveSession() : Boolean
      {
         return isActiveUserSession() || isActiveGuideSession();
      }
      
      public function isActiveUserSession() : Boolean
      {
         return var_4015 == 2 && (var_2222 == "user_create" || var_2222 == "user_pending" || var_2222 == "user_ongoing" || var_2222 == "user_feedback");
      }
      
      public function isActiveGuideSession() : Boolean
      {
         return var_4015 == 1 && (var_2222 == "guide_accept" || var_2222 == "guide_ongoing" || var_2222 == "guide_closed");
      }
      
      public function isOnGoingSession() : Boolean
      {
         return var_2222 == "guide_ongoing" || var_2222 == "user_ongoing";
      }
      
      public function set role(param1:uint) : void
      {
         var_4015 = param1;
      }
      
      public function get activeWindow() : String
      {
         return var_2222;
      }
      
      public function set activeWindow(param1:String) : void
      {
         var_2222 = param1;
      }
      
      public function get requestType() : uint
      {
         return var_2579;
      }
      
      public function set requestType(param1:uint) : void
      {
         var_2579 = param1;
      }
      
      public function get requestDescription() : String
      {
         return var_4635;
      }
      
      public function set requestDescription(param1:String) : void
      {
         var_4635 = param1;
      }
      
      public function get userId() : uint
      {
         return var_418;
      }
      
      public function set userId(param1:uint) : void
      {
         var_418 = param1;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get userFigure() : String
      {
         return var_4606;
      }
      
      public function set userFigure(param1:String) : void
      {
         var_4606 = param1;
      }
      
      public function get guideId() : uint
      {
         return var_3120;
      }
      
      public function set guideId(param1:uint) : void
      {
         var_3120 = param1;
      }
      
      public function get guideName() : String
      {
         return _guideName;
      }
      
      public function set guideName(param1:String) : void
      {
         _guideName = param1;
      }
      
      public function get guideFigure() : String
      {
         return var_1030;
      }
      
      public function set guideFigure(param1:String) : void
      {
         var_1030 = param1;
      }
   }
}
