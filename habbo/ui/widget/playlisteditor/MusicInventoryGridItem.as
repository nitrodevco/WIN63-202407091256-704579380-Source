package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class MusicInventoryGridItem
   {
      
      public static const const_870:int = 0;
      
      public static const const_573:int = 1;
      
      public static const BUTTON_STATE_DOWNLOAD:int = 2;
      
      private static const BG_COLOR_SELECTED:uint = 14612159;
      
      private static const BG_COLOR_UNSELECTED:uint = 15856113;
       
      
      private var var_1629:PlayListEditorWidget;
      
      private var _window:IWindowContainer = null;
      
      private var var_4420:int;
      
      private var var_606:int;
      
      private var var_4810:class_3489 = null;
      
      private var var_4667:int;
      
      public function MusicInventoryGridItem(param1:PlayListEditorWidget, param2:int, param3:int, param4:String, param5:ColorTransform)
      {
         super();
         var_1629 = param1;
         var_4420 = param2;
         var_606 = param3;
         createWindow();
         deselect();
         if(param4 != null && param5 != null)
         {
            trackName = param4;
            diskColor = param5;
         }
      }
      
      public function get window() : IWindow
      {
         return _window as IWindow;
      }
      
      public function get diskId() : int
      {
         return var_4420;
      }
      
      public function get songId() : int
      {
         return var_606;
      }
      
      public function get toPlayListButton() : class_3489
      {
         return var_4810;
      }
      
      public function get playButtonState() : int
      {
         return var_4667;
      }
      
      public function update(param1:int, param2:String, param3:ColorTransform) : void
      {
         if(param1 == var_606)
         {
            trackName = param2;
            diskColor = param3;
         }
      }
      
      public function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
         }
      }
      
      private function createWindow() : void
      {
         var _loc3_:BitmapDataAsset = null;
         if(var_1629 == null)
         {
            return;
         }
         var _loc2_:XmlAsset = var_1629.assets.getAssetByName("playlisteditor_music_inventory_item") as XmlAsset;
         _window = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:IWindowContainer = _window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc1_ != null)
         {
            var_4810 = _loc1_.getChildByName("button_to_playlist") as class_3489;
         }
         assignAssetByNameToElement("title_fader",_window.getChildByName("title_fader_bitmap") as IBitmapWrapperWindow);
         _loc3_ = var_1629.assets.getAssetByName("icon_arrow") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            if(_loc3_.content != null)
            {
               this.buttonToPlaylistBitmap = _loc3_.content as BitmapData;
            }
         }
         this.playButtonState = 0;
      }
      
      public function select() : void
      {
         var _loc2_:class_3437 = _window.getChildByName("background") as class_3437;
         if(_loc2_ != null)
         {
            _loc2_.color = 14612159;
         }
         var _loc3_:IWindowContainer = _window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
         var _loc1_:class_3437 = _window.getChildByName("selected") as class_3437;
         if(_loc1_ != null)
         {
            _loc1_.visible = true;
         }
      }
      
      public function deselect() : void
      {
         var _loc2_:class_3437 = _window.getChildByName("background") as class_3437;
         if(_loc2_ != null)
         {
            _loc2_.color = 15856113;
         }
         var _loc3_:IWindowContainer = _window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
         var _loc1_:class_3437 = _window.getChildByName("selected") as class_3437;
         if(_loc1_ != null)
         {
            _loc1_.visible = false;
         }
      }
      
      public function set diskColor(param1:ColorTransform) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc3_:BitmapDataAsset = var_1629.assets.getAssetByName("icon_cd_big") as BitmapDataAsset;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.content != null)
         {
            _loc2_ = _loc3_.content as BitmapData;
            if((_loc4_ = _loc2_.clone()) != null)
            {
               _loc4_.colorTransform(_loc2_.rect,param1);
               this.diskIconBitmap = _loc4_;
            }
         }
      }
      
      public function set playButtonState(param1:int) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == 0)
         {
            _loc2_ = var_1629.assets.getAssetByName("icon_play") as BitmapDataAsset;
         }
         else if(param1 == 1)
         {
            _loc2_ = var_1629.assets.getAssetByName("icon_pause") as BitmapDataAsset;
         }
         else if(param1 == 2)
         {
            _loc2_ = var_1629.assets.getAssetByName("icon_download") as BitmapDataAsset;
         }
         if(_loc2_ != null)
         {
            if(_loc2_.content != null)
            {
               this.buttonPlayPauseBitmap = _loc2_.content as BitmapData;
            }
         }
         var_4667 = param1;
      }
      
      public function set trackName(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.getChildByName("song_title_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function set diskIconBitmap(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperWindow = _window.getChildByName("disk_image") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.bitmap = param1;
         }
      }
      
      private function set buttonToPlaylistBitmap(param1:BitmapData) : void
      {
         assignBitmapDataToButton("button_to_playlist","image_button_to_playlist",param1);
      }
      
      private function set buttonPlayPauseBitmap(param1:BitmapData) : void
      {
         assignBitmapDataToButton("button_play_pause","image_button_play_pause",param1);
      }
      
      private function assignBitmapDataToButton(param1:String, param2:String, param3:BitmapData) : void
      {
         if(param3 == null)
         {
            return;
         }
         var _loc4_:IWindowContainer;
         if((_loc4_ = _window.getChildByName("action_buttons") as IWindowContainer) == null)
         {
            return;
         }
         if((_loc4_ = _loc4_.getChildByName(param1) as IWindowContainer) == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow;
         if((_loc5_ = _loc4_.getChildByName(param2) as IBitmapWrapperWindow) != null)
         {
            _loc5_.bitmap = param3.clone();
            _loc5_.width = param3.width;
            _loc5_.height = param3.height;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:IBitmapWrapperWindow) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapDataAsset;
         if((_loc4_ = var_1629.assets.getAssetByName(param1) as BitmapDataAsset) != null)
         {
            if(param2 != null && _loc4_.content != null)
            {
               _loc3_ = _loc4_.content as BitmapData;
               param2.bitmap = _loc3_.clone();
            }
         }
      }
   }
}
