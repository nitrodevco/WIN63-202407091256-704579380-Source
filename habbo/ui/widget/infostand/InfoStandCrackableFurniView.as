package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.object.data.CrackableStuffData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   
   public class InfoStandCrackableFurniView extends InfoStandFurniView
   {
       
      
      public function InfoStandCrackableFurniView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         super.update(param1);
         var _loc2_:CrackableStuffData = param1.stuffData as CrackableStuffData;
         showButton("use",true);
         var_1640.visible = true;
         setHitsAndTarget(_loc2_.hits,_loc2_.target);
      }
      
      private function setHitsAndTarget(param1:int, param2:int) : void
      {
         var _loc3_:IWindow = var_1693.getListItemByName("hits_remaining");
         if(_loc3_ == null)
         {
            return;
         }
         var_1629.localizations.registerParameter("infostand.crackable_furni.hits_remaining","hits",String(param1));
         var_1629.localizations.registerParameter("infostand.crackable_furni.hits_remaining","target",String(param2));
         _loc3_.visible = true;
         updateWindow();
      }
      
      override protected function createWindow(param1:String) : void
      {
         var _loc2_:IWindow = null;
         var _loc5_:int = 0;
         var _loc4_:XmlAsset = var_1629.assets.getAssetByName("crackable_furni_view") as XmlAsset;
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
            _loc5_ = 0;
            while(_loc5_ < var_1640.numListItems)
            {
               _loc2_ = var_1640.getListItemAt(_loc5_);
               _loc2_.addEventListener("WME_CLICK",onButtonClicked);
               _loc5_++;
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
         var _loc6_:IRegionWindow;
         if((_loc6_ = var_1693.getListItemByName("owner_region") as IRegionWindow) != null)
         {
            _loc6_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc6_.addEventListener("WME_OVER",onOwnerRegion);
            _loc6_.addEventListener("WME_OUT",onOwnerRegion);
         }
      }
   }
}
