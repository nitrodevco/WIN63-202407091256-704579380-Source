package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
   
   public class BanListCtrl extends UserListCtrl
   {
       
      
      private var var_1881:int = -1;
      
      public function BanListCtrl(param1:IHabboTransitionalNavigator)
      {
         super(param1,false);
      }
      
      override protected function getRowView() : IWindowContainer
      {
         return IWindowContainer(_navigator.getXmlWindow("ros_banned_user"));
      }
      
      override protected function onBgMouseClick(param1:WindowEvent) : void
      {
         var_1881 = param1.target.parent.id;
         refreshColorsAfterClick(param1.target.findParentByName("moderation_banned_users") as IItemListWindow);
      }
      
      override protected function getBgColor(param1:int, param2:Boolean) : uint
      {
         if(param1 == var_1881)
         {
            return 4288329945;
         }
         return super.getBgColor(param1,param2);
      }
      
      private function refreshColorsAfterClick(param1:IItemListWindow) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowContainer = null;
         _loc3_ = 0;
         while(_loc3_ < var_554)
         {
            _loc2_ = IWindowContainer(param1.getListItemAt(_loc3_));
            _loc2_.color = this.getBgColor(_loc3_,false);
            _loc3_++;
         }
      }
      
      public function get selectedRow() : int
      {
         return var_1881;
      }
   }
}
