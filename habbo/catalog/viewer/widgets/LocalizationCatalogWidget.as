package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3404;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.navigation.class_3411;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.text.StyleSheet;
   import flash.utils.Dictionary;
   
   public class LocalizationCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var var_2770:Dictionary;
      
      private var _catalog:HabboCatalog;
      
      public function LocalizationCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         var_2770 = new Dictionary();
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _catalog = null;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         initLocalizables();
         initStaticImages();
         initLinks();
         events.addEventListener("SELECT_PRODUCT",onProductSelected);
         return true;
      }
      
      private function onProductSelected(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
      }
      
      private function initLinks() : void
      {
         var _loc2_:IWindow = null;
         if(page.hasLinks)
         {
            for each(var _loc1_ in page.links)
            {
               _loc2_ = _window.findChildByName(_loc1_);
               if(_loc2_ != null)
               {
                  _loc2_.setParamFlag(1);
                  _loc2_.mouseThreshold = 0;
                  _loc2_.addEventListener("WME_CLICK",onClickLink);
               }
            }
         }
      }
      
      private function onClickLink(param1:WindowMouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:IHabboLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
         var _loc2_:ICoreConfiguration = page.viewer.catalog as HabboCatalog;
         var _loc6_:String = String(IWindow(param1.target).name);
         var _loc5_:String = "";
         switch(page.layoutCode)
         {
            case "frontpage3":
               switch(_loc6_)
               {
                  case "ctlg_txt3":
                     if(IWindow(param1.target).caption != "")
                     {
                        _loc5_ = page.localization.getTextElementContent(6);
                        page.viewer.catalog.openCatalogPage(_loc5_);
                     }
                     break;
                  case "ctlg_txt7":
                     if(IWindow(param1.target).caption != "")
                     {
                        if((_loc5_ = page.localization.getTextElementContent(10)).indexOf("http") >= 0)
                        {
                           openExternalLink(_loc5_);
                        }
                        else if(_loc5_ == "credits")
                        {
                           HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                        }
                        else
                        {
                           page.viewer.catalog.openCatalogPage(_loc5_);
                        }
                     }
               }
               break;
            case "info_pixels":
               switch(_loc6_)
               {
                  case "ctlg_text_5":
                     _catalog.questEngine.showAchievements();
                     break;
                  case "ctlg_text_7":
                     _loc5_ = page.localization.getTextElementContent(7);
                     page.viewer.catalog.openCatalogPage(_loc5_);
               }
               break;
            case "info_credits":
               switch(_loc6_)
               {
                  case "ctlg_text_5":
                     HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                     break;
                  case "ctlg_text_7":
                     _loc5_ = page.localization.getTextElementContent(7);
                     page.viewer.catalog.openCatalogPage(_loc5_);
               }
               break;
            case "collectibles":
               var _loc7_:* = _loc6_;
               if("ctlg_collectibles_link" === _loc7_)
               {
                  _loc5_ = String(_loc2_.getProperty("link.format.collectibles"));
                  openExternalLink(_loc5_);
               }
               break;
            case "club1":
               _loc7_ = _loc6_;
               if("ctlg_text_5" === _loc7_)
               {
                  page.viewer.catalog.openCatalogPage("hc_membership");
               }
               break;
            case "club_buy":
               _loc7_ = _loc6_;
               if("club_link" === _loc7_)
               {
                  _loc5_ = String(_loc2_.getProperty("link.format.club"));
                  openExternalLink(_loc5_);
               }
               break;
            case "mad_money":
               _loc7_ = _loc6_;
               if("ctlg_madmoney_button" === _loc7_)
               {
                  _loc5_ = String(_loc2_.getProperty("link.format.madmoney"));
                  openExternalLink(_loc5_);
               }
               break;
            case "monkey":
               switch(_loc6_)
               {
                  case "ctlg_teaserimg_1_region":
                  case "ctlg_special_img_region":
                     _loc5_ = String(_loc4_.getLocalization("link.format.monkey","http://store.apple.com/"));
                     openExternalLink(_loc5_);
               }
               break;
            case "niko":
               switch(_loc6_)
               {
                  case "ctlg_teaserimg_1_region":
                  case "ctlg_special_img_region":
                     _loc5_ = String(_loc4_.getLocalization("link.format.niko","http://itunes.apple.com/us/app/niko/id481670205?mt=8"));
                     openExternalLink(_loc5_);
               }
               break;
            default:
               class_14.log("[Localization Catalog Widget] Unhandled link clicked" + [page.layoutCode,_loc6_]);
         }
      }
      
      private function openExternalLink(param1:String) : void
      {
         if(param1 != "")
         {
            page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
            HabboWebTools.navigateToURL(param1,"habboMain");
         }
      }
      
      private function onExternalLink(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function initStaticImages() : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc1_:Array = [];
         _window.groupChildrenWithTag("STATIC_IMAGE",_loc1_,10);
         for each(var _loc3_ in _loc1_)
         {
            if(_loc3_ is IBitmapWrapperWindow)
            {
               _loc4_ = _loc3_.name;
               _loc2_ = _loc3_.name;
               var_2770[_loc2_] = _loc4_;
               if(page.viewer.catalog.assets.hasAsset(_loc2_))
               {
                  setElementImage(_loc4_,_loc2_);
               }
               else
               {
                  retrieveCatalogImage(_loc2_);
               }
            }
         }
      }
      
      protected function initLocalizables() : void
      {
         var _loc9_:String = null;
         var _loc6_:String = null;
         var _loc8_:IWindow = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var_2770 = new Dictionary();
         _catalog.mainContainer.findChildByName("catalog.header.description").caption = "";
         _loc4_ = 0;
         while(_loc4_ < page.localization.textCount)
         {
            _loc9_ = page.localization.getTextElementName(_loc4_,page.layoutCode);
            _loc6_ = page.localization.getTextElementContent(_loc4_);
            if(_loc9_ == "catalog.header.description")
            {
               _loc8_ = _catalog.mainContainer.findChildByName(_loc9_);
            }
            else if(_window != null)
            {
               _loc8_ = _window.findChildByName(_loc9_);
            }
            if(_loc8_ != null)
            {
               _loc6_ = _loc6_.replace(/\r\n/g,"\n");
               _loc8_.caption = _loc6_;
               if(_loc8_ is class_3404)
               {
                  _loc8_.addEventListener("WE_LINK",onClickHtmlLink);
                  setLinkStyle(_loc8_ as class_3404);
               }
            }
            else
            {
               class_14.log("[Localization Catalog Widget] Could not place text in layout:  element: " + _loc9_ + ", content: " + _loc6_);
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < page.localization.imageCount)
         {
            _loc9_ = page.localization.getImageElementName(_loc4_,page.layoutCode);
            _loc6_ = page.localization.getImageElementContent(_loc4_);
            if(_loc9_ != "")
            {
               if(_loc6_ != "")
               {
                  _loc5_ = _loc6_;
                  var_2770[_loc5_] = _loc9_;
                  if(page.viewer.catalog.assets.hasAsset(_loc5_))
                  {
                     setElementImage(_loc9_,_loc5_);
                  }
                  else
                  {
                     retrieveCatalogImage(_loc5_);
                  }
               }
            }
            _loc4_++;
         }
         var _loc1_:class_3411 = _catalog.currentCatalogNavigator.getNodeById(page.pageId);
         var _loc7_:IWindow = _catalog.mainContainer.findChildByName("catalog.header.title");
         var _loc3_:IStaticBitmapWrapperWindow = _catalog.mainContainer.findChildByName("catalog.header.icon") as IStaticBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            _loc7_.caption = _loc1_ != null ? _loc1_.localization : (page.mode == 1 ? "${catalog.search.header}" : "${catalog.header}");
         }
         if(_loc3_ != null && _loc1_ != null)
         {
            _loc3_.assetUri = page.mode == 1 ? "common_small_pen" : (_catalog.catalogType == "BUILDERS_CLUB" ? _catalog.imageGalleryHost + "icon_193.png" : _catalog.imageGalleryHost + _loc1_.iconName + ".png");
         }
      }
      
      private function onClickHtmlLink(param1:WindowEvent) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            class_14.log("=============== HTML LINK: " + _loc2_.link);
         }
         else
         {
            class_14.log("=============== BAD HTML LINK: " + param1.target);
         }
      }
      
      private function setElementImage(param1:String, param2:String) : void
      {
         var _loc9_:IWindow = null;
         var _loc7_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:String = null;
         var _loc6_:String = null;
         class_14.log("[Localization Catalog Widget] Set Element Image: " + [param1,param2]);
         if(_window == null)
         {
            class_14.log("[Localization Catalog Widget] Window is null! " + [param1,param2]);
            return;
         }
         if(_window.disposed)
         {
            class_14.log("[Localization Catalog Widget] Window is disposed! " + [param1,param2,_window.name]);
            return;
         }
         if(param1 == "catalog.header.image")
         {
            _loc9_ = _catalog.mainContainer.findChildByName(param1);
         }
         else
         {
            _loc9_ = _window.findChildByName(param1);
         }
         if(_loc9_ is IBitmapWrapperWindow)
         {
            if((_loc7_ = page.viewer.catalog.assets.getAssetByName(param2) as BitmapDataAsset) == null)
            {
               class_14.log("[Localization Catalog Widget] Asset does not exist (Bitmap window): " + [param1,param2]);
               return;
            }
            _loc4_ = _loc7_.content as BitmapData;
            if((_loc9_ as IBitmapWrapperWindow).bitmap == null)
            {
               (_loc9_ as IBitmapWrapperWindow).bitmap = new BitmapData(_loc9_.width,_loc9_.height,true,16777215);
            }
            (_loc9_ as IBitmapWrapperWindow).bitmap.fillRect((_loc9_ as IBitmapWrapperWindow).bitmap.rect,16777215);
            _loc3_ = (_loc9_.width - _loc4_.width) / 2;
            _loc5_ = (_loc9_.height - _loc4_.height) / 2;
            (_loc9_ as IBitmapWrapperWindow).bitmap.copyPixels(_loc4_,_loc4_.rect,new Point(_loc3_,_loc5_),null,null,true);
         }
         else if(_loc9_ is IStaticBitmapWrapperWindow)
         {
            _loc6_ = (_loc8_ = _catalog.getProperty("image.library.catalogue.url")) + param2 + ".gif";
            class_14.log("[Localization Catalog Widget] Static Image: " + _loc6_);
            (_loc9_ as IStaticBitmapWrapperWindow).assetUri = _loc6_;
         }
         else
         {
            class_14.log("[Localization Catalog Widget] Could not find element: " + param1);
         }
      }
      
      private function retrieveCatalogImage(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc9_:IWindow = null;
         var _loc6_:String = (page.viewer.catalog as HabboCatalog).getProperty("image.library.catalogue.url");
         var _loc2_:String = (page.viewer.catalog as HabboCatalog).getProperty("image.library.url") + "Top_Story_Images/";
         var _loc8_:String;
         if((_loc8_ = String(var_2770[param1])) == "catalog.header.image")
         {
            _loc9_ = _catalog.mainContainer.findChildByName(_loc8_);
         }
         else
         {
            _loc9_ = _window.findChildByName(_loc8_);
         }
         if(_loc9_ && _loc9_.tags.indexOf("TOP_STORY") > -1)
         {
            _loc5_ = _loc2_;
         }
         else
         {
            _loc5_ = _loc6_;
         }
         var _loc7_:String = _loc5_ + param1 + ".gif";
         class_14.log("[Localization Catalog Widget]  : " + _loc7_);
         var _loc3_:URLRequest = new URLRequest(_loc7_);
         var _loc4_:AssetLoaderStruct;
         (_loc4_ = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc3_,"image/gif")).addEventListener("AssetLoaderEventComplete",onCatalogImageReady);
      }
      
      private function onCatalogImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.assetName;
            _loc4_ = String(var_2770[_loc2_]);
            setElementImage(_loc4_,_loc2_);
         }
      }
      
      private function setLinkStyle(param1:ITextWindow) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc6_:StyleSheet = new StyleSheet();
         var _loc2_:Object = {};
         _loc2_.color = "#336a95";
         var _loc3_:Object = {};
         _loc3_.textDecoration = "underline";
         _loc3_.color = "#333333";
         var _loc5_:Object;
         (_loc5_ = {}).color = "#41b7d9";
         var _loc4_:Object;
         (_loc4_ = {}).textDecoration = "underline";
         _loc6_.setStyle("a:link",_loc3_);
         _loc6_.setStyle("a:hover",_loc2_);
         _loc6_.setStyle("a:active",_loc5_);
         _loc6_.setStyle(".visited",_loc4_);
         param1.styleSheet = _loc6_;
      }
   }
}
