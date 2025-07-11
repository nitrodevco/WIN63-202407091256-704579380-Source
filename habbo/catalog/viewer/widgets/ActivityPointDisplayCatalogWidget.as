package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
   import com.sulake.habbo.catalog.purse.class_3473;
   
   public class ActivityPointDisplayCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      public function ActivityPointDisplayCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:HabboCatalog = HabboCatalog(page.viewer.catalog);
         _loc1_.events.removeEventListener("catalog_purse_update",onPurseUpdate);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("activityPointDisplayWidget");
         _window.findChildByName("activity_points_txt").caption = "";
         var _loc1_:HabboCatalog = HabboCatalog(page.viewer.catalog);
         _loc1_.events.addEventListener("catalog_purse_update",onPurseUpdate);
         return updateAmount();
      }
      
      private function updateAmount() : Boolean
      {
         if(disposed)
         {
            return false;
         }
         if(_window == null)
         {
            return false;
         }
         var _loc3_:int = getActivityPointType();
         if(_loc3_ < 1 || !class_3473.isVisible(_loc3_))
         {
            _window.visible = false;
            return false;
         }
         var _loc1_:HabboCatalog = HabboCatalog(page.viewer.catalog);
         var _loc2_:String = "catalog.purchase.youractivitypoints";
         _loc1_.localization.registerParameter(_loc2_,"activitypoints","" + _loc1_.getPurse().getActivityPointsForType(_loc3_));
         _loc1_.localization.registerParameter(_loc2_,"currencyname",_loc1_.getActivityPointName(_loc3_));
         _window.findChildByName("activity_points_txt").caption = _loc1_.localization.getLocalization(_loc2_);
         var _loc4_:IWindow;
         (_loc4_ = _window.findChildByName("activity_point_icon")).style = class_3473.getIconStyleFor(_loc3_,_loc1_,true);
         _window.visible = true;
         return true;
      }
      
      private function onPurseUpdate(param1:PurseUpdateEvent) : void
      {
         updateAmount();
      }
      
      private function getActivityPointType() : int
      {
         if(page == null || page.offers == null)
         {
            return 0;
         }
         for each(var _loc1_ in page.offers)
         {
            if(_loc1_.activityPointType > 0)
            {
               return _loc1_.activityPointType;
            }
         }
         return 0;
      }
   }
}
