package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandSongDiskView extends InfoStandFurniView
   {
       
      
      private var var_606:int = -1;
      
      public function InfoStandSongDiskView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         super.update(param1);
         var_606 = getSongIdFromExtraParam(param1.extraParam);
      }
      
      public function updateSongInfo(param1:RoomWidgetSongUpdateEvent) : void
      {
         if(param1.type == "RWSUE_DATA_RECEIVED" && param1.songId == var_606)
         {
            trackName = param1.songName;
            authorName = param1.songAuthor;
         }
      }
      
      override protected function createWindow(param1:String) : void
      {
         var _loc2_:IWindow = null;
         var _loc7_:int = 0;
         var _loc5_:BitmapData = null;
         var _loc10_:BitmapDataAsset = null;
         var _loc4_:XmlAsset = var_1629.assets.getAssetByName("songdisk_view") as XmlAsset;
         _window = var_1629.windowManager.buildFromXML(_loc4_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_1638 = _window.getListItemByName("info_border") as class_3437;
         var_1640 = _window.getListItemByName("button_list") as IItemListWindow;
         if(var_1638 != null)
         {
            var_1693 = var_1638.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         var_1629.mainContainer.addChild(_window);
         var _loc3_:IWindow = var_1638.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         if(var_1640 != null)
         {
            _loc7_ = 0;
            while(_loc7_ < var_1640.numListItems)
            {
               _loc2_ = var_1640.getListItemAt(_loc7_);
               _loc2_.addEventListener("WME_CLICK",onButtonClicked);
               _loc7_++;
            }
         }
         var_1884 = var_1638.findChildByTag("catalog");
         if(var_1884 != null)
         {
            var_1884.addEventListener("WME_CLICK",onCatalogButtonClicked);
         }
         var_1869 = var_1638.findChildByName("rent_button");
         if(var_1869 != null)
         {
            var_1869.addEventListener("WME_CLICK",onRentButtonClicked);
         }
         var_1858 = var_1638.findChildByName("extend_button");
         if(var_1858 != null)
         {
            var_1858.addEventListener("WME_CLICK",onExtendButtonClicked);
         }
         var_1854 = var_1638.findChildByName("buyout_button");
         if(var_1854 != null)
         {
            var_1854.addEventListener("WME_CLICK",onBuyoutButtonClicked);
         }
         var _loc6_:IBitmapWrapperWindow;
         if((_loc6_ = var_1638.findChildByName("icon_disc") as IBitmapWrapperWindow) != null)
         {
            _loc5_ = (_loc10_ = var_1629.assets.getAssetByName("jb_icon_disc") as BitmapDataAsset).content as BitmapData;
            _loc6_.bitmap = _loc5_.clone();
         }
         var _loc9_:IBitmapWrapperWindow;
         if((_loc9_ = var_1638.findChildByName("icon_composer") as IBitmapWrapperWindow) != null)
         {
            _loc5_ = (_loc10_ = var_1629.assets.getAssetByName("jb_icon_composer") as BitmapDataAsset).content as BitmapData;
            _loc9_.bitmap = _loc5_.clone();
         }
         var _loc8_:IRegionWindow;
         if((_loc8_ = var_1693.getListItemByName("owner_region") as IRegionWindow) != null)
         {
            _loc8_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc8_.addEventListener("WME_OVER",onOwnerRegion);
            _loc8_.addEventListener("WME_OUT",onOwnerRegion);
         }
      }
      
      private function set trackName(param1:String) : void
      {
         var _loc2_:IWindowContainer = var_1693.getListItemByName("trackname_container") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_name_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
         updateWindow();
      }
      
      private function set authorName(param1:String) : void
      {
         var _loc2_:IWindowContainer = var_1693.getListItemByName("creatorname_container") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_creator_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
         updateWindow();
      }
      
      private function getSongIdFromExtraParam(param1:String) : int
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            _loc2_ = param1.substr("RWEIEP_SONGDISK".length,param1.length);
            return parseInt(_loc2_);
         }
         return -1;
      }
   }
}
