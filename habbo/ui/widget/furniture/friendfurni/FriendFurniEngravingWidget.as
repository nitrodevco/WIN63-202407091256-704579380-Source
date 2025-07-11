package com.sulake.habbo.ui.widget.furniture.friendfurni
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_3560;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class FriendFurniEngravingWidget extends RoomWidgetBase
   {
       
      
      private var _stuffId:int = -1;
      
      private var var_2297:FriendFurniEngravingView;
      
      public function FriendFurniEngravingWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
         engravingWidgetHandler.widget = this;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get engravingWidgetHandler() : class_3560
      {
         return var_1653 as class_3560;
      }
      
      public function open(param1:int, param2:int, param3:StringArrayStuffData) : void
      {
         close(_stuffId);
         _stuffId = param1;
         switch(param2)
         {
            case 0:
               var_2297 = new LoveLockEngravingView(this,param3);
               break;
            case 1:
            case 2:
               break;
            case 3:
               var_2297 = new WildWestEngravingView(this,param3);
               break;
            case 4:
               var_2297 = new HabboweenEngravingView(this,param3);
         }
         var_2297.open();
      }
      
      public function close(param1:int) : void
      {
         if(param1 == _stuffId && var_2297)
         {
            var_2297.dispose();
            var_2297 = null;
            _stuffId = -1;
         }
      }
   }
}
