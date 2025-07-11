package com.sulake.habbo.notifications.feed
{
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
   import com.sulake.habbo.notifications.feed.view.content.EntityFactory;
   import com.sulake.habbo.notifications.feed.view.content.class_3603;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class NotificationController
   {
       
      
      private var var_1660:HabboNotifications;
      
      private var var_2347:NotificationView;
      
      private var var_3237:FeedSettings;
      
      private var var_3069:EntityFactory;
      
      public function NotificationController(param1:HabboNotifications)
      {
         super();
         var_1660 = param1;
         var_3237 = new FeedSettings(this);
         var_2347 = new NotificationView(this,param1);
         var_3069 = new EntityFactory();
         var_1660.roomSessionManager.events.addEventListener("RSE_CREATED",roomSessionStateEventHandler);
         var_1660.roomSessionManager.events.addEventListener("RSE_STARTED",roomSessionStateEventHandler);
         var_1660.roomSessionManager.events.addEventListener("RSE_ENDED",roomSessionStateEventHandler);
      }
      
      public function dispose() : void
      {
         if(var_2347)
         {
            var_2347.dispose();
            var_2347 = null;
         }
         var_1660.roomSessionManager.events.removeEventListener("RSE_CREATED",roomSessionStateEventHandler);
         var_1660.roomSessionManager.events.removeEventListener("RSE_STARTED",roomSessionStateEventHandler);
         var_1660.roomSessionManager.events.removeEventListener("RSE_ENDED",roomSessionStateEventHandler);
         var_1660 = null;
         if(var_3237)
         {
            var_3237.dispose();
            var_3237 = null;
         }
         if(var_3069)
         {
            var_3069.dispose();
            var_3069 = null;
         }
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_CREATED":
            case "RSE_STARTED":
            case "RSE_ENDED":
               if(var_2347)
               {
                  var_2347.setGameMode(param1.session.isGameSession);
               }
         }
      }
      
      public function setFeedEnabled(param1:Boolean) : void
      {
         if(var_2347)
         {
            var_2347.setViewEnabled(param1);
         }
      }
      
      public function getSettings() : FeedSettings
      {
         return var_3237;
      }
      
      public function updateFeedCategoryFiltering() : void
      {
      }
      
      public function addFeedItem(param1:int, param2:GenericNotificationItemData) : void
      {
         var _loc3_:class_3603 = var_3069.createNotificationEntity(param2);
         var_2347.addNotificationFeedItem(param1,_loc3_);
      }
      
      public function executeAction(param1:String) : void
      {
         if(param1.indexOf("http") == 0)
         {
            HabboWebTools.openWebPage(param1);
         }
      }
   }
}
