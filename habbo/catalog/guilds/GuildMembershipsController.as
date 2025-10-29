package com.sulake.habbo.catalog.guilds
{
    import assets.class_14

    import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.class_779;
   
   public class GuildMembershipsController
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var var_2259:GuildSelectorCatalogWidget;
      
      public function GuildMembershipsController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         _catalog = null;
         var_2259 = null;
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function registerGuildSelectorWidget(param1:GuildSelectorCatalogWidget) : void
      {
         var_2259 = param1;
         _catalog.connection.send(new class_779());
      }
      
      public function unregisterGuildSelectorWidget(param1:GuildSelectorCatalogWidget) : void
      {
         if(var_2259 == param1)
         {
            var_2259 = null;
         }
         else
         {
            class_14.log("ERROR: Tried to unregister a nonregistered group selector catalog widget");
         }
      }
      
      public function onGuildMembershipsMessageEvent(param1:GuildMembershipsMessageEvent) : void
      {
         var _loc2_:Array = param1.guilds.slice(0,param1.guilds.length);
         if(var_2259 && !var_2259.disposed)
         {
            var_2259.populateAndSelectFavorite(_loc2_);
            var_2259.selectFirstOffer();
         }
      }
      
      public function onGuildVisualSettingsChanged(param1:int) : void
      {
         if(var_2259 != null)
         {
            _catalog.connection.send(new class_779());
         }
      }
   }
}
