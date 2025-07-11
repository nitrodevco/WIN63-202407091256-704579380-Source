package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   
   public class InfoStandRentableBotData
   {
       
      
      private var var_418:int = 0;
      
      private var _name:String = "";
      
      private var var_121:Array;
      
      private var var_4423:int = 0;
      
      private var var_4464:int = 0;
      
      private var var_3758:Boolean;
      
      private var var_3695:Boolean;
      
      private var _botSkills:Array;
      
      public function InfoStandRentableBotData()
      {
         var_121 = [];
         super();
      }
      
      public function set userId(param1:int) : void
      {
         var_418 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         var_121 = param1;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_4423 = param1;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_4464 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_3758 = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_3695 = param1;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get badges() : Array
      {
         return var_121.slice();
      }
      
      public function get carryItem() : int
      {
         return var_4423;
      }
      
      public function get userRoomId() : int
      {
         return var_4464;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_3758;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_3695;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function setData(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         userId = param1.webID;
         name = param1.name;
         badges = param1.badges;
         carryItem = param1.carryItem;
         userRoomId = param1.userRoomId;
         amIOwner = param1.amIOwner;
         amIAnyRoomController = param1.amIAnyRoomController;
         botSkills = param1.botSkills;
      }
   }
}
