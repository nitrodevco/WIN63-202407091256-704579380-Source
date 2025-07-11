package com.sulake.habbo.navigator.view.search
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class SearchView
   {
      
      private static var FILTER_SELECTOR_INDEX_TO_MODE:Array = [5,2,1,3,4];
      
      private static var FILTER_MODE_TO_SELECTOR_INDEX:Array = [0,2,1,3,4,0];
      
      private static const INPUT_PLACEHOLDER_TEXTCOLOR:uint = 10461087;
      
      private static const INPUT_TEXTCOLOR:uint = 0;
       
      
      private var _navigator:HabboNewNavigator;
      
      private var _container:IWindowContainer;
      
      private var var_1639:ITextFieldWindow;
      
      private var var_3379:class_3520;
      
      private var var_3109:String;
      
      public function SearchView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         var_3109 = _navigator.localization.getLocalizationWithParams("navigator.filter.input.placeholder","filter rooms by...");
      }
      
      public function set container(param1:IWindowContainer) : void
      {
         _container = param1;
         var_3379 = class_3520(_container.findChildByName("filter_type_drop_menu"));
         var_1639 = ITextFieldWindow(_container.findChildByName("search_input"));
         var_1639.addEventListener("WKE_KEY_UP",keyUpHandler);
         var_1639.addEventListener("WE_CHANGE",onInputChanged);
         var_1639.addEventListener("WE_FOCUSED",onInputFocused);
         var _loc2_:IWindow = _container.findChildByName("clear_search_button");
         if(_loc2_)
         {
            _loc2_.addEventListener("WME_CLICK",onClearSearch);
         }
         clear();
      }
      
      private function onClearSearch(param1:WindowMouseEvent = null) : void
      {
         var_1639.focus();
         var_1639.caption = "";
         var _loc2_:IStaticBitmapWrapperWindow = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc2_.assetUri = "common_small_pen";
      }
      
      public function clear() : void
      {
         setInputToFilterPlaceHolder();
         var_3379.selection = 0;
         _container.findChildByName("refreshButtonContainer").visible = false;
      }
      
      public function setTextAndSearchModeFromFilter(param1:String, param2:String = "") : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc3_:int = class_3756.filterInInput(param1);
         if(_loc3_ != 0)
         {
            var_3379.selection = FILTER_MODE_TO_SELECTOR_INDEX[_loc3_];
            var_1639.caption = param1.substr(class_3756.FILTER_PREFIX[_loc3_].length,param1.length - class_3756.FILTER_PREFIX[_loc3_].length);
         }
         else
         {
            var_1639.caption = param1;
            var_3379.selection = 0;
         }
         if(param2 != "" && param2 != var_3109)
         {
            var_1639.caption = param2;
            setInputFieldTextFormattingToPlaceholder(true);
         }
         else if(var_1639.caption == "")
         {
            setInputToFilterPlaceHolder();
         }
         else
         {
            setInputFieldTextFormattingToPlaceholder(false);
         }
         if(var_1639.caption.length != 0 && var_1639.caption != var_3109)
         {
            _container.findChildByName("refreshButtonContainer").visible = true;
            (_loc4_ = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow).assetUri = "icons_close";
         }
         else
         {
            _container.findChildByName("refreshButtonContainer").visible = false;
            (_loc4_ = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow).assetUri = "common_small_pen";
         }
      }
      
      private function keyUpHandler(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            _navigator.performSearch(_navigator.currentResults.searchCodeOriginal,getFilterParameter());
         }
      }
      
      private function getFilterParameter() : String
      {
         return class_3756.FILTER_PREFIX[FILTER_SELECTOR_INDEX_TO_MODE[var_3379.selection]] + var_1639.caption;
      }
      
      private function setInputToFilterPlaceHolder() : void
      {
         setInputFieldTextFormattingToPlaceholder(true);
         var_1639.caption = var_3109;
      }
      
      private function onInputFocused(param1:WindowEvent) : void
      {
         setInputFieldTextFormattingToPlaceholder(false);
         if(var_1639.caption == var_3109)
         {
            var_1639.caption = "";
         }
      }
      
      private function setInputFieldTextFormattingToPlaceholder(param1:Boolean) : void
      {
         var_1639.textColor = param1 ? 10461087 : 0;
         var_1639.italic = param1;
      }
      
      private function onInputChanged(param1:WindowEvent) : void
      {
      }
      
      public function get currentInput() : String
      {
         if(var_1639 != null)
         {
            return var_1639.caption;
         }
         return var_3109;
      }
   }
}
