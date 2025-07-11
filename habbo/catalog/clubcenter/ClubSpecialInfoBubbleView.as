package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3592;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1739;
   
   public class ClubSpecialInfoBubbleView
   {
      
      private static const MARGIN:int = 8;
       
      
      private var var_47:class_1739;
      
      private var var_319:HabboClubCenter;
      
      private var _window:IWindowContainer;
      
      private var var_2857:Timer;
      
      public function ClubSpecialInfoBubbleView(param1:HabboClubCenter, param2:IHabboWindowManager, param3:class_1739, param4:IWindow)
      {
         super();
         var_47 = param3;
         var_319 = param1;
         _window = param2.buildFromXML(XML(var_319.assets.getAssetByName("club_center_special_info_xml").content)) as IWindowContainer;
         if(!_window)
         {
            return;
         }
         _window.procedure = onInput;
         positionWindow(param4);
         setElementText("info_creditsspent",getLocalization("hccenter.breakdown.creditsspent").replace("%credits%",var_47.totalCreditsSpent));
         var _loc6_:int = var_47.kickbackPercentage * 100;
         setElementText("info_factor",getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%",_loc6_).replace("%multiplier%",var_47.kickbackPercentage));
         _loc6_ = var_47.kickbackPercentage * 100;
         var _loc5_:String;
         if((_loc5_ = String(var_319.localization.getLocalization("hccenter.breakdown.paydayfactor.percent"))) && _loc5_.length > 0)
         {
            _loc5_ = _loc5_.replace("%percent%",_loc6_).replace("%multiplier%",var_47.kickbackPercentage);
         }
         else
         {
            _loc5_ = getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%",var_47.kickbackPercentage);
         }
         setElementText("info_factor",_loc5_);
         setElementText("info_streakbonus",getLocalization("hccenter.breakdown.streakbonus").replace("%credits%",var_47.creditRewardForStreakBonus));
         var _loc8_:Number = int((var_47.kickbackPercentage * var_47.totalCreditsSpent + var_47.creditRewardForStreakBonus) * 100) / 100;
         var _loc7_:int = (var_47.creditRewardForMonthlySpent + var_47.creditRewardForStreakBonus) * 100 / 100;
         setElementText("info_total",getLocalization("hccenter.breakdown.total").replace("%credits%",_loc7_).replace("%actual%",_loc8_));
         _window.activate();
         var_2857 = new Timer(80,1);
         var_2857.addEventListener("timer",onTimerEvent);
         var_2857.start();
         if(var_319.stage)
         {
            var_319.stage.addEventListener("click",onStageClick);
         }
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         var_2857.stop();
         var_2857.removeEventListener("timer",onTimerEvent);
         var_2857 = null;
         _window.activate();
      }
      
      public function dispose() : void
      {
         if(var_319 && var_319.stage)
         {
            var_319.stage.removeEventListener("click",onStageClick);
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_319 = null;
      }
      
      private function onInput(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_DOWN" || !var_319)
         {
            return;
         }
         param1.stopImmediatePropagation();
         var _loc3_:* = param2.name;
         if("special_infolink" === _loc3_)
         {
            var_319.openPaydayHelpPage();
         }
         var_319.removeBreakdown();
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         if(var_319)
         {
            var_319.removeBreakdown();
         }
      }
      
      private function positionWindow(param1:IWindow) : void
      {
         if(!param1 || !_window || !var_319 || !var_319.stage)
         {
            return;
         }
         var _loc2_:Point = new Point();
         param1.getGlobalPosition(_loc2_);
         if(var_319.stage.stageWidth < _loc2_.x + param1.width + _window.width + 8 && _loc2_.x > _window.width + 8)
         {
            (_window as class_3592).direction = "right";
            _loc2_.x -= _window.width + 8;
         }
         else
         {
            _loc2_.x += param1.width + 8;
         }
         _loc2_.y += param1.height * 0.5 - _window.height * 0.5;
         _window.position = _loc2_;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:ITextWindow = _window.findChildByName(param1) as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = param2;
         }
      }
      
      private function getLocalization(param1:String) : String
      {
         if(!var_319 || !var_319.localization)
         {
            return "";
         }
         return var_319.localization.getLocalization(param1,param1);
      }
   }
}
