package com.sulake.habbo.nux
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.session.product.class_1812;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.communication.messages.outgoing.nux.class_1232;
   import com.sulake.habbo.communication.messages.incoming.nux.class_1714;
   import com.sulake.habbo.communication.messages.incoming.nux.class_1779;
   import com.sulake.habbo.communication.messages.incoming.nux.class_1792;
   
   public class NuxGiftSelectionView implements class_1812
   {
       
      
      private var _frame:class_3514;
      
      private var var_1660:HabboNuxDialogs;
      
      private var var_3407:IWindowContainer;
      
      private var var_717:Vector.<class_1714>;
      
      private var var_1718:int;
      
      private var var_4191:Vector.<class_1232>;
      
      public function NuxGiftSelectionView(param1:HabboNuxDialogs, param2:Vector.<class_1714>)
      {
         super();
         var_1660 = param1;
         var_717 = param2;
         var_1718 = 0;
         var_4191 = new Vector.<class_1232>();
         if(var_1660.sessionDataManager && var_1660.sessionDataManager.loadProductData(this))
         {
            show();
         }
      }
      
      public function productDataReady() : void
      {
         show();
      }
      
      public function dispose() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         var_1660 = null;
         var_3407 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1660 == null;
      }
      
      private function hide() : void
      {
         if(var_1660)
         {
            var_1660.destroyNuxOfferView();
         }
      }
      
      private function show() : void
      {
         if(_frame != null)
         {
            _frame.dispose();
         }
         var _loc2_:XmlAsset = var_1660.assets.getAssetByName("nux_gift_selection_xml") as XmlAsset;
         _frame = var_1660.windowManager.buildFromXML(_loc2_.content as XML) as class_3514;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:IWindow = _frame.findChildByTag("close");
         if(_loc1_)
         {
            _loc1_.visible = false;
         }
         populateStep();
      }
      
      private function populateStep() : void
      {
         var _loc6_:int = 0;
         var _loc2_:class_1779 = null;
         var _loc12_:IWindowContainer = null;
         var _loc3_:ITextWindow = null;
         var _loc9_:class_3357 = null;
         var _loc10_:IWindowContainer = null;
         var _loc14_:IStaticBitmapWrapperWindow = null;
         var _loc13_:String = null;
         var _loc15_:int = 0;
         var _loc4_:class_1792 = null;
         var _loc16_:String = null;
         var _loc8_:String = null;
         var _loc11_:class_3423 = null;
         var _loc17_:String = null;
         if(!var_717 || !var_717.length)
         {
            return;
         }
         var _loc1_:class_1714 = var_717[var_1718];
         var _loc5_:IItemListWindow = _frame.findChildByName("nux_gift_selection_list") as IItemListWindow;
         if(!var_3407)
         {
            var_3407 = _loc5_.getListItemAt(0) as IWindowContainer;
         }
         _loc5_.removeListItems();
         var _loc7_:String = decodeURI(var_1660.localizationManager.getLocalization("nux.gift.selection.separator",", "));
         _loc6_ = 0;
         while(_loc6_ < _loc1_.options.length)
         {
            _loc2_ = _loc1_.options[_loc6_];
            _loc3_ = (_loc12_ = var_3407.clone() as IWindowContainer).getChildByName("option_heading") as ITextWindow;
            _loc9_ = _loc12_.getChildByName("option_button") as class_3357;
            _loc14_ = (_loc10_ = _loc12_.getChildByName("option_thumbnail") as IWindowContainer).getChildByName("option_bitmap") as IStaticBitmapWrapperWindow;
            _loc13_ = "";
            if(_loc2_.productOfferList.length)
            {
               _loc15_ = 0;
               while(_loc15_ < _loc2_.productOfferList.length)
               {
                  _loc16_ = (_loc4_ = _loc2_.productOfferList[_loc15_]).productCode;
                  if((_loc8_ = _loc4_.localizationKey) != null)
                  {
                     _loc13_ += var_1660.localizationManager.getLocalization(_loc8_,_loc8_);
                  }
                  else if((_loc11_ = var_1660.catalog.getProductData(_loc16_)) && _loc11_.name)
                  {
                     _loc13_ += _loc11_.name;
                  }
                  else
                  {
                     _loc13_ += var_1660.localizationManager.getLocalization("product_" + _loc16_ + "_name","product_" + _loc16_ + "_name");
                  }
                  if(_loc15_ < _loc2_.productOfferList.length - 1)
                  {
                     _loc13_ += _loc7_;
                  }
                  _loc15_++;
               }
            }
            if(_loc17_ = _loc2_.thumbnailUrl)
            {
               _loc14_.assetUri = var_1660.configuration.getProperty("image.library.url") + _loc17_;
            }
            _loc3_.text = _loc13_;
            _loc9_.name = _loc6_.toString();
            _loc9_.procedure = onSelectOption;
            _loc5_.addListItem(_loc12_);
            _loc6_++;
         }
         _loc5_.arrangeListItems();
         if(var_717.length > 1)
         {
            _frame.caption = var_1660.localizationManager.getLocalization("nux.gift.selection.title") + " " + (var_1718 + 1) + "/" + var_717.length;
         }
         _frame.center();
      }
      
      private function onSelectOption(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:class_1714 = null;
         var _loc6_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc5_:class_1232 = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_717[var_1718];
            if((_loc4_ = (_loc6_ = _frame.findChildByName("nux_gift_selection_list") as IItemListWindow).getListItemIndex(param2.parent)) == -1)
            {
               return;
            }
            _loc5_ = new class_1232(_loc3_.dayIndex,_loc3_.stepIndex,_loc4_);
            var_4191.push(_loc5_);
            var_1718++;
            if(var_1718 == var_717.length)
            {
               var_1660.onSendGetGifts(var_4191);
            }
            else
            {
               show();
            }
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
   }
}
