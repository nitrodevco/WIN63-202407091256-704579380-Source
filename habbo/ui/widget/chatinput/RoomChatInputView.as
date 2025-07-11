package com.sulake.habbo.ui.widget.chatinput
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3542;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.freeflowchat.class_1809;
   import com.sulake.habbo.freeflowchat.style.class_3632;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.chatinput.styleselector.ChatStyleSelector;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class RoomChatInputView
   {
      
      private static const MARGIN_H:int = 12;
      
      private static const CHAT_HELP_INTERNAL_CLIENT_LINK:String = "habbopages/chat/commands";
       
      
      private var var_1629:RoomChatInputWidget;
      
      private var _window:IWindowContainer;
      
      private var var_1639:ITextFieldWindow;
      
      private var var_4248:IWindow;
      
      private var var_3009:IWindow;
      
      private var var_1947:class_3542;
      
      private var var_2572:IRegionWindow;
      
      private var var_3372:Boolean = false;
      
      private var var_1697:IWindowContainer;
      
      private var var_4651:IWindowContainer;
      
      private var _chatModeIdShout:String;
      
      private var var_3467:String;
      
      private var var_4447:String;
      
      private var var_3355:Boolean = false;
      
      private var var_4547:TextFormat;
      
      private var var_514:Boolean = false;
      
      private var var_3035:Boolean = false;
      
      private var var_2102:Timer;
      
      private var var_2200:Timer;
      
      private var var_1876:Timer;
      
      private var var_2026:String = "";
      
      private var var_2124:Timer;
      
      private var var_4132:Boolean = false;
      
      private var var_2015:Timer;
      
      private var var_3870:int = 0;
      
      private var var_2456:Timer;
      
      private var var_2440:ChatStyleSelector;
      
      public function RoomChatInputView(param1:RoomChatInputWidget)
      {
         var _loc3_:ICoreConfiguration = null;
         var _loc2_:int = 0;
         super();
         var_1629 = param1;
         var_3467 = param1.localizations.getLocalization("widgets.chatinput.mode.whisper",":tell");
         _chatModeIdShout = param1.localizations.getLocalization("widgets.chatinput.mode.shout",":shout");
         var_4447 = param1.localizations.getLocalization("widgets.chatinput.mode.speak",":speak");
         var_2102 = new Timer(1000,1);
         var_2102.addEventListener("timerComplete",onTypingTimerComplete);
         var_2200 = new Timer(10000,1);
         var_2200.addEventListener("timerComplete",onIdleTimerComplete);
         var_4132 = sessionDataManager.isNoob || sessionDataManager.isRealNoob;
         if(var_4132)
         {
            _loc3_ = param1.handler.container.config;
            if(_loc3_.getProperty("nux.chat.reminder.shown") != "1")
            {
               _loc2_ = int(_loc3_.getInteger("nux.noob.chat.reminder.delay",240));
               var_1876 = new Timer(_loc2_ * 1000,1);
               var_1876.addEventListener("timerComplete",onNuxIdleTimerComplete);
               var_1876.start();
            }
         }
         var_4547 = new TextFormat(null,null,10066329,null,true,false);
         createWindow();
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(var_4132)
         {
            widget.windowManager.hideHint();
            widget.windowManager.unregisterHintWindow("nux_chat_reminder");
         }
         var_1629 = null;
         if(var_1639)
         {
            var_1639.removeEventListener("WME_DOWN",windowMouseEventProcessor);
            var_1639.removeEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
            var_1639.removeEventListener("WKE_KEY_UP",keyUpHandler);
            var_1639.removeEventListener("WE_CHANGE",onInputChanged);
            var_1639.removeEventListener("WME_OVER",onInputHoverRegionMouseEvent);
            var_1639.removeEventListener("WME_OUT",onInputHoverRegionMouseEvent);
            var_1639 = null;
         }
         var_4248 = null;
         var_3009 = null;
         if(var_1947)
         {
            var_1947.removeEventListener("WME_CLICK",onHelpButtonMouseEvent);
            var_1947.removeEventListener("WME_OVER",onHelpButtonMouseEvent);
            var_1947.removeEventListener("WME_OUT",onHelpButtonMouseEvent);
            var_1947 = null;
         }
         if(var_2572)
         {
            var_2572.removeEventListener("WME_OVER",onInputHoverRegionMouseEvent);
            var_2572.removeEventListener("WME_OUT",onInputHoverRegionMouseEvent);
            var_2572 = null;
         }
         if(var_1697 != null)
         {
            var_1697.dispose();
            var_1697 = null;
         }
         if(var_2102 != null)
         {
            var_2102.reset();
            var_2102.removeEventListener("timerComplete",onTypingTimerComplete);
            var_2102 = null;
         }
         if(var_2200 != null)
         {
            var_2200.reset();
            var_2200.removeEventListener("timerComplete",onIdleTimerComplete);
            var_2200 = null;
         }
         if(var_1876 != null)
         {
            var_1876.reset();
            var_1876.removeEventListener("timerComplete",onNuxIdleTimerComplete);
            var_1876 = null;
         }
         if(var_2015 != null)
         {
            var_2015.reset();
            var_2015.removeEventListener("timerComplete",onChatReminderTimer);
            var_2015 = null;
         }
         if(var_2124)
         {
            var_2124.reset();
            var_2124.removeEventListener("timerComplete",onRemoveDimmer);
            var_2124 = null;
         }
         if(_window && _window.desktop)
         {
            _window.desktop.removeChild(_window);
         }
      }
      
      private function createWindow() : void
      {
         var _loc6_:ISessionDataManager = null;
         var _loc8_:class_1809 = null;
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc9_:class_3632 = null;
         if(var_1697 != null)
         {
            return;
         }
         var _loc7_:String = "chatinput_window_new";
         var _loc5_:XmlAsset;
         if((_loc5_ = var_1629.assets.getAssetByName(_loc7_) as XmlAsset) == null || _loc5_.content == null)
         {
            return;
         }
         _window = var_1629.windowManager.buildFromXML(_loc5_.content as XML) as IWindowContainer;
         _window.width = _window.desktop.width;
         _window.height = _window.desktop.height;
         _window.invalidate();
         var_4651 = IWindowContainer(_window.findChildByName("chatstyles_menu"));
         var_1697 = _window.findChildByName("bubblecont") as IWindowContainer;
         var_1697.tags.push("room_widget_chatinput");
         var_1639 = var_1697.findChildByName("chat_input") as ITextFieldWindow;
         var_4248 = var_1697.findChildByName("input_border");
         var_3009 = var_1697.findChildByName("block_text");
         var_2572 = IRegionWindow(var_1697.findChildByName("helpbutton_show_hover_region"));
         var_2572.addEventListener("WME_OVER",onInputHoverRegionMouseEvent);
         var_2572.addEventListener("WME_OUT",onInputHoverRegionMouseEvent);
         updatePosition();
         var_1639.setParamFlag(1,true);
         var_1639.addEventListener("WME_DOWN",windowMouseEventProcessor);
         var_1639.addEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
         var_1639.addEventListener("WKE_KEY_UP",keyUpHandler);
         var_1639.addEventListener("WE_CHANGE",onInputChanged);
         var_1639.addEventListener("WME_OVER",onInputHoverRegionMouseEvent);
         var_1639.addEventListener("WME_OUT",onInputHoverRegionMouseEvent);
         var_1639.toolTipDelay = 0;
         var_1639.toolTipIsDynamic = true;
         var_3355 = true;
         var_1639.setTextFormat(var_4547);
         var_2026 = "";
         _window.addEventListener("WE_PARENT_RESIZED",updatePosition);
         _window.addEventListener("WE_PARENT_ADDED",updatePosition);
         if(customChatStylesEnabled() && !var_1629.handler.container.roomSession.isGameSession && var_1629.handler.container.freeFlowChat != null && var_1629.handler.container.freeFlowChat.chatStyleLibrary != null)
         {
            _loc6_ = var_1629.handler.container.sessionDataManager;
            _loc8_ = var_1629.handler.container.freeFlowChat;
            _loc1_ = [];
            _loc2_ = var_1629.roomUi.getProperty("disabled.custom.chat.styles").split(",");
            _loc3_ = _loc6_.hasSecurity(4);
            for each(var _loc4_ in _loc8_.chatStyleLibrary.getStyleIds())
            {
               _loc9_ = _loc8_.chatStyleLibrary.getStyle(_loc4_);
               if(isNftChatStyle(_loc4_))
               {
                  if(_loc6_.hasNftChatStyle(_loc4_))
                  {
                     _loc1_.push(_loc4_);
                  }
                  else if(!_loc3_)
                  {
                     continue;
                  }
               }
               if(!_loc9_.isSystemStyle && _loc2_.indexOf(_loc4_.toString()) == -1)
               {
                  if(_loc9_.isHcOnly && _loc6_.hasClub)
                  {
                     _loc1_.push(_loc4_);
                  }
                  else if(!_loc9_.isHcOnly && !_loc9_.isAmbassadorOnly)
                  {
                     _loc1_.push(_loc4_);
                  }
               }
               if(_loc9_.isStaffOverrideable && _loc3_)
               {
                  _loc1_.push(_loc4_);
               }
               if(_loc9_.isAmbassadorOnly && (_loc3_ || _loc6_.isAmbassador))
               {
                  _loc1_.push(_loc4_);
               }
            }
            removeDuplicateStyles(_loc1_);
            createChatStyleSelectorMenuItems(_loc1_);
         }
         else if(var_1697.findChildByName("chat_input_container") is IItemListWindow)
         {
            IItemListWindow(var_1697.findChildByName("chat_input_container")).removeListItemAt(0);
         }
         createAndAttachDimmerWindow();
         var_1947 = class_3542(_window.findChildByName("helpbutton"));
         var_1947.addEventListener("WME_CLICK",onHelpButtonMouseEvent);
         var_1947.addEventListener("WME_OVER",onHelpButtonMouseEvent);
         var_1947.addEventListener("WME_OUT",onHelpButtonMouseEvent);
         var_1947.visible = false;
      }
      
      private function removeDuplicateStyles(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length - 1)
         {
            _loc3_ = _loc2_ + 1;
            while(_loc3_ < param1.length)
            {
               if(param1[_loc2_] === param1[_loc3_])
               {
                  param1.splice(_loc3_--,1);
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function isNftChatStyle(param1:int) : Boolean
      {
         return param1 >= 1000;
      }
      
      private function customChatStylesEnabled() : Boolean
      {
         return var_1629.roomUi.getBoolean("custom.chat.styles.enabled");
      }
      
      private function createAndAttachDimmerWindow() : void
      {
         var _loc1_:IWindow = null;
         if(RoomEnterEffect.isRunning())
         {
            _loc1_ = var_1629.windowManager.createWindow("chat_dimmer","",30,1,128 | 2048 | 1,new Rectangle(0,0,var_1697.width,var_1697.height),null,0);
            _loc1_.color = 0;
            _loc1_.blend = 0.3;
            var_1697.addChild(_loc1_);
            var_1697.invalidate();
            if(var_2124 == null)
            {
               var_2124 = new Timer(RoomEnterEffect.totalRunningTime,1);
               var_2124.addEventListener("timerComplete",onRemoveDimmer);
               var_2124.start();
            }
         }
      }
      
      private function onRemoveDimmer(param1:TimerEvent) : void
      {
         var_2124.removeEventListener("timerComplete",onRemoveDimmer);
         var_2124 = null;
         var _loc2_:IWindow = var_1697.findChildByName("chat_dimmer");
         if(_loc2_ != null)
         {
            var_1697.removeChild(_loc2_);
            var_1629.windowManager.destroy(_loc2_);
         }
      }
      
      public function updatePosition(param1:WindowEvent = null, param2:int = 10000, param3:int = 10000) : void
      {
         _window.width = _window.desktop.width;
         _window.height = _window.desktop.height;
         var _loc9_:Point = new Point();
         if(!var_1697)
         {
            return;
         }
         var _loc4_:int = widget.getToolBarWidth();
         var _loc6_:int = widget.getFriendBarWidth();
         var _loc5_:int = _window.desktop.width / 2 - var_1697.width / 2;
         var _loc7_:int = 0;
         var _loc8_:int = var_1697.width + 12;
         if(_window.desktop.width - _loc4_ - _loc6_ > _loc8_)
         {
            _loc7_ = _loc4_ + 12;
            var_1697.y = _window.desktop.height - 104;
            if(_loc5_ + var_1697.width > _window.desktop.width - _loc6_)
            {
               _loc5_ = 0;
            }
         }
         else
         {
            _loc7_ = widget.getRoomToolsWidth() + 12;
            var_1697.y = _window.desktop.height - 160;
         }
         var_1697.x = Math.max(_loc5_,_loc7_);
         if(var_2440)
         {
            var_2440.alignMenuToSelector();
         }
      }
      
      private function onSend(param1:WindowMouseEvent) : void
      {
         if(!var_3355)
         {
            sendChatFromInputField();
         }
      }
      
      public function hideFloodBlocking() : void
      {
         var_1639.visible = true;
         var_3009.visible = false;
      }
      
      public function showFloodBlocking() : void
      {
         var_1639.visible = false;
         var_3009.visible = true;
      }
      
      public function updateBlockText(param1:int) : void
      {
         var_3009.caption = var_1629.localizations.registerParameter("chat.input.alert.flood","time",param1.toString());
      }
      
      public function displaySpecialChatMessage(param1:String, param2:String = "") : void
      {
         if(var_1697 == null || var_1639 == null)
         {
            return;
         }
         var_1639.enable();
         var_1639.selectable = true;
         var_1639.text = "";
         setInputFieldFocus();
         var_1639.text += param1 + " ";
         if(param2.length > 0)
         {
            var_1639.text += param2 + " ";
         }
         var_1639.setSelection(var_1639.text.length,var_1639.text.length);
         var_2026 = var_1639.text;
      }
      
      private function windowMouseEventProcessor(param1:WindowEvent = null, param2:IWindow = null) : void
      {
         setInputFieldFocus();
      }
      
      private function windowKeyEventProcessor(param1:WindowEvent = null, param2:IWindow = null) : void
      {
         var _loc7_:* = 0;
         var _loc3_:Boolean = false;
         var _loc6_:WindowKeyboardEvent = null;
         var _loc4_:KeyboardEvent = null;
         var _loc8_:String = null;
         var _loc5_:Array = null;
         if(var_1697 == null || var_1629 == null || var_1629.floodBlocked)
         {
            return;
         }
         if(anotherFieldHasFocus())
         {
            return;
         }
         setInputFieldFocus();
         if(param1 is WindowKeyboardEvent)
         {
            _loc7_ = (_loc6_ = param1 as WindowKeyboardEvent).charCode;
            _loc3_ = _loc6_.shiftKey;
         }
         if(param1 is KeyboardEvent)
         {
            _loc7_ = (_loc4_ = param1 as KeyboardEvent).charCode;
            _loc3_ = _loc4_.shiftKey;
         }
         if(_loc4_ == null && _loc6_ == null)
         {
            return;
         }
         if(_loc7_ == 32)
         {
            checkSpecialKeywordForInput();
         }
         if(_loc7_ == 13)
         {
            sendChatFromInputField(_loc3_);
            setButtonPressedState(true);
         }
         if(_loc7_ == 8)
         {
            if(var_1639 != null)
            {
               if((_loc5_ = (_loc8_ = String(var_1639.text)).split(" "))[0] == var_3467 && _loc5_.length == 3 && _loc5_[2] == "")
               {
                  var_1639.text = "";
                  var_2026 = "";
               }
            }
         }
      }
      
      private function keyUpHandler(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            setButtonPressedState(false);
         }
      }
      
      private function setButtonPressedState(param1:Boolean) : void
      {
      }
      
      private function onInputChanged(param1:WindowEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.window as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_2200.reset();
         var _loc3_:* = _loc2_.text.length == 0;
         if(_loc3_)
         {
            var_514 = false;
            var_2102.start();
         }
         else
         {
            if(_loc2_.text.length > var_2026.length + 1)
            {
               if(var_1629.allowPaste)
               {
                  var_1629.setLastPasteTime();
               }
               else
               {
                  _loc2_.text = "";
               }
            }
            var_2026 = _loc2_.text;
            if(!var_514)
            {
               var_514 = true;
               var_2102.reset();
               var_2102.start();
            }
            var_2200.start();
            if(var_1876 != null)
            {
               var_1876.reset();
               var_1876 = null;
            }
         }
      }
      
      private function checkSpecialKeywordForInput() : void
      {
         if(var_1639 == null || var_1639.text == "")
         {
            return;
         }
         var _loc2_:String = String(var_1639.text);
         var _loc1_:String = var_1629.selectedUserName;
         if(_loc2_ == var_3467)
         {
            if(_loc1_.length > 0)
            {
               var_1639.text += " " + var_1629.selectedUserName;
               var_1639.setSelection(var_1639.text.length,var_1639.text.length);
               var_2026 = var_1639.text;
            }
         }
      }
      
      private function onIdleTimerComplete(param1:TimerEvent) : void
      {
         if(var_514)
         {
            var_3035 = false;
         }
         var_514 = false;
         sendTypingMessage();
      }
      
      private function onNuxIdleTimerComplete(param1:TimerEvent) : void
      {
         if(var_1876 != null)
         {
            var_1876.reset();
            var_1876.removeEventListener("timerComplete",onNuxIdleTimerComplete);
            var_1876 = null;
         }
         highlightChatInput();
      }
      
      private function onTypingTimerComplete(param1:TimerEvent) : void
      {
         if(var_514)
         {
            var_3035 = true;
         }
         sendTypingMessage();
      }
      
      private function sendTypingMessage() : void
      {
         if(var_1629 == null)
         {
            return;
         }
         if(var_1629.floodBlocked)
         {
            return;
         }
         var _loc1_:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(var_514);
         var_1629.messageListener.processWidgetMessage(_loc1_);
      }
      
      private function highlightChatInput() : void
      {
         var_1639.text = widget.localizations.getLocalization("widgets.chatinput.mode.remind.noobie");
         var_2015 = new Timer(500);
         var_2015.addEventListener("timer",onChatReminderTimer);
         var_2015.start();
         widget.windowManager.registerHintWindow("nux_chat_reminder",var_1639);
         widget.windowManager.showHint("nux_chat_reminder");
      }
      
      private function onChatReminderTimer(param1:TimerEvent) : void
      {
         var_3870++;
         if(var_3870 % 2 != 0)
         {
            var_1629.mainWindow.y -= 1;
         }
         else
         {
            var_1629.mainWindow.y += 1;
         }
         if(var_3870 >= 10)
         {
            var_2015.reset();
            var_2015 = null;
            var_1629.mainWindow.y = 0;
            chatBarReminderShown();
         }
      }
      
      private function chatBarReminderShown() : void
      {
         widget.handler.container.config.setProperty("nux.chat.reminder.shown","1");
         if(var_2015 != null)
         {
            var_2015.reset();
         }
         widget.windowManager.hideHint();
         widget.windowManager.unregisterHintWindow("nux_chat_reminder");
      }
      
      private function setInputFieldFocus() : void
      {
         if(var_1639 == null)
         {
            return;
         }
         if(var_2015 != null)
         {
            chatBarReminderShown();
         }
         if(var_3355)
         {
            var_1639.text = "";
            var_1639.textColor = 0;
            var_1639.italic = false;
            var_3355 = false;
            var_2026 = "";
         }
         var_1639.focus();
      }
      
      public function setInputFieldColor(param1:uint) : void
      {
         if(var_1639 == null)
         {
            return;
         }
         var_1639.textColor = param1;
         var_1639.defaultTextFormat.color = param1;
      }
      
      private function sendChatFromInputField(param1:Boolean = false) : void
      {
         if(var_1639 == null || var_1639.text == "")
         {
            return;
         }
         var _loc7_:int = param1 ? 2 : 0;
         var _loc6_:String;
         var _loc4_:Array = (_loc6_ = String(var_1639.text)).split(" ");
         var _loc2_:String = "";
         var _loc5_:String = "";
         switch(_loc4_[0])
         {
            case var_3467:
               _loc7_ = 1;
               _loc2_ = String(_loc4_[1]);
               _loc5_ = var_3467 + " " + _loc2_ + " ";
               _loc4_.shift();
               _loc4_.shift();
               break;
            case _chatModeIdShout:
               _loc7_ = 2;
               _loc4_.shift();
               break;
            case var_4447:
               _loc7_ = 0;
               _loc4_.shift();
         }
         _loc6_ = _loc4_.join(" ");
         var _loc3_:int = 0;
         if(customChatStylesEnabled() && var_2440 != null)
         {
            _loc3_ = var_2440.selectedStyleId;
         }
         if(var_1629 != null)
         {
            if(var_2102.running)
            {
               var_2102.reset();
            }
            if(var_2200.running)
            {
               var_2200.reset();
            }
            var_1629.sendChat(_loc6_,_loc7_,_loc2_,_loc3_);
            var_514 = false;
            if(var_3035)
            {
               sendTypingMessage();
            }
            var_3035 = false;
         }
         if(var_1639 != null)
         {
            var_1639.text = _loc5_;
         }
         var_2026 = _loc5_;
      }
      
      private function anotherFieldHasFocus() : Boolean
      {
         var _loc3_:Stage = null;
         var _loc2_:InteractiveObject = null;
         if(var_1639 != null)
         {
            if(var_1639.focused)
            {
               return false;
            }
         }
         var _loc1_:DisplayObject = var_1697.context.getDesktopWindow().getDisplayObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.stage;
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.focus;
               if(_loc2_ == null)
               {
                  return false;
               }
               if(_loc2_ is TextField)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return var_1629.handler.container.sessionDataManager;
      }
      
      private function createChatStyleSelectorMenuItems(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!var_2440)
         {
            var_2440 = new ChatStyleSelector(this,IWindowContainer(var_1697.findChildByName("styles")),sessionDataManager);
            var_2440.gridColumns = param1.length / 6 + 1;
         }
         _loc3_ = param1.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = int(param1[_loc3_]);
            var_2440.addItem(_loc2_,var_1629.handler.container.freeFlowChat.chatStyleLibrary.getStyle(_loc2_).selectorPreview);
            _loc3_--;
         }
         var_2440.initSelection();
      }
      
      public function get widget() : RoomChatInputWidget
      {
         return var_1629;
      }
      
      public function get chatStyleMenuContainer() : IWindowContainer
      {
         return var_4651;
      }
      
      public function getChatInputY() : int
      {
         if(!_window || !_window.findChildByName("chat_input_container"))
         {
            return 0;
         }
         var _loc1_:Point = new Point();
         _window.findChildByName("chat_input_container").getGlobalPosition(_loc1_);
         return _loc1_.y;
      }
      
      public function getChatWindowElements() : Array
      {
         return [var_1697,var_1639];
      }
      
      private function onHelpButtonMouseEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_1629.roomUi.context.createLinkEvent("habbopages/chat/commands");
         }
         if(param1.type == "WME_OVER")
         {
            var_1947.visible = true;
            var_3372 = true;
            stopHelpButtonHideTimer();
         }
         else if(param1.type == "WME_OUT")
         {
            var_3372 = false;
            startHelpButtonHideTimer();
         }
      }
      
      private function onInputHoverRegionMouseEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OVER")
         {
            var_1947.visible = true;
            stopHelpButtonHideTimer();
         }
         else if(param1.type == "WME_OUT" && !var_3372)
         {
            startHelpButtonHideTimer();
         }
      }
      
      private function startHelpButtonHideTimer() : void
      {
         if(var_2456 != null)
         {
            stopHelpButtonHideTimer();
         }
         var_2456 = new Timer(400);
         var_2456.addEventListener("timer",onHelpButtonHideTimer);
         var_2456.start();
      }
      
      private function onHelpButtonHideTimer(param1:TimerEvent) : void
      {
         if(!var_3372 && var_1947)
         {
            var_1947.visible = false;
         }
         stopHelpButtonHideTimer();
      }
      
      private function stopHelpButtonHideTimer() : void
      {
         if(!var_2456)
         {
            return;
         }
         var_2456.stop();
         var_2456.removeEventListener("timer",onHelpButtonHideTimer);
         var_2456 = null;
      }
   }
}
