package com.sulake.habbo.window.utils
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class SimpleAlertDialog implements IDisposable
   {
      
      private static const WINDOW_MARGIN:int = 10;
       
      
      private var _disposed:Boolean;
      
      private var var_1907:IModalDialog;
      
      private var var_96:String;
      
      private var _window:IWindowContainer;
      
      private var var_19:IItemListWindow;
      
      private var var_2702:IItemListWindow;
      
      private var var_3513:IItemListWindow;
      
      private var var_3683:IWindow;
      
      private var var_2882:IWindow;
      
      private var var_445:ITextLinkWindow;
      
      private var var_2151:IStaticBitmapWrapperWindow;
      
      private var var_3508:Function;
      
      private var var_3442:Function;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      public function SimpleAlertDialog(param1:HabboWindowManagerComponent, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Map, param8:String, param9:Function, param10:Function)
      {
         var _loc12_:String = null;
         super();
         var_3508 = param9;
         var_3442 = param10;
         _windowManager = param1;
         var _loc14_:IAsset = param1.assets.getAssetByName("simple_alert_xml");
         var_1907 = param1.buildModalDialogFromXML(_loc14_.content as XML);
         _window = IWindowContainer(var_1907.rootWindow);
         var_19 = IItemListWindow(_window.findChildByName("list"));
         var_2702 = IItemListWindow(_window.findChildByName("list_top"));
         var_3513 = IItemListWindow(_window.findChildByName("list_bottom"));
         var_3683 = _window.findChildByName("message");
         var_2882 = _window.findChildByName("subtitle");
         var_445 = ITextLinkWindow(_window.findChildByName("link"));
         var_2151 = IStaticBitmapWrapperWindow(_window.findChildByName("illustration"));
         _window.findChildByName("header_button_close").dispose();
         _window.procedure = windowProcedure;
         _window.caption = param2;
         var_3683.caption = param4;
         if(param7 != null)
         {
            for each(var _loc13_ in [param2,param3,param4,param5])
            {
               if(_loc13_ != null && _loc13_.substr(0,2) == "${" && _loc13_.indexOf("}") > 0)
               {
                  _loc12_ = _loc13_.substring(2,_loc13_.indexOf("}"));
                  for(var _loc11_ in param7)
                  {
                     param1.localization.registerParameter(_loc12_,_loc11_,param7.getValue(_loc11_));
                  }
               }
            }
         }
         if(param3 != null && param3 != "")
         {
            var_2882.caption = param3;
         }
         else
         {
            var_2882.dispose();
            var_2882 = null;
         }
         param6 = param1.interpolate(param6);
         if(param5 != null && param5 != "" && (param6 != null && param6 != "" || param9 != null))
         {
            var_445.caption = param5;
            var_445.addEventListener("WME_CLICK",onSimpleAlertClick);
            var_445.immediateClickMode = true;
            var_96 = param6;
         }
         else
         {
            var_445.dispose();
            var_445 = null;
         }
         if(param8 != null && param8 != "")
         {
            var_2151.addEventListener("WE_RESIZED",onIllustrationResized);
            var_2151.assetUri = param8;
         }
         else
         {
            var_2151.dispose();
            var_2151 = null;
         }
         resizeWindow();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            close();
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function close() : void
      {
         if(var_3442 != null)
         {
            var_3442();
         }
         if(var_1907 != null)
         {
            if(var_445 != null)
            {
               var_445.removeEventListener("WME_CLICK",onSimpleAlertClick);
               var_445 = null;
            }
            if(var_2151)
            {
               var_2151.removeEventListener("WE_RESIZED",onIllustrationResized);
               var_2151 = null;
            }
            _window = null;
            var_19 = null;
            var_2702 = null;
            var_3513 = null;
            var_3683 = null;
            var_2882 = null;
            var_3508 = null;
            var_3442 = null;
            var_1907.dispose();
            var_1907 = null;
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK" && param2.name == "close_button")
         {
            dispose();
         }
      }
      
      private function onSimpleAlertClick(param1:WindowMouseEvent) : void
      {
         if(var_96 != null && var_96.length > 0)
         {
            if(var_96.substr(0,6) == "event:")
            {
               _windowManager.context.createLinkEvent(var_96.substr(6));
               dispose();
            }
            else
            {
               HabboWebTools.openWebPage(var_96,"habboMain");
            }
         }
         else if(var_3508 != null)
         {
            var_3508();
            dispose();
         }
      }
      
      private function onIllustrationResized(param1:WindowEvent) : void
      {
         var_2702.x = var_2151.width + 10;
         var_3513.width = var_2702.right;
         _window.width = var_2702.right + 2 * 10;
         var_2702.limits.minHeight = var_2151.height + 10;
         resizeWindow();
      }
      
      private function resizeWindow() : void
      {
         var_2702.arrangeListItems();
         var_3513.arrangeListItems();
         var_19.arrangeListItems();
         _window.height = var_19.height + 40;
         _window.center();
      }
   }
}
