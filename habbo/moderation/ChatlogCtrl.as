package com.sulake.habbo.moderation
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.StringUtil;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1757;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1774;
   
   public class ChatlogCtrl implements IDisposable, ITrackedWindow, class_3593
   {
      
      private static var CHAT_LINE_POOL:Array = [];
      
      private static var CHAT_LINE_POOL_MAX_SIZE:int = 1000;
      
      private static const CHAT_REPORTED_USER_COLOUR:uint = 4293973667;
      
      private static const CHAT_REPORTEE_COLOUR:uint = 4288921072;
       
      
      private var var_329:int;
      
      private var var_280:int;
      
      private var _msg:IMessageComposer;
      
      private var _main:ModerationManager;
      
      private var _frame:IWindowContainer;
      
      private var var_19:IItemListWindow;
      
      private var _rooms:Array;
      
      private var _embedded:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_2677:IWindowContainer;
      
      private var var_3266:IWindowContainer;
      
      private var _hilitedUserIds:Dictionary;
      
      private var var_2303:Timer;
      
      private var var_3808:Map;
      
      private var var_3769:class_1722;
      
      private var var_2709:Array;
      
      private var _headers:Array;
      
      public function ChatlogCtrl(param1:IMessageComposer, param2:ModerationManager, param3:int, param4:int, param5:class_1722 = null, param6:IWindowContainer = null, param7:IItemListWindow = null, param8:Boolean = false)
      {
         var_2709 = [];
         _headers = [];
         super();
         _main = param2;
         var_329 = param3;
         var_280 = param4;
         _msg = param1;
         var_3808 = new Map();
         var_3769 = param5;
         _frame = param6;
         var_19 = param7;
         _embedded = param8;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         var _loc2_:IWindow = null;
         var _loc1_:class_3514 = class_3514(_main.getXmlWindow("evidence_frame"));
         _loc1_.visible = false;
         var _loc3_:IItemListWindow = IItemListWindow(_loc1_.findChildByName("evidence_list"));
         var_3266 = _loc3_.getListItemAt(0) as IWindowContainer;
         var_2677 = _loc3_.getListItemAt(1) as IWindowContainer;
         _loc3_.removeListItems();
         var_2303 = new Timer(1000,1);
         var_2303.addEventListener("timer",onResizeTimer);
         if(!_embedded)
         {
            _frame = _loc1_;
            _frame.procedure = onWindow;
            _frame.visible = true;
            _loc2_ = _frame.findChildByTag("close");
            _loc2_.procedure = onClose;
            var_19 = _loc3_;
         }
         else
         {
            _loc1_.dispose();
         }
         _main.connection.send(_msg);
         _main.messageHandler.addChatlogListener(this);
      }
      
      public function hide() : void
      {
         dispose();
      }
      
      public function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary) : void
      {
         var _loc6_:* = null;
         if(param2 != var_329 || param3 != var_280 || _disposed)
         {
            return;
         }
         for each(_loc6_ in var_2709)
         {
            recycleContentLine(_loc6_);
         }
         for each(_loc6_ in _headers)
         {
            _loc6_.dispose();
         }
         var_2709 = [];
         _headers = [];
         _main.messageHandler.removeChatlogListener(this);
         _rooms = param4;
         _hilitedUserIds = param5;
         populate();
         onResizeTimer(null);
         if(!_embedded)
         {
            _frame.caption = param1;
            _frame.visible = true;
         }
      }
      
      public function getType() : int
      {
         return var_329;
      }
      
      public function getId() : String
      {
         return "" + var_280;
      }
      
      public function setId(param1:int) : void
      {
         var_280 = param1;
      }
      
      public function getFrame() : class_3514
      {
         return _frame as class_3514;
      }
      
      private function populate() : void
      {
         var _loc1_:* = null;
         var_19.autoArrangeItems = false;
         var_19.removeListItems();
         for each(_loc1_ in _rooms)
         {
            populateEvidence(_loc1_);
         }
         var_19.autoArrangeItems = true;
      }
      
      private function populateEvidence(param1:class_1757) : void
      {
         var _loc10_:String = null;
         var _loc7_:int = 0;
         var _loc8_:class_1774 = null;
         var _loc6_:IWindowContainer;
         var _loc9_:IWindow = (_loc6_ = createHeaderLine()).findChildByName("text");
         var _loc2_:class_3357 = class_3357(_loc6_.findChildByName("btnHeaderAction"));
         var _loc3_:class_3357 = class_3357(_loc6_.findChildByName("btnHeaderAction2"));
         if(_loc3_)
         {
            _loc3_.visible = false;
         }
         switch(param1.recordType - 1)
         {
            case 0:
               if(param1.roomId > 0)
               {
                  _loc2_.caption = "Room tool";
                  if(param1.roomName == null)
                  {
                     _loc9_.caption = "Room #" + param1.roomId;
                  }
                  else
                  {
                     _loc9_.caption = "Room: " + param1.roomName;
                  }
                  _loc3_.visible = true;
                  _loc3_.caption = "View room";
                  new OpenRoomInSpectatorMode(_main,_loc3_,param1.roomId);
                  if(_embedded)
                  {
                     new OpenRoomTool(null,_main,_loc2_,param1.roomId);
                  }
                  else
                  {
                     new OpenRoomTool(_frame as class_3514,_main,_loc2_,param1.roomId);
                  }
               }
               break;
            case 1:
               _loc9_.caption = "IM session";
               break;
            case 2:
               _loc9_.caption = "Forum thread";
               _loc3_.visible = true;
               _loc3_.caption = "Open thread";
               new OpenDiscussionThread(_main,_loc3_,param1.groupId,param1.threadId);
               _loc2_.caption = "Delete";
               new HideDiscussionThread(_main,this,_loc2_,param1.groupId,param1.threadId);
               break;
            case 3:
               _loc9_.caption = "Forum message";
               _loc3_.visible = true;
               _loc3_.caption = "Open Message";
               new OpenDiscussionMessage(_main,_loc3_,param1.groupId,param1.threadId,param1.context.messageIndex);
               _loc2_.caption = "Delete";
               new HideDiscussionMessage(_main,this,_loc2_,param1.groupId,param1.threadId,param1.messageId);
               break;
            case 4:
               _loc9_.caption = "Selfie report";
               _loc3_.visible = true;
               _loc3_.caption = "View selfie";
               new OpenExternalLink(_main,_loc3_,param1.context.url);
               _loc2_.visible = true;
               _loc2_.caption = "Room tool";
               if(_embedded)
               {
                  new OpenRoomTool(null,_main,_loc2_,param1.roomId);
               }
               else
               {
                  new OpenRoomTool(_frame as class_3514,_main,_loc2_,param1.roomId);
               }
               break;
            case 5:
               _loc9_.caption = "Photo report";
               _loc3_.visible = true;
               _loc3_.caption = "Moderate photo";
               _loc10_ = _main.getProperty("stories.admin.tool.base.url");
               if(StringUtil.isEmpty(_loc10_))
               {
                  _loc10_ = "https://theallseeingeye.sulake.com/habbo-stories-admin/#/photos/";
               }
               _loc10_ += param1.context.extraDataId;
               new OpenExternalLink(_main,_loc3_,_loc10_);
               _loc2_.visible = true;
               _loc2_.caption = "Room tool";
               if(_embedded)
               {
                  new OpenRoomTool(null,_main,_loc2_,param1.roomId);
               }
               else
               {
                  new OpenRoomTool(_frame as class_3514,_main,_loc2_,param1.roomId);
               }
         }
         addHeaderLineToList(_loc6_);
         var _loc4_:* = true;
         var _loc5_:* = -1;
         _loc7_ = 0;
         while(_loc7_ < param1.chatlog.length)
         {
            _loc8_ = param1.chatlog[_loc7_];
            populateContentLine(_loc8_,_loc4_);
            _loc4_ = !_loc4_;
            if(_loc8_.hasHighlighting && _loc5_ == -1)
            {
               _loc5_ = _loc7_;
            }
            _loc7_++;
         }
         if(_loc5_ > -1)
         {
            var_19.autoArrangeItems = true;
            if(var_19.maxScrollV > 0)
            {
               var_19.scrollV = var_19.getListItemAt(_loc5_).y / var_19.maxScrollV;
            }
         }
      }
      
      private function addContentLineToList(param1:IWindowContainer) : void
      {
         var_19.addListItem(param1);
         var_2709.push(param1);
      }
      
      private function addHeaderLineToList(param1:IWindowContainer) : void
      {
         var_19.addListItem(param1);
         _headers.push(param1);
      }
      
      private function createContentLine() : IWindowContainer
      {
         if(CHAT_LINE_POOL.length > 0)
         {
            return CHAT_LINE_POOL.pop() as IWindowContainer;
         }
         return IWindowContainer(var_2677.clone());
      }
      
      private function recycleContentLine(param1:IWindowContainer) : void
      {
         var _loc2_:ITextWindow = null;
         if(CHAT_LINE_POOL.length < CHAT_LINE_POOL_MAX_SIZE)
         {
            _loc2_ = ITextWindow(param1.findChildByName("chatter_txt"));
            _loc2_.removeEventListener("WME_CLICK",onUserClick);
            param1.width = var_2677.width;
            param1.height = var_2677.height - 10;
            CHAT_LINE_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function createHeaderLine() : IWindowContainer
      {
         return var_3266.clone() as IWindowContainer;
      }
      
      private function populateContentLine(param1:class_1774, param2:Boolean) : void
      {
         var _loc5_:TextFormat = null;
         var _loc7_:IWindowContainer;
         var _loc8_:IWindow = (_loc7_ = createContentLine()).findChildByName("time_txt");
         var _loc4_:ITextWindow = ITextWindow(_loc7_.findChildByName("chatter_txt"));
         var _loc6_:ITextWindow = _loc7_.findChildByName("msg_txt") as ITextWindow;
         _loc8_.caption = param1.timeStamp;
         var _loc9_:*;
         if((_loc9_ = _hilitedUserIds[param1.chatterId]) != null)
         {
            _loc7_.color = _loc9_ as int == 0 ? 4293973667 : 4288921072;
         }
         else
         {
            _loc7_.color = param2 ? 4291030266 : 4294967295;
         }
         if(param1.hasHighlighting)
         {
            (_loc5_ = _loc6_.getTextFormat()).bold = true;
            _loc6_.setTextFormat(_loc5_);
            _loc6_.bold = true;
         }
         if(param1.chatterId > 0)
         {
            _loc4_.text = param1.chatterName;
            _loc4_.underline = true;
            _loc4_.addEventListener("WME_CLICK",onUserClick);
            if(!var_3808.getValue(param1.chatterName))
            {
               var_3808.add(param1.chatterName,param1.chatterId);
            }
         }
         else if(param1.chatterId == 0)
         {
            _loc4_.text = "Bot / pet";
            _loc4_.underline = false;
         }
         else
         {
            _loc4_.text = "-";
            _loc4_.underline = false;
         }
         _loc4_.color = _loc7_.color;
         _loc8_.color = _loc7_.color;
         _loc6_.color = _loc7_.color;
         _loc6_.text = param1.msg;
         var _loc3_:int = Math.max(_loc8_.height,_loc6_.textHeight + 5);
         _loc6_.height = _loc3_;
         if(_loc6_.getTextFormat())
         {
            _loc6_.getTextFormat().align = "left";
            _loc6_.getTextFormat().rightMargin = _loc6_.getTextFormat().rightMargin + 10;
         }
         _loc4_.height = _loc3_;
         _loc8_.height = _loc3_;
         _loc7_.height = _loc3_;
         addContentLineToList(_loc7_);
      }
      
      private function onUserClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = param1.target.caption;
         var _loc3_:int = var_3808.getValue(_loc2_);
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,_loc3_,var_3769),_frame as class_3514,false,false,true);
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         var_2303.reset();
         var_2303.start();
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         refreshListDims();
         var _loc2_:Boolean = refreshScrollBarVisibility();
      }
      
      private function refreshListDims() : void
      {
         var _loc4_:IWindowContainer = null;
         var _loc2_:ITextWindow = null;
         var _loc3_:int = 0;
         var_19.autoArrangeItems = false;
         var _loc1_:int = var_19.numListItems;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if((_loc4_ = IWindowContainer(var_19.getListItemAt(_loc3_))).name == "chatline")
            {
               _loc2_ = ITextWindow(_loc4_.findChildByName("msg_txt"));
               _loc2_.width = _loc4_.width - _loc2_.x;
               _loc2_.height = _loc2_.textHeight + 5;
               _loc4_.height = _loc2_.height;
            }
            _loc3_++;
         }
         var_19.autoArrangeItems = true;
      }
      
      private function refreshScrollBarVisibility() : Boolean
      {
         var _loc2_:IWindowContainer = IWindowContainer(var_19.parent);
         var _loc4_:IWindow = _loc2_.getChildByName("scroller") as IWindow;
         var _loc3_:* = var_19.scrollableRegion.height > var_19.height;
         var _loc1_:int = 22;
         if(_loc4_.visible)
         {
            if(_loc3_)
            {
               return false;
            }
            _loc4_.visible = false;
            var_19.width += _loc1_;
            return true;
         }
         if(_loc3_)
         {
            _loc4_.visible = true;
            var_19.width -= _loc1_;
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main = null;
         _msg = null;
         var_3769 = null;
         if(var_19 != null)
         {
            var_19.removeListItems();
            var_19.dispose();
            var_19 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _rooms = null;
         _hilitedUserIds = null;
         if(var_2303 != null)
         {
            var_2303.stop();
            var_2303.removeEventListener("timer",onResizeTimer);
            var_2303 = null;
         }
         if(!_embedded)
         {
            for each(_loc1_ in var_2709)
            {
               recycleContentLine(_loc1_);
            }
            for each(_loc1_ in _headers)
            {
               _loc1_.dispose();
            }
         }
         var_2709 = [];
         _headers = [];
         if(var_2677 != null)
         {
            var_2677.dispose();
            var_2677 = null;
         }
         if(var_3266 != null)
         {
            var_3266.dispose();
            var_3266 = null;
         }
      }
   }
}
