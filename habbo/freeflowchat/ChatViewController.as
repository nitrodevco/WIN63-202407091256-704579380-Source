package com.sulake.habbo.freeflowchat
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryTray;
   import com.sulake.habbo.freeflowchat.viewer.ChatFlowViewer;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   
   public class ChatViewController implements IDisposable
   {
       
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var var_1985:Stage;
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_4020:ChatFlowViewer;
      
      private var _pulldown:ChatHistoryTray;
      
      private var _flowViewerDisplayObject:DisplayObject;
      
      private var _pulldownDisplayObject:DisplayObject;
      
      public function ChatViewController(param1:HabboFreeFlowChat, param2:ChatFlowViewer, param3:ChatHistoryTray)
      {
         super();
         var_1660 = param1;
         var_4020 = param2;
         _pulldown = param3;
         _flowViewerDisplayObject = var_4020.rootDisplayObject;
         _pulldownDisplayObject = _pulldown.rootDisplayObject;
         _rootDisplayObject = new Sprite();
         _rootDisplayObject.addChild(_flowViewerDisplayObject);
         _rootDisplayObject.addChild(_pulldownDisplayObject);
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
      }
      
      public function dispose() : void
      {
         if(_rootDisplayObject)
         {
            var_1660.removeUpdateReceiver(_pulldown);
            if(var_1985)
            {
               var_1985.removeEventListener("resize",onStageResized);
            }
            _rootDisplayObject.removeChild(_pulldownDisplayObject);
            _rootDisplayObject.removeChild(_flowViewerDisplayObject);
            _rootDisplayObject.removeEventListener("addedToStage",onAddedToStage);
            _rootDisplayObject = null;
            _pulldownDisplayObject = null;
            _flowViewerDisplayObject = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObject
      {
         return _rootDisplayObject;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var_1985 = _rootDisplayObject.stage;
         var_1985.addEventListener("resize",onStageResized);
         _pulldown.resize(var_1985.stageWidth,var_1985.stageHeight);
         var_1660.registerUpdateReceiver(_pulldown,200);
      }
      
      private function onStageResized(param1:Event) : void
      {
         _pulldown.resize(var_1985.stageWidth,var_1985.stageHeight);
         var_4020.resize(var_1985.stageWidth,var_1985.stageHeight);
      }
   }
}
