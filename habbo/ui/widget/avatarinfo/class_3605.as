package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.class_1736;
   
   public class class_3605
   {
       
      
      private var var_280:int = -1;
      
      private var var_871:int;
      
      private var var_3924:Boolean = false;
      
      private var var_3758:Boolean = false;
      
      private var var_3695:Boolean = false;
      
      private var var_3765:int = 0;
      
      private var _botSkills:Array;
      
      private var var_2591:Array;
      
      private var _name:String;
      
      public function class_3605()
      {
         var_2591 = new Array(0);
         super();
      }
      
      public function set id(param1:int) : void
      {
         var_280 = param1;
      }
      
      public function set roomIndex(param1:int) : void
      {
         var_871 = param1;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get roomIndex() : int
      {
         return var_871;
      }
      
      public function get isIgnored() : Boolean
      {
         return var_3924;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_3758;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_3695;
      }
      
      public function get carryItemType() : int
      {
         return var_3765;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_3924 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_3758 = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_3695 = param1;
      }
      
      public function set carryItemType(param1:int) : void
      {
         var_3765 = param1;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get botSkillsWithCommands() : Array
      {
         return var_2591;
      }
      
      public function set botSkillsWithCommands(param1:Array) : void
      {
         var_2591 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function populate(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         if(param1.webID != id)
         {
            var_2591 = new Array(0);
         }
         id = param1.webID;
         roomIndex = param1.userRoomId;
         amIOwner = param1.amIOwner;
         amIAnyRoomController = param1.amIAnyRoomController;
         carryItemType = param1.carryItem;
         botSkills = param1.botSkills;
         _name = param1.name;
      }
      
      public function cloneAndSetSkillsWithCommands(param1:Array) : void
      {
         _botSkills = [];
         for each(var _loc2_ in param1)
         {
            botSkills.push(_loc2_.id);
         }
         var_2591 = param1.concat();
      }
   }
}
