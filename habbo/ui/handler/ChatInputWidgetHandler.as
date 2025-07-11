package com.sulake.habbo.ui.handler
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.runtime.Component;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.room.events.RoomEngineZoomEvent;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.events.HideRoomWidgetEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.utils.RoomShakingEffect;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.ui.Mouse;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class ChatInputWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var var_318:Boolean = false;
      
      private var var_3935:Boolean = true;
      
      private var _demonicTriggers:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1629:RoomChatInputWidget;
      
      public function ChatInputWidgetHandler()
      {
         super();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set widget(param1:RoomChatInputWidget) : void
      {
         var_1629 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get type() : String
      {
         return "RWE_CHAT_INPUT_WIDGET";
      }
      
      public function dispose() : void
      {
         var_318 = true;
         _container = null;
         var_1629 = null;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWCTM_TYPING_STATUS");
         _loc1_.push("RWCM_MESSAGE_CHAT");
         _loc1_.push("RWCSAM_MESSAGE_SELECT_AVATAR");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc3_:* = null;
         var _loc22_:int = 0;
         var _loc25_:int = 0;
         var _loc31_:RoomWidgetChatTypingMessage = null;
         var _loc26_:RoomWidgetChatMessage = null;
         var _loc7_:String = null;
         var _loc27_:RoomWidgetRequestWidgetMessage = null;
         var _loc32_:Array = null;
         var _loc18_:String = null;
         var _loc33_:String = null;
         var _loc34_:int = 0;
         var _loc6_:class_3490 = null;
         var _loc13_:class_3490 = null;
         var _loc20_:class_3490 = null;
         var _loc12_:class_3490 = null;
         var _loc23_:class_3490 = null;
         var _loc30_:class_3490 = null;
         var _loc16_:HabboToolbarEvent = null;
         var _loc4_:String = null;
         var _loc8_:class_1675 = null;
         var _loc2_:Date = null;
         var _loc28_:String = null;
         var _loc11_:Array = null;
         var _loc29_:Array = null;
         var _loc19_:Array = null;
         var _loc15_:class_3365 = null;
         var _loc17_:int = 0;
         var _loc5_:IRoomObjectSpriteVisualization = null;
         var _loc24_:int = 0;
         var _loc14_:IRoomObjectSprite = null;
         var _loc21_:int = 0;
         var _loc9_:RoomWidgetChatSelectAvatarMessage = null;
         var _loc10_:class_3490 = null;
         switch(param1.type)
         {
            case "RWCTM_TYPING_STATUS":
               if((_loc31_ = param1 as RoomWidgetChatTypingMessage) != null)
               {
                  _container.roomSession.sendChatTypingMessage(_loc31_.isTyping);
               }
               break;
            case "RWCM_MESSAGE_CHAT":
               if(_container != null && _container.roomSession != null)
               {
                  if((_loc26_ = param1 as RoomWidgetChatMessage) != null)
                  {
                     if(_loc26_.text == "")
                     {
                        return null;
                     }
                     _loc7_ = _loc26_.text;
                     _loc27_ = null;
                     if((_loc32_ = _loc26_.text.split(" ")).length > 0)
                     {
                        _loc18_ = String(_loc32_[0]);
                        _loc33_ = "";
                        if(_loc32_.length > 1)
                        {
                           _loc33_ = String(_loc32_[1]);
                        }
                        if(_loc18_.charAt(0) == ":" && _loc33_ == "x")
                        {
                           if((_loc34_ = _container.roomEngine.getSelectedAvatarId()) > -1)
                           {
                              if((_loc6_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc34_)) != null)
                              {
                                 _loc33_ = _loc6_.name;
                                 _loc7_ = _loc26_.text.replace(" x"," " + _loc6_.name);
                              }
                           }
                        }
                        switch(_loc18_.toLowerCase())
                        {
                           case ":shake":
                              RoomShakingEffect.init(250,5000);
                              RoomShakingEffect.turnVisualizationOn();
                              return null;
                           case ":d":
                           case ";d":
                              if(_container.sessionDataManager.hasVip)
                              {
                                 _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.LAUGH.ordinal);
                                 HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","laugh");
                              }
                              break;
                           case ":kiss":
                              if(_container.sessionDataManager.hasVip)
                              {
                                 _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.BLOW.ordinal);
                                 HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","blow");
                                 return null;
                              }
                              break;
                           case ":jump":
                              if(_container.sessionDataManager.hasVip)
                              {
                                 _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.JUMP.ordinal);
                                 HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","jump");
                                 return null;
                              }
                              break;
                           case ":news":
                              if(_container.config.getBoolean("client.news.embed.enabled"))
                              {
                                 HabboWebTools.openNews();
                                 return null;
                              }
                              break;
                           case ":mail":
                              if(_container.config.getBoolean("client.minimail.embed.enabled"))
                              {
                                 HabboWebTools.openMinimail("#mail/inbox/");
                                 return null;
                              }
                              break;
                           case ":crashme":
                           case ":ss":
                           case ":qss":
                           case ":gd":
                              break;
                           case ":csmm":
                              if(_container.sessionDataManager.hasSecurity(4))
                              {
                                 _container.gameManager.generateChecksumMismatch();
                                 return null;
                              }
                              break;
                           case ":tgl":
                           case ":li":
                              break;
                           case ":kick":
                              if(!container.sessionDataManager.hasSecurity(4))
                              {
                                 if(_container.roomSession.roomControllerLevel >= 1)
                                 {
                                    if(_loc13_ = _container.roomSession.userDataManager.getUserDataByName(_loc33_))
                                    {
                                       _container.roomSession.kickUser(_loc13_.webID);
                                    }
                                 }
                                 return null;
                              }
                              break;
                           case ":shutup":
                           case ":mute":
                              if(!_container.sessionDataManager.hasSecurity(4))
                              {
                                 if(_container.roomSession.roomControllerLevel >= 1)
                                 {
                                    if(_loc20_ = _container.roomSession.userDataManager.getUserDataByName(_loc33_))
                                    {
                                       _container.roomSession.muteUser(_loc20_.webID,2);
                                    }
                                 }
                                 return null;
                              }
                              break;
                           case ":link":
                           case ":q":
                           default:
                              break;
                           case "o/":
                           case "_o/":
                              _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.WAVE.ordinal);
                              return null;
                           case ":idle":
                              _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.const_423.ordinal);
                              HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","idle");
                              return null;
                           case "_b":
                              _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.RESPECT.ordinal);
                              HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","respect");
                              return null;
                           case ":fps":
                              (_container.roomEngine as Component).context.displayObjectContainer.stage.frameRate = int(_loc33_);
                              return null;
                           case ":sign":
                              _container.roomSession.sendSignMessage(int(_loc33_));
                              HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","sign",null,int(_loc33_));
                              return null;
                           case ":drop":
                           case ":dropitem":
                              _loc27_ = new RoomWidgetRequestWidgetMessage("RWUAM_DROP_CARRY_ITEM");
                              _container.processWidgetMessage(_loc27_);
                              return null;
                           case ":chooser":
                              if(_container.sessionDataManager.hasClub || _container.sessionDataManager.hasSecurity(2) || _container.sessionDataManager.isAmbassador)
                              {
                                 _loc27_ = new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER");
                                 _container.processWidgetMessage(_loc27_);
                              }
                              return null;
                           case ":furni":
                              if(_container.sessionDataManager.hasClub && _container.roomSession.roomControllerLevel >= 1 || _container.sessionDataManager.hasSecurity(2) || _container.sessionDataManager.isAmbassador)
                              {
                                 _loc27_ = new RoomWidgetRequestWidgetMessage("RWRWM_FURNI_CHOOSER");
                                 _container.processWidgetMessage(_loc27_);
                              }
                              return null;
                           case ":pickall":
                              _container.sessionDataManager.pickAllFurniture(_container.roomSession.roomId);
                              return null;
                           case ":pickallbc":
                              _container.sessionDataManager.pickAllBuilderFurniture(_container.roomSession.roomId);
                              return null;
                           case ":resetscores":
                              _container.sessionDataManager.resetScores(_container.roomSession.roomId);
                              return null;
                           case ":ejectall":
                              _container.sessionDataManager.ejectAllFurniture(_container.roomSession.roomId,_loc7_);
                              return null;
                           case ":ejectpets":
                              _container.sessionDataManager.ejectPets(_container.roomSession.roomId);
                              return null;
                           case ":moonwalk":
                              _container.sessionDataManager.sendSpecialCommandMessage(":moonwalk");
                              return null;
                           case ":habnam":
                              _container.sessionDataManager.sendSpecialCommandMessage(":habnam");
                              return null;
                           case ":yyxxabxa":
                              _container.sessionDataManager.sendSpecialCommandMessage(":yyxxabxa");
                              return null;
                           case ":mutepets":
                              _container.sessionDataManager.sendSpecialCommandMessage(":mutepets");
                              return null;
                           case ":mpgame":
                              _container.sessionDataManager.sendSpecialCommandMessage(_loc7_);
                              return null;
                           case ":ignore":
                              if(_loc33_)
                              {
                                 if(_loc12_ = _container.roomSession.userDataManager.getUserDataByName(_loc33_))
                                 {
                                    _container.sessionDataManager.ignoreUser(_loc12_.webID);
                                 }
                              }
                              return null;
                           case ":unignore":
                              if(_loc33_)
                              {
                                 if(_loc23_ = _container.roomSession.userDataManager.getUserDataByName(_loc33_))
                                 {
                                    _container.sessionDataManager.unignoreUser(_loc23_.webID);
                                 }
                              }
                              return null;
                           case ":floor":
                           case ":bcfloor":
                              if(_container.roomSession.roomControllerLevel >= 3)
                              {
                                 _container.windowManager.displayFloorPlanEditor();
                              }
                              return null;
                           case ":lang":
                              (_container.localization as ICoreLocalizationManager).activateLocalizationDefinition(_loc33_);
                              return null;
                           case ":uc":
                              if(_container.sessionDataManager.hasSecurity(4))
                              {
                                 if(_loc33_ == "hotel")
                                 {
                                    _container.roomSession.sendPeerUsersClassificationMessage(_loc32_[2]);
                                 }
                                 else
                                 {
                                    _container.roomSession.sendRoomUsersClassificationMessage(_loc33_);
                                 }
                              }
                              return null;
                           case ":anew":
                              if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                              {
                                 _container.roomSession.sendRoomUsersClassificationMessage("new");
                              }
                              return null;
                           case ":avisit":
                              if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                              {
                                 if("group" == _loc33_)
                                 {
                                    (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/predefined_group_lobby");
                                 }
                                 else
                                 {
                                    (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/predefined_noob_lobby");
                                 }
                              }
                              return null;
                           case ":aalert":
                              if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                              {
                                 if(_loc30_ = _container.roomSession.userDataManager.getUserDataByName(_loc33_))
                                 {
                                    _container.roomSession.ambassadorAlert(_loc30_.webID);
                                 }
                              }
                              return null;
                           case ":visit":
                              _container.roomSession.sendVisitUserMessage(_loc33_);
                              return null;
                           case ":roomid":
                              _container.roomSession.sendVisitFlatMessage(parseInt(_loc33_));
                              return null;
                           case ":zoom":
                              _container.roomEngine.events.dispatchEvent(new RoomEngineZoomEvent(_container.roomEngine.activeRoomId,Number(_loc33_)));
                              return null;
                           case ":cam":
                           case ":camera":
                              if(_container.sessionDataManager.isPerkAllowed("CAMERA"))
                              {
                                 (_loc16_ = new HabboToolbarEvent("HTE_ICON_CAMERA")).iconName = "chatCameraCommand";
                                 _container.toolbar.events.dispatchEvent(_loc16_);
                              }
                              return null;
                           case ":fs":
                           case ":fullscreen":
                              _container.windowManager.toggleFullScreen();
                              return null;
                           case ":screenshot":
                              if(_loc8_ = _container.navigator.enteredGuestRoomData)
                              {
                                 _loc4_ = _loc8_.roomName;
                              }
                              if(_loc4_ == null || _loc4_.length == 0)
                              {
                                 _loc2_ = new Date();
                                 _loc28_ = [_loc2_.getFullYear(),_loc2_.getMonth(),_loc2_.getDate()].join("-") + " " + [_loc2_.getHours(),_loc2_.getMinutes(),_loc2_.getSeconds()].join(".");
                                 _loc4_ = "Habbo " + _loc28_;
                              }
                              _container.roomEngine.createScreenShot(_container.roomSession.roomId,_container.getFirstCanvasId(),_loc4_ + ".png");
                              return null;
                           case ":iddqd":
                              _container.roomEngine.events.dispatchEvent(new RoomEngineZoomEvent(_container.roomEngine.activeRoomId,-1,true));
                              return null;
                           case ":hidemouse":
                              if(var_3935)
                              {
                                 Mouse.hide();
                                 _container.roomEngine.setTileCursorState(_container.roomEngine.activeRoomId,0);
                              }
                              else
                              {
                                 Mouse.show();
                                 _container.roomEngine.setTileCursorState(_container.roomEngine.activeRoomId,1);
                              }
                              _container.roomEngine.toggleTileCursorVisibility(_container.roomEngine.activeRoomId,!var_3935);
                              var_3935 = !var_3935;
                              return null;
                           case ":wf":
                           case ":wired":
                              (_container.roomEngine as Component).context.createLinkEvent("wiredmenu/open");
                              return null;
                           case ":var":
                           case ":variables":
                              (_container.roomEngine as Component).context.createLinkEvent("wiredmenu/open/variable_overview");
                              return null;
                           case ":inspect":
                           case ":inspection":
                              (_container.roomEngine as Component).context.createLinkEvent("wiredmenu/open/variable_inspection");
                              return null;
                           case ":demonictriggers":
                              _loc11_ = _container.roomEngine.getObjectsByCategory(10);
                              _demonicTriggers = !_demonicTriggers;
                              _loc29_ = [];
                              if(_demonicTriggers)
                              {
                                 _loc19_ = [-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0];
                                 _loc29_ = [new ColorMatrixFilter(_loc19_)];
                              }
                              for each(var _loc35_ in _loc11_)
                              {
                                 _loc17_ = int(_loc35_.getModel().getNumber("furniture_type_id"));
                                 if((_loc15_ = _container.sessionDataManager.getFloorItemData(_loc17_)).className.indexOf("wf_trg_") == 0)
                                 {
                                    _loc5_ = _loc35_.getVisualization() as IRoomObjectSpriteVisualization;
                                    _loc24_ = 0;
                                    while(_loc24_ < _loc5_.spriteCount)
                                    {
                                       if((_loc14_ = _loc5_.getSprite(_loc24_)).blendMode != "add")
                                       {
                                          _loc14_.filters = _loc29_;
                                       }
                                       _loc24_++;
                                    }
                                 }
                              }
                              return null;
                        }
                     }
                     _loc21_ = _loc26_.styleId;
                     if(_container != null && _container.roomSession != null)
                     {
                        if(this._container.freeFlowChat != null)
                        {
                           if(this._container.freeFlowChat.preferedChatStyle != _loc26_.styleId && _loc26_.styleId != -1)
                           {
                              this._container.freeFlowChat.preferedChatStyle = _loc26_.styleId;
                           }
                           _loc21_ = this._container.freeFlowChat.preferedChatStyle;
                        }
                        switch(_loc26_.chatType)
                        {
                           case 0:
                              _container.roomSession.sendChatMessage(_loc7_,_loc21_);
                              break;
                           case 1:
                              _container.roomSession.sendWhisperMessage(_loc26_.recipientName,_loc7_,_loc21_);
                              break;
                           case 2:
                              _container.roomSession.sendShoutMessage(_loc7_,_loc21_);
                        }
                        HabboTracking.getInstance().trackEventLogOncePerSession("Tutorial","interaction","avatar.chat");
                     }
                  }
               }
               break;
            case "RWCSAM_MESSAGE_SELECT_AVATAR":
               if((_loc9_ = param1 as RoomWidgetChatSelectAvatarMessage) != null)
               {
                  _container.roomEngine.selectAvatar(_loc9_.roomId,_loc9_.objectId);
                  if((_loc10_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc9_.objectId)) != null)
                  {
                     _container.moderation.userSelected(_loc10_.webID,_loc9_.userName);
                  }
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSCE_FLOOD_EVENT","hrwe_hide_room_widget","FBE_BAR_RESIZE_EVENT"];
      }
      
      public function update() : void
      {
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:RoomSessionChatEvent = null;
         var _loc2_:int = 0;
         var _loc4_:FriendBarResizeEvent = null;
         var _loc5_:Event = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSCE_FLOOD_EVENT":
               _loc3_ = param1 as RoomSessionChatEvent;
               _loc2_ = parseInt(_loc3_.text);
               _loc5_ = new RoomWidgetFloodControlEvent(_loc2_);
               break;
            case "FBE_BAR_RESIZE_EVENT":
               _loc4_ = param1 as FriendBarResizeEvent;
               var_1629.checkChatInputPosition();
               break;
            default:
               break;
            case "hrwe_hide_room_widget":
               handleHideWidgetEvent(param1 as HideRoomWidgetEvent);
               return;
         }
         if(_container != null && _container.events != null && _loc5_ != null)
         {
            _container.events.dispatchEvent(_loc5_);
         }
      }
      
      private function handleHideWidgetEvent(param1:HideRoomWidgetEvent) : void
      {
         if(param1 && param1.widgetType == this.type)
         {
            var_1629.hide();
         }
      }
   }
}
