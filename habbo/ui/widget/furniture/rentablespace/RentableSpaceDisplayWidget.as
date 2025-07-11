package com.sulake.habbo.ui.widget.furniture.rentablespace
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_3559;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.object.IRoomObject;
   import flash.utils.Dictionary;
   
   public class RentableSpaceDisplayWidget extends RoomWidgetBase
   {
      
      private static var var_2008:Dictionary = new Dictionary();
      
      {
         var_2008[100] = "${rentablespace.widget.error_reason_already_rented}";
         var_2008[101] = "${rentablespace.widget.error_reason_not_rented}";
         var_2008[102] = "${rentablespace.widget.error_reason_not_rented_by_you}";
         var_2008[103] = "${rentablespace.widget.error_reason_can_rent_only_one_space}";
         var_2008[200] = "${rentablespace.widget.error_reason_not_enough_credits}";
         var_2008[201] = "${rentablespace.widget.error_reason_not_enough_duckets}";
         var_2008[202] = "${rentablespace.widget.error_reason_no_permission}";
         var_2008[203] = "${rentablespace.widget.error_reason_no_habboclub}";
         var_2008[300] = "${rentablespace.widget.error_reason_disabled}";
         var_2008[400] = "${rentablespace.widget.error_reason_generic}";
      }
      
      private var _window:IWindowContainer;
      
      private var _roomObject:IRoomObject;
      
      public function RentableSpaceDisplayWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
         ownHandler.widget = this;
      }
      
      private function get ownHandler() : class_3559
      {
         return var_1653 as class_3559;
      }
      
      public function hide(param1:IRoomObject) : void
      {
         if(_roomObject != param1)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _roomObject = null;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide(_roomObject);
         super.dispose();
      }
      
      override public function get mainWindow() : IWindow
      {
         return _window;
      }
      
      public function show(param1:IRoomObject) : void
      {
         _roomObject = param1;
         updateWidgetState();
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = windowManager.buildFromXML(XML(assets.getAssetByName("rentablespace_xml").content)) as IWindowContainer;
         _window.procedure = windowProcedure;
         _window.center();
         _window.findChildByName("rent_button").disable();
         _window.findChildByName("rented_view").visible = false;
         _window.findChildByName("error_view").visible = false;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = param1.type;
         if("WME_CLICK" === _loc3_)
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "error_button_close":
                  hide(_roomObject);
                  break;
               case "rent_button":
                  ownHandler.rentSpace(_roomObject.getId());
                  break;
               case "cancel_rent_button":
                  ownHandler.cancelRent(_roomObject.getId());
            }
         }
      }
      
      public function updateWidgetState() : void
      {
         if(_roomObject == null)
         {
            return;
         }
         ownHandler.getRentableSpaceStatus(_roomObject.getId());
      }
      
      public function populateRentInfo(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:String, param6:int, param7:int) : void
      {
         var _loc8_:* = false;
         if(_roomObject == null)
         {
            return;
         }
         createWindow();
         if(param1)
         {
            _window.findChildByName("rent_view").visible = false;
            _window.findChildByName("error_view").visible = false;
            _window.findChildByName("rented_view").visible = true;
            _window.findChildByName("renter_name").caption = param5;
            _window.findChildByName("time_remaining_label").caption = FriendlyTime.getFriendlyTime(ownHandler.container.localization,param6);
            _window.findChildByName("cancel_rent_button").visible = ownHandler.container.isOwnerOfFurniture(_roomObject) || ownHandler.container.sessionDataManager.hasSecurity(5);
            IItemListWindow(_window.findChildByName("rented_view")).arrangeListItems();
         }
         else
         {
            _window.findChildByName("rented_view").visible = false;
            _window.findChildByName("error_view").visible = false;
            _window.findChildByName("rent_view").visible = true;
            _window.findChildByName("price_label").caption = param7.toString() + " x";
            _loc8_ = param7 <= ownHandler.getUsersCreditAmount();
            if(!param2)
            {
               _window.findChildByName("cant_rent_error").caption = var_2008[param3];
            }
            else if(!_loc8_)
            {
               _window.findChildByName("cant_rent_error").caption = var_2008[200];
            }
            else
            {
               _window.findChildByName("cant_rent_error").visible = false;
               _window.findChildByName("rent_button").enable();
            }
            IItemListWindow(_window.findChildByName("rent_view")).arrangeListItems();
         }
         if(!_window.visible)
         {
            _window.visible = true;
         }
      }
      
      public function showErrorView(param1:int) : void
      {
         _window.findChildByName("rent_view").visible = false;
         _window.findChildByName("rented_view").visible = false;
         _window.findChildByName("error_view").visible = true;
         _window.findChildByName("error_message").caption = var_2008[param1];
      }
   }
}
