package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   
   public class WiredMenuDefaultTab implements class_3627
   {
       
      
      private var var_318:Boolean = false;
      
      private var var_319:WiredMenuController;
      
      private var _container:IWindowContainer;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2341:Boolean;
      
      private var var_2332:Boolean;
      
      private var var_2872:Boolean;
      
      public function WiredMenuDefaultTab(param1:WiredMenuController, param2:IWindowContainer)
      {
         super();
         var_319 = param1;
         _container = param2;
         _messageEvents = new Vector.<IMessageEvent>(0);
         var _loc3_:IUpdateReceiver = this as IUpdateReceiver;
         if(_loc3_ != null)
         {
            param1.context.registerUpdateReceiver(_loc3_,1);
         }
      }
      
      public function setTabActive() : void
      {
         var_2341 = true;
      }
      
      public function setTabInactive() : void
      {
         var_2341 = false;
      }
      
      public function startViewing() : void
      {
         var_2332 = true;
      }
      
      public function stopViewing() : void
      {
         var_2332 = false;
         if(var_2872)
         {
            var_319.view.loadingContainer.visible = false;
         }
      }
      
      protected function updateLoadingState() : void
      {
         var _loc1_:Boolean = isDataReady();
         if(var_2872 && _loc1_)
         {
            initializeInterface();
         }
         var_2872 = !_loc1_;
         var _loc2_:IWindowContainer = var_319.view.loadingContainer;
         if(var_2332 && _loc2_.visible != var_2872)
         {
            _loc2_.visible = var_2872;
            controller.view.window.caption = controller.localizationManager.getLocalization(var_2872 ? "wiredmenu.title.loading" : "wiredmenu.title");
         }
      }
      
      protected function isDataReady() : Boolean
      {
         return true;
      }
      
      protected function initializeInterface() : void
      {
      }
      
      public function get controller() : WiredMenuController
      {
         return var_319;
      }
      
      protected function get localization() : IHabboLocalizationManager
      {
         return var_319.localizationManager;
      }
      
      protected function loc(param1:String) : String
      {
         return localization.getLocalization(param1,"");
      }
      
      public function get container() : IWindowContainer
      {
         return _container;
      }
      
      public function get isActive() : Boolean
      {
         return var_2341;
      }
      
      public function get isViewing() : Boolean
      {
         return var_2332;
      }
      
      public function get isLoading() : Boolean
      {
         return var_2872;
      }
      
      protected function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(param1);
         var_319.addMessageEvent(param1);
      }
      
      private function removeMessageEvents() : void
      {
         for each(var _loc1_ in _messageEvents)
         {
            var_319.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function dispose() : void
      {
         if(var_318)
         {
            return;
         }
         removeMessageEvents();
         var _loc1_:IUpdateReceiver = this as IUpdateReceiver;
         if(_loc1_ != null)
         {
            controller.context.removeUpdateReceiver(_loc1_);
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function permissionsUpdated() : void
      {
      }
   }
}
