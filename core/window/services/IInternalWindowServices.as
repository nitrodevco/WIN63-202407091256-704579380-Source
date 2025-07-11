package com.sulake.core.window.services
{
   public interface IInternalWindowServices
   {
       
      
      function getMouseDraggingService() : IMouseDraggingService;
      
      function getMouseScalingService() : IMouseScalingService;
      
      function getMouseListenerService() : IMouseListenerService;
      
      function getFocusManagerService() : class_3694;
      
      function getToolTipAgentService() : IToolTipAgentService;
      
      function getGestureAgentService() : class_3739;
   }
}
