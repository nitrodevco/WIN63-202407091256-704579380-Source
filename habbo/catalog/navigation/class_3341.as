package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1373;
   
   public interface class_3341
   {
       
      
      function dispose() : void;
      
      function get catalog() : IHabboCatalog;
      
      function buildCatalogIndex(param1:class_1373) : void;
      
      function showIndex() : void;
      
      function activateNode(param1:class_3411) : void;
      
      function loadFrontPage() : void;
      
      function get initialized() : Boolean;
      
      function getNodesByOfferId(param1:int, param2:Boolean = false) : Vector.<class_3411>;
      
      function getNodeByName(param1:String) : class_3411;
      
      function getOptionalNodeByName(param1:String) : class_3411;
      
      function getNodeById(param1:int, param2:class_3411 = null) : class_3411;
      
      function openPage(param1:String) : void;
      
      function openPageById(param1:int, param2:int) : void;
      
      function openPageByOfferId(param1:int) : void;
      
      function deactivateCurrentNode() : void;
      
      function filter(param1:String, param2:Array) : void;
      
      function get listTemplate() : IWindow;
      
      function getItemTemplate(param1:int) : IWindow;
      
      function get isDeepHierarchy() : Boolean;
   }
}
