package com.sulake.habbo.navigator.domain
{
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;
   
   public class Tab
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_280:int;
      
      private var var_3418:int;
      
      private var _button:ITabButtonWindow;
      
      private var var_4729:ITabPageDecorator;
      
      private var _selected:Boolean;
      
      private var _searchMsg:int;
      
      public function Tab(param1:HabboNavigator, param2:int, param3:int, param4:ITabPageDecorator, param5:int = 1)
      {
         super();
         _navigator = param1;
         var_280 = param2;
         var_3418 = param3;
         var_4729 = param4;
         _searchMsg = param5;
      }
      
      public function sendSearchRequest() : void
      {
         var _loc1_:Boolean = Boolean(_navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator"));
         if(_loc1_ && id == 2)
         {
            var_3418 = 22;
         }
         _navigator.mainViewCtrl.startSearch(var_280,var_3418,"-1",_searchMsg);
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get defaultSearchType() : int
      {
         return var_3418;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get tabPageDecorator() : ITabPageDecorator
      {
         return var_4729;
      }
      
      public function get searchMsg() : int
      {
         return _searchMsg;
      }
      
      public function get button() : ITabButtonWindow
      {
         return _button;
      }
      
      public function set button(param1:ITabButtonWindow) : void
      {
         _button = param1;
      }
   }
}
