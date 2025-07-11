package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
   import com.sulake.habbo.utils.class_3527;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.class_595;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1733;
   
   public class UserListCtrl implements IDisposable
   {
      
      private static const DISPLAY_LIMIT:int = 200;
       
      
      protected var _navigator:IHabboTransitionalNavigator;
      
      private var var_4171:Boolean;
      
      protected var var_554:int;
      
      public function UserListCtrl(param1:IHabboTransitionalNavigator, param2:Boolean)
      {
         super();
         _navigator = param1;
         var_4171 = param2;
      }
      
      public function dispose() : void
      {
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function refresh(param1:IItemListWindow, param2:Array, param3:String, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         var _loc8_:Array = [];
         for each(var _loc7_ in param2)
         {
            if(param3 == "" || _loc7_.userName.toLowerCase().indexOf(param3) > -1)
            {
               _loc8_.push(_loc7_);
            }
            if(_loc8_.length >= 200)
            {
               break;
            }
         }
         param1.autoArrangeItems = false;
         _loc6_ = 0;
         while(!(_loc5_ = refreshEntry(param1,_loc6_,_loc8_[_loc6_],param4)))
         {
            _loc6_++;
         }
         param1.autoArrangeItems = true;
         param1.invalidate();
         var_554 = _loc8_.length;
      }
      
      private function getListEntry(param1:int) : IWindowContainer
      {
         var _loc2_:IWindowContainer = getRowView();
         var _loc3_:IRegionWindow = IRegionWindow(_loc2_.findChildByName("bg_region"));
         _loc3_.addEventListener("WME_CLICK",onBgMouseClick);
         _loc3_.addEventListener("WME_OVER",onBgMouseOver);
         _loc3_.addEventListener("WME_OUT",onBgMouseOut);
         class_3527.setup(_loc2_,onUserInfoMouseClick);
         _loc2_.id = param1;
         return _loc2_;
      }
      
      protected function getRowView() : IWindowContainer
      {
         return IWindowContainer(_navigator.getXmlWindow(var_4171 ? "ros_friend" : "ros_flat_controller"));
      }
      
      protected function getBgColor(param1:int, param2:Boolean) : uint
      {
         return param2 ? 4290173439 : (param1 % 2 != 0 ? 4294967295 : 4293519841);
      }
      
      private function refreshEntry(param1:IItemListWindow, param2:int, param3:class_1733, param4:int) : Boolean
      {
         var _loc5_:IWindowContainer;
         if((_loc5_ = IWindowContainer(param1.getListItemAt(param2))) == null)
         {
            if(param3 == null)
            {
               return true;
            }
            _loc5_ = getListEntry(param2);
            param1.addListItem(_loc5_);
         }
         if(param3 != null)
         {
            _loc5_.color = this.getBgColor(param2,param3.userId == param4);
            refreshEntryDetails(_loc5_,param3);
            _loc5_.visible = true;
            _loc5_.height = 20;
         }
         else
         {
            _loc5_.height = 0;
            _loc5_.visible = false;
         }
         return false;
      }
      
      private function refreshEntryDetails(param1:IWindowContainer, param2:class_1733) : void
      {
         param1.findChildByName("user_name_txt").caption = param2.userName;
         var _loc3_:IRegionWindow = IRegionWindow(param1.findChildByName("bg_region"));
         _loc3_.id = param2.userId;
         param1.findChildByName("user_info_region").id = param2.userId;
         class_3527.setUserInfoState(false,param1);
      }
      
      protected function onBgMouseClick(param1:WindowEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:IWindowContainer = IWindowContainer(param1.target);
         if(var_4171)
         {
            _navigator.send(new class_595(_loc3_.id));
         }
         else
         {
            _loc2_ = [];
            _loc2_.push(_loc3_.id);
            _navigator.send(new RemoveRightsMessageComposer(_loc2_));
         }
      }
      
      private function onBgMouseOver(param1:WindowEvent) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(param1.target.parent);
         _loc3_.color = getBgColor(-1,true);
         var _loc2_:IWindow = _loc3_.findChildByName("arrow_icon");
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
      }
      
      private function onBgMouseOut(param1:WindowEvent) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(param1.target.parent);
         _loc3_.color = getBgColor(_loc3_.id,false);
         var _loc2_:IWindow = _loc3_.findChildByName("arrow_icon");
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
      }
      
      public function get userCount() : int
      {
         return var_554;
      }
      
      private function onUserInfoMouseClick(param1:WindowEvent) : void
      {
         _navigator.trackGoogle("extendedProfile","navigator_roomSettingsUsersList");
         _navigator.send(new class_322(param1.target.id));
      }
   }
}
