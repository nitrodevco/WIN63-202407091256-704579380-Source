package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.HabboCatalogUtils;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.collectibles.widget.MintTokenPurchaseOffer;
   import com.sulake.habbo.catalog.viewer.GameTokensOffer;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import com.sulake.habbo.catalog.viewer.class_3623;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.utils.RentUtils;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   
   public class PurchaseConfirmationDialog implements IAvatarImageListener, IGetImageListener
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _assets:IAssetLibrary;
      
      private var _offerId:int;
      
      private var var_398:String = "";
      
      private var var_562:int;
      
      private var var_2859:String;
      
      private var var_1091:IStuffData = null;
      
      private var var_1471:Array;
      
      private var _userName:String;
      
      private var var_1888:IWindowContainer;
      
      private var var_2701:IWindowContainer;
      
      private var _highlightIndex:int = -1;
      
      private var var_2460:int;
      
      private var var_4885:Boolean = false;
      
      private const MAX_SUGGESTIONS:int = 10;
      
      private var _receiverName:String = "";
      
      private var var_3115:int;
      
      private var var_3599:int = 0;
      
      private var var_739:Array;
      
      private var var_711:Array;
      
      private var var_754:Array;
      
      private var var_1778:int;
      
      private var var_1775:int;
      
      private var var_3006:int;
      
      private const COLOR_EVEN:uint = 4293848814;
      
      private const COLOR_ODD:uint = 4294967295;
      
      private const COLOR_HIGHLIGHT:uint = 4291613146;
      
      private var _window:class_3514;
      
      private var _disposed:Boolean = false;
      
      public function PurchaseConfirmationDialog(param1:IHabboLocalizationManager, param2:IAssetLibrary)
      {
         var_739 = [];
         var_711 = [];
         var_754 = [];
         super();
         _localization = param1;
         _assets = param2;
      }
      
      private static function isValentinesBox(param1:int) : Boolean
      {
         return param1 == 8;
      }
      
      public function showOffer(param1:IHabboCatalog, param2:IRoomEngine, param3:class_3377, param4:int, param5:String, param6:int, param7:IStuffData, param8:Array, param9:String, param10:BitmapData) : void
      {
         _catalog = param1 as HabboCatalog;
         _roomEngine = param2;
         _offerId = param3.offerId;
         var_562 = param4;
         var_2859 = param5;
         var_1091 = param7;
         var_1471 = param8;
         _userName = param9;
         var_2460 = param6;
         var_4885 = _catalog.bundleDiscountEnabled ? param3.bundlePurchaseAllowed : false;
         if(param3 is Offer && param3.product != null)
         {
            var_398 = param3.product.productType;
         }
         else if(param3 is ClubBuyOfferData || HabboCatalogUtils.buildersClub(param3.localizationId))
         {
            var_398 = "h";
         }
         else if(param3 is GameTokensOffer)
         {
            var_398 = "GAME_TOKEN";
         }
         else
         {
            if(!(param3 is MintTokenPurchaseOffer))
            {
               return;
            }
            var_398 = "MINT_TOKEN";
         }
         showConfirmationDialog(param3,param10);
         _catalog.syncPlacedOfferWithPurchase(param3);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         _catalog = null;
         _roomEngine = null;
         _offerId = -1;
         var_562 = -1;
         var_2859 = "";
         var_1471 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_1888 = null;
         if(var_2701 != null)
         {
            var_2701.dispose();
            var_2701 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get productType() : String
      {
         return var_398;
      }
      
      public function getIconWrapper() : IBitmapWrapperWindow
      {
         return !!_window ? _window.findChildByName("product_image") as IBitmapWrapperWindow : null;
      }
      
      public function isGiftPurchase() : Boolean
      {
         return _receiverName != null && _receiverName != "";
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == var_3115)
         {
            var_3115 = 0;
            setImage(param2,true);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setImage(param1:BitmapData, param2:Boolean) : void
      {
         if(_window == null || param1 == null || disposed)
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow;
         if((_loc5_ = _window.findChildByName("product_image") as IBitmapWrapperWindow) == null)
         {
            return;
         }
         if(_loc5_.bitmap != null)
         {
            _loc5_.bitmap.dispose();
            _loc5_.bitmap = null;
         }
         if(_loc5_.bitmap == null)
         {
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         }
         var _loc3_:int = (_loc5_.width - param1.width) * 0.5;
         var _loc4_:int = (_loc5_.height - param1.height) * 0.5;
         _loc5_.bitmap.draw(param1,new Matrix(1,0,0,1,_loc3_,_loc4_));
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function showConfirmationDialog(param1:class_3377, param2:BitmapData) : void
      {
         var _loc17_:class_3423 = null;
         var _loc18_:IItemListWindow = null;
         var _loc8_:int = 0;
         var _loc10_:Boolean = false;
         var _loc14_:String = null;
         var _loc19_:BitmapDataAsset = null;
         var _loc16_:IRoomEngine = null;
         var _loc6_:class_3499 = null;
         var _loc12_:* = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc3_:class_3388 = null;
         var _loc11_:class_3374 = null;
         if(_catalog == null)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         _window = _catalog.utils.createWindow("purchase_confirmation",2) as class_3514;
         if(_window == null)
         {
            return;
         }
         _window.color = param1 is MintTokenPurchaseOffer ? 2763306 : 4296112;
         updateLocalizations(param1);
         var _loc15_:IWindowContainer = _window.findChildByName("purchase_cost_box") as IWindowContainer;
         _catalog.utils.showPriceInContainer(_loc15_,param1,var_2460);
         addClickListener("buy_button",onBuyButtonClick);
         addClickListener("cancel_button",onClose);
         addClickListener("header_button_close",onClose);
         _window.center();
         if(_catalog.getBoolean("disclaimer.credit_spending.enabled"))
         {
            _window.findChildByName("spending_disclaimer").addEventListener("WME_CLICK",onSpendingDisclaimerClicked);
            _window.findChildByName("spending_disclaimer").addEventListener("WME_DOUBLE_CLICK",onSpendingDisclaimerClicked);
            setDisclaimerAccepted(false);
         }
         else
         {
            _window.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         var _loc13_:ITextWindow;
         if((_loc13_ = _window.findChildByName("product_name") as ITextWindow) != null)
         {
            _loc17_ = _catalog.getProductData(param1.localizationId);
            _loc13_.text = _loc17_ == null ? param1.localizationId : _loc17_.name;
         }
         var _loc4_:ITextWindow;
         if((_loc4_ = _window.findChildByName("quantity") as ITextWindow) != null)
         {
            if(_catalog.multiplePurchaseEnabled && var_2460 > 1)
            {
               _loc4_.text = "X " + var_2460;
            }
            else if((_loc18_ = IItemListWindow(_window.findChildByName("properties_itemlist"))) != null)
            {
               _loc18_.removeListItem(_loc4_);
            }
         }
         _window.findChildByName("freeQuantity").visible = false;
         if(_catalog.bundleDiscountEnabled)
         {
            _loc8_ = _catalog.utils.getDiscountItemsCount(var_2460);
            _window.findChildByName("freeQuantity").visible = _loc8_ > 0;
            _catalog.localization.registerParameter("shop.bonus.items.count","amount",_loc8_.toString());
         }
         var _loc9_:IBitmapWrapperWindow;
         if((_loc9_ = _window.findChildByName("product_image") as IBitmapWrapperWindow) != null)
         {
            _loc10_ = false;
            if(class_3623.hasProductImage(param1.localizationId))
            {
               _loc14_ = String(class_3623.PRODUCT_IMAGES[param1.localizationId]);
               if(_loc19_ = _assets.getAssetByName(_loc14_) as BitmapDataAsset)
               {
                  setImage(_loc19_.content as BitmapData,false);
                  _loc10_ = true;
               }
            }
            if(!_loc10_ && (param1.product || param1 is MintTokenPurchaseOffer))
            {
               _loc16_ = _catalog.roomEngine;
               _loc5_ = 0;
               _loc7_ = "";
               if(param1 is Offer)
               {
                  _loc3_ = param1.product;
                  if(_loc3_ != null)
                  {
                     _loc5_ = _loc3_.productClassId;
                     _loc7_ = _loc3_.extraParam;
                  }
               }
               if(param2 == null)
               {
                  switch(productType)
                  {
                     case "s":
                        _loc6_ = _loc16_.getFurnitureImage(_loc5_,new Vector3d(90,0,0),64,this,0,_loc7_,-1,-1,var_1091);
                        break;
                     case "i":
                        _loc6_ = _loc16_.getWallItemImage(_loc5_,new Vector3d(90,0,0),64,this,0,_loc7_);
                        break;
                     case "e":
                        _loc12_ = _catalog.getPixelEffectIcon(_loc5_);
                        break;
                     case "h":
                        _loc12_ = _catalog.getSubscriptionProductIcon(_loc5_);
                        break;
                     case "MINT_TOKEN":
                        _loc12_ = _catalog.getMintTokenProductIcon();
                        break;
                     case "r":
                        (_loc11_ = _catalog.avatarRenderManager.createAvatarImage(_loc7_,"h",null,this)).setDirection("full",3);
                        _loc11_.appendAction("wave");
                        _loc11_.appendAction("gest","sml");
                        _loc12_ = _loc11_.getImage("full",true);
                        _loc11_.dispose();
                  }
                  if(_loc6_ != null)
                  {
                     _loc12_ = _loc6_.data;
                     var_3115 = _loc6_.id;
                  }
               }
               else
               {
                  _loc12_ = param2;
               }
               setImage(_loc12_,true);
               RentUtils.updateBuyCaption(param1,_window.findChildByName("buy_button") as class_3357);
            }
         }
      }
      
      private function onSpendingDisclaimerClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_3398 = param1.target as class_3398;
         if(_loc2_ != null)
         {
            setDisclaimerAccepted(_loc2_.isSelected);
         }
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindow = _window.findChildByName("buy_button");
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      private function updateLocalizations(param1:class_3377) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_3423 = _catalog.getProductData(param1.localizationId);
         var _loc3_:String = _loc2_ == null ? "" : _loc2_.name;
         _catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.costs","offer_name",_loc3_);
      }
      
      private function addClickListener(param1:String, param2:Function) : void
      {
         var _loc3_:IWindow = _window.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",param2);
         }
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         if(_catalog == null || _catalog.avatarRenderManager == null)
         {
            return null;
         }
         var _loc2_:BitmapData = null;
         var _loc3_:class_3374 = _catalog.avatarRenderManager.createAvatarImage(param1,"h",null,this);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getCroppedImage("head");
            _loc3_.dispose();
         }
         return _loc2_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_catalog == null || _window == null || Boolean(_window.disposed) || disposed)
         {
            return;
         }
         if(param1 == _catalog.sessionDataManager.figure)
         {
            updateGiftDialogAvatarImage();
         }
         var _loc2_:class_3374 = _catalog.avatarRenderManager.createAvatarImage(param1,"h",null,this);
         _loc2_.setDirection("full",3);
         _loc2_.appendAction("wave");
         _loc2_.appendAction("gest","sml");
         var _loc3_:BitmapData = _loc2_.getImage("full",true);
         _loc2_.dispose();
         setImage(_loc3_,true);
      }
      
      private function enableGiftDialogAvatarImage(param1:Boolean) : void
      {
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("avatar_image") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            if(param1)
            {
               updateGiftDialogAvatarImage();
            }
            else
            {
               updateUnknownSenderAvatarImage();
            }
         }
         var _loc3_:ITextWindow = _window.findChildByName("message_from") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.visible = param1;
         }
      }
      
      private function updateGiftDialogAvatarImage() : void
      {
         var _loc1_:BitmapData = getAvatarFaceBitmap(_catalog.sessionDataManager.figure);
         if(_loc1_ != null)
         {
            updateAvatarImage(_loc1_);
         }
      }
      
      private function updateUnknownSenderAvatarImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapDataAsset = _assets.getAssetByName("gift_incognito") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.content as BitmapData;
            if(_loc1_ != null)
            {
               updateAvatarImage(_loc1_.clone());
            }
         }
      }
      
      private function updateAvatarImage(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("avatar_image") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.bitmap = param1;
         _loc2_.width = param1.width;
         _loc2_.height = param1.height;
      }
      
      private function onShowFaceSelected(param1:WindowEvent) : void
      {
         enableGiftDialogAvatarImage(true);
         updateGiftDialogAvatarImage();
      }
      
      private function onShowFaceUnselected(param1:WindowEvent) : void
      {
         enableGiftDialogAvatarImage(false);
      }
      
      private function isShowPurchaserName() : Boolean
      {
         var _loc1_:class_3398 = null;
         if(isModerator())
         {
            if(_window != null)
            {
               _loc1_ = _window.findChildByName("show_face_checkbox") as class_3398;
               if(_loc1_ != null)
               {
                  return _loc1_.isSelected;
               }
            }
            return false;
         }
         return true;
      }
      
      private function updateGiftDialogLabels() : void
      {
         var _loc9_:IWindow = null;
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = isDefaultBoxSelected();
         var _loc6_:* = "";
         var _loc7_:String = "";
         var _loc1_:ILocalization = null;
         var _loc2_:ITextWindow = _window.findChildByName("pick_box_title") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc7_ = _loc3_ ? "catalog.gift_wrapping_new.box.default" : "catalog.gift_wrapping_new.box." + var_754[var_1775];
            _loc1_ = _localization.getLocalizationRaw(_loc7_);
            _loc6_ = _loc7_;
            if(_loc1_ != null)
            {
               _loc6_ = String(_loc1_.value);
            }
            _loc2_.text = _loc6_;
         }
         var _loc5_:ITextWindow;
         if((_loc5_ = _window.findChildByName("pick_box_price_title") as ITextWindow) != null)
         {
            _loc7_ = _loc3_ ? "catalog.gift_wrapping_new.freeprice" : "catalog.gift_wrapping_new.price";
            _loc1_ = _localization.getLocalizationRaw(_loc7_);
            _loc6_ = _loc7_;
            if(_loc1_ != null)
            {
               _loc6_ = String(_loc1_.value);
            }
            _loc5_.text = _loc6_;
         }
         var _loc8_:IItemListWindow;
         if((_loc8_ = _window.findChildByName("price_box_container") as IItemListWindow) != null)
         {
            if((_loc9_ = _loc8_.getListItemByName("small_coin")) != null)
            {
               _loc9_.visible = !_loc3_;
               _loc8_.arrangeListItems();
            }
         }
         var _loc4_:ITextWindow;
         if((_loc4_ = _window.findChildByName("pick_ribbon_title") as ITextWindow) != null)
         {
            _loc7_ = "catalog.gift_wrapping_new.ribbon." + var_1778;
            _loc1_ = _localization.getLocalizationRaw(_loc7_);
            _loc6_ = _loc7_;
            if(_loc1_ != null)
            {
               _loc6_ = String(_loc1_.value);
            }
            _loc4_.text = _loc6_;
         }
      }
      
      public function showGiftDialog() : void
      {
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc11_:String = null;
         var _loc3_:Number = NaN;
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc7_:GiftWrappingConfiguration = _catalog.giftWrappingConfiguration;
         _window = _catalog.utils.createWindow("gift_wrapping") as class_3514;
         if(_window == null)
         {
            return;
         }
         _window.center();
         addClickListener("give_gift_button",onGiveGiftButtonClick);
         addClickListener("cancel_link_region",onCancelGift);
         addClickListener("header_button_close",onCancelGift);
         var _loc8_:IWindow;
         if((_loc8_ = _window.findChildByName("name_input")) != null)
         {
            if(_userName != null)
            {
               setReceiverName(_userName);
            }
            else
            {
               focusNameField();
            }
            updateNameHint();
            _loc8_.addEventListener("WE_CHANGE",onNameInputChange);
            _loc8_.addEventListener("WME_DOWN",onNameInputMouseDown);
            _loc8_.addEventListener("WKE_KEY_UP",onNameInputKeyUp);
            _loc8_.addEventListener("WE_FOCUSED",onNameInputFocus);
            _loc8_.addEventListener("WE_UNFOCUSED",onNameInputUnfocus);
         }
         var _loc9_:IStaticBitmapWrapperWindow;
         if(_loc9_ = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow)
         {
            if((_loc4_ = _catalog.getProperty("catalog.gift_wrapping_new.gift_card")) != "")
            {
               _loc9_.assetUri = "${image.library.url}Giftcards/" + _loc4_ + ".png";
            }
         }
         var _loc2_:class_3398 = _window.findChildByName("show_face_checkbox") as class_3398;
         if(_loc2_)
         {
            if(isModerator())
            {
               _loc2_.visible = true;
               _loc2_.select();
               _loc2_.addEventListener("WE_SELECT",onShowFaceSelected);
               _loc2_.addEventListener("WE_UNSELECT",onShowFaceUnselected);
            }
            else
            {
               _loc2_.visible = false;
            }
         }
         var _loc1_:IWindow = _window.findChildByName("show_face_checkbox_title");
         if(_loc1_ != null && !isModerator())
         {
            _loc1_.visible = false;
         }
         updateGiftDialogAvatarImage();
         var _loc5_:IWindow;
         if((_loc5_ = _window.findChildByName("message_input")) != null)
         {
            updateMessageHint();
            _loc5_.addEventListener("WE_CHANGE",onMessageInputChange);
            _loc5_.addEventListener("WE_FOCUSED",onMessageInputFocus);
            _loc5_.addEventListener("WE_UNFOCUSED",onMessageInputUnfocus);
         }
         var _loc10_:IWindow;
         if((_loc10_ = _window.findChildByName("message_from")) != null)
         {
            _loc6_ = _catalog.sessionDataManager.userName;
            _loc11_ = "catalog.gift_wrapping_new.message_from";
            _localization.registerParameter(_loc11_,"name",_loc6_);
            _loc10_.caption = _localization.getLocalization(_loc11_,_loc6_);
         }
         addClickListener("ribbon_prev",onPreviousGiftWrap);
         addClickListener("ribbon_next",onNextGiftWrap);
         addClickListener("box_prev",onPreviousGiftBox);
         addClickListener("box_next",onNextGiftBox);
         _localization.registerParameter("catalog.gift_wrapping_new.price","price",_loc7_.price.toString());
         if(_loc7_.defaultStuffTypes.length > 0)
         {
            _loc3_ = Math.floor(Math.random() * _loc7_.defaultStuffTypes.length);
            var_3599 = _loc7_.defaultStuffTypes[_loc3_];
         }
         var_739 = _loc7_.stuffTypes;
         var_754 = var_754.concat(_loc7_.boxTypes);
         var_754.push(var_3599);
         var_711 = _loc7_.ribbonTypes;
         var_3006 = var_739[0];
         var_1778 = var_711[0];
         var_1775 = _catalog.getInteger("catalog.purchase.gift_wrapping.default_box_index",0);
         if(var_1775 < 0 || var_1775 > var_754.length - 1)
         {
            var_1775 = 0;
         }
         initColorGrid();
         updateColorGrid();
         updatePreview();
      }
      
      private function isModerator() : Boolean
      {
         return _catalog.sessionDataManager.hasSecurity(5);
      }
      
      private function isDefaultBoxSelected() : Boolean
      {
         return var_754[var_1775] == var_3599;
      }
      
      private function updatePreview() : void
      {
         if(var_1778 < 0)
         {
            var_1778 = var_711.length - 1;
         }
         if(var_1778 > var_711.length - 1)
         {
            var_1778 = 0;
         }
         if(var_1775 < 0)
         {
            var_1775 = var_754.length - 1;
         }
         if(var_1775 > var_754.length - 1)
         {
            var_1775 = 0;
         }
         var _loc5_:int = int(var_754[var_1775]);
         if(isValentinesBox(_loc5_))
         {
            var_1778 = 10;
            if(var_1778 > var_711.length - 1)
            {
               var_1778 = 0;
            }
         }
         var _loc2_:int = _loc5_ * 1000 + var_711[var_1778];
         if(_window == null)
         {
            return;
         }
         if(_roomEngine == null)
         {
            return;
         }
         var _loc3_:String = _loc2_.toString();
         var _loc6_:int = var_3006;
         var _loc1_:Boolean = isDefaultBoxSelected();
         if(_loc1_)
         {
            enableBoxColorAndRibbonSelectors(false);
            _loc6_ = var_3599;
            _loc3_ = "";
         }
         else if(isValentinesBox(_loc5_))
         {
            enableBoxColorAndRibbonSelectors(false);
         }
         else
         {
            enableBoxColorAndRibbonSelectors(true);
            if(_loc5_ >= 3 && _loc5_ <= 6)
            {
               enableBoxColorSelectors(false);
            }
         }
         var _loc4_:class_3499;
         if((_loc4_ = _roomEngine.getFurnitureImage(_loc6_,new Vector3d(180),64,this,0,_loc3_)) == null)
         {
            return;
         }
         var_3115 = _loc4_.id;
         setImage(_loc4_.data,true);
         showSuggestions(false);
         updateGiftDialogLabels();
      }
      
      private function initColorGrid() : void
      {
         var _loc3_:class_3365 = null;
         var _loc2_:IWindowContainer = null;
         if(_window == null)
         {
            return;
         }
         var _loc1_:IItemGridWindow = _window.findChildByName("color_grid") as IItemGridWindow;
         _loc1_.destroyGridItems();
         var _loc5_:IWindowContainer = _catalog.utils.createWindow("gift_palette_item") as IWindowContainer;
         for each(var _loc4_ in var_739)
         {
            _loc3_ = _catalog.getFurnitureData(_loc4_,"s");
            _loc2_ = _loc5_.clone() as IWindowContainer;
            if(!(!_loc3_ || !_loc2_))
            {
               _loc2_.addEventListener("WME_CLICK",onColorItemClick);
               _loc2_.findChildByName("color").color = _loc3_.colours[0];
               _loc2_.id = _loc4_;
               _loc1_.addGridItem(_loc2_);
            }
         }
      }
      
      private function giveGift() : void
      {
         var _loc3_:IWindow = _window.findChildByName("name_input");
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:String = _loc3_.caption;
         var _loc1_:IWindow = _window.findChildByName("message_input");
         var _loc8_:String = _loc1_ == null ? "" : _loc1_.caption;
         var _loc9_:Boolean;
         var _loc7_:int = (_loc9_ = isDefaultBoxSelected()) ? var_3599 : var_3006;
         var _loc5_:int = int(_loc9_ ? 0 : var_754[var_1775]);
         var _loc6_:int = int(_loc9_ ? 0 : var_711[var_1778]);
         var _loc2_:Boolean = isShowPurchaserName();
         _catalog.purchaseProductAsGift(var_562,_offerId,var_2859,_loc4_,_loc8_,_loc7_,_loc5_,_loc6_,_loc2_);
      }
      
      private function safeDisable(param1:String) : void
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.disable();
         }
      }
      
      private function safeEnable(param1:String) : void
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.enable();
         }
      }
      
      private function onBuyButtonClick(param1:WindowEvent) : void
      {
         var _loc2_:class_3455 = null;
         safeDisable("buy_button");
         safeDisable("cancel_button");
         safeDisable("publish_check");
         if(var_398 == "GAME_TOKEN")
         {
            _catalog.purchaseGameTokensOffer(var_2859);
         }
         else if(var_398 == "MINT_TOKEN")
         {
            _catalog.purchaseMintTokens(_offerId,var_2859);
         }
         else
         {
            _catalog.purchaseProduct(var_562,_offerId,var_2859,var_2460);
            _loc2_ = _catalog.currentPage;
            if(_loc2_ != null)
            {
               _loc2_.dispatchWidgetEvent(new CatalogWidgetEvent("PURCHASE"));
            }
         }
      }
      
      private function onGiftButtonClick(param1:WindowEvent) : void
      {
         showGiftDialog();
         HabboTracking.getInstance().trackEventLog("Catalog","clickConfirm","client.buy_as_gift.clicked");
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         _catalog.resetPlacedOfferData();
         dispose();
      }
      
      private function onGiveGiftButtonClick(param1:WindowEvent) : void
      {
         giveGift();
         enableGiftButton(false);
         _catalog.giftReceiver = null;
         _catalog.resetPlacedOfferData();
      }
      
      private function onCancelGift(param1:WindowEvent) : void
      {
         _catalog.resetPlacedOfferData();
         dispose();
      }
      
      private function onPreviousGiftWrap(param1:WindowEvent) : void
      {
         var_1778--;
         updatePreview();
      }
      
      private function onNextGiftWrap(param1:WindowEvent) : void
      {
         var_1778++;
         updatePreview();
      }
      
      private function onPreviousGiftBox(param1:WindowEvent) : void
      {
         var_1775--;
         updatePreview();
      }
      
      private function onNextGiftBox(param1:WindowEvent) : void
      {
         var_1775++;
         updatePreview();
      }
      
      private function onNameInputChange(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateNameHint();
         if(_receiverName == _loc2_.caption)
         {
            return;
         }
         var _loc3_:String = _loc2_.caption.toLowerCase();
         var _loc5_:Array = [];
         for each(var _loc4_ in var_1471)
         {
            if(_loc4_.toLowerCase().search(_loc3_) != -1)
            {
               _loc5_.push(_loc4_);
            }
            if(_loc5_.length >= 10)
            {
               break;
            }
         }
         _receiverName = _loc2_.caption;
         updateSuggestions(_loc5_);
      }
      
      private function onNameInputMouseDown(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         showSuggestions(false);
      }
      
      private function onNameInputKeyUp(param1:WindowEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         var _loc2_:IWindow = param1.target;
         switch(_loc4_.keyCode)
         {
            case 38:
               highlightSuggestion(_highlightIndex - 1);
               break;
            case 40:
               highlightSuggestion(_highlightIndex + 1);
               if(_loc2_ != null)
               {
                  if(_loc2_.caption.length == 0)
                  {
                     if(var_1888 == null || !var_1888.visible)
                     {
                        _loc3_ = showAllFriendSuggestions();
                        if(_loc3_)
                        {
                           highlightSuggestion(0);
                        }
                     }
                  }
               }
               break;
            case 13:
               selectHighlighted();
               break;
            case 9:
               focusMessageField();
         }
      }
      
      private function showAllFriendSuggestions() : Boolean
      {
         var _loc2_:Array = null;
         if(var_1471 != null && var_1471.length > 0)
         {
            _loc2_ = [];
            for each(var _loc1_ in var_1471)
            {
               _loc2_.push(_loc1_);
               if(_loc2_.length >= 10)
               {
                  break;
               }
            }
            updateSuggestions(_loc2_);
            showSuggestions(true);
            return true;
         }
         return false;
      }
      
      private function focusNameField() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = _window.findChildByName("name_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = true;
         _loc1_.focus();
      }
      
      private function focusMessageField() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = _window.findChildByName("message_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = true;
         _loc1_.focus();
      }
      
      private function selectHighlighted() : void
      {
         if(var_1888 == null || !var_1888.visible)
         {
            return;
         }
         var _loc3_:IItemListWindow = var_1888.findChildByName("suggestion_list") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:IWindowContainer = _loc3_.getListItemAt(_highlightIndex) as IWindowContainer;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:IWindow = _loc1_.findChildByName("name_text");
         if(_loc2_ == null)
         {
            return;
         }
         setReceiverName(_loc2_.caption);
         showSuggestions(false);
      }
      
      private function showSuggestions(param1:Boolean) : void
      {
         if(var_1888 == null)
         {
            return;
         }
         var_1888.visible = param1;
         if(!param1)
         {
            showMessageInput(true);
         }
      }
      
      private function showMessageInput(param1:Boolean) : void
      {
         var _loc2_:IWindow = _window.findChildByName("message_input");
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      private function onMessageInputChange(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateMessageHint();
      }
      
      private function onNameInputFocus(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateNameHint();
      }
      
      private function onNameInputUnfocus(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         updateNameHint();
      }
      
      private function onMessageInputFocus(param1:WindowEvent) : void
      {
         updateMessageHint();
         showSuggestions(false);
      }
      
      private function onMessageInputUnfocus(param1:WindowEvent) : void
      {
         updateMessageHint();
      }
      
      private function updateNameHint() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:IWindow = _window.findChildByName("name_input");
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:String = _loc1_.caption;
         if(_loc2_ == null || _loc2_.length == 0)
         {
            enableHint(true,"name_input_hint","catalog.gift_wrapping_new.name_hint");
         }
         else
         {
            enableHint(false,"name_input_hint","catalog.gift_wrapping_new.name_hint");
         }
      }
      
      private function updateMessageHint() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:IWindow = _window.findChildByName("message_input");
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:String = _loc1_.caption;
         if(_loc2_ == null || _loc2_.length == 0)
         {
            enableHint(true,"message_input_hint","catalog.gift_wrapping_new.message_hint");
         }
         else
         {
            enableHint(false,"message_input_hint","catalog.gift_wrapping_new.message_hint");
         }
      }
      
      private function enableHint(param1:Boolean, param2:String, param3:String) : void
      {
         var _loc4_:ITextWindow;
         if((_loc4_ = _window.findChildByName(param2) as ITextWindow) != null)
         {
            _loc4_.text = _localization.getLocalization(param3);
            _loc4_.visible = param1;
         }
      }
      
      private function enableRibbonSelectors(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindow = _window.findChildByName("ribbon_prev");
         enableWindow(_loc2_,param1);
         var _loc3_:IWindow = _window.findChildByName("ribbon_next");
         enableWindow(_loc3_,param1);
         var _loc4_:IWindow = _window.findChildByName("pick_ribbon_title");
         enableWindow(_loc4_,param1);
      }
      
      private function enableBoxColorAndRibbonSelectors(param1:Boolean) : void
      {
         enableBoxColorSelectors(param1);
         enableRibbonSelectors(param1);
      }
      
      private function enableBoxColorSelectors(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IWindow = _window.findChildByName("box_color_title");
         enableWindow(_loc3_,param1);
         var _loc2_:IWindowContainer = _window.findChildByName("color_picker_container") as IWindowContainer;
         if(_loc2_ != null)
         {
            enableWindow(_loc2_,param1);
         }
      }
      
      private function enableWindow(param1:IWindow, param2:Boolean) : void
      {
         var _loc3_:IIterator = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:IWindow = null;
         enableElement(param1,param2);
         if(param1 is IIterable)
         {
            _loc3_ = IIterable(param1).iterator;
            if((_loc4_ = int(_loc3_.length)) > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  if((_loc6_ = _loc3_[_loc5_] as IWindow) != null)
                  {
                     enableElement(_loc6_,param2);
                     if(_loc6_ is IIterable)
                     {
                        enableWindow(_loc6_,param2);
                     }
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      private function enableElement(param1:IWindow, param2:Boolean) : void
      {
         if(param2)
         {
            param1.blend = 1;
            param1.enable();
         }
         else
         {
            param1.blend = 0.5;
            param1.disable();
         }
      }
      
      private function updateSuggestions(param1:Array) : void
      {
         var _loc5_:IWindowContainer = null;
         var _loc7_:ITextWindow = null;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:TextFormat = null;
         var _loc3_:int = 0;
         if(var_1888 == null)
         {
            var_1888 = _window.findChildByName("suggestion_container") as IWindowContainer;
         }
         if(var_2701 == null)
         {
            var_2701 = _catalog.utils.createWindow("suggestion_list_item_new") as IWindowContainer;
         }
         if(var_1888 == null || var_2701 == null)
         {
            return;
         }
         var _loc9_:IItemListWindow;
         if((_loc9_ = var_1888.findChildByName("suggestion_list") as IItemListWindow) == null)
         {
            return;
         }
         _loc9_.removeListItems();
         if(param1.length == 0)
         {
            showSuggestions(false);
            return;
         }
         showSuggestions(true);
         var _loc6_:int = 0;
         for each(var _loc4_ in param1)
         {
            if((_loc5_ = var_2701.clone() as IWindowContainer) != null)
            {
               _loc5_.addEventListener("WME_CLICK",onSuggestionsClick);
               _loc5_.addEventListener("WME_OVER",onSuggestionsMouseOver);
               if((_loc7_ = _loc5_.findChildByName("name_text") as ITextWindow) != null)
               {
                  _loc7_.text = _loc4_;
                  if(_receiverName != null)
                  {
                     _loc2_ = _receiverName.length;
                     if(_loc2_ > 0)
                     {
                        if((_loc8_ = _loc4_.toLowerCase().search(_receiverName.toLowerCase())) != -1)
                        {
                           (_loc10_ = _loc7_.getTextFormat()).bold = true;
                           _loc3_ = _loc8_ + _loc2_;
                           if(_loc3_ > _loc4_.length)
                           {
                              _loc3_ = _loc4_.length;
                           }
                           _loc7_.setTextFormat(_loc10_,_loc8_,_loc3_);
                        }
                     }
                  }
                  _loc9_.addListItem(_loc5_);
               }
               _loc5_.color = getColor(_loc6_);
               _loc6_++;
            }
         }
         showMessageInput(param1.length < 2);
         highlightSuggestion(0);
      }
      
      private function onSuggestionsClick(param1:WindowEvent) : void
      {
         var _loc2_:IWindowContainer = param1.target as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.findChildByName("name_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         setReceiverName(_loc3_.text);
         showSuggestions(false);
      }
      
      private function onSuggestionsMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:IWindowContainer = param1.target as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = var_1888.findChildByName("suggestion_list") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         highlightSuggestion(_loc3_.getListItemIndex(_loc2_));
      }
      
      private function highlightSuggestion(param1:int) : void
      {
         var _loc2_:IWindowContainer = null;
         if(var_1888 == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = var_1888.findChildByName("suggestion_list") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_ = _loc3_.getListItemAt(_highlightIndex) as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.color = getColor(_highlightIndex);
         }
         _highlightIndex = param1;
         if(_highlightIndex < 0)
         {
            _highlightIndex = _loc3_.numListItems - 1;
         }
         if(_highlightIndex >= _loc3_.numListItems)
         {
            _highlightIndex = 0;
         }
         _loc2_ = _loc3_.getListItemAt(_highlightIndex) as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.color = 4291613146;
         }
      }
      
      private function getColor(param1:int) : uint
      {
         return param1 % 2 == 0 ? 4293848814 : 4294967295;
      }
      
      private function setReceiverName(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindow = _window.findChildByName("name_input");
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.caption = param1;
         updateNameHint();
         focusMessageField();
      }
      
      private function onColorItemClick(param1:WindowEvent) : void
      {
         var_3006 = param1.target.id;
         updateColorGrid();
         updatePreview();
      }
      
      private function updateColorGrid() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc2_:IWindow = null;
         var _loc4_:int = 0;
         if(_window == null)
         {
            return;
         }
         var _loc3_:IItemGridWindow = _window.findChildByName("color_grid") as IItemGridWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.numGridItems)
         {
            _loc1_ = _loc3_.getGridItemAt(_loc4_) as IWindowContainer;
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_.findChildByName("selection");
               if(_loc2_ != null)
               {
                  _loc2_.visible = _loc1_.id == var_3006;
               }
            }
            _loc4_++;
         }
      }
      
      public function receiverNotFound() : void
      {
         if(disposed)
         {
            return;
         }
         enableGiftButton(true);
         if(!_catalog || !_catalog.windowManager)
         {
            return;
         }
         _catalog.windowManager.alert("${catalog.gift_wrapping.receiver_not_found.title}","${catalog.gift_wrapping.receiver_not_found.info}",0,alertHandler);
      }
      
      private function alertHandler(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
         enableGiftButton(true);
      }
      
      private function enableGiftButton(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:class_3357 = _window.findChildByName("give_gift_button") as class_3357;
         if(_loc2_ != null)
         {
            param1 ? _loc2_.enable() : Boolean(_loc2_.disable());
         }
      }
      
      public function notEnoughCredits() : void
      {
         if(disposed)
         {
            return;
         }
         if(_window == null)
         {
            return;
         }
         enableGiftButton(true);
         safeEnable("header_button_close");
         var _loc1_:class_3398 = _window.findChildByName("use_free_checkbox") as class_3398;
         if(_loc1_ != null)
         {
            _loc1_.select();
         }
      }
      
      public function turnIntoGifting() : void
      {
         var _loc1_:IWindow = _window.findChildByName("buy_button");
         _loc1_.removeEventListener("WME_CLICK",onBuyButtonClick);
         _loc1_.addEventListener("WME_CLICK",onGiftButtonClick);
         _loc1_.caption = "${catalog.purchase_confirmation.gift}";
         _window.caption = "${catalog.purchase_confirmation.gift.title}";
      }
   }
}
