package com.sulake.habbo.avatar.nft
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.class_3676;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   
   public class NftAvatarsView implements class_3676
   {
       
      
      private var _window:IWindowContainer;
      
      private var var_1644:NftAvatarsModel;
      
      private var var_2906:IItemGridWindow;
      
      public function NftAvatarsView(param1:NftAvatarsModel)
      {
         super();
         var_1644 = param1;
      }
      
      public function init() : void
      {
         if(var_2906)
         {
            var_2906.removeGridItems();
         }
         if(!_window)
         {
            _window = var_1644.controller.view.getCategoryContainer("nfts") as IWindowContainer;
            var_2906 = _window.findChildByName("nfts") as IItemGridWindow;
            _window.visible = false;
         }
         update();
      }
      
      public function dispose() : void
      {
         var_2906.removeGridItems();
         _window = null;
         var_1644 = null;
      }
      
      public function update() : void
      {
         var _loc2_:IWindow = null;
         var_2906.removeGridItems();
         for each(var _loc1_ in var_1644.nftAvatars)
         {
            _loc2_ = _loc1_.view.window;
            var_2906.addGridItem(_loc2_);
            _loc2_.procedure = nftAvatarsEventProc;
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return _window;
      }
      
      private function nftAvatarsEventProc(param1:WindowEvent, param2:IWindow = null) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            param2 = param1.target as IWindow;
         }
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_2906.getGridItemIndex(param2.parent);
            var_1644.selectNftAvatar(_loc3_);
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
