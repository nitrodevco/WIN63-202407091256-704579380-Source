package com.sulake.habbo.catalog.viewer
{
    import assets.class_14

    import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.class_3365;
   import flash.events.Event;
   
   public class CatalogViewer implements class_3477
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var _container:IWindowContainer;
      
      private var var_1768:class_3455;
      
      private var _forceRefresh:Boolean;
      
      private var var_4234:int;
      
      public function CatalogViewer(param1:HabboCatalog, param2:IWindowContainer)
      {
         super();
         _catalog = param1;
         _container = param2;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _catalog.roomEngine;
      }
      
      public function dispose() : void
      {
         if(var_1768)
         {
            var_1768.dispose();
            var_1768 = null;
         }
         _catalog = null;
         _container = null;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function showCatalogPage(param1:int, param2:String, param3:class_3440, param4:Vector.<class_3377>, param5:int, param6:Boolean) : void
      {
         class_14.log("[Catalog Viewer] Show Catalog Page: " + [param1,param2,param4.length,param5]);
         if(var_1768 != null)
         {
            if(!_forceRefresh && var_1768.pageId == param1)
            {
               if(param5 > -1)
               {
                  var_1768.selectOffer(param5);
               }
               return;
            }
            disposeCurrentPage();
         }
         var _loc7_:class_3455;
         var_1768 = _loc7_ = new CatalogPage(this,param1,param2,param3,param4,_catalog,param6);
         var_4234 = param1 > -12345678 ? param1 : var_4234;
         if(_loc7_.window != null)
         {
            _container.addChild(_loc7_.window);
            _loc7_.window.height = _container.height;
            _container.width = _loc7_.window.width;
            _container.x = _container.parent.width - _container.width - 8;
            if(_container.x < 130)
            {
               _catalog.setLeftPaneVisibility(false);
            }
            else
            {
               _catalog.setLeftPaneVisibility(true);
            }
         }
         else
         {
            class_14.log("[CatalogViewer] No window for page: " + param2);
         }
         _container.visible = true;
         _forceRefresh = false;
         _loc7_.selectOffer(param5);
      }
      
      public function disposeCurrentPage() : void
      {
         if(var_1768 != null)
         {
            _container.removeChild(var_1768.window);
            var_1768.dispose();
            _container.invalidate();
         }
      }
      
      public function catalogWindowClosed() : void
      {
         if(var_1768 != null)
         {
            var_1768.closed();
         }
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         return var_1768.dispatchWidgetEvent(param1);
      }
      
      public function getCurrentLayoutCode() : String
      {
         if(var_1768 == null)
         {
            return "";
         }
         return var_1768.layoutCode;
      }
      
      public function get currentPage() : class_3455
      {
         return var_1768;
      }
      
      public function showSearchResults(param1:Vector.<class_3365>) : void
      {
         var _loc3_:class_3377 = null;
         if(var_1768 != null)
         {
            _container.removeChild(var_1768.window);
            var_1768.dispose();
         }
         var _loc2_:Vector.<class_3377> = new Vector.<class_3377>(0);
         for each(var _loc5_ in param1)
         {
            _loc3_ = new FurnitureOffer(_loc5_,_catalog);
            _loc2_.push(_loc3_);
         }
         var _loc4_:class_3455;
         var_1768 = _loc4_ = new CatalogPage(this,-1,"default_3x3",new PageLocalization(["catalog_header_roombuilder","credits_v3_teaser"],["${catalog.search.results}"]),_loc2_,_catalog,false,1);
         if(_loc4_.window != null)
         {
            _container.addChild(_loc4_.window);
            _loc4_.window.width = _container.width;
            _loc4_.window.height = _container.height;
         }
         else
         {
            class_14.log("[CatalogViewer] No window for page: <SEARCH>");
         }
         _container.visible = true;
      }
      
      public function get viewerTags() : Array
      {
         return !!_container ? _container.tags : [];
      }
      
      public function setForceRefresh() : void
      {
         _forceRefresh = true;
      }
      
      public function get previousPageId() : int
      {
         return var_4234;
      }
   }
}
