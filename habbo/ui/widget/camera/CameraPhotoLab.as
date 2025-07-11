package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.images.class_3362;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.quest.class_2197;
   import com.sulake.habbo.tracking.HabboTracking;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.globalization.DateTimeFormatter;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import com.sulake.habbo.communication.messages.incoming.camera.class_473;
   import com.sulake.habbo.communication.messages.incoming.camera.class_532;
   
   public class CameraPhotoLab implements IDisposable
   {
      
      private static var TEXT_WIDTH_MARGIN:int = 6;
      
      private static var var_1816:PhotoPurchaseConfirmationDialog;
       
      
      private var var_1629:CameraWidget;
      
      private var _window:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_1785:IBitmapWrapperWindow;
      
      private var var_3478:BitmapData;
      
      private var var_2092:CameraFxStrengthSlider;
      
      private var _sliderEffectInfo:ITextWindow;
      
      private var var_1852:CameraEffect;
      
      private var var_1939:Map;
      
      private var _itemGrid:IScrollableGridWindow;
      
      private var var_3430:Sprite;
      
      private var var_3061:Map;
      
      private var _captionInputKeyEvents:int = 0;
      
      private var var_4746:String = "";
      
      private var var_3636:Boolean = false;
      
      private var var_117:FileReference;
      
      public function CameraPhotoLab(param1:CameraWidget)
      {
         var_1939 = new Map();
         var_3061 = new Map();
         var_117 = new FileReference();
         super();
         var_1629 = param1;
      }
      
      public static function preloadEffects(param1:String, param2:String, param3:IHabboLocalizationManager) : void
      {
         var _loc5_:Array = [];
         var _loc4_:Map = CameraEffect.getEffects(param2,param3);
         for each(var _loc6_ in _loc4_)
         {
            if(_loc6_.type == "composite" || _loc6_.type == "frame")
            {
               _loc5_.push(_loc6_.name);
            }
         }
         CameraFxPreloader.init(param1,_loc5_);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_1816)
         {
            var_1816.hide();
         }
         CameraEffect.resetAllEffects();
         var_3478 = null;
         var_1629 = null;
         var_1785 = null;
         if(var_2092 != null)
         {
            var_2092.dispose();
            var_2092 = null;
         }
         _sliderEffectInfo = null;
         var_1852 = null;
         var_1939 = null;
         var_3061 = null;
         _disposed = true;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function setImageAndFilterButtons(param1:BitmapData) : void
      {
         var_3478 = param1.clone();
         var_1785.bitmap = param1;
         buildFilterButtons();
      }
      
      internal function setSelectedFxValue(param1:Number) : void
      {
         if(var_1852)
         {
            var_1852.value = param1;
            updateSliderEffectInfo();
            renderAllEffects();
         }
      }
      
      private function updateSliderEffectInfo() : void
      {
         _sliderEffectInfo.text = var_1852.description + " " + int(var_1852.getEffectStrength() * 100) + "%";
         _sliderEffectInfo.width = _sliderEffectInfo.textWidth + TEXT_WIDTH_MARGIN;
      }
      
      internal function setCaptionText(param1:String) : void
      {
         ITextWindow(_window.findChildByName("captionInput")).text = param1;
      }
      
      private function buildTypeButtons() : void
      {
         var _loc5_:int = 0;
         _loc5_ = 6;
         var _loc3_:int = 0;
         _loc3_ = 2;
         if(var_3061.length > 0)
         {
            return;
         }
         var _loc1_:int = (_window as class_3514).margins.left + _itemGrid.x;
         var _loc2_:IWindowContainer = createTypeButton("colormatrix","camera_icon_colorfilter");
         _loc2_.x = _loc1_ + (_itemGrid.width - (2 * (_loc2_.width + 6) - 6)) / 2;
         _loc2_.y = 50;
         _window.addChild(_loc2_);
         var _loc4_:IWindowContainer;
         (_loc4_ = createTypeButton("composite","camera_icon_compositefilter")).x = _loc2_.right + 6;
         _loc4_.y = _loc2_.y;
         _window.addChild(_loc4_);
      }
      
      private function buildFilterButtons() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc5_:String = null;
         if(CameraFxPreloader.preloadFinished() == false)
         {
            setTimeout(buildFilterButtons,200);
         }
         var _loc6_:int = 0;
         var _loc7_:class_2197;
         if((_loc7_ = var_1629.handler.roomDesktop.questEngine) != null)
         {
            if((_loc6_ = _loc7_.getAchievementLevel("explore","ACH_CameraPhotoCount")) == 0)
            {
               _loc6_ = _loc7_.getAchievementLevel("archive","ACH_CameraPhotoCount");
            }
         }
         var _loc2_:Map = CameraEffect.getEffects(var_1629.component.getProperty("camera.available.effects"),var_1629.localizations);
         for each(var _loc4_ in _loc2_)
         {
            _loc1_ = createFxButton(_loc4_,var_3478.clone(),_loc6_);
            if(_loc1_)
            {
               _loc5_ = _loc4_.description;
               if(_loc6_ < _loc4_.var_4227)
               {
                  _loc5_ = var_1629.localizations.getLocalization("camera.effect.required.level") + " " + _loc4_.var_4227;
               }
               IRegionWindow(_loc1_).toolTipCaption = _loc5_;
            }
         }
         var _loc3_:IWindowContainer = _window.findChildByName("slider_container") as IWindowContainer;
         var_2092 = new CameraFxStrengthSlider(this,_loc3_,var_1629.windowManager.assets);
         var_2092.disable();
         CameraEffect.setMaxValue(var_2092.getScale());
         setFilterType("colormatrix");
      }
      
      private function createTypeButton(param1:String, param2:String) : IWindowContainer
      {
         var _loc3_:IRegionWindow = var_1629.getXmlWindow("camera_typebutton") as IRegionWindow;
         var _loc4_:IBitmapWrapperWindow;
         (_loc4_ = _loc3_.findChildByName("icon") as IBitmapWrapperWindow).bitmap = (var_1629.windowManager.assets.getAssetByName(param2).content as BitmapData).clone();
         _loc3_.name = "typebutton," + param1;
         _loc3_.toolTipCaption = param1;
         var_3061.add(param1,_loc3_);
         return _loc3_;
      }
      
      private function createFxButton(param1:CameraEffect, param2:BitmapData, param3:int) : IWindowContainer
      {
         var _loc7_:IBitmapWrapperWindow = null;
         var _loc5_:Number = NaN;
         var _loc8_:Matrix = null;
         var _loc9_:Bitmap = null;
         var _loc6_:IWindow = null;
         var _loc4_:IWindowContainer = var_1629.getXmlWindow("camera_filterbutton") as IWindowContainer;
         if(param3 >= param1.var_4227)
         {
            (_loc7_ = _loc4_.findChildByName("content") as IBitmapWrapperWindow).bitmap = new BitmapData(_loc7_.width,_loc7_.height,true,0);
            _loc5_ = _loc7_.width / param2.width;
            (_loc8_ = new Matrix()).scale(_loc5_,_loc5_);
            _loc9_ = new Bitmap(param2,"auto",true);
            switch(param1.type)
            {
               case "colormatrix":
                  param2.applyFilter(param2,param2.rect,new Point(0,0),param1.getColorMatrixFilter(true));
                  break;
               case "composite":
                  if(CameraFxPreloader.getImage(param1.name) == null)
                  {
                     return null;
                  }
                  param2.draw(CameraFxPreloader.getImage(param1.name),null,null,param1.var_4861,null,true);
                  break;
               case "frame":
                  if(CameraFxPreloader.getImage(param1.name) == null)
                  {
                     return null;
                  }
                  param2.draw(CameraFxPreloader.getImage(param1.name),null,null,null,null,true);
                  break;
            }
            _loc7_.bitmap.draw(_loc9_,_loc8_,null,null,null,true);
            _loc4_.procedure = effectButtonClick;
         }
         else
         {
            (_loc6_ = _loc4_.findChildByName("lock_indicator") as IWindow).visible = true;
         }
         _loc4_.name = param1.name;
         param1.button = _loc4_;
         var_1939[_loc4_.name] = param1;
         return _loc4_;
      }
      
      public function openPhotoLab(param1:BitmapData) : void
      {
         _window = var_1629.getXmlWindow("camera_editor") as IWindowContainer;
         _window.center();
         if(var_1629.component.getProperty("camera.effects.enabled") != "true")
         {
            openPurchaseConfirmationDialog(null);
            return;
         }
         _itemGrid = _window.findChildByName("item_grid") as IScrollableGridWindow;
         _itemGrid.spacing = 7;
         var_1785 = _window.findChildByName("image") as IBitmapWrapperWindow;
         _window.procedure = windowEventHandler;
         var _loc10_:ITextWindow;
         (_loc10_ = ITextWindow(_window.findChildByName("captionInput"))).procedure = captionProcedure;
         var _loc6_:class_3431 = _window.findChildByName("purchase_display_object") as class_3431;
         var_3430 = new Sprite();
         var_3430.graphics.beginFill(16711680,0);
         var_3430.graphics.drawRect(0,0,_loc6_.width,_loc6_.height);
         _loc6_.setDisplayObject(var_3430);
         var_3430.addEventListener("click",openPurchaseConfirmationDialog);
         var _loc11_:class_3437;
         var _loc7_:IRegionWindow;
         var _loc5_:ITextWindow = (_loc11_ = (_loc7_ = _window.findChildByName("zoom_button") as IRegionWindow).getChildByName("centerizer") as class_3437).getChildByName("zoom_text") as ITextWindow;
         _loc5_.width = _loc5_.textWidth + TEXT_WIDTH_MARGIN;
         var _loc4_:class_3437;
         var _loc8_:IRegionWindow;
         var _loc9_:ITextWindow = (_loc4_ = (_loc8_ = _window.findChildByName("save_button") as IRegionWindow).getChildByName("centerizer") as class_3437).getChildByName("save_text") as ITextWindow;
         _loc9_.width = _loc9_.textWidth + TEXT_WIDTH_MARGIN;
         var _loc2_:class_3431 = _window.findChildByName("save_click_catcher") as class_3431;
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680,0);
         _loc3_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc2_.setDisplayObject(_loc3_);
         _loc3_.addEventListener("click",offerSaveAsFile);
         buildTypeButtons();
         setImageAndFilterButtons(param1);
         _sliderEffectInfo = _window.findChildByName("slider_effect_info") as ITextWindow;
         CameraEffect.resetAllEffects();
      }
      
      private function effectButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:CameraEffect = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2.name == "remove_effect_button")
         {
            if(var_1939.hasKey(param2.parent.name))
            {
               _loc3_ = var_1939[param2.parent.name];
               _loc3_.setChosen(false);
               if(var_1852 == _loc3_)
               {
                  var_2092.disable();
                  var_1852 = null;
               }
               renderAllEffects();
               return;
            }
         }
         if(var_1939.hasKey(param2.name))
         {
            setActiveEffect(var_1939[param2.name]);
         }
      }
      
      private function captionProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WKE_KEY_DOWN")
         {
            if(WindowKeyboardEvent(param1).ctrlKey || WindowKeyboardEvent(param1).charCode == 0)
            {
               _captionInputKeyEvents = 0;
            }
            else
            {
               _captionInputKeyEvents++;
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _captionInputKeyEvents = 0;
         }
         else if(param1.type == "WE_CHANGE")
         {
            if(_captionInputKeyEvents == 1)
            {
               var_4746 = ITextWindow(_window.findChildByName("captionInput")).text;
            }
            else
            {
               setCaptionText(var_4746);
            }
            _captionInputKeyEvents = 0;
         }
      }
      
      private function openPurchaseConfirmationDialog(param1:MouseEvent) : void
      {
         if(var_1816)
         {
            var_1816.hide();
         }
         if(var_1629.container.sessionDataManager.isAccountSafetyLocked())
         {
            var_1629.windowManager.alert("${generic.alert.title}","${notifications.text.safety_locked}",0,null);
            if(var_1629.component.getProperty("camera.effects.enabled") != "true")
            {
               dispose();
            }
            return;
         }
         var_1816 = new PhotoPurchaseConfirmationDialog(var_1629,ITextWindow(_window.findChildByName("captionInput")).text);
         var _loc2_:Boolean = var_1629.sendPhotoData();
         var_1816.setPrices(var_1629.handler.creditPrice,var_1629.handler.ducketPrice,var_1629.handler.publishDucketPrice);
         HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.purchase_dialog_opened");
         if(!_loc2_)
         {
            var_1816.setRenderingFailed();
            var_1629.windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
         }
         hide();
      }
      
      public function hide() : void
      {
         _window.visible = false;
      }
      
      public function show() : void
      {
         _window.visible = true;
      }
      
      public function closePurchaseConfirmation() : void
      {
         if(var_1816)
         {
            var_1816.hide();
            var_1816 = null;
         }
      }
      
      internal function animateSuccessfulPurchase() : void
      {
         if(var_1816)
         {
            var_1816.animateIconToToolbar();
         }
      }
      
      public function publishingStatus(param1:class_473) : void
      {
         if(var_1816)
         {
            var_1816.publishingStatus(param1);
         }
      }
      
      public function competitionStatus(param1:class_532) : void
      {
         if(var_1816)
         {
            var_1816.competitionStatus(param1);
         }
      }
      
      private function offerSaveAsFile(param1:MouseEvent) : void
      {
         var _loc2_:DateTimeFormatter = null;
         var _loc4_:String = null;
         var _loc3_:BitmapData = var_1785.bitmap.clone();
         var _loc5_:ByteArray = class_3362.encode(_loc3_);
         try
         {
            _loc2_ = new DateTimeFormatter("i-default");
            _loc2_.setDateTimePattern("yyyy-MM-dd_HH-mm-ss");
            _loc4_ = "Habbo_" + _loc2_.format(new Date()) + ".png";
            var_117.save(_loc5_,_loc4_);
         }
         catch(error:Error)
         {
         }
      }
      
      public function logChosenEffects() : void
      {
         for each(var _loc1_ in var_1939)
         {
            if(_loc1_.isOn)
            {
               HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.effect.chosen",_loc1_.name);
            }
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "cancel_button":
               var_1629.startTakingPhoto("effectEditorCancel");
               dispose();
               break;
            case "header_button_close":
               dispose();
               break;
            case "help_button":
               var_1629.component.context.createLinkEvent("habbopages/camera");
               break;
            case "save_button":
            case "slider_container":
               break;
            case "zoom_button":
               var_3636 = !var_3636;
               renderAllEffects();
               break;
            default:
               var_2092.disable();
               if(var_1852 != null)
               {
                  var_1852.turnOffHighlight();
               }
         }
         if(param2.name.indexOf("typebutton") != -1)
         {
            setFilterType(param2.name.split(",")[1]);
         }
      }
      
      private function setActiveEffect(param1:CameraEffect) : void
      {
         if(var_1852 != null)
         {
            var_1852.turnOffHighlight();
         }
         var_1852 = param1;
         var_1852.setChosen(true);
         if(param1.usesEffectStrength())
         {
            var_2092.enable();
            var_2092.setValue(param1.value);
            updateSliderEffectInfo();
         }
         else
         {
            var_2092.disable();
         }
         if(param1.allowsOnlyOneInstance())
         {
            turnOffOtherEffectsOfSameType(param1);
         }
         renderAllEffects();
      }
      
      private function turnOffOtherEffectsOfSameType(param1:CameraEffect) : void
      {
         for each(var _loc2_ in var_1939)
         {
            if(_loc2_.type == param1.type && _loc2_ != param1)
            {
               _loc2_.setChosen(false);
            }
         }
      }
      
      private function setFilterType(param1:String) : void
      {
         if(var_1852 != null)
         {
            var_1852.turnOffHighlight();
         }
         _itemGrid.removeGridItems();
         for each(var _loc2_ in var_1939)
         {
            if(_loc2_.type == param1)
            {
               _itemGrid.addGridItem(_loc2_.button);
            }
         }
         highlightSelectedButtonType(param1);
      }
      
      private function highlightSelectedButtonType(param1:String) : void
      {
         var _loc3_:IWindow = null;
         for each(var _loc2_ in var_3061)
         {
            _loc3_ = _loc2_.findChildByName("active_border");
            _loc3_.visible = _loc2_.name == "typebutton," + param1;
         }
      }
      
      private function renderAllEffects() : void
      {
         var _loc2_:ColorTransform = null;
         var _loc5_:Matrix = null;
         var _loc3_:BitmapData = null;
         var _loc1_:* = var_3478.clone();
         if(var_3636)
         {
            (_loc5_ = new Matrix()).a = 2;
            _loc5_.d = 2;
            _loc5_.tx = -_loc1_.width / 2;
            _loc5_.ty = -_loc1_.height / 2;
            _loc3_ = new BitmapData(_loc1_.width,_loc1_.height);
            _loc3_.draw(_loc1_,_loc5_);
            _loc1_ = _loc3_;
         }
         for each(var _loc4_ in var_1939)
         {
            if(_loc4_.isOn)
            {
               if(_loc4_.type == "colormatrix")
               {
                  _loc1_.applyFilter(_loc1_,_loc1_.rect,new Point(0,0),_loc4_.getColorMatrixFilter());
               }
               if(_loc4_.type == "composite")
               {
                  _loc2_ = new ColorTransform(1,1,1,_loc4_.getEffectStrength());
                  _loc1_.draw(CameraFxPreloader.getImage(_loc4_.name),null,_loc2_,_loc4_.var_4861);
               }
            }
         }
         for each(var _loc6_ in var_1939)
         {
            if(_loc6_.isOn && _loc6_.type == "frame")
            {
               _loc1_.draw(CameraFxPreloader.getImage(_loc6_.name));
            }
         }
         var_1785.bitmap = _loc1_;
         var_1785.invalidate();
      }
      
      protected function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      public function setRenderedPhotoUrl(param1:String) : void
      {
         if(var_1816)
         {
            var_1816.setImageUrl(param1);
         }
      }
      
      public function getEffectDataJson() : String
      {
         var _loc2_:Object = null;
         var _loc1_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc3_ in var_1939)
         {
            if(_loc3_.isOn && _loc3_.type != "frame")
            {
               _loc2_ = {};
               _loc2_.name = _loc3_.name;
               _loc2_.alpha = int(_loc3_.getEffectStrength() * 255);
               _loc1_.push(_loc2_);
            }
         }
         for each(var _loc4_ in var_1939)
         {
            if(_loc4_.isOn && _loc4_.type == "frame")
            {
               _loc2_ = {};
               _loc2_.name = _loc4_.name;
               _loc1_.push(_loc2_);
            }
         }
         return JSON.stringify(_loc1_);
      }
      
      public function getZoom() : int
      {
         return var_3636 ? 2 : 1;
      }
   }
}
