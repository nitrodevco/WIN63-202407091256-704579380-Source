package com.sulake.habbo.ui.widget.uihelpbubbles
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3592;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UiHelpBubble
   {
       
      
      private var _window:IWindowContainer;
      
      private var var_1629:UiHelpBubblesWidget;
      
      private var var_280:String;
      
      private var var_661:Point;
      
      private var var_4827:String;
      
      private var var_3762:Boolean;
      
      private var _bubble:class_3592;
      
      private var _nextButton:class_3357;
      
      private var var_1828:IWindowContainer;
      
      private var var_4365:Boolean;
      
      private var var_3460:IBitmapWrapperWindow;
      
      private var var_3830:IWindow;
      
      private var var_4627:IWindow;
      
      private var var_2084:Function;
      
      public function UiHelpBubble(param1:UiHelpBubblesWidget, param2:HelpBubbleItem, param3:Boolean)
      {
         super();
         var_1629 = param1;
         var_280 = param2.name;
         var_4827 = param2.text;
         var_3762 = param3;
         var_4365 = param2.modal;
         createWindow();
      }
      
      public function dispose() : void
      {
         var_1629 = null;
         if(var_3830 != null && var_2084 != null)
         {
            var_3830.removeEventListener("WME_CLICK",var_2084);
         }
         if(var_1828)
         {
            var_1828.dispose();
            var_1828 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function addMouseClickListener(param1:IWindow, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(1,true);
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      private function createWindow() : void
      {
         var _loc4_:XmlAsset = null;
         var _loc1_:int = 0;
         if(!var_1629 || !var_1629.assets || !var_1629.windowManager)
         {
            return;
         }
         if(var_4365)
         {
            _loc4_ = var_1629.assets.getAssetByName("ui_help_modal") as XmlAsset;
            var_1828 = var_1629.windowManager.buildFromXML(_loc4_.content as XML,3) as IWindowContainer;
         }
         if(var_1828)
         {
            var_1828.width = var_1828.desktop.width;
            var_1828.height = var_1828.desktop.height;
            var_3460 = var_1828.findChildByName("bitmap") as IBitmapWrapperWindow;
            addMouseClickListener(var_3460,onActivateBubble);
         }
         var _loc2_:XmlAsset = var_1629.assets.getAssetByName("ui_help_bubble") as XmlAsset;
         if(!_loc2_)
         {
            return;
         }
         _window = var_1629.windowManager.buildFromXML(_loc2_.content as XML,3) as IWindowContainer;
         if(!_window)
         {
            return;
         }
         _nextButton = _window.findChildByName("help_bubble_btn_ok") as class_3357;
         _bubble = _window.findChildByName("bubble") as class_3592;
         var _loc3_:ITextWindow = _window.findChildByName("help_bubble_text") as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = var_4827;
            _loc1_ = _loc3_.textHeight;
            _window.height = _loc1_ + 90;
            _nextButton.y = _loc1_ + 30;
         }
         if(!var_3762)
         {
            _nextButton.caption = var_1629.localizations.getLocalization("alert.close.button","alert.close.button");
            addMouseClickListener(_nextButton,onLastBubble);
         }
         else
         {
            addMouseClickListener(_nextButton,onNext);
         }
         _window.visible = true;
      }
      
      public function show() : void
      {
         if(_window != null)
         {
            _window.visible = true;
            _window.activate();
         }
      }
      
      private function onActivateBubble(param1:WindowMouseEvent) : void
      {
         var_1828.deactivate();
         _window.activate();
      }
      
      private function onNext(param1:WindowMouseEvent) : void
      {
         if(!var_1629)
         {
            return;
         }
         if(var_1828)
         {
            var_1828.visible = false;
         }
         var_1629.removeHelpBubble(var_280);
      }
      
      private function onLastBubble(param1:WindowMouseEvent) : void
      {
         if(!var_1629)
         {
            return;
         }
         var_1629.sendScriptProceedMessage();
         if(var_1828)
         {
            var_1828.visible = false;
         }
         var_1629.removeHelpBubble(var_280);
      }
      
      public function setModal(param1:Rectangle) : void
      {
         if(!var_3460)
         {
            return;
         }
         var _loc3_:BitmapData = new BitmapData(var_1828.width,var_1828.height,true,4292870144);
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,16777215);
         _loc3_.copyPixels(_loc2_,_loc2_.rect,new Point(param1.x,param1.y));
         var_3460.bitmap = _loc3_;
         var_3460.invalidate();
      }
      
      public function setPosition(param1:Point) : void
      {
         var_661 = param1;
         _window.y = var_661.y;
         _window.x = var_661.x - _window.width / 2;
      }
      
      public function setArrowPos(param1:String, param2:int) : void
      {
         _bubble.direction = param1;
         _bubble.pointerOffset = param2 - 8;
      }
      
      public function setCallback(param1:IWindow) : void
      {
         if(var_2084 != null)
         {
            return;
         }
         var_3830 = param1;
         if(!var_3762)
         {
            var_2084 = onLastBubble;
         }
         else
         {
            var_2084 = onNext;
         }
         var_3830.addEventListener("WME_CLICK",var_2084);
      }
      
      public function setChatFieldCallback(param1:ITextFieldWindow) : void
      {
         if(var_2084 != null)
         {
            return;
         }
         var_4627 = param1;
         if(!var_3762)
         {
            var_2084 = onLastBubble;
         }
         else
         {
            var_2084 = onNext;
         }
         var_4627.addEventListener("WME_CLICK",var_2084);
      }
      
      public function getWindow() : IWindowContainer
      {
         return _window;
      }
      
      public function getName() : String
      {
         return var_280;
      }
   }
}
