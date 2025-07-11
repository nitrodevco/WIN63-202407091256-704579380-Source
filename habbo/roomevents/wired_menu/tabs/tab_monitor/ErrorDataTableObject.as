package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.ITableObject;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.TableCell;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_1708;
   
   public class ErrorDataTableObject implements ITableObject
   {
       
      
      private var var_4404:WiredMenuMonitorTab;
      
      private var var_47:class_1708;
      
      private var _localization:IHabboLocalizationManager;
      
      public function ErrorDataTableObject(param1:WiredMenuMonitorTab, param2:class_1708, param3:IHabboLocalizationManager)
      {
         super();
         var_4404 = param1;
         var_47 = param2;
         _localization = param3;
      }
      
      private static function convertTimestamp(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc6_:int = _loc2_.fullYear;
         var _loc5_:int = _loc2_.month + 1;
         var _loc8_:int = _loc2_.date;
         var _loc3_:int = _loc2_.hours;
         var _loc7_:int = _loc2_.minutes;
         var _loc4_:int = _loc2_.seconds;
         return _loc6_ + "-" + addLeadingZero(_loc5_) + "-" + addLeadingZero(_loc8_) + " " + addLeadingZero(_loc3_) + ":" + addLeadingZero(_loc7_) + ":" + addLeadingZero(_loc4_);
      }
      
      private static function addLeadingZero(param1:int) : String
      {
         return param1 < 10 ? "0" + param1.toString() : param1.toString();
      }
      
      public function get data() : class_1708
      {
         return var_47;
      }
      
      public function get identifier() : String
      {
         return String(var_47.errorId);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:class_1708 = (param2 as ErrorDataTableObject).data;
         switch(param1)
         {
            case WiredMenuMonitorTab.var_4394:
               return var_47.throwCount != _loc3_.throwCount;
            case WiredMenuMonitorTab.LOG_COLUMN_LATEST:
               return var_47.msSinceLastOccurrence != _loc3_.msSinceLastOccurrence;
            default:
               return false;
         }
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         var _loc2_:class_1708 = (param1 as ErrorDataTableObject).data;
         return var_47.msSinceLastOccurrence != _loc2_.msSinceLastOccurrence || var_47.throwCount != _loc2_.throwCount;
      }
      
      public function onLinkClicked() : void
      {
         var_4404.onErrorLinkClicked(var_47);
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case WiredMenuMonitorTab.LOG_COLUMN_TYPE:
               return new TableCell(TableCell.var_4815,var_47.errorName,false,false,null,onLinkClicked);
            case WiredMenuMonitorTab.var_4883:
               return new TableCell(TableCell.var_2017,var_47.category);
            case WiredMenuMonitorTab.var_4394:
               return new TableCell(TableCell.var_2017,String(var_47.throwCount));
            case WiredMenuMonitorTab.LOG_COLUMN_LATEST:
               if(var_47.msSinceLastOccurrence < 0)
               {
                  return new TableCell(TableCell.var_2017,"/");
               }
               return new TableCell(TableCell.var_2017,FriendlyTime.getFriendlyTime(_localization,var_47.msSinceLastOccurrence / 1000,".ago",3),false,false,null,null,false,timestampString);
               break;
            default:
               return null;
         }
      }
      
      private function get timestampString() : String
      {
         var _loc1_:Number = new Date().time - var_47.msSinceLastOccurrence;
         _loc1_ -= _loc1_ % 1000;
         return convertTimestamp(_loc1_);
      }
   }
}
