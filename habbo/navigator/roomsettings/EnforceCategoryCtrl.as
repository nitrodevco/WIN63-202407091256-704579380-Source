package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1735;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.UpdateRoomCategoryAndTradeSettingsComposer;
   
   public class EnforceCategoryCtrl
   {
       
      
      private var _navigator:IHabboTransitionalNavigator;
      
      private var _window:class_3514;
      
      private var var_1907:IModalDialog;
      
      private var var_3408:int = 0;
      
      private var var_4502:int = 0;
      
      private var var_3263:Array;
      
      public function EnforceCategoryCtrl(param1:IHabboTransitionalNavigator)
      {
         var_3263 = [];
         super();
         _navigator = param1;
      }
      
      public function show(param1:int) : void
      {
         close();
         var_1907 = _navigator.windowManager.buildModalDialogFromXML(_navigator.assets.getAssetByName("enforce_category_xml").content as XML);
         _window = var_1907.rootWindow as class_3514;
         _window.procedure = windowProcedure;
         _window.center();
         _window.findChildByName("header_button_close").visible = false;
         var _loc2_:class_3520 = _window.findChildByName("trade_mode") as class_3520;
         var _loc5_:Array;
         (_loc5_ = []).push("${navigator.roomsettings.trade_not_allowed}");
         _loc5_.push("${navigator.roomsettings.trade_not_with_Controller}");
         _loc5_.push("${navigator.roomsettings.trade_allowed}");
         _loc2_.populate(_loc5_);
         _loc2_.selection = 0;
         var _loc6_:class_3520 = _window.findChildByName("category") as class_3520;
         var_3263 = [];
         for each(var _loc7_ in _navigator.data.visibleCategories)
         {
            if(!_loc7_.automatic && (!_loc7_.staffOnly || _loc7_.staffOnly && _navigator.sessionData.hasSecurity(7)))
            {
               var_3263.push(_loc7_);
            }
         }
         var _loc3_:Array = [];
         for each(var _loc4_ in var_3263)
         {
            _loc3_.push(_loc4_.visibleName);
         }
         _loc6_.populate(_loc3_);
         _loc6_.selection = 0;
      }
      
      private function close() : void
      {
         if(var_1907 && _window)
         {
            var_1907.dispose();
            var_1907 = null;
            _window = null;
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            var _loc4_:* = param2.name;
            if("ok" === _loc4_)
            {
               _loc3_ = int(class_1735(var_3263[Math.max(0,var_3408)]).nodeId);
               _navigator.communication.connection.send(new UpdateRoomCategoryAndTradeSettingsComposer(_navigator.data.currentRoomId,_loc3_,var_4502));
               close();
            }
         }
         else if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "category":
                  var_3408 = class_3520(param2).selection;
                  break;
               case "trade_mode":
                  var_4502 = class_3520(param2).selection;
            }
         }
      }
   }
}
