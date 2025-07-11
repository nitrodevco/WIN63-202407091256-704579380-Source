package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.quest.HabboQuestEngine;
   
   public class RareTeaser implements IDisposable
   {
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IWindowContainer;
      
      private var var_3562:Array;
      
      private var var_4415:Array;
      
      private var var_2295:Array;
      
      public function RareTeaser(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function prepare(param1:class_3514) : void
      {
         var _loc2_:int = 0;
         var_3562 = parseInts("quests.seasonalcalendar.rareteaser.days");
         var_4415 = parseStrings("quests.seasonalcalendar.rareteaser.images");
         var_2295 = parseStrings("quests.seasonalcalendar.rareteaser.pages");
         _window = IWindowContainer(param1.findChildByName("rare_teaser_cont"));
         _loc2_ = 1;
         while(_loc2_ <= var_3562.length)
         {
            getFurniPic(_loc2_).assetUri = _questEngine.questController.seasonalCalendarWindow.getCalendarImageGalleryHost() + var_4415[_loc2_ - 1] + ".png";
            _loc2_++;
         }
         getClickRegion(1).procedure = onFirstSlot;
         getClickRegion(2).procedure = onSecondSlot;
         getClickRegion(3).procedure = onThirdSlot;
      }
      
      private function parseInts(param1:String) : Array
      {
         var _loc4_:String;
         var _loc3_:Array = (_loc4_ = String(_questEngine.localization.getLocalization(param1,""))).split(",");
         var _loc2_:Array = [];
         for each(var _loc5_ in _loc3_)
         {
            if(!isNaN(Number(_loc5_)))
            {
               _loc2_.push(int(_loc5_));
            }
         }
         return _loc2_;
      }
      
      private function parseStrings(param1:String) : Array
      {
         var _loc4_:String;
         var _loc3_:Array = (_loc4_ = String(_questEngine.localization.getLocalization(param1,""))).split(",");
         var _loc2_:Array = [];
         for each(var _loc5_ in _loc3_)
         {
            if(_loc5_ != "")
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      private function getFurniPic(param1:int) : IStaticBitmapWrapperWindow
      {
         return getRare(param1).findChildByName("furni_pic") as IStaticBitmapWrapperWindow;
      }
      
      private function getLockIcon(param1:int) : IWindow
      {
         return getRare(param1).findChildByName("locked_icon");
      }
      
      private function getLockedBg(param1:int) : IWindow
      {
         return getRare(param1).findChildByName("locked_bg");
      }
      
      private function getOpenBg(param1:int) : IWindow
      {
         return getRare(param1).findChildByName("open_bg");
      }
      
      private function getClickRegion(param1:int) : IWindow
      {
         return getRare(param1).findChildByName("click_region");
      }
      
      private function getRare(param1:int) : IWindowContainer
      {
         return IWindowContainer(_window.findChildByName("rare_cont_" + param1));
      }
      
      public function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = false;
         var _loc1_:int = _questEngine.questController.seasonalCalendarWindow.currentDay;
         var _loc2_:int = -1;
         _loc3_ = 1;
         while(_loc3_ <= var_3562.length)
         {
            _loc4_ = var_3562[_loc3_ - 1] > _loc1_;
            getFurniPic(_loc3_).visible = !_loc4_;
            getLockIcon(_loc3_).visible = _loc4_;
            getOpenBg(_loc3_).visible = !_loc4_;
            getLockedBg(_loc3_).visible = _loc4_;
            getClickRegion(_loc3_).visible = !_loc4_;
            if(_loc4_ && _loc2_ == -1)
            {
               _loc2_ = var_3562[_loc3_ - 1] - _loc1_;
            }
            _loc3_++;
         }
         _window.findChildByName("teaser_info").visible = _loc2_ != -1;
         _questEngine.localization.registerParameter("quests.seasonalcalendar.rareteaser.info","days","" + _loc2_);
      }
      
      private function onFirstSlot(param1:WindowEvent, param2:IWindow) : void
      {
         onSlot(param1,0);
      }
      
      private function onSecondSlot(param1:WindowEvent, param2:IWindow) : void
      {
         onSlot(param1,1);
      }
      
      private function onThirdSlot(param1:WindowEvent, param2:IWindow) : void
      {
         onSlot(param1,2);
      }
      
      private function onSlot(param1:WindowEvent, param2:int) : void
      {
         if(param1.type == "WME_CLICK" && var_2295[param2] != null)
         {
            _questEngine.catalog.openCatalogPage(var_2295[param2]);
         }
      }
   }
}
