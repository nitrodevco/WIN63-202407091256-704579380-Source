package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.communication.messages.incoming.users.class_1745;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembershipsMessageComposer;
   
   public class class_3754 extends DefaultConditionType
   {
      
      private static var REQUEST_TIMEOUT:int = 5;
       
      
      private var _cont:IWindowContainer;
      
      private var var_1660:HabboUserDefinedRoomEvents;
      
      private var var_354:Array;
      
      private var var_1895:int = -1;
      
      private var var_4716:Number = 0;
      
      public function class_3754()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.ACTOR_IS_GROUP_MEMBER;
      }
      
      override public function get negativeCode() : int
      {
         return class_3848.NOT_ACTOR_IS_GROUP_MEMBER;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:int = 0;
         var _loc2_:class_1745 = null;
         if(getGroupTypeRadio(1).isSelected)
         {
            _loc1_ = getGroupMenu().selection;
            if(_loc1_ == -1)
            {
               return "";
            }
            _loc2_ = var_354[getGroupMenu().selection];
            return _loc2_.groupId.toString();
         }
         return "";
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_1660 = param3;
         _cont = param1;
         getGroupTypeRadio(1).addEventListener("WE_SELECT",onSpecifyGroupSelect);
         getGroupTypeRadio(1).addEventListener("WE_UNSELECT",onSpecifyGroupUnselect);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var_1895 = param1.stringParam == "" ? -1 : int(param1.stringParam);
         initGuilds(var_354 == null ? [] : var_354);
         maybeGetGuildMemberships();
         if(param1.stringParam != "")
         {
            getGroupTypeSelector().setSelected(getGroupTypeRadio(1));
            getGroupMenu().visible = true;
         }
         else
         {
            getGroupTypeSelector().setSelected(getGroupTypeRadio(0));
            getGroupMenu().visible = false;
         }
      }
      
      private function maybeGetGuildMemberships() : void
      {
         var _loc1_:Number = new Date().time;
         if(_loc1_ > var_4716 + 1000 * REQUEST_TIMEOUT)
         {
            var_4716 = _loc1_;
            var_1660.send(new GetGuildMembershipsMessageComposer());
         }
      }
      
      private function initGuilds(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc2_:class_1745 = null;
         var _loc3_:* = -1;
         var_354 = param1;
         var _loc4_:Vector.<String> = new Vector.<String>();
         _loc5_ = 0;
         while(_loc5_ < var_354.length)
         {
            _loc2_ = var_354[_loc5_];
            _loc4_.push(_loc2_.groupName);
            if(_loc2_.groupId == var_1895)
            {
               _loc3_ = _loc5_;
            }
            _loc5_++;
         }
         getGroupMenu().populateWithVector(_loc4_);
         if(_loc3_ != -1)
         {
            getGroupMenu().selection = _loc3_;
         }
      }
      
      override public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         initGuilds(param1.guilds);
      }
      
      private function onSpecifyGroupSelect(param1:WindowEvent) : void
      {
         getGroupMenu().visible = true;
      }
      
      private function onSpecifyGroupUnselect(param1:WindowEvent) : void
      {
         getGroupMenu().visible = false;
      }
      
      private function getGroupMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_group"));
      }
      
      private function getGroupTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("grouptype_" + param1 + "_radio"));
      }
      
      private function getGroupTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("grouptype_selector"));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}
