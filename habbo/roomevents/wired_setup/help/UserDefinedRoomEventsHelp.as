package com.sulake.habbo.roomevents.wired_setup.help
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class UserDefinedRoomEventsHelp
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_4225:IWindowContainer;
      
      private var _window:class_3514;
      
      private var var_1631:IWindowContainer;
      
      private var var_1824:int = 0;
      
      private var var_44:Array;
      
      private var var_3361:class_3489;
      
      private var _buttonPrevious:class_3489;
      
      public function UserDefinedRoomEventsHelp(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
      }
      
      public function dispose() : void
      {
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         initLocalizations();
         _window = class_3514(_roomEvents.getXmlWindow("ude_help"));
         var_4225 = IWindowContainer(find(_window,"help_container"));
         _buttonPrevious = var_4225.findChildByName("button_previous") as class_3489;
         if(_buttonPrevious)
         {
            _buttonPrevious.procedure = onButtonClick;
         }
         var_3361 = var_4225.findChildByName("button_next") as class_3489;
         if(var_3361)
         {
            var_3361.procedure = onButtonClick;
         }
         var _loc1_:IWindow = _window.findChildByTag("close");
         _loc1_.procedure = onWindowClose;
         _window.center();
      }
      
      public function open(param1:int = -1, param2:int = -1) : void
      {
         prepareWindow();
         openPage();
         _window.visible = true;
         if(param1 >= 0)
         {
            _window.x = param1;
         }
         if(param2 >= 0)
         {
            _window.y = param2;
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function find(param1:IWindowContainer, param2:String) : IWindow
      {
         var _loc3_:IWindow = param1.findChildByName(param2);
         if(_loc3_ == null)
         {
            throw new Error("Window element with name: " + param2 + " cannot be found!");
         }
         return _loc3_;
      }
      
      public function toggle() : void
      {
         _window.visible = !_window.visible;
      }
      
      private function openPage() : void
      {
         localize();
         checkButtons();
      }
      
      private function checkButtons() : void
      {
         if(var_1824 >= var_44.length - 1)
         {
            var_3361.disable();
         }
         else
         {
            var_3361.enable();
         }
         if(var_1824 <= 0)
         {
            _buttonPrevious.disable();
         }
         else
         {
            _buttonPrevious.enable();
         }
      }
      
      private function nextPage() : void
      {
         var_1824++;
         var_1824 = Math.min(var_1824,var_44.length - 1);
         openPage();
      }
      
      private function previousPage() : void
      {
         var_1824--;
         var_1824 = Math.max(var_1824,0);
         openPage();
      }
      
      private function initLocalizations() : void
      {
         var _loc1_:ILocalization = null;
         var _loc4_:ILocalization = null;
         var _loc3_:ILocalization = null;
         var_44 = [];
         var _loc2_:int = 1;
         while(_roomEvents.localization.getLocalizationRaw("wiredfurni.help." + _loc2_ + ".title"))
         {
            _loc1_ = _roomEvents.localization.getLocalizationRaw("wiredfurni.help." + _loc2_ + ".title");
            _loc4_ = _roomEvents.localization.getLocalizationRaw("wiredfurni.help." + _loc2_ + ".img");
            _loc3_ = _roomEvents.localization.getLocalizationRaw("wiredfurni.help." + _loc2_ + ".text");
            var_44.push([_loc1_,_loc4_,_loc3_]);
            _loc2_++;
         }
      }
      
      private function onButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_previous":
                  previousPage();
                  break;
               case "button_next":
                  nextPage();
            }
         }
      }
      
      private function localize() : void
      {
         var _loc1_:ILocalization = null;
         var _loc3_:String = null;
         var _loc5_:ITextWindow = find(_window,"help_title") as ITextWindow;
         var _loc4_:ITextWindow = find(_window,"help_text") as ITextWindow;
         var _loc2_:IBitmapWrapperWindow = find(_window,"help_image") as IBitmapWrapperWindow;
         if(var_44 == null || var_44.length == 0)
         {
            return;
         }
         if(_loc5_)
         {
            _loc1_ = ILocalization(var_44[var_1824][0]);
            if(_loc1_ != null)
            {
               _loc5_.text = _loc1_.value;
            }
         }
         if(_loc4_)
         {
            _loc1_ = ILocalization(var_44[var_1824][2]);
            if(_loc1_ != null)
            {
               _loc5_.text = _loc1_.value;
            }
         }
         if(_loc2_)
         {
            _loc1_ = ILocalization(var_44[var_1824][1]);
            if(_loc1_ != null)
            {
               _loc3_ = String(_loc1_.value);
               setPreviewFromAsset(_loc3_);
            }
         }
      }
      
      private function setElementImage(param1:IBitmapWrapperWindow, param2:BitmapData) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.disposed)
         {
            return;
         }
         var _loc3_:int = (param1.width - param2.width) / 2;
         var _loc4_:int = (param1.height - param2.height) / 2;
         if(param1.bitmap == null)
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,16777215);
         }
         param1.bitmap.fillRect(param1.bitmap.rect,16777215);
         param1.bitmap.copyPixels(param2,param2.rect,new Point(_loc3_,_loc4_),null,null,false);
         param1.invalidate();
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         if(!param1 || !_roomEvents || !_roomEvents.assets)
         {
            return;
         }
         var _loc3_:BitmapDataAsset = _roomEvents.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc3_ == null)
         {
            retrievePreviewAsset(param1);
            return;
         }
         var _loc2_:IBitmapWrapperWindow = find(_window,"help_image") as IBitmapWrapperWindow;
         if(_loc2_)
         {
            setElementImage(_loc2_,_loc3_.content as BitmapData);
         }
      }
      
      private function retrievePreviewAsset(param1:String) : void
      {
         if(!param1 || !_roomEvents || !_roomEvents.assets)
         {
            return;
         }
         var _loc4_:String;
         var _loc5_:String = (_loc4_ = _roomEvents.getProperty("image.library.catalogue.url")) + param1 + ".gif";
         class_14.log("[ProductViewCatalogWidget] Retrieve Product Preview Asset: " + _loc5_);
         var _loc2_:URLRequest = new URLRequest(_loc5_);
         var _loc3_:AssetLoaderStruct = _roomEvents.assets.loadAssetFromFile(param1,_loc2_,"image/gif");
         if(!_loc3_)
         {
            return;
         }
         _loc3_.addEventListener("AssetLoaderEventComplete",onPreviewImageReady);
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            setPreviewFromAsset(_loc2_.assetName);
         }
      }
   }
}
