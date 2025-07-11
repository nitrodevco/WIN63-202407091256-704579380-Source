package com.sulake.habbo.avatar.hotlooks
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.class_3676;
   import com.sulake.habbo.avatar.wardrobe.Outfit;
   
   public class HotLooksView implements class_3676
   {
       
      
      private var _window:IWindowContainer;
      
      private var var_1644:HotLooksModel;
      
      private var var_2886:IItemGridWindow;
      
      public function HotLooksView(param1:HotLooksModel)
      {
         super();
         var_1644 = param1;
      }
      
      public function init() : void
      {
         if(var_2886)
         {
            var_2886.removeGridItems();
         }
         if(!_window)
         {
            _window = var_1644.controller.view.getCategoryContainer("hotlooks") as IWindowContainer;
            var_2886 = _window.findChildByName("hotlooks") as IItemGridWindow;
            _window.visible = false;
         }
         update();
      }
      
      public function dispose() : void
      {
         var_2886.removeGridItems();
         _window = null;
         var_1644 = null;
      }
      
      public function update() : void
      {
         var _loc2_:IWindow = null;
         var_2886.removeGridItems();
         for each(var _loc1_ in var_1644.hotLooks)
         {
            _loc2_ = _loc1_.view.window;
            var_2886.addGridItem(_loc2_);
            _loc2_.procedure = hotLooksEventProc;
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return _window;
      }
      
      private function hotLooksEventProc(param1:WindowEvent, param2:IWindow = null) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            param2 = param1.target as IWindow;
         }
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_2886.getGridItemIndex(param2.parent);
            var_1644.selectHotLook(_loc3_);
         }
      }
      
      public function switchCategory(param1:String) : void
      {
      }
      
      public function showPalettes(param1:String, param2:int) : void
      {
      }
      
      public function reset() : void
      {
      }
   }
}
