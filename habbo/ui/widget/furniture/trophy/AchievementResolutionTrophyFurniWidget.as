package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAchievementResolutionTrophyDataUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class AchievementResolutionTrophyFurniWidget extends RoomWidgetBase implements ITrophyFurniWidget
   {
       
      
      private var _name:String;
      
      private var var_161:String;
      
      private var var_368:String;
      
      private var _color:int;
      
      private var var_209:ICoreConfiguration;
      
      private var var_1631:ITrophyView;
      
      private var var_4070:int;
      
      public function AchievementResolutionTrophyFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:ICoreConfiguration)
      {
         super(param1,param2,param3,param4);
         var_209 = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get date() : String
      {
         return var_161;
      }
      
      public function get message() : String
      {
         return var_368;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function get configuration() : ICoreConfiguration
      {
         return var_209;
      }
      
      override public function dispose() : void
      {
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         var_209 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWARTDUE_TROPHY_DATA",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWARTDUE_TROPHY_DATA",onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetAchievementResolutionTrophyDataUpdateEvent) : void
      {
         _name = param1.name;
         var_161 = param1.date;
         var_368 = param1.message;
         _color = param1.color - 1;
         var_4070 = param1.viewType;
         if(_color < 0 || _color > 2)
         {
            _color = 0;
         }
         updateInterface();
      }
      
      private function updateInterface() : void
      {
         if(var_1631 != null)
         {
            var_1631.dispose();
         }
         var _loc1_:int = var_4070;
         var_1631 = new TrophyView(this);
         var_1631.showInterface();
      }
   }
}
