package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.outgoing.users.class_201;
   
   public class GuildInfoCtrl implements IDisposable
   {
      
      private static const GUILD_INFO_NAME:String = "guild_info";
       
      
      private var _navigator:IHabboTransitionalNavigator;
      
      private var _groupId:int;
      
      public function GuildInfoCtrl(param1:IHabboTransitionalNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function dispose() : void
      {
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function refresh(param1:IWindowContainer, param2:class_1675, param3:Boolean = false) : void
      {
         var _loc5_:IWindowContainer;
         if((_loc5_ = IWindowContainer(param1.findChildByName("guild_info"))) == null)
         {
            (_loc5_ = IWindowContainer(_navigator.getXmlWindow("guild_info"))).name = "guild_info";
            param1.addChild(_loc5_);
            _loc5_.addEventListener("WME_CLICK",onGuildInfo);
         }
         if(param2 == null || param2.habboGroupId < 1)
         {
            _loc5_.visible = false;
            return;
         }
         _loc5_.visible = true;
         _navigator.registerParameter("navigator.guildbase","groupName",param2.groupName);
         _loc5_.findChildByName("guild_base_txt").caption = _navigator.getText("navigator.guildbase");
         var _loc4_:IBadgeImageWidget;
         (_loc4_ = IWidgetWindow(param1.findChildByName("guild_badge")).widget as IBadgeImageWidget).badgeId = param2.groupBadgeCode;
         _loc4_.groupId = param2.habboGroupId;
         _groupId = param2.habboGroupId;
      }
      
      private function onGuildInfo(param1:WindowEvent) : void
      {
         _navigator.send(new class_201(_groupId,true));
      }
   }
}
