package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   
   public class class_3862
   {
      
      public static const CAPTION:String = "caption";
      
      public static const TITLE:String = "title";
      
      public static const const_687:String = "subcaption";
      
      public static const BODYTEXT:String = "bodytext";
      
      public static const SPACING:String = "spacing";
      
      public static const CATALOGBUTTON:String = "catalogbutton";
      
      public static const PROMOTEDROOMBUTTON:String = "promotedroombutton";
      
      public static const LINK:String = "link";
      
      public static const const_1182:String = "gotoroombutton";
      
      public static const REQUESTBADGEBUTTON:String = "requestbadgebutton";
      
      public static const REQUESTBADGEBUTTONSECOND:String = "requestbadgebuttonsecond";
      
      public static const REQUESTBADGEBUTTONTHIRD:String = "requestbadgebuttonthird";
      
      public static const REQUESTBADGEBUTTONFOURTH:String = "requestbadgebuttonfourth";
      
      public static const REQUESTBADGEBUTTONFIFTH:String = "requestbadgebuttonfifth";
      
      public static const CREDITHABBLETBUTTON:String = "credithabbletbutton";
      
      public static const COMMUNITYGOALTIMER:String = "communitygoaltimer";
      
      public static const CUSTOMTIMER:String = "customtimer";
      
      public static const const_937:String = "gotohomeroombutton";
      
      public static const const_522:String = "gotocompetitionroombutton";
      
      public static const REWARDBADGE:String = "rewardbadge";
      
      public static const IMAGE:String = "image";
      
      public static const SUBMITCOMPETITIONROOM:String = "submitcompetitionroom";
      
      public static const CONCURRENTUSERSMETER:String = "concurrentusersmeter";
      
      public static const CONCURRENTUSERSINFO:String = "concurrentusersinfo";
      
      public static const DAILYQUEST:String = "dailyquest";
      
      public static const const_1032:String = "buyvipbutton";
      
      public static const COMMUNITYGOALSCORE:String = "communitygoalscore";
      
      public static const INTERNAL_LINK_BUTTON:String = "internallinkbutton";
       
      
      public function class_3862()
      {
         super();
      }
      
      public static function createHandler(param1:String) : IElementHandler
      {
         switch(param1)
         {
            case "caption":
            case "subcaption":
            case "bodytext":
               return new class_3877();
            case "title":
               return new TitleElementHandler();
            case "spacing":
               return new class_3882();
            case "catalogbutton":
               return new CatalogButtonElementHandler();
            case "promotedroombutton":
               return new class_3893();
            case "link":
               return new class_3885();
            case "gotoroombutton":
               return new class_3892();
            case "requestbadgebutton":
            case "requestbadgebuttonsecond":
            case "requestbadgebuttonthird":
            case "requestbadgebuttonfourth":
            case "requestbadgebuttonfifth":
               break;
            case "credithabbletbutton":
               return new class_3880();
            case "communitygoaltimer":
               return new class_3889();
            case "customtimer":
               return new class_3887();
            case "gotohomeroombutton":
               return new class_3881();
            case "gotocompetitionroombutton":
               return new class_3890();
            case "rewardbadge":
               return new class_3878();
            case "image":
               return new class_3896();
            case "submitcompetitionroom":
               return new class_3894();
            case "concurrentusersmeter":
               return new class_3897();
            case "concurrentusersinfo":
               return new ConcurrentUsersInfoElementHandler();
            case "dailyquest":
               return new class_3891();
            case "buyvipbutton":
               return new class_3895();
            case "communitygoalscore":
               return new class_3883();
            case "internallinkbutton":
               return new class_3884();
            default:
               return null;
         }
         return new class_3888();
      }
   }
}
