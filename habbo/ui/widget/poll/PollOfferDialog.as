package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   
   public class PollOfferDialog implements class_3685
   {
      
      public static const OK:String = "POLL_OFFER_STATE_OK";
      
      public static const CANCEL:String = "POLL_OFFER_STATE_CANCEL";
      
      public static const UNKNOWN:String = "POLL_OFFER_STATE_UNKNOWN";
       
      
      private var _disposed:Boolean = false;
      
      private var _window:class_3514;
      
      private var var_149:String = "POLL_OFFER_STATE_UNKNOWN";
      
      private var var_1629:PollWidget;
      
      private var var_280:int = -1;
      
      public function PollOfferDialog(param1:int, param2:String, param3:String, param4:PollWidget)
      {
         var _loc9_:IWindow = null;
         var _loc5_:IWindow = null;
         var _loc7_:IWindow = null;
         var _loc6_:IWindow = null;
         var _loc8_:IItemListWindow = null;
         var _loc12_:ITextWindow = null;
         var _loc10_:ITextWindow = null;
         super();
         var_280 = param1;
         var_1629 = param4;
         var _loc11_:XmlAsset;
         if((_loc11_ = var_1629.assets.getAssetByName("poll_offer") as XmlAsset) != null)
         {
            _window = var_1629.windowManager.buildFromXML(_loc11_.content as XML) as class_3514;
            if(_window)
            {
               _window.center();
               if((_loc9_ = _window.findChildByName("poll_offer_button_ok")) != null)
               {
                  _loc9_.addEventListener("WME_CLICK",onOk);
               }
               if((_loc5_ = _window.findChildByName("poll_offer_button_cancel")) != null)
               {
                  _loc5_.addEventListener("WME_CLICK",onCancel);
               }
               if((_loc7_ = _window.findChildByName("poll_offer_button_later")) != null)
               {
                  _loc7_.addEventListener("WME_CLICK",onLater);
               }
               if((_loc6_ = _window.findChildByName("header_button_close")) != null)
               {
                  _loc6_.addEventListener("WME_CLICK",onClose);
               }
               if(_loc12_ = _window.findChildByName("poll_offer_headline") as ITextWindow)
               {
                  _loc12_.htmlText = param2;
                  if(_loc8_ = _window.findChildByName("poll_offer_headline_wrapper") as IItemListWindow)
                  {
                     _window.height += _loc8_.scrollableRegion.height - _loc8_.visibleRegion.height;
                  }
               }
               if(_loc10_ = _window.findChildByName("poll_offer_summary") as ITextWindow)
               {
                  _loc10_.htmlText = param3;
                  if(_loc8_ = _window.findChildByName("poll_offer_summary_wrapper") as IItemListWindow)
                  {
                     _window.height += _loc8_.scrollableRegion.height - _loc8_.visibleRegion.height;
                  }
               }
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get state() : String
      {
         return var_149;
      }
      
      public function start() : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_1629 = null;
      }
      
      private function onOk(param1:WindowEvent) : void
      {
         if(var_149 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_149 = "POLL_OFFER_STATE_OK";
         var_1629.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_START",var_280));
      }
      
      private function onCancel(param1:WindowEvent) : void
      {
         if(var_149 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_149 = "POLL_OFFER_STATE_CANCEL";
         var_1629.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT",var_280));
         var_1629.pollCancelled(var_280);
      }
      
      private function onLater(param1:WindowEvent) : void
      {
         if(var_149 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_149 = "POLL_OFFER_STATE_CANCEL";
         var_1629.pollCancelled(var_280);
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         if(var_149 != "POLL_OFFER_STATE_UNKNOWN")
         {
            return;
         }
         var_149 = "POLL_OFFER_STATE_CANCEL";
         var_1629.messageListener.processWidgetMessage(new RoomWidgetPollMessage("RWPM_REJECT",var_280));
         var_1629.pollCancelled(var_280);
      }
   }
}
