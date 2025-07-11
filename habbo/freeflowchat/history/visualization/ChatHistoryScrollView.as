package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.history.*;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_3535;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_3536;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ChatHistoryScrollView implements IDisposable
   {
       
      
      private var var_1660:HabboFreeFlowChat;
      
      private var _historyBuffer:ChatHistoryBuffer;
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var var_1985:Stage;
      
      private var var_1834:Vector.<class_3536>;
      
      private var var_3348:int = 0;
      
      private var var_3074:Rectangle;
      
      private var _visibleWidth:int = 0;
      
      private var var_4197:int;
      
      private var var_4708:int;
      
      private var var_2128:Sprite;
      
      private var var_2341:Boolean = false;
      
      private var _scrollBar:ChatHistoryScrollBar;
      
      private var _ignore:Bitmap;
      
      private var var_1770:class_3536;
      
      public function ChatHistoryScrollView(param1:HabboFreeFlowChat, param2:ChatHistoryBuffer)
      {
         super();
         var_1660 = param1;
         _historyBuffer = param2;
         _rootDisplayObject = new Sprite();
         _rootDisplayObject.x = 0;
         _rootDisplayObject.y = 0;
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
         _scrollBar = new ChatHistoryScrollBar(this,param1);
         _ignore = new Bitmap();
         _ignore.bitmapData = BitmapData(var_1660.assets.getAssetByName("close_x").content);
         var_1770 = null;
      }
      
      public function dispose() : void
      {
         deactivateScrolling();
         deactivateView();
         var_2128 = null;
         _ignore = null;
         var_1770 = null;
         if(_rootDisplayObject)
         {
            _rootDisplayObject.removeEventListener("addedToStage",onAddedToStage);
            _rootDisplayObject = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_2128 == null && _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function activateView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:class_3536 = null;
         var _loc1_:class_3535 = null;
         if(!_historyBuffer)
         {
            return;
         }
         deactivateView();
         var_1834 = new Vector.<class_3536>(_historyBuffer.entries.length);
         _loc4_ = 0;
         _loc3_ = -var_3348;
         while(_loc4_ < _historyBuffer.entries.length)
         {
            _loc2_ = new class_3536();
            _loc1_ = _historyBuffer.entries[_loc4_];
            _loc2_.roomId = _loc1_.roomId;
            _loc2_.userId = _loc1_.userId;
            _loc2_.bitmapData = _loc1_.bitmap;
            _loc2_.canIgnore = _loc1_.canIgnore;
            _loc2_.userName = _loc1_.userName;
            _loc3_ -= _loc1_.overlap.y;
            _loc2_.y = _loc3_;
            _loc2_.x = 3;
            _loc3_ += _loc2_.bitmapData.height;
            _loc3_ -= 8;
            var_1834[_loc4_] = _loc2_;
            _rootDisplayObject.addChild(var_1834[_loc4_]);
            _loc4_++;
         }
         _rootDisplayObject.addChild(_scrollBar.displayObject);
         var_2341 = true;
      }
      
      public function deactivateView() : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc1_ in var_1834)
         {
            _rootDisplayObject.removeChild(_loc1_);
            _loc1_.bitmapData = null;
         }
         if(var_1770 != null)
         {
            _rootDisplayObject.removeChild(_ignore);
            var_1770 = null;
         }
         var_1834 = new Vector.<class_3536>(0);
         if(_scrollBar.displayObject != null && _scrollBar.displayObject.parent == _rootDisplayObject)
         {
            _rootDisplayObject.removeChild(_scrollBar.displayObject);
         }
         var_2341 = false;
      }
      
      public function activateScrolling() : void
      {
         deactivateScrolling();
         _rootDisplayObject.stage.addEventListener("mouseDown",mouseDragEventHandler);
         var_1985 = _rootDisplayObject.stage;
         var_1985.addEventListener("resize",onStageResized);
      }
      
      public function deactivateScrolling() : void
      {
         if(var_1985)
         {
            var_1985.removeEventListener("mouseDown",mouseDragEventHandler);
            var_1985.removeEventListener("mouseMove",mouseDragEventHandler,true);
            var_1985.removeEventListener("mouseUp",mouseDragEventHandler);
            var_1985.removeEventListener("resize",onStageResized);
         }
      }
      
      public function get topY() : int
      {
         return var_3348;
      }
      
      public function get bufferHeight() : int
      {
         return _historyBuffer.totalHeight;
      }
      
      public function set topY(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:class_3535 = null;
         var_3348 = param1;
         if(var_1834)
         {
            _loc4_ = 0;
            _loc3_ = -var_3348;
            while(_loc4_ < _historyBuffer.entries.length)
            {
               if(var_1834.length <= _loc4_)
               {
                  break;
               }
               _loc2_ = _historyBuffer.entries[_loc4_];
               _loc3_ -= _loc2_.overlap.y;
               var_1834[_loc4_].y = _loc3_;
               _loc3_ += _loc2_.bitmap.height - 8;
               _loc4_++;
            }
         }
         if(var_1770 != null)
         {
            _ignore.y = var_1770.y + (var_1770.height - _ignore.height) / 2;
         }
         _scrollBar.updateThumbTrack();
      }
      
      public function addHistoryEntry(param1:class_3535) : void
      {
         var _loc2_:class_3536 = new class_3536();
         _loc2_.bitmapData = param1.bitmap;
         _loc2_.y = -var_3348 + _historyBuffer.totalHeight - param1.bitmap.height + 8;
         _loc2_.x = 3;
         _loc2_.userId = param1.userId;
         _loc2_.roomId = param1.roomId;
         _loc2_.canIgnore = param1.canIgnore;
         _loc2_.userName = param1.userName;
         var_1834.push(_loc2_);
         _rootDisplayObject.addChild(var_1834[var_1834.length - 1]);
      }
      
      public function scrollUpAndSpliceTopItem(param1:int) : void
      {
         if(var_1834 && var_1834.length > 0)
         {
            _rootDisplayObject.removeChild(var_1834[0]);
            var_1834.splice(0,1);
            for each(var _loc2_ in var_1834)
            {
               _loc2_.y -= param1;
            }
         }
      }
      
      public function get viewPort() : Rectangle
      {
         return var_3074;
      }
      
      public function set viewPort(param1:Rectangle) : void
      {
         var_3074 = param1;
         _rootDisplayObject.width = param1.width;
         _rootDisplayObject.height = param1.height;
         _rootDisplayObject.scaleX = 1;
         _rootDisplayObject.scaleY = 1;
         if(!var_2128)
         {
            var_2128 = new Sprite();
            _rootDisplayObject.addChild(var_2128);
         }
         var_2128.graphics.clear();
         var_2128.graphics.beginFill(16777215);
         var_2128.graphics.drawRect(0,0,viewPort.width,viewPort.height);
         _rootDisplayObject.mask = var_2128;
         _scrollBar.displayObject.x = var_3074.width - 0;
         viewBottom = param1.height;
      }
      
      public function set viewBottom(param1:int) : void
      {
         _rootDisplayObject.y = param1 - var_3074.height;
         _scrollBar.height = param1;
         _scrollBar.displayObject.y = var_3074.height - param1;
      }
      
      public function set viewWidth(param1:int) : void
      {
         _visibleWidth = param1;
         _scrollBar.displayObject.x = _visibleWidth - 0;
      }
      
      public function scrollToBottom() : void
      {
         topY = _historyBuffer.totalHeight - viewPort.height + 100;
      }
      
      public function get isActive() : Boolean
      {
         return var_2341;
      }
      
      private function findSpriteAtY(param1:int) : class_3536
      {
         for each(var _loc2_ in var_1834)
         {
            if(param1 >= _loc2_.y && param1 <= _loc2_.y + _loc2_.height)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function mouseDragEventHandler(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:class_3536 = null;
         if(!_rootDisplayObject || !_rootDisplayObject.stage)
         {
            return;
         }
         var _loc2_:MouseEvent = MouseEvent(param1);
         switch(_loc2_.type)
         {
            case "mouseDown":
               if(_loc2_.stageY < _rootDisplayObject.y + var_3074.height && _loc2_.stageX < _scrollBar.displayObject.x)
               {
                  _scrollBar.endScroll();
                  var_4197 = _loc2_.stageY;
                  var_4708 = topY;
                  var_1985.addEventListener("mouseMove",mouseDragEventHandler,true);
                  var_1985.addEventListener("mouseUp",mouseDragEventHandler);
               }
               break;
            case "mouseMove":
               _loc5_ = _loc2_.stageY - var_4197;
               topY = var_4708 - _loc5_;
               param1.stopImmediatePropagation();
               break;
            case "mouseUp":
               var_1985.removeEventListener("mouseMove",mouseDragEventHandler,true);
               var_1985.removeEventListener("mouseUp",mouseDragEventHandler);
               if((_loc4_ = _loc2_.stageY - var_4197) < 1 && _loc4_ > -1)
               {
                  if(!hitIgnore(_loc2_.stageX,_loc2_.stageY))
                  {
                     _loc3_ = findSpriteAtY(_loc2_.stageY);
                     if(_loc3_)
                     {
                        onEntrySpriteClicked(_loc3_);
                        moveIgnore(_loc3_);
                     }
                  }
                  break;
               }
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:Stage = _rootDisplayObject.stage;
         viewPort = new Rectangle(0,0,_loc2_.stageWidth,_loc2_.stageHeight - 50);
      }
      
      private function onStageResized(param1:Event) : void
      {
         if(var_1985)
         {
            viewPort = new Rectangle(0,0,var_1985.stageWidth,var_1985.stageHeight - 50);
         }
      }
      
      private function onEntrySpriteClicked(param1:class_3536) : void
      {
         if(!var_1660)
         {
            return;
         }
         var_1660.selectAvatar(param1.roomId,param1.userId);
      }
      
      private function moveIgnore(param1:class_3536) : void
      {
         if(!var_1660 || param1 == var_1770)
         {
            return;
         }
         if(!param1.canIgnore || var_1660.sessionDataManager.isIgnored(param1.userId))
         {
            if(var_1770 != null)
            {
               _rootDisplayObject.removeChild(_ignore);
               var_1770 = null;
            }
            return;
         }
         _ignore.x = param1.x + param1.width + 5;
         _ignore.y = param1.y + (param1.height - _ignore.height) / 2;
         _rootDisplayObject.addChild(_ignore);
         var_1770 = param1;
      }
      
      private function hitIgnore(param1:int, param2:int) : Boolean
      {
         if(var_1770 == null || param1 < _ignore.x || param1 > _ignore.x + _ignore.width || param2 < _ignore.y || param2 > _ignore.y + _ignore.height)
         {
            return false;
         }
         var_1660.localizations.registerParameter("chat.ignore_user.confirm.info","username",var_1770.userName);
         var _loc4_:String = String(var_1660.localizations.getLocalization("chat.ignore_user.confirm.title"));
         var _loc3_:String = String(var_1660.localizations.getLocalization("chat.ignore_user.confirm.info"));
         var_1660.windowManager.confirmWithModal(_loc4_,_loc3_,0,ignoreConfirmDialogEventProcessor);
         return true;
      }
      
      private function ignoreConfirmDialogEventProcessor(param1:class_3441, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_1660.sessionDataManager.ignoreUser(var_1770.userId);
         }
         if(var_1770 != null)
         {
            _rootDisplayObject.removeChild(_ignore);
            var_1770 = null;
         }
      }
   }
}
