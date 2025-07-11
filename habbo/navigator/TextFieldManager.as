package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Point;
   
   public class TextFieldManager
   {
       
      
      private var _navigator:IHabboTransitionalNavigator;
      
      private var var_1730:ITextFieldWindow;
      
      private var _includeInfo:Boolean;
      
      private var var_3776:String = "";
      
      private var _maxTextLen:int;
      
      private var var_4090:Function;
      
      private var var_4902:String = "";
      
      private var _errorPopup:IWindowContainer;
      
      private var var_4876:Boolean;
      
      private var _orgTextBackgroundColor:uint;
      
      public function TextFieldManager(param1:IHabboTransitionalNavigator, param2:ITextFieldWindow, param3:int = 1000, param4:Function = null, param5:String = null)
      {
         super();
         _navigator = param1;
         var_1730 = param2;
         _maxTextLen = param3;
         param2.maxChars = param3;
         var_4090 = param4;
         if(param5 != null)
         {
            _includeInfo = true;
            var_3776 = param5;
            var_1730.text = param5;
         }
         Util.setProcDirectly(var_1730,onInputClick);
         var_1730.addEventListener("WKE_KEY_DOWN",checkEnterPress);
         var_1730.addEventListener("WE_CHANGE",checkMaxLen);
         this.var_4876 = var_1730.textBackground;
         this._orgTextBackgroundColor = var_1730.textBackgroundColor;
      }
      
      public function dispose() : void
      {
         if(var_1730)
         {
            var_1730.dispose();
            var_1730 = null;
         }
         if(_errorPopup)
         {
            _errorPopup.dispose();
            _errorPopup = null;
         }
         _navigator = null;
      }
      
      public function checkMandatory(param1:String) : Boolean
      {
         if(!isInputValid())
         {
            displayError(param1);
            return false;
         }
         restoreBackground();
         return true;
      }
      
      public function restoreBackground() : void
      {
         var_1730.textBackground = this.var_4876;
         var_1730.textBackgroundColor = this._orgTextBackgroundColor;
      }
      
      public function displayError(param1:String) : void
      {
         var_1730.textBackground = true;
         var_1730.textBackgroundColor = 4294021019;
         if(this._errorPopup == null)
         {
            this._errorPopup = IWindowContainer(_navigator.getXmlWindow("nav_error_popup"));
            _navigator.refreshButton(this._errorPopup,"popup_arrow_down",true,null,0);
            IWindowContainer(var_1730.parent).addChild(this._errorPopup);
         }
         var _loc4_:ITextWindow;
         (_loc4_ = ITextWindow(this._errorPopup.findChildByName("error_text"))).text = param1;
         _loc4_.width = _loc4_.textWidth + 5;
         _errorPopup.findChildByName("border").width = _loc4_.width + 15;
         _errorPopup.width = _loc4_.width + 15;
         var _loc2_:Point = new Point();
         var_1730.getLocalPosition(_loc2_);
         this._errorPopup.x = _loc2_.x;
         this._errorPopup.y = _loc2_.y - this._errorPopup.height + 3;
         var _loc3_:IWindow = _errorPopup.findChildByName("popup_arrow_down");
         _loc3_.x = this._errorPopup.width / 2 - _loc3_.width / 2;
         _errorPopup.x += (var_1730.width - _errorPopup.width) / 2;
         this._errorPopup.visible = true;
      }
      
      public function goBackToInitialState() : void
      {
         clearErrors();
         if(var_3776 != null)
         {
            var_1730.text = var_3776;
            _includeInfo = true;
         }
         else
         {
            var_1730.text = "";
            _includeInfo = false;
         }
      }
      
      public function getText() : String
      {
         if(_includeInfo)
         {
            return var_4902;
         }
         return var_1730.text;
      }
      
      public function setText(param1:String) : void
      {
         _includeInfo = false;
         var_1730.text = param1;
      }
      
      public function clearErrors() : void
      {
         this.restoreBackground();
         if(this._errorPopup != null)
         {
            _errorPopup.visible = false;
         }
      }
      
      public function get input() : ITextFieldWindow
      {
         return var_1730;
      }
      
      private function isInputValid() : Boolean
      {
         return !_includeInfo && Util.trim(getText()).length > 2;
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(!_includeInfo)
         {
            return;
         }
         var_1730.text = var_4902;
         _includeInfo = false;
         this.restoreBackground();
      }
      
      private function checkEnterPress(param1:WindowKeyboardEvent) : void
      {
         if(param1.charCode == 13)
         {
            if(var_4090 != null)
            {
               var_4090();
            }
         }
      }
      
      private function checkMaxLen(param1:WindowEvent) : void
      {
         var _loc2_:String = String(var_1730.text);
         if(_loc2_.length > _maxTextLen)
         {
            var_1730.text = _loc2_.substring(0,_maxTextLen);
         }
      }
   }
}
