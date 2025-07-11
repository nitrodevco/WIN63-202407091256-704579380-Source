package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   
   public class CategoryBaseView
   {
       
      
      protected var _window:IWindowContainer;
      
      protected var var_1713:String = "";
      
      protected var _currentTabName:String = "";
      
      protected var var_1644:class_3554;
      
      protected var var_1618:Boolean;
      
      public function CategoryBaseView(param1:class_3554)
      {
         super();
         var_1644 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_1644 = null;
         var_1618 = false;
      }
      
      public function init() : void
      {
      }
      
      public function reset() : void
      {
         var_1713 = "";
         _currentTabName = "";
         var_1618 = false;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!var_1618)
         {
            init();
         }
         return _window;
      }
      
      public function showPalettes(param1:String, param2:int) : void
      {
         var_1644.controller.view.gridView.showPalettes(param2);
      }
      
      protected function updateGridView(param1:String) : void
      {
         var_1644.controller.view.gridView.initFromList(var_1644,param1);
      }
      
      protected function activateTab(param1:String) : void
      {
         var _loc2_:IStaticBitmapWrapperWindow = null;
         if(!_window)
         {
            return;
         }
         var _loc3_:IWindowContainer = _window.findChildByName(param1) as IWindowContainer;
         if(_loc3_)
         {
            _loc2_ = _loc3_.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow;
            TabUtils.setElementImage(_loc2_,true);
         }
      }
      
      protected function inactivateTab(param1:String) : void
      {
         var _loc2_:IStaticBitmapWrapperWindow = null;
         if(!_window)
         {
            return;
         }
         var _loc3_:IWindowContainer = _window.findChildByName(param1) as IWindowContainer;
         if(_loc3_)
         {
            _loc2_ = _loc3_.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow;
            TabUtils.setElementImage(_loc2_,false);
         }
      }
   }
}
