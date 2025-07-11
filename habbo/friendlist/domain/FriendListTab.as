package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.ITabView;
   
   public class FriendListTab
   {
       
      
      private var var_280:int;
      
      private var _name:String;
      
      private var _footerName:String;
      
      private var _headerPicName:String;
      
      private var var_4251:ITabView;
      
      private var var_3276:Boolean;
      
      private var _selected:Boolean;
      
      private var var_1631:IWindowContainer;
      
      public function FriendListTab(param1:HabboFriendList, param2:int, param3:ITabView, param4:String, param5:String, param6:String)
      {
         super();
         var_280 = param2;
         _name = param4;
         var_4251 = param3;
         _footerName = param5;
         _headerPicName = param6;
         var_4251.init(param1);
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(param1)
         {
            var_3276 = false;
         }
         _selected = param1;
      }
      
      public function setNewMessageArrived(param1:Boolean) : void
      {
         if(selected)
         {
            var_3276 = false;
         }
         else
         {
            var_3276 = param1;
         }
      }
      
      public function get newMessageArrived() : Boolean
      {
         return var_3276;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get footerName() : String
      {
         return _footerName;
      }
      
      public function get headerPicName() : String
      {
         return _headerPicName;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get tabView() : ITabView
      {
         return var_4251;
      }
      
      public function get view() : IWindowContainer
      {
         return var_1631;
      }
      
      public function set view(param1:IWindowContainer) : void
      {
         var_1631 = param1;
      }
   }
}
