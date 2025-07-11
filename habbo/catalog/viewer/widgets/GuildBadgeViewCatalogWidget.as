package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class GuildBadgeViewCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var var_2581:GuildMembershipsController;
      
      public function GuildBadgeViewCatalogWidget(param1:IWindowContainer, param2:GuildMembershipsController)
      {
         super(param1);
         var_2581 = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_2581 = null;
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("guildBadgeViewWidget");
         events.addEventListener("GUILD_SELECTED",onGuildSelected);
         return true;
      }
      
      private function onGuildSelected(param1:CatalogWidgetGuildSelectedEvent) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc2_:IBadgeImageWidget = IWidgetWindow(_window.findChildByName("badge")).widget as IBadgeImageWidget;
         if(_loc2_ != null)
         {
            _loc2_.badgeId = param1.badgeCode;
            _loc2_.groupId = param1.guildId;
         }
      }
   }
}
