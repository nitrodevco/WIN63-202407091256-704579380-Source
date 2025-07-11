package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class TrophyView implements ITrophyView
   {
      
      private static const BG_IMAGE_LIST:Array = new Array("trophy_bg_gold","trophy_bg_silver","trophy_bg_bronze");
      
      private static const BG_COLOR_LIST:Array = new Array(4293707079,4291411404,4290279476);
       
      
      private var var_1629:ITrophyFurniWidget;
      
      private var _window:IWindowContainer;
      
      public function TrophyView(param1:ITrophyFurniWidget)
      {
         super();
         var_1629 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_1629 = null;
      }
      
      public function showInterface() : Boolean
      {
         var _loc2_:IWindow = null;
         var _loc9_:IWindowContainer = null;
         var _loc6_:ITextWindow = null;
         var _loc3_:ITextWindow = null;
         var _loc7_:ITextWindow = null;
         var _loc5_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         var _loc8_:IBitmapWrapperWindow = null;
         var _loc10_:IAsset = var_1629.assets.getAssetByName("trophy");
         var _loc1_:XmlAsset = XmlAsset(_loc10_);
         if(_loc1_ == null)
         {
            return false;
         }
         if(_window == null)
         {
            _window = var_1629.windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer;
         }
         _window.center();
         _loc2_ = _window.findChildByName("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         if((_loc9_ = _window.findChildByName("title_bg") as IWindowContainer) != null)
         {
            _loc9_.color = BG_COLOR_LIST[var_1629.color];
         }
         if((_loc6_ = _window.findChildByName("greeting") as ITextWindow) != null)
         {
            _loc6_.text = var_1629.message.replace(/\\r/g,"\n");
         }
         _loc3_ = _window.findChildByName("date") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = var_1629.date;
         }
         if((_loc7_ = _window.findChildByName("name") as ITextWindow) != null)
         {
            _loc7_.text = var_1629.name;
         }
         _loc5_ = var_1629.assets.getAssetByName(BG_IMAGE_LIST[var_1629.color]) as BitmapDataAsset;
         _loc8_ = _window.findChildByName("trophy_bg") as IBitmapWrapperWindow;
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.content as BitmapData;
            _loc8_.bitmap = _loc4_;
         }
         return true;
      }
      
      public function disposeInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         disposeInterface();
      }
   }
}
