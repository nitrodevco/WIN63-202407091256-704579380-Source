package com.sulake.habbo.navigator.view.search.results
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class CategoryElementFactory
   {
      
      private static const MARGIN_LAYOUT_CATEGORY_CONTAINER:int = 13;
       
      
      private var _navigator:HabboNewNavigator;
      
      private var var_1929:BlockResultsView;
      
      private var var_2655:RoomEntryElementFactory;
      
      private var var_4324:IWindowContainer;
      
      private var var_4283:IWindowContainer;
      
      private var var_4703:IWindowContainer;
      
      public function CategoryElementFactory(param1:HabboNewNavigator, param2:RoomEntryElementFactory)
      {
         super();
         _navigator = param1;
         var_2655 = param2;
      }
      
      public function set blockResultsView(param1:BlockResultsView) : void
      {
         var_1929 = param1;
      }
      
      public function set categoryTemplate(param1:IWindowContainer) : void
      {
         var_4324 = param1;
      }
      
      public function set collapsedCategoryTemplate(param1:IWindowContainer) : void
      {
         var_4283 = param1;
      }
      
      public function set noResultsTemplate(param1:IWindowContainer) : void
      {
         var_4703 = param1;
      }
      
      public function getOpenCategoryElement(param1:Vector.<class_1675>, param2:String, param3:int = -1, param4:int = 0, param5:int = -1) : IWindowContainer
      {
         var headerControls:IItemListWindow;
         var roomList:IItemListWindow;
         var colorMod:uint;
         var color:int;
         var colorModAccumulator:int;
         var currentTileContainer:IItemListWindow;
         var guestRoom:class_1675;
         var alternatingColor:int;
         var guestRooms:Vector.<class_1675> = param1;
         var title:String = param2;
         var showMoreId:int = param3;
         var actionAllowed:int = param4;
         var resultMode:int = param5;
         var container:IWindowContainer = IWindowContainer(var_4324.clone());
         container.width = var_1929.itemListWidth - 13;
         container.height = 16 + var_2655.rowEntryTemplateHeight * (guestRooms.length + 1);
         container.findChildByName("category_name").caption = title;
         container.findChildByName("category_back").addEventListener("WME_CLICK",var_1929.onCategoryBackClicked);
         container.findChildByName("category_back").visible = actionAllowed == 2;
         container.findChildByName("category_collapse").visible = actionAllowed != 2;
         container.findChildByName("category_collapse").id = showMoreId;
         container.findChildByName("category_collapse").addEventListener("WME_CLICK",var_1929.onCategoryCollapseClicked);
         container.findChildByName("category_name_region").id = showMoreId;
         container.findChildByName("category_name_region").addEventListener("WME_CLICK",var_1929.onCategoryCollapseClicked);
         container.findChildByName("category_show_more").id = showMoreId;
         container.findChildByName("category_show_more").addEventListener("WME_CLICK",var_1929.onCategoryShowMoreClicked);
         container.findChildByName("category_show_more").visible = actionAllowed == 1;
         container.findChildByName("category_add_quick_link").id = showMoreId;
         container.findChildByName("category_add_quick_link").addEventListener("WME_CLICK",var_1929.onCategoryAddQuickLinkClicked);
         container.findChildByName("category_content_background").background = true;
         container.findChildByName("category_content_background").height = 12 + var_2655.rowEntryTemplateHeight * (guestRooms.length + 1);
         container.findChildByName("category_add_quick_link").visible = _navigator.currentResults.searchCodeOriginal.indexOf("official_view") == -1;
         headerControls = IItemListWindow(container.findChildByName("category_controls_itemlist"));
         if(_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA"))
         {
            headerControls.getListItemByName("category_toggle_tiles").addEventListener("WME_CLICK",var_1929.onCategoryToggleModeClicked);
            headerControls.getListItemByName("category_toggle_tiles").id = showMoreId;
            headerControls.getListItemByName("category_toggle_tiles").visible = resultMode == 0;
            headerControls.getListItemByName("category_toggle_rows").addEventListener("WME_CLICK",var_1929.onCategoryToggleModeClicked);
            headerControls.getListItemByName("category_toggle_rows").id = showMoreId;
            headerControls.getListItemByName("category_toggle_rows").visible = resultMode == 1;
         }
         else
         {
            headerControls.removeListItem(headerControls.getListItemByName("category_toggle_tiles"));
            headerControls.removeListItem(headerControls.getListItemByName("category_toggle_rows"));
         }
         headerControls.arrangeListItems();
         roomList = IItemListWindow(container.findChildByName("category_content"));
         if(resultMode == 0)
         {
            roomList.spacing = 0;
         }
         colorMod = 9412607;
         color = -1;
         colorModAccumulator = 1;
         currentTileContainer = null;
         for each(guestRoom in guestRooms)
         {
            alternatingColor = int(colorModAccumulator % 2 == 0 ? color : colorMod);
            if(resultMode == 0)
            {
               roomList.addListItem(var_2655.getNewRowElement(guestRoom,alternatingColor));
               colorModAccumulator++;
            }
            else
            {
               if(!currentTileContainer)
               {
                  currentTileContainer = var_2655.getNewTileContainerElement();
                  roomList.addListItem(currentTileContainer);
                  currentTileContainer.addEventListener("WME_WHEEL",function(param1:WindowMouseEvent):void
                  {
                     var_1929.itemList.scrollWithWheel(param1.delta);
                  });
               }
               currentTileContainer.addListItem(var_2655.getNewTileElement(guestRoom,alternatingColor));
               if(currentTileContainer.numListItems >= 3)
               {
                  currentTileContainer = null;
                  colorModAccumulator++;
               }
            }
         }
         roomList.arrangeListItems();
         return container;
      }
      
      public function getCollapsedCategoryElement(param1:String, param2:int = -1, param3:int = 0) : IWindowContainer
      {
         var _loc4_:IWindowContainer;
         (_loc4_ = IWindowContainer(var_4283.clone())).findChildByName("category_name").caption = param1;
         _loc4_.findChildByName("category_show_more").id = param2;
         _loc4_.findChildByName("category_show_more").addEventListener("WME_CLICK",var_1929.onCategoryShowMoreClicked);
         _loc4_.findChildByName("category_show_more").visible = param3 == 1;
         _loc4_.findChildByName("category_expand").addEventListener("WME_CLICK",var_1929.onCategoryExpandClicked);
         _loc4_.findChildByName("category_expand").id = param2;
         _loc4_.findChildByName("category_name_region").addEventListener("WME_CLICK",var_1929.onCategoryExpandClicked);
         _loc4_.findChildByName("category_name_region").id = param2;
         _loc4_.findChildByName("category_add_quick_link").addEventListener("WME_CLICK",var_1929.onCategoryAddQuickLinkClicked);
         _loc4_.findChildByName("category_add_quick_link").id = param2;
         _loc4_.findChildByName("category_add_quick_link").visible = _navigator.currentResults.searchCodeOriginal.indexOf("official_view") == -1;
         _loc4_.width = var_1929.itemListWidth - 13;
         IItemListWindow(_loc4_.findChildByName("category_controls_itemlist")).arrangeListItems();
         return _loc4_;
      }
      
      public function getNoResultsELement() : IWindowContainer
      {
         return IWindowContainer(var_4703.clone());
      }
   }
}
