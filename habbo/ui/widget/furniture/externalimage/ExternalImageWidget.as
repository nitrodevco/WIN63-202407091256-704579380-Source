package com.sulake.habbo.ui.widget.furniture.externalimage
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3404;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.inventory.items.class_3393;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.ExternalImageWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.AlertDialogCaption;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   import com.sulake.room.object.IRoomObject;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import adobe.serialization.json.JSONDecoder;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class ExternalImageWidget extends RoomWidgetBase
   {
      
      private static const TYPE_PHOTO_POSTER:String = "photo_poster";
      
      private static const TYPE_SELFIE:String = "selfie";
      
      private static const TYPE_LEGACY:String = "legacy";
      
      private static const HORIZONTAL_ITEM_SPACING:int = 10;
      
      private static const VERTICAL_SPACE:int = 71;
       
      
      private var _window:IWindowContainer;
      
      private var var_1743:IBitmapWrapperWindow;
      
      private var _moderationText:class_3404;
      
      private var _makeOwnButton:IWindow;
      
      private var var_175:IWindow;
      
      private var var_3457:IWindowContainer;
      
      private var _bgBorder:IWindow;
      
      private var _buttonContainer:IWindowContainer;
      
      private var _shareArea:IWindowContainer;
      
      private var _shareButton:IWindow;
      
      private var _senderNameButton:IRegionWindow;
      
      private var var_3707:ILabelWindow;
      
      private var var_2664:TextField;
      
      private var var_3389:ILabelWindow;
      
      private var var_3001:BitmapFileLoader;
      
      private var var_3614:Bitmap;
      
      private var _inventory:class_1814;
      
      private var var_2773:int;
      
      private var var_2815:String;
      
      private var _caption:String;
      
      private var var_779:int;
      
      private var var_2457:String;
      
      private var var_3746:IWindowContainer;
      
      private var var_2432:String;
      
      private var var_4985:IBitmapWrapperWindow;
      
      private var _habboHelp:IHabboHelp;
      
      private var _roomEngine:IRoomEngine;
      
      private var reportWindow:IWindowContainer;
      
      private var var_1959:int = 0;
      
      private var var_3644:Boolean = false;
      
      private var var_1660:Component;
      
      public function ExternalImageWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:class_1814, param6:IHabboHelp, param7:IRoomEngine, param8:Component)
      {
         var _loc9_:class_3431 = null;
         super(param1,param2,param3,param4);
         _window = param2.buildFromXML(param3.getAssetByName("stories_image_widget_xml").content as XML) as IWindowContainer;
         ownHandler.widget = this;
         var_175 = _window.findChildByName("closebutton") as IWindow;
         var_1743 = _window.findChildByName("imageLoader") as IBitmapWrapperWindow;
         _moderationText = _window.findChildByName("moderationText") as class_3404;
         _moderationText.addEventListener("WE_LINK",onClickModerationInfoLink);
         _shareArea = _window.findChildByName("shareArea") as IWindowContainer;
         var_3457 = _window.findChildByName("removeButtonContainer") as IWindowContainer;
         _makeOwnButton = _window.findChildByName("makeOwnButton") as IWindow;
         _shareButton = _window.findChildByName("shareButtonContainer") as IWindow;
         _bgBorder = _window.findChildByName("bgBorder") as IWindow;
         _senderNameButton = _window.findChildByName("senderNameButton") as IRegionWindow;
         var_3707 = _window.findChildByName("senderName") as ILabelWindow;
         var_2664 = new TextField();
         if(ownHandler.container.roomSession.roomControllerLevel == 5)
         {
            _loc9_ = _window.findChildByName("name_copy_wrapper") as class_3431;
            var_2664.textColor = 10061943;
            var_2664.text = "";
            _loc9_.setDisplayObject(var_2664);
         }
         var_3389 = _window.findChildByName("creationDate") as ILabelWindow;
         _buttonContainer = _window.findChildByName("buttonContainer") as IWindowContainer;
         _inventory = param5;
         _habboHelp = param6;
         _roomEngine = param7;
         var_3746 = _window.findChildByName("reportButtonContainer") as IWindowContainer;
         _window.procedure = onWindowEvent;
         _window.center();
         _shareArea.visible = false;
         var_1660 = param8;
         hide();
      }
      
      private function get ownHandler() : ExternalImageWidgetHandler
      {
         return var_1653 as ExternalImageWidgetHandler;
      }
      
      public function showWithRoomObject(param1:IRoomObject) : void
      {
         var_2773 = param1.getId();
         var_2432 = param1.getType();
         var_3644 = false;
         var_3457.visible = ownHandler.hasRightsToRemove();
         if(getType() == "photo_poster")
         {
            var_3746.visible = true;
         }
         else
         {
            var_3746.visible = ownHandler.isSelfieReportingEnabled();
         }
         show(param1.getModel().getString("furniture_data"));
         var _loc2_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc2_.indexOf(param1) != -1)
         {
            var_1959 = _loc2_.indexOf(param1);
         }
      }
      
      public function showWithFurniID(param1:int) : void
      {
         var _loc2_:class_3393 = _inventory.getWallItemById(param1);
         if(_loc2_)
         {
            var_2773 = param1;
            var_2432 = _roomEngine.getWallItemType(_loc2_.type);
            var_3644 = true;
            var_3457.visible = false;
            var_3746.visible = false;
            show(_loc2_.stuffData.getLegacyString());
         }
      }
      
      private function show(param1:String) : void
      {
         if(ownHandler.storiesImageUrlBase == "disabled")
         {
            return;
         }
         clearImage();
         if(param1 != null)
         {
            readFurniJson(param1);
         }
      }
      
      private function showNext() : void
      {
         var _loc1_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc1_.length > 0)
         {
            var_1959++;
            if(var_1959 > _loc1_.length - 1)
            {
               var_1959 = 0;
            }
            showWithRoomObject(_loc1_[var_1959]);
         }
      }
      
      private function showPrevious() : void
      {
         var _loc1_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc1_.length > 0)
         {
            var_1959--;
            if(var_1959 < 0)
            {
               var_1959 = _loc1_.length - 1;
            }
            showWithRoomObject(_loc1_[var_1959]);
         }
      }
      
      private function getWallItemsOfCurrentTypeInRoom() : Vector.<IRoomObject>
      {
         var _loc2_:Vector.<IRoomObject> = new Vector.<IRoomObject>();
         var _loc3_:Array = _roomEngine.getObjectsByCategory(20);
         for each(var _loc1_ in _loc3_)
         {
            if(_loc1_.getType() == var_2432)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      private function clearImage() : void
      {
         var_2815 = null;
         _caption = "";
         var _loc1_:ITextWindow = _window.findChildByName("captionText") as ITextWindow;
         _loc1_.text = "";
         _senderNameButton.visible = false;
         var_779 = 0;
         var_3707.caption = "";
         var_2664.text = "";
         var_3389.caption = "";
         var_2457 = null;
         _moderationText.visible = false;
         drawImage(new Bitmap(new BitmapData(var_1743.width - 2,var_1743.height - 2,false,0)));
      }
      
      private function readFurniJson(param1:String) : void
      {
         try
         {
            var_2815 = new JSONDecoder(param1,false).getValue().id;
            if(var_2815)
            {
               loadExternalData();
               return;
            }
            loadPhoto(param1,getImageUrl(new JSONDecoder(param1,false).getValue()));
         }
         catch(error:Error)
         {
         }
      }
      
      private function getImageUrl(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = getJsonValue(param1,"w","url");
         if(_loc2_.indexOf("http") != 0)
         {
            _loc3_ = "postcards/selfie/";
            if(getType() == "photo_poster")
            {
               _loc3_ = "";
            }
            if(_loc2_.indexOf(".png") == -1)
            {
               _loc2_ += ".png";
            }
            _loc2_ = ownHandler.storiesImageUrlBase + _loc3_ + _loc2_;
         }
         return _loc2_;
      }
      
      private function loadPhoto(param1:String, param2:String) : void
      {
         var _loc8_:Object = null;
         var _loc3_:IWindow = null;
         var _loc10_:String = null;
         var _loc7_:ITextWindow = null;
         try
         {
            _loc8_ = new JSONDecoder(param1,false).getValue();
         }
         catch(error:Error)
         {
            return;
         }
         if(!param2)
         {
            param2 = getImageUrl(_loc8_);
         }
         var_3001 = new BitmapFileLoader("image/png",new URLRequest(param2));
         var_3001.addEventListener("AssetLoaderEventComplete",onImageLoaded);
         var _loc4_:String = getJsonValue(_loc8_,"n","creator_name");
         var _loc5_:String = getJsonValue(_loc8_,"s","creator_id");
         var _loc11_:String = getJsonValue(_loc8_,"u","unique_id");
         var _loc6_:String = getJsonValue(_loc8_,"t","time");
         var _loc9_:Date = new Date(Number(_loc6_));
         if(_loc4_)
         {
            var_3707.caption = _loc4_;
            _senderNameButton.visible = true;
            var_2664.text = _loc4_;
            var_779 = int(_loc5_);
            var_3389.caption = _loc9_.date + "-" + (_loc9_.month + 1) + "-" + _loc9_.fullYear;
         }
         if(ownHandler.storiesImageShareUrl && ownHandler.storiesImageShareUrl.length > 4)
         {
            _loc3_ = _window.findChildByName("urlField") as IWindow;
            _loc10_ = ownHandler.storiesImageShareUrl.replace("%id%",_loc11_);
            _loc3_.caption = _loc10_;
            var_2457 = _loc10_;
         }
         _caption = getJsonValue(_loc8_,"m","caption");
         if(_caption)
         {
            (_loc7_ = _window.findChildByName("captionText") as ITextWindow).text = _caption;
         }
      }
      
      private function getJsonValue(param1:Object, param2:String, param3:String = null) : String
      {
         var _loc4_:String = null;
         if(!(_loc4_ = String(param1[param2])) && param3)
         {
            _loc4_ = String(param1[param3]);
         }
         return _loc4_;
      }
      
      private function onImageLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:Bitmap = null;
         if(var_3001)
         {
            _loc2_ = var_3001.content as Bitmap;
            if(_loc2_)
            {
               var_1743.width = _loc2_.width + 2;
               var_1743.height = _loc2_.height + 2;
               drawImage(_loc2_);
            }
         }
      }
      
      private function drawImage(param1:Bitmap) : void
      {
         var_3614 = param1;
         var_1743.bitmap = new BitmapData(var_1743.width,var_1743.height,true,0);
         _window.visible = true;
         var _loc3_:IWindow = _window.findChildByName("previousButton");
         var _loc2_:IWindow = _window.findChildByName("nextButton");
         _loc3_.x = 10;
         _bgBorder.y = _bgBorder.x = 0;
         var_1743.x = 10 * 2 + _loc3_.width;
         var_1743.y = 71;
         _bgBorder.height = _window.height = var_1743.height + 71 * 2;
         _bgBorder.width = _window.width = var_1743.width + 10 * 4 + _loc3_.width * 2;
         _senderNameButton.x = var_1743.right - _senderNameButton.width - 3;
         _senderNameButton.y = var_1743.bottom + 3;
         var_3389.x = var_1743.x + 3;
         var_3389.y = _senderNameButton.y = var_1743.bottom;
         _buttonContainer.y = 0;
         _buttonContainer.x = _bgBorder.right - _buttonContainer.width;
         _loc2_.x = var_1743.right + 10;
         if(var_3644)
         {
            _loc2_.visible = _loc3_.visible = false;
         }
         else
         {
            _loc2_.visible = _loc3_.visible = getWallItemsOfCurrentTypeInRoom().length > 1;
         }
         var _loc4_:Matrix = new Matrix();
         var _loc5_:ColorTransform;
         (_loc5_ = new ColorTransform()).color = 0;
         _loc4_.ty += 1;
         var_1743.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.tx += 1;
         _loc4_.ty -= 1;
         var_1743.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.ty += 2;
         var_1743.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.ty -= 1;
         _loc4_.tx += 1;
         var_1743.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.tx -= 1;
         var_1743.bitmap.draw(param1,_loc4_);
         _window.activate();
         updateWindowPosition();
      }
      
      private function loadExternalData() : void
      {
         var _loc2_:String = ownHandler.extraDataServiceUrl + var_2815;
         var _loc1_:URLLoader = new URLLoader(new URLRequest(_loc2_));
         _loc1_.addEventListener("httpStatus",onExternalDataHttpStatus);
         _loc1_.addEventListener("complete",onExternalDataLoaded);
         _loc1_.addEventListener("ioError",onExternalDataError);
      }
      
      private function onExternalDataHttpStatus(param1:HTTPStatusEvent) : void
      {
         if(param1.status == 403 && ownHandler.hasRightsToRemove())
         {
            _moderationText.visible = true;
         }
      }
      
      private function onExternalDataError(param1:Event) : void
      {
         if(!_moderationText.visible)
         {
            class_14.log("Extra data loading failed: " + param1.toString());
         }
      }
      
      private function onExternalDataLoaded(param1:Event) : void
      {
         var _loc2_:String = String(URLLoader(param1.target).data);
         if(_loc2_.length == 0)
         {
            return;
         }
         loadPhoto(_loc2_,null);
      }
      
      override public function dispose() : void
      {
         if(!_window)
         {
            return;
         }
         var_1743 = null;
         var_175 = null;
         _bgBorder = null;
         _makeOwnButton = null;
         var_3457 = null;
         var_3001 = null;
         _inventory = null;
         _habboHelp = null;
         _roomEngine = null;
         var_779 = 0;
         _senderNameButton = null;
         var_2664 = null;
         _buttonContainer = null;
         _shareArea = null;
         _window.procedure = null;
         _window.dispose();
         var_1660 = null;
         super.dispose();
         if(reportWindow)
         {
            reportWindow.destroy();
         }
      }
      
      public function hide() : void
      {
         _window.visible = false;
      }
      
      private function updateWindowPosition() : void
      {
         if(!var_3614)
         {
            _window.center();
            return;
         }
         var _loc5_:Stage;
         var _loc1_:Number = ((_loc5_ = var_1660.context.displayObjectContainer.stage).stageWidth - 100) / var_3614.width;
         var _loc3_:Number = (_loc5_.stageHeight - 200) / var_3614.height;
         if(_loc1_ < 1)
         {
            _window.x = 50;
         }
         else
         {
            _window.x = (_loc5_.stageWidth - _window.width) * 0.5;
         }
         if(_loc3_ < 1)
         {
            _window.y = 50;
         }
         else
         {
            _window.y = (_loc5_.stageHeight - _window.height) * 0.5;
         }
         var _loc4_:IWindow = _window.findChildByName("previousButton");
         var _loc2_:IWindow = _window.findChildByName("nextButton");
         var _loc6_:int = int(var_1660.context.displayObjectContainer.stage.stageHeight);
         if(_bgBorder.height > _loc6_)
         {
            _loc4_.y = _loc2_.y = _loc6_ / 2 - _loc4_.height / 2;
         }
         else
         {
            _loc4_.y = _loc2_.y = _bgBorder.height / 2 - _loc4_.height / 2;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:class_3441 = null;
         var _loc4_:HabboToolbarEvent = null;
         var _loc5_:ITextFieldWindow = null;
         if(param2 == _window)
         {
            var _loc6_:* = param1.type;
            if("WE_PARENT_RESIZED" === _loc6_)
            {
               updateWindowPosition();
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "closebutton":
               hide();
               break;
            case "removebutton":
               _loc3_ = windowManager.confirm(var_44.getLocalization("inventory.remove.external_image_wallitem_header"),var_44.getLocalization("inventory.remove.external_image_wallitem_body"),0,onDeleteConfirm);
               _loc3_.setButtonCaption(16,new AlertDialogCaption(var_44.getLocalization("inventory.remove.external_image_wallitem_delete"),"",true));
               break;
            case "makeOwnButton":
               if(getType() == "photo_poster")
               {
                  (_loc4_ = new HabboToolbarEvent("HTE_ICON_CAMERA")).iconName = "imageWidgetMakeOwn";
                  ownHandler.container.toolbar.events.dispatchEvent(_loc4_);
                  hide();
               }
               else if(var_1660.getInteger("spaweb",0) == 1)
               {
                  HabboWebTools.openPage("/stories/cards/selfie/edit");
               }
               else
               {
                  var_1660.context.createLinkEvent("games/play/elisa_habbo_stories?ref=btn_selfie_myo");
               }
               break;
            case "shareButton":
               _shareArea.visible = true;
               HabboTracking.getInstance().trackEventLog("Stories","shareopened","stories.share.clicked",var_2432);
               break;
            case "twitterShare":
               navigateToURL(new URLRequest("http://www.twitter.com/share?url=" + var_2457),"_blank");
               HabboTracking.getInstance().trackEventLog("Stories","twitter","stories.share.clicked",var_2432);
               break;
            case "fbShare":
               navigateToURL(new URLRequest("https://www.facebook.com/sharer/sharer.php?u=" + var_2457),"_blank");
               HabboTracking.getInstance().trackEventLog("Stories","facebook","stories.share.clicked",var_2432);
               break;
            case "senderNameButton":
               ownHandler.sendMessage(new GetExtendedProfileMessageComposer(var_779));
               break;
            case "urlField":
               (_loc5_ = _window.findChildByName("urlField") as ITextFieldWindow).setSelection(0,_loc5_.length);
               HabboTracking.getInstance().trackEventLog("Stories","fieldselected","stories.share.clicked",var_2432);
               break;
            case "reportButton":
               openReportImage();
               break;
            case "nextButton":
               showNext();
               break;
            case "previousButton":
               showPrevious();
         }
      }
      
      private function onClickModerationInfoLink(param1:WindowLinkEvent) : void
      {
         if(param1 != null && !StringUtil.isBlank(param1.link))
         {
            navigateToURL(new URLRequest(param1.link),"_blank");
         }
      }
      
      private function openReportImage() : void
      {
         _habboHelp.startPhotoReportingInNewCfhFlow(var_779,var_3707.caption,var_2815,var_2773);
      }
      
      private function getType() : String
      {
         switch(var_2432)
         {
            case "external_image_wallitem_poster":
            case "external_image_wallitem_poster_small":
               break;
            case "external_image_wallitem":
               return "selfie";
            default:
               return "legacy";
         }
         return "photo_poster";
      }
      
      private function onReportWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         var _loc9_:IWindow = null;
         var _loc8_:ISelectableWindow = null;
         var _loc6_:String = null;
         var _loc4_:IWindow = null;
         var _loc7_:IIlluminaInputWidget = null;
         var _loc5_:Boolean = false;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               reportWindow.destroy();
               break;
            case "report_confirm":
               _loc3_ = 0;
               if((_loc9_ = reportWindow.findChildByName("reporting_reason")) != null)
               {
                  if((_loc8_ = ISelectorWindow(_loc9_).getSelected()) != null)
                  {
                     _loc3_ = int(_loc8_.name);
                  }
               }
               _loc6_ = null;
               if((_loc4_ = reportWindow.findChildByName("input_widget")) != null)
               {
                  _loc6_ = (_loc7_ = (_loc4_ as IWidgetWindow).widget as IIlluminaInputWidget).message;
               }
               if(!var_2457)
               {
                  var_2457 = "url not available";
               }
               if(getType() == "photo_poster")
               {
                  _loc5_ = _habboHelp.reportPhoto(var_2815,_loc3_,_roomEngine.activeRoomId,var_779,var_2773);
               }
               else
               {
                  _loc5_ = _habboHelp.reportSelfie(var_2457,_loc6_,_roomEngine.activeRoomId,var_779,var_2773);
               }
               if(_loc5_)
               {
                  reportWindow.destroy();
               }
         }
      }
      
      private function onDeleteConfirm(param1:class_3441, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            ownHandler.deleteCard(var_2773);
         }
      }
   }
}
