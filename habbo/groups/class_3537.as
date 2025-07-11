package com.sulake.habbo.groups
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1183;
   
   public class class_3537
   {
      
      public static const TYPE_REGULAR:int = 0;
      
      public static const TYPE_EXCLUSIVE:int = 1;
      
      public static const const_155:int = 2;
      
      public static const TYPE_LARGE:int = 3;
      
      public static const const_31:int = 4;
      
      public static const RIGHTS_MEMBERS:int = 0;
      
      public static const const_1112:int = 1;
       
      
      private var var_47:GuildSettingsData;
      
      private var var_3166:ISelectorWindow;
      
      private var var_3772:IRadioButtonWindow;
      
      private var var_3964:IRadioButtonWindow;
      
      private var var_4179:IRadioButtonWindow;
      
      private var var_3923:class_3398;
      
      public function class_3537()
      {
         super();
      }
      
      public function prepare(param1:IWindowContainer) : void
      {
         var _loc2_:IWindowContainer = param1.findChildByName("step_cont_5") as IWindowContainer;
         var_3166 = _loc2_.findChildByName("group_type_selector") as ISelectorWindow;
         var_3772 = _loc2_.findChildByName("rb_type_regular") as IRadioButtonWindow;
         var_3772.procedure = onRegularGuildType;
         var_3964 = _loc2_.findChildByName("rb_type_exclusive") as IRadioButtonWindow;
         var_3964.procedure = onExclusiveGuildType;
         var_4179 = _loc2_.findChildByName("rb_type_private") as IRadioButtonWindow;
         var_4179.procedure = onPrivateGuildType;
         var_3923 = _loc2_.findChildByName("cb_member_rights") as class_3398;
         var_3923.procedure = onMembersHaveRights;
      }
      
      public function refresh(param1:class_1183) : void
      {
         var_47 = new GuildSettingsData(param1);
         switch(var_47.guildType)
         {
            case 0:
               var_3166.setSelected(var_3772);
               break;
            case 1:
               var_3166.setSelected(var_3964);
               break;
            case 2:
               var_3166.setSelected(var_4179);
               break;
            default:
               var_3166.setSelected(var_3772);
         }
         if(var_47.rightsLevel == 0)
         {
            var_3923.select();
         }
         else
         {
            var_3923.unselect();
         }
         var_3166.invalidate();
      }
      
      private function onRegularGuildType(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_47.guildType = 0;
         }
      }
      
      private function onExclusiveGuildType(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_47.guildType = 1;
         }
      }
      
      private function onPrivateGuildType(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_47.guildType = 2;
         }
      }
      
      private function onMembersHaveRights(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_47.rightsLevel = 0;
         }
         if(param1.type == "WE_UNSELECT")
         {
            var_47.rightsLevel = 1;
         }
      }
      
      public function resetModified() : void
      {
         if(var_47 != null && var_47.isModified)
         {
            var_47.resetModified();
         }
      }
      
      public function get guildType() : int
      {
         return var_47.guildType;
      }
      
      public function get rightsLevel() : int
      {
         return var_47.rightsLevel;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_47 != null;
      }
   }
}
