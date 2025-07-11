package com.sulake.habbo.ui.widget.effects
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.memenu.class_3522;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class EffectView
   {
       
      
      private const UPDATE_TIMER_MS:int = 1000;
      
      private var var_1629:EffectsWidget;
      
      private var _window:IWindowContainer;
      
      private var var_1758:class_3522;
      
      private var _bar:IWindow;
      
      private var _maxWidth:Number;
      
      private var var_2043:ITextWindow;
      
      private var var_1883:Timer;
      
      private var _hilite:IWindow;
      
      public function EffectView(param1:EffectsWidget, param2:class_3522)
      {
         super();
         var_1758 = param2;
         var_1629 = param1;
         var_1883 = new Timer(1000);
         var_1883.addEventListener("timer",onUpdate);
         update();
      }
      
      public function get effect() : class_3522
      {
         return var_1758;
      }
      
      public function dispose() : void
      {
         if(var_1883 != null)
         {
            var_1883.stop();
            var_1883.removeEventListener("timer",onUpdate);
            var_1883 = null;
         }
         var_1629 = null;
         var_1758 = null;
         _bar = null;
         var_2043 = null;
         _hilite = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         if(_bar == null)
         {
            var_1883.stop();
            return;
         }
         if(var_1758.isActive)
         {
            _loc2_ = var_1758.secondsLeft / var_1758.duration;
            _bar.width = _loc2_ * _maxWidth;
         }
         else
         {
            _bar.width = 0;
            var_1883.stop();
         }
         setTimeLeft();
      }
      
      private function setTimeLeft() : void
      {
         var _loc8_:String = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         if(var_2043 == null)
         {
            var_2043 = _window.findChildByName("time_left") as ITextWindow;
            if(var_2043 == null)
            {
               return;
            }
         }
         if(!var_1758.isActive)
         {
            var_2043.caption = "${widgets.memenu.effects.activate}";
            return;
         }
         if(var_1758.secondsLeft > 86400)
         {
            var_2043.caption = "${widgets.memenu.effects.active.daysleft}";
            _loc8_ = var_2043.text;
            _loc7_ = Math.floor(var_1758.secondsLeft / 86400);
            _loc8_ = _loc8_.replace("%days_left%",_loc7_);
         }
         else
         {
            var_2043.caption = "${widgets.memenu.effects.active.timeleft}";
            _loc8_ = var_2043.text;
            _loc9_ = var_1758.secondsLeft;
            _loc1_ = Math.floor(_loc9_ / 3600);
            _loc3_ = Math.floor(_loc9_ / 60) % 60;
            _loc2_ = _loc9_ % 60;
            _loc5_ = _loc1_ < 10 ? "0" : "";
            _loc4_ = _loc3_ < 10 ? "0" : "";
            _loc6_ = _loc2_ < 10 ? "0" : "";
            if(_loc1_ > 0)
            {
               _loc8_ = _loc8_.replace("%time_left%",_loc5_ + _loc1_ + ":" + _loc4_ + _loc3_ + ":" + _loc6_ + _loc2_);
            }
            else
            {
               _loc8_ = _loc8_.replace("%time_left%",_loc4_ + _loc3_ + ":" + _loc6_ + _loc2_);
            }
         }
         var_2043.text = _loc8_;
      }
      
      public function update() : void
      {
         var _loc7_:IWindow = null;
         var _loc5_:XmlAsset = null;
         var _loc4_:class_3357 = null;
         if(!_window)
         {
            _window = var_1629.windowManager.createWindow("","",4,0,16) as IWindowContainer;
         }
         while(_window.numChildren > 0)
         {
            (_loc7_ = _window.removeChildAt(0)).dispose();
         }
         _bar = null;
         _hilite = null;
         var_2043 = null;
         var _loc2_:String = "";
         if(var_1758.isInUse)
         {
            _loc2_ = "memenu_effect_selected";
         }
         else if(var_1758.isActive)
         {
            _loc2_ = "memenu_effect_unselected";
         }
         else
         {
            _loc2_ = "memenu_effect_inactive";
         }
         _loc5_ = var_1629.assets.getAssetByName(_loc2_) as XmlAsset;
         var _loc6_:IWindowContainer = var_1629.windowManager.buildFromXML(_loc5_.content as XML) as IWindowContainer;
         _window.addChild(_loc6_);
         var _loc3_:ITextWindow = _window.findChildByName("effect_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = "${fx_" + var_1758.type + "}";
         }
         var _loc8_:ITextWindow;
         if((_loc8_ = _window.findChildByName("effect_amount") as ITextWindow) != null)
         {
            _loc8_.caption = var_1758.amountInInventory + "";
         }
         var _loc1_:IWindowContainer = _window.findChildByName("effect_amount_bg1") as IWindowContainer;
         if(var_1758.amountInInventory < 2)
         {
            if(_loc1_ != null)
            {
               _loc1_.visible = false;
            }
         }
         if(_loc2_ == "memenu_effect_inactive")
         {
            if((_loc4_ = _window.findChildByName("activate_effect") as class_3357) != null)
            {
               _loc4_.addEventListener("WME_CLICK",onMouseEvent);
            }
         }
         else
         {
            _loc6_.addEventListener("WME_CLICK",onMouseEvent);
            if(var_1758.isActive)
            {
               _loc6_.addEventListener("WME_OVER",onMouseEvent);
               _loc6_.addEventListener("WME_OUT",onMouseEvent);
            }
            if(var_1758.isInUse)
            {
               setElementImage("effect_hilite","memenu_fx_pause");
            }
            else
            {
               setElementImage("effect_hilite","memenu_fx_play");
            }
            _hilite = _window.findChildByName("effect_hilite");
            _hilite.visible = false;
         }
         setTimeLeft();
         _bar = _window.findChildByName("loader_bar");
         if(_bar != null)
         {
            _maxWidth = _bar.width;
            var_1883.start();
            onUpdate();
         }
         if(var_1758.icon)
         {
            setElementBitmap("effect_icon",var_1758.icon);
         }
         _window.rectangle = _loc6_.rectangle;
      }
      
      private function setElementBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc3_ != null)
         {
            if(_loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         switch(param1.type)
         {
            case "WME_OVER":
               if(_hilite != null)
               {
                  _hilite.visible = true;
               }
               break;
            case "WME_OUT":
               if(_hilite != null)
               {
                  _hilite.visible = false;
               }
               break;
            case "WME_CLICK":
               var_1629.selectEffect(var_1758.type,var_1758.isInUse);
         }
      }
      
      private function setElementImage(param1:String, param2:String) : void
      {
         var _loc4_:BitmapDataAsset;
         var _loc3_:BitmapData = (_loc4_ = var_1629.assets.getAssetByName(param2) as BitmapDataAsset).content as BitmapData;
         setElementBitmap(param1,_loc3_);
      }
   }
}
