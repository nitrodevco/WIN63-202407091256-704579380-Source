package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1671;
   
   public class FeaturedItemsCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var var_2695:IItemListWindow;
      
      private var var_3462:IWindowContainer;
      
      public function FeaturedItemsCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _catalog = null;
            var_2695.dispose();
            var_2695 = null;
            var_3462.dispose();
            var_3462 = null;
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         var _loc2_:int = 0;
         if(!super.init())
         {
            return false;
         }
         var_2695 = window.findChildByName("itemlist_featured") as IItemListWindow;
         var_3462 = var_2695.getListItemByName("featured_item_template") as IWindowContainer;
         var_2695.removeListItems();
         if(_catalog.frontPageItems == null || _catalog.frontPageItems.length == 0)
         {
            return true;
         }
         var _loc1_:IWindowContainer = _window.findChildByName("firstitem") as IWindowContainer;
         populateItem(_catalog.frontPageItems[0],_loc1_);
         _loc2_ = 1;
         while(_loc2_ < Math.min(4,_catalog.frontPageItems.length))
         {
            var_2695.addListItem(createItemFromTemplate(_catalog.frontPageItems[_loc2_]));
            _loc2_++;
         }
         return true;
      }
      
      private function createItemFromTemplate(param1:class_1671) : IWindowContainer
      {
         return populateItem(param1,var_3462.clone() as IWindowContainer);
      }
      
      private function populateItem(param1:class_1671, param2:IWindowContainer) : IWindowContainer
      {
         var _loc3_:String = null;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc5_:ITextWindow;
         (_loc5_ = param2.findChildByName("item_title") as ITextWindow).text = param1.itemName;
         if(param1.itemPromoImage != null && param1.itemPromoImage != "")
         {
            _loc3_ = String(_catalog.context.configuration.getProperty("image.library.url"));
            (_loc4_ = param2.findChildByName("item_image") as IStaticBitmapWrapperWindow).assetUri = _loc3_ + param1.itemPromoImage;
         }
         var _loc6_:IWindow;
         if((_loc6_ = param2.getChildByName("event_catcher_region")) != null)
         {
            _loc6_.procedure = eventProc;
         }
         return param2;
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_1671 = null;
         if(param1.type == "WME_DOWN")
         {
            _loc4_ = (_loc4_ = var_2695.getListItemIndex(param2.parent)) < 0 ? 0 : _loc4_ + 1;
            _loc3_ = _catalog.frontPageItems[_loc4_];
            switch(_loc3_.type)
            {
               case 0:
                  if(_loc3_.cataloguePageLocation == "room_bundles_mobile")
                  {
                     return _catalog.openCatalogPage("room_bundles","NORMAL");
                  }
                  if(_loc3_.cataloguePageLocation == "mobile_subscriptions")
                  {
                     return _catalog.openCatalogPage("hc_membership","NORMAL");
                  }
                  _catalog.openCatalogPage(_loc3_.cataloguePageLocation,"NORMAL");
                  break;
               case 1:
                  _catalog.openCatalogPageByOfferId(_loc3_.productOfferID,"NORMAL");
            }
         }
      }
   }
}
