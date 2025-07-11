package com.sulake.habbo.navigator.view
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import flash.utils.getTimer;
   
   public class LiftView implements IUpdateReceiver
   {
      
      private static const AUTO_CYCLE_TIMEOUT_MS:uint = 8000;
       
      
      private var _navigator:HabboNewNavigator;
      
      private var var_3510:class_3437;
      
      private var var_3401:IItemListWindow;
      
      private var var_4303:IRegionWindow;
      
      private var var_1840:int = -1;
      
      private var var_2990:uint;
      
      public function LiftView(param1:HabboNewNavigator)
      {
         var_2990 = getTimer();
         super();
         _navigator = param1;
         _navigator.registerUpdateReceiver(this,1000);
      }
      
      public function dispose() : void
      {
         _navigator.removeUpdateReceiver(this);
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function set pagerIconTemplate(param1:IRegionWindow) : void
      {
         var_4303 = param1;
      }
      
      public function set borderWindow(param1:class_3437) : void
      {
         var_3510 = param1;
         var_3401 = IItemListWindow(var_3510.findChildByName("pager_itemlist"));
         IRegionWindow(var_3510.findChildByName("room_image_click_region")).procedure = goToRoomRegionProcedure;
      }
      
      public function refresh(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var_3401.destroyListItems();
         var_1840 = param1 ? 0 : var_1840;
         _loc2_ = 0;
         while(_loc2_ < _navigator.liftDataContainer.liftedRooms.length)
         {
            var_3401.addListItem(var_4303.clone());
            _loc2_++;
         }
         setPagerToSelectedPage();
         drawSelectedPage();
      }
      
      private function setPagerToSelectedPage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IRegionWindow = null;
         _loc1_ = 0;
         while(_loc1_ < var_3401.numListItems)
         {
            _loc2_ = IRegionWindow(var_3401.getListItemAt(_loc1_));
            IStaticBitmapWrapperWindow(_loc2_.findChildByName("icon")).assetUri = _loc1_ == var_1840 ? "progress_disk_flat_on" : "progress_disk_flat_off";
            _loc2_.id = _loc1_;
            _loc2_.procedure = pagerPageProcedure;
            _loc1_++;
         }
      }
      
      private function drawSelectedPage() : void
      {
         setPagerToSelectedPage();
         IStaticBitmapWrapperWindow(var_3510.findChildByName("room_image")).assetUri = _navigator.liftDataContainer.getUrlForLiftImageAtIndex(var_1840);
         if(var_1840 < _navigator.liftDataContainer.liftedRooms.length)
         {
            var_3510.findChildByName("caption_text").caption = _navigator.liftDataContainer.liftedRooms[var_1840].caption;
         }
      }
      
      private function autoCycleToNextPage() : void
      {
         var_1840++;
         if(var_1840 > _navigator.liftDataContainer.liftedRooms.length - 1)
         {
            var_1840 = 0;
         }
         refresh(false);
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(var_2990 + 8000 < _loc2_)
         {
            autoCycleToNextPage();
            var_2990 = _loc2_;
         }
      }
      
      private function pagerPageProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(param2.id != var_1840)
            {
               var_1840 = param2.id;
               drawSelectedPage();
               var_2990 = getTimer();
               _navigator.trackEventLog("browse.promotion","Promotion","",var_1840);
            }
         }
      }
      
      private function goToRoomRegionProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(_navigator.liftDataContainer.liftedRooms.length > var_1840)
            {
               _navigator.goToRoom(_navigator.liftDataContainer.liftedRooms[var_1840].flatId,"promotion");
            }
         }
      }
   }
}
