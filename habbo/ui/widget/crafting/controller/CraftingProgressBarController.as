package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CraftingProgressBarController
   {
       
      
      private var var_1629:CraftingWidget;
      
      private var var_3567:Timer;
      
      private var var_3524:Number;
      
      public function CraftingProgressBarController(param1:CraftingWidget)
      {
         super();
         var_1629 = param1;
         var_3567 = new Timer(70);
         var_3567.addEventListener("timer",onProgressTimerEvent);
      }
      
      public function dispose() : void
      {
         var_1629 = null;
      }
      
      private function setProgress(param1:Number) : void
      {
         var _loc3_:IWindow = null;
         var _loc2_:IWindow = container.findChildByName("btn_cancel");
         var _loc4_:IWindow;
         if(_loc4_ = !!container ? container.findChildByName("bar") : null)
         {
            _loc3_ = _loc4_.parent;
            _loc4_.width = _loc2_.width * param1;
         }
      }
      
      private function onProgressTimerEvent(param1:TimerEvent) : void
      {
         setProgress(var_3524 = var_3524 + 0.02);
         if(var_3524 >= 1)
         {
            hide();
            var_1629.infoCtrl.onProgressBarComplete();
         }
      }
      
      public function hide() : void
      {
         if(var_3567)
         {
            var_3567.stop();
         }
         if(container)
         {
            container.visible = false;
            container.procedure = null;
         }
      }
      
      public function show() : void
      {
         var_3567.start();
         var_3524 = 0;
         if(container)
         {
            container.visible = true;
            container.procedure = onTriggered;
         }
      }
      
      private function onTriggered(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         var_1629.infoCtrl.cancelCrafting();
      }
      
      private function get container() : IWindowContainer
      {
         if(!var_1629 || !var_1629.window)
         {
            return null;
         }
         return var_1629.window.findChildByName("progress_bar") as IWindowContainer;
      }
   }
}
