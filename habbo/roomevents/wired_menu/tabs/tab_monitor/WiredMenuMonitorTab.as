package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3404;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.ITableObject;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.TableColumn;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.TableView;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsData;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_1100;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_1708;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_905;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_286;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_437;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_777;
   
   public class WiredMenuMonitorTab extends WiredMenuDefaultTab implements IUpdateReceiver
   {
      
      private static var POLL_MONITOR_MS:uint = 500;
      
      private static var COLOR_RED:String = "ff5733";
      
      private static var COLOR_ORANGE:String = "BD7800";
      
      private static var COLOR_GREEN:String = "008000";
      
      private static var THRESHOLD_USAGE_1:Number = 0.3;
      
      private static var THRESHOLD_USAGE_2:Number = 0.7;
      
      private static var THRESHOLD_FURNI_1:Number = 0.6;
      
      private static var THRESHOLD_FURNI_2:Number = 0.85;
      
      public static var LOG_COLUMN_TYPE:String = "type";
      
      public static var var_4883:String = "category";
      
      public static var var_4394:String = "quantity";
      
      public static var LOG_COLUMN_LATEST:String = "latest";
       
      
      private var var_3885:TableView;
      
      private var var_4677:int = 0;
      
      private var var_2703:WiredErrorInfoView = null;
      
      private var var_399:Vector.<class_1708> = null;
      
      private var var_648:WiredRoomStatsData = null;
      
      public function WiredMenuMonitorTab(param1:WiredMenuController, param2:IWindowContainer)
      {
         super(param1,param2);
         createLogTable();
         addMessageEvent(new class_1100(onRoomStatsEvent));
         addMessageEvent(new class_905(onErrorLogsEvent));
         clearButton.addEventListener("WME_CLICK",onClearButtonClicked);
      }
      
      private static function colorize(param1:int, param2:int, param3:int, param4:Number, param5:Number) : String
      {
         var _loc6_:Number;
         if((_loc6_ = (param1 - param2) / (param3 - param2)) < param4)
         {
            return COLOR_GREEN;
         }
         if(_loc6_ < param5)
         {
            return COLOR_ORANGE;
         }
         return COLOR_RED;
      }
      
      private function createLogTable() : void
      {
         var_3885 = new TableView(controller,logTableContainer);
         var _loc1_:Array = [new TableColumn(LOG_COLUMN_TYPE,loc("wiredmenu.monitor.column.type"),0.33),new TableColumn(var_4883,loc("wiredmenu.monitor.column.category"),0.22),new TableColumn(var_4394,loc("wiredmenu.monitor.column.occurrences"),0.15),new TableColumn(LOG_COLUMN_LATEST,loc("wiredmenu.monitor.column.latest"),0.3)];
         var_3885.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         clearData();
         updateLoadingState();
         requestData();
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_399 != null && var_648 != null;
      }
      
      private function clearData() : void
      {
         var_399 = null;
         var_648 = null;
      }
      
      private function requestData() : void
      {
         var_4677 = getTimer();
         controller.send(new class_777());
         controller.send(new class_286());
      }
      
      private function onRoomStatsEvent(param1:class_1100) : void
      {
         var_648 = param1.getParser().roomStats;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            updateRoomStatsUI();
            updateImageUI();
         }
      }
      
      private function onErrorLogsEvent(param1:class_905) : void
      {
         var_399 = param1.getParser().errors;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            updateErrorLogsUI();
            updateClearButtonUI();
            updateImageUI();
         }
      }
      
      private function onClearButtonClicked(param1:WindowMouseEvent) : void
      {
         clearButton.disable();
         controller.send(new class_437());
      }
      
      override protected function initializeInterface() : void
      {
         updateRoomStatsUI();
         updateErrorLogsUI();
         updateClearButtonUI();
         updateImageUI();
      }
      
      private function updateRoomStatsUI() : void
      {
         statWiredUsageHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.usage","","color",usageStatColor,"amount",var_648.executionCost.toFixed(0),"limit",var_648.executionCostCap.toFixed(0));
         statHeavyHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.is_heavy","","color",var_648.isHeavy ? COLOR_ORANGE : COLOR_GREEN,"bool",var_648.isHeavy ? localization.getLocalization("wiredmenu.bool.yes") : String(localization.getLocalization("wiredmenu.bool.no")));
         statFloorCountHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.floorfurni","","color",floorItemStatColor,"amount",var_648.floorItemCount,"limit",var_648.floorItemCap);
         statWallCountHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.wallfurni","","color",wallItemStatColor,"amount",var_648.wallItemCount,"limit",var_648.wallItemCap);
      }
      
      private function get usageStatColor() : String
      {
         return colorize(var_648.executionCost,0,var_648.executionCostCap,THRESHOLD_USAGE_1,THRESHOLD_USAGE_2);
      }
      
      private function get floorItemStatColor() : String
      {
         return colorize(var_648.floorItemCount,0,var_648.floorItemCap,THRESHOLD_FURNI_1,THRESHOLD_FURNI_2);
      }
      
      private function get wallItemStatColor() : String
      {
         return colorize(var_648.wallItemCount,0,var_648.wallItemCap,THRESHOLD_FURNI_1,THRESHOLD_FURNI_2);
      }
      
      private function updateErrorLogsUI() : void
      {
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc2_ in var_399)
         {
            _loc1_.push(new ErrorDataTableObject(this,_loc2_,localization));
         }
         var_3885.setObjects(_loc1_);
      }
      
      private function updateImageUI() : void
      {
         var _loc1_:Boolean = isFrankPanicking;
         monitorImage1.visible = !_loc1_;
         monitorImage2.visible = _loc1_;
      }
      
      private function get isFrankPanicking() : Boolean
      {
         if(var_648.isHeavy)
         {
            return true;
         }
         if(usageStatColor != COLOR_GREEN || floorItemStatColor != COLOR_GREEN || wallItemStatColor != COLOR_GREEN)
         {
            return true;
         }
         return hasErrors;
      }
      
      internal function onErrorLinkClicked(param1:class_1708) : void
      {
         if(var_2703 == null)
         {
            var_2703 = new WiredErrorInfoView(controller);
         }
         var_2703.initialize(param1);
         var_2703.show();
      }
      
      private function updateClearButtonUI() : void
      {
         if(controller.hasWritePermission && hasErrors)
         {
            clearButton.enable();
         }
         else
         {
            clearButton.disable();
         }
      }
      
      private function get hasErrors() : Boolean
      {
         for each(var _loc1_ in var_399)
         {
            if(_loc1_.throwCount > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function permissionsUpdated() : void
      {
         updateClearButtonUI();
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var _loc2_:int = getTimer();
         if(var_4677 < _loc2_ - POLL_MONITOR_MS)
         {
            requestData();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_2703 != null)
         {
            var_2703.dispose();
            var_2703 = null;
         }
         var_3885.dispose();
         var_399 = null;
         var_648 = null;
         super.dispose();
      }
      
      private function get statWiredUsageHtml() : class_3404
      {
         return container.findChildByName("statistics_usage_html") as class_3404;
      }
      
      private function get statHeavyHtml() : class_3404
      {
         return container.findChildByName("statistics_heavy_html") as class_3404;
      }
      
      private function get statFloorCountHtml() : class_3404
      {
         return container.findChildByName("statistics_floorfurni_html") as class_3404;
      }
      
      private function get statWallCountHtml() : class_3404
      {
         return container.findChildByName("statistics_wallfurni_html") as class_3404;
      }
      
      private function get logTableContainer() : IWindowContainer
      {
         return container.findChildByName("log_table_container") as IWindowContainer;
      }
      
      private function get clearButton() : class_3357
      {
         return container.findChildByName("clear_log_btn") as class_3357;
      }
      
      private function get monitorImage1() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("monitor_image_1") as IStaticBitmapWrapperWindow;
      }
      
      private function get monitorImage2() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("monitor_image_2") as IStaticBitmapWrapperWindow;
      }
   }
}
