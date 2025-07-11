package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   import com.sulake.habbo.inventory.common.ThumbListManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class EffectsView implements IInventoryView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2286:IAssetLibrary;
      
      private var var_1631:IWindowContainer;
      
      private var var_1644:EffectsModel;
      
      private var var_2668:ThumbListManager;
      
      private var var_2639:ThumbListManager;
      
      private var _disposed:Boolean = false;
      
      public function EffectsView(param1:EffectsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IThumbListDataProvider, param6:IThumbListDataProvider)
      {
         super();
         var_1644 = param1;
         var_2286 = param3;
         _windowManager = param2;
         var _loc9_:IAsset = var_2286.getAssetByName("inventory_effects_xml");
         var _loc7_:XmlAsset = XmlAsset(_loc9_);
         var_1631 = IWindowContainer(_windowManager.buildFromXML(XML(_loc7_.content)));
         var_1631.visible = false;
         var_1631.procedure = windowEventProc;
         var_2668 = new ThumbListManager(var_2286,param5,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         var_2639 = new ThumbListManager(var_2286,param6,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         var _loc10_:IBitmapWrapperWindow;
         (_loc10_ = var_1631.findChildByName("active_items_image") as IBitmapWrapperWindow).procedure = activeThumbListEventProc;
         var _loc8_:IBitmapWrapperWindow;
         (_loc8_ = var_1631.findChildByName("inactive_items_image") as IBitmapWrapperWindow).procedure = inactiveThumbListEventProc;
         var_1631.procedure = windowEventProc;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            var_1644 = null;
            var_1631 = null;
            if(var_2668 != null)
            {
               var_2668.dispose();
               var_2668 = null;
            }
            if(var_2639 != null)
            {
               var_2639.dispose();
               var_2639 = null;
            }
            _disposed = true;
         }
      }
      
      public function getActiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperWindow = var_1631.findChildByName("active_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getActiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperWindow = var_1631.findChildByName("active_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getInactiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperWindow = var_1631.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getInactiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperWindow = var_1631.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(var_1631 == null)
         {
            return null;
         }
         if(var_1631.disposed)
         {
            return null;
         }
         return var_1631;
      }
      
      public function updateListViews() : void
      {
         if(var_1631 == null)
         {
            return;
         }
         if(var_1631.disposed)
         {
            return;
         }
         var_2639.updateImageFromList();
         var_2668.updateImageFromList();
         var _loc2_:IBitmapWrapperWindow = var_1631.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         var _loc4_:BitmapData = var_2639.getListImage();
         _loc2_.bitmap = _loc4_;
         _loc2_.width = _loc4_.width;
         _loc2_.height = _loc4_.height;
         _loc2_.invalidate();
         var _loc3_:IBitmapWrapperWindow = var_1631.findChildByName("active_items_image") as IBitmapWrapperWindow;
         var _loc1_:BitmapData = var_2668.getListImage();
         _loc3_.bitmap = _loc1_;
         _loc3_.width = _loc1_.width;
         _loc3_.height = _loc1_.height;
         _loc3_.invalidate();
      }
      
      public function updateActionView() : void
      {
         if(var_1631 == null)
         {
            return;
         }
         if(var_1631.disposed)
         {
            return;
         }
         var _loc2_:class_3357 = var_1631.findChildByName("activateEffect_button") as class_3357;
         var _loc3_:ITextWindow = var_1631.findChildByName("effectDescriptionText") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Effect = var_1644.getSelectedEffect(-1);
         if(_loc1_ == null)
         {
            _loc2_.disable();
            setEffectDescriptionImage(null);
            _loc3_.text = "${inventory.effects.defaultdescription}";
         }
         else if(_loc1_.isActive)
         {
            _loc2_.disable();
            setEffectDescriptionImage(_loc1_.iconImage);
            _loc3_.text = "${inventory.effects.active}";
            _windowManager.registerLocalizationParameter("inventory.effects.active","timeleft",convertSecondsToTime(_loc1_.secondsLeft));
            _windowManager.registerLocalizationParameter("inventory.effects.active","duration",convertSecondsToTime(_loc1_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.active","itemcount",String(_loc1_.amountInInventory));
         }
         else
         {
            _loc2_.enable();
            setEffectDescriptionImage(_loc1_.iconImage);
            _loc3_.text = "${inventory.effects.inactive}";
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","duration",convertSecondsToTime(_loc1_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","itemcount",String(_loc1_.amountInInventory));
         }
      }
      
      private function setEffectDescriptionImage(param1:BitmapData) : void
      {
         if(var_1631 == null)
         {
            return;
         }
         if(var_1631.disposed)
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = var_1631.findChildByName("effectDescriptionImage") as IBitmapWrapperWindow;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.bitmap == null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,false);
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc3_.width,_loc3_.height);
         }
         var _loc2_:Point = new Point((_loc3_.width - param1.width) / 2,(_loc3_.height - param1.height) / 2);
         _loc3_.bitmap.copyPixels(param1,param1.rect,_loc2_,null,null,false);
         _loc3_.invalidate();
      }
      
      private function convertSecondsToTime(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 60 / 60);
         var _loc4_:int = Math.floor((param1 - _loc2_ * 60 * 60) / 60);
         var _loc3_:int = param1 - _loc2_ * 60 * 60 - _loc4_ * 60;
         var _loc5_:String = "";
         if(_loc2_ > 0)
         {
            _loc5_ = _loc2_ + ":";
         }
         _loc5_ = (_loc5_ = _loc4_ < 10 ? _loc5_ + "0" + _loc4_ : _loc5_ + _loc4_) + ":";
         return _loc3_ < 10 ? _loc5_ + "0" + _loc3_ : _loc5_ + _loc3_;
      }
      
      private function activeThumbListEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc4_:Effect = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc5_ = var_2668.resolveIndexFromImageLocation(_loc3_);
            if((_loc4_ = var_1644.getItemInIndex(_loc5_,1)) != null)
            {
               var_1644.toggleEffectSelected(_loc4_.type);
            }
         }
      }
      
      private function inactiveThumbListEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc4_:Effect = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc5_ = var_2639.resolveIndexFromImageLocation(_loc3_);
            if((_loc4_ = var_1644.getItemInIndex(_loc5_,0)) != null)
            {
               var_1644.toggleEffectSelected(_loc4_.type);
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Effect = null;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "activateEffect_button")
            {
               _loc3_ = var_1644.getSelectedEffect(0);
               if(_loc3_ != null)
               {
                  var_1644.requestEffectActivated(_loc3_.type);
               }
            }
         }
      }
   }
}
