package com.sulake.habbo.notifications.feed
{
   public class FeedSettings
   {
      
      public static const const_861:int = 0;
      
      public static const const_577:int = 1;
      
      public static const const_668:int = 2;
      
      public static const const_771:int = 3;
      
      public static const FEED_CATEGORY_ME:int = 0;
      
      public static const const_654:int = 1;
      
      public static const FEED_CATEGORY_HOTEL:int = 2;
       
      
      private var var_4789:NotificationController;
      
      private var var_2802:Vector.<int>;
      
      public function FeedSettings(param1:NotificationController)
      {
         super();
         var_2802 = new Vector.<int>();
         var_2802.push(1);
         var_2802.push(0);
         var_2802.push(2);
      }
      
      public function dispose() : void
      {
         var_4789 = null;
         var_2802 = null;
      }
      
      public function getVisibleFeedCategories() : Vector.<int>
      {
         return var_2802;
      }
      
      public function toggleVisibleFeedCategory(param1:int) : void
      {
         var_4789.updateFeedCategoryFiltering();
      }
   }
}
