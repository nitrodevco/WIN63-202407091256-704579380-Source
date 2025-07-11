package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.class_3400;
   import flash.display.DisplayObject;
   
   public class ServiceManager implements IInternalWindowServices, IDisposable
   {
       
      
      private var var_4880:uint;
      
      private var var_509:DisplayObject;
      
      private var _disposed:Boolean = false;
      
      private var var_2535:class_3400;
      
      private var var_3233:IMouseDraggingService;
      
      private var var_3079:IMouseScalingService;
      
      private var var_3139:IMouseListenerService;
      
      private var var_3045:class_3694;
      
      private var var_3254:IToolTipAgentService;
      
      private var var_3181:class_3739;
      
      public function ServiceManager(param1:class_3400, param2:DisplayObject)
      {
         super();
         var_4880 = 0;
         var_509 = param2;
         var_2535 = param1;
         var_3233 = new WindowMouseDragger(param2);
         var_3079 = new WindowMouseScaler(param2);
         var_3139 = new WindowMouseListener(param2);
         var_3045 = new FocusManager(param2);
         var_3254 = new WindowToolTipAgent(param2);
         var_3181 = new GestureAgentService();
      }
      
      public function dispose() : void
      {
         if(var_3233 != null)
         {
            var_3233.dispose();
            var_3233 = null;
         }
         if(var_3079 != null)
         {
            var_3079.dispose();
            var_3079 = null;
         }
         if(var_3139 != null)
         {
            var_3139.dispose();
            var_3139 = null;
         }
         if(var_3045 != null)
         {
            var_3045.dispose();
            var_3045 = null;
         }
         if(var_3254 != null)
         {
            var_3254.dispose();
            var_3254 = null;
         }
         if(var_3181 != null)
         {
            var_3181.dispose();
            var_3181 = null;
         }
         var_509 = null;
         var_2535 = null;
         _disposed = true;
      }
      
      public function getMouseDraggingService() : IMouseDraggingService
      {
         return var_3233;
      }
      
      public function getMouseScalingService() : IMouseScalingService
      {
         return var_3079;
      }
      
      public function getMouseListenerService() : IMouseListenerService
      {
         return var_3139;
      }
      
      public function getFocusManagerService() : class_3694
      {
         return var_3045;
      }
      
      public function getToolTipAgentService() : IToolTipAgentService
      {
         return var_3254;
      }
      
      public function getGestureAgentService() : class_3739
      {
         return var_3181;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
