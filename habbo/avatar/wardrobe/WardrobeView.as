package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.avatar.common.ISideContentView;
   
   public class WardrobeView implements ISideContentView
   {
       
      
      private var _window:IWindowContainer;
      
      private var var_1644:WardrobeModel;
      
      private var var_2948:IItemListWindow;
      
      private var var_3384:IItemListWindow;
      
      private var var_3637:IWindow;
      
      public function WardrobeView(param1:WardrobeModel)
      {
         super();
         var_1644 = param1;
         var _loc2_:XmlAsset = var_1644.controller.manager.assets.getAssetByName("avatareditor_wardrobe_base") as XmlAsset;
         _window = var_1644.controller.manager.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         var_2948 = _window.findChildByName("hc_slots") as IItemListWindow;
         var_3384 = _window.findChildByName("vip_slots") as IItemListWindow;
         var_3637 = _window.findChildByName("slot_template");
         if(var_3637)
         {
            _window.removeChild(var_3637);
         }
         _window.visible = false;
      }
      
      public function get slotWindowTemplate() : IWindow
      {
         return var_3637;
      }
      
      public function dispose() : void
      {
         var_1644 = null;
         var_2948 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function update() : void
      {
         var _loc3_:WardrobeSlot = null;
         var _loc2_:int = 0;
         if(var_2948)
         {
            var_2948.removeListItems();
         }
         if(var_3384)
         {
            var_3384.removeListItems();
         }
         var _loc1_:Array = var_1644.slots;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            if(_loc2_ < 5)
            {
               if(var_2948)
               {
                  var_2948.addListItem(_loc3_.view);
                  _loc3_.view.visible = true;
               }
            }
            else if(var_3384)
            {
               var_3384.addListItem(_loc3_.view);
               _loc3_.view.visible = true;
            }
            _loc2_++;
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return _window;
      }
   }
}
