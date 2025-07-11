package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   
   public class PollSession implements IDisposable
   {
       
      
      private var var_280:int = -1;
      
      private var var_3014:PollWidget;
      
      private var var_2186:class_3685;
      
      private var var_2255:class_3685;
      
      private var _endMessage:String = "";
      
      private var _disposed:Boolean = false;
      
      public function PollSession(param1:int, param2:PollWidget)
      {
         super();
         var_280 = param1;
         var_3014 = param2;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_2186 != null)
         {
            var_2186.dispose();
            var_2186 = null;
         }
         if(var_2255 != null)
         {
            var_2255.dispose();
            var_2255 = null;
         }
         var_3014 = null;
         _disposed = true;
      }
      
      public function showOffer(param1:String, param2:String) : void
      {
         hideOffer();
         var_2186 = new PollOfferDialog(var_280,param1,param2,var_3014);
         var_2186.start();
      }
      
      public function hideOffer() : void
      {
         if(var_2186 is PollOfferDialog)
         {
            if(!var_2186.disposed)
            {
               var_2186.dispose();
            }
            var_2186 = null;
         }
      }
      
      public function showContent(param1:String, param2:String, param3:Array, param4:Boolean) : void
      {
         hideOffer();
         hideContent();
         _endMessage = param2;
         var_2255 = new PollContentDialog(var_280,param1,param3,var_3014,param4);
         var_2255.start();
      }
      
      public function hideContent() : void
      {
         if(var_2255 is PollContentDialog)
         {
            if(!var_2255.disposed)
            {
               var_2255.dispose();
            }
            var_2255 = null;
         }
      }
      
      public function showThanks() : void
      {
         var_3014.windowManager.alert("${poll_thanks_title}",_endMessage,0,function(param1:class_3348, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
   }
}
