package com.sulake.habbo.freeflowchat
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.freeflowchat.data.ChatEventHandler;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.data.RoomSessionEventHandler;
   import com.sulake.habbo.freeflowchat.history.ChatHistoryBuffer;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryScrollView;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryTray;
   import com.sulake.habbo.freeflowchat.style.class_3511;
   import com.sulake.habbo.freeflowchat.viewer.ChatBubbleFactory;
   import com.sulake.habbo.freeflowchat.viewer.ChatFlowViewer;
   import com.sulake.habbo.freeflowchat.viewer.simulation.ChatFlowStage;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.game.class_1805;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboGameManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboModeration;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.preferences.class_152;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.room.chat.RoomChatSettingsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1732;
   
   public class HabboFreeFlowChat extends Component implements class_1809
   {
      
      private static const ZERO_POINT:Point = new Point(0,0);
       
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _navigator:IHabboNavigator;
      
      private var _moderation:IHabboModeration;
      
      private var _roomUI:IRoomUI;
      
      private var _gameManager:class_1805;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var var_3049:ChatEventHandler;
      
      private var var_3150:RoomSessionEventHandler;
      
      private var var_2279:ChatHistoryBuffer;
      
      private var var_1992:ChatFlowStage;
      
      private var var_3293:ChatHistoryScrollView;
      
      private var _chatHistoryPulldown:ChatHistoryTray;
      
      private var var_2123:ChatFlowViewer;
      
      private var var_2952:ChatViewController;
      
      private var var_2287:ChatBubbleFactory;
      
      private var var_2750:Boolean = false;
      
      private var _isInRoom:Boolean = false;
      
      private var var_3046:class_1732;
      
      private var var_3429:Boolean = false;
      
      private var var_650:int = 1;
      
      private var var_3891:Boolean = false;
      
      public function HabboFreeFlowChat(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
      
      public static function getTimeStampNow() : String
      {
         var _loc1_:Date = new Date();
         var _loc2_:Number = _loc1_.getHours();
         var _loc4_:Number = _loc1_.getMinutes();
         var _loc3_:Number = _loc1_.getSeconds();
         var _loc5_:String;
         return (_loc5_ = (_loc5_ = _loc2_ < 10 ? "0" + _loc2_ : _loc2_.toString()) + ":" + (_loc4_ < 10 ? "0" + _loc4_ : _loc4_.toString())) + ":" + (_loc3_ < 10 ? "0" + _loc3_ : _loc3_.toString());
      }
      
      public static function create9SliceSprite(param1:Rectangle, param2:BitmapData) : Sprite
      {
         var _loc8_:int = 0;
         var _loc5_:Number = NaN;
         var _loc9_:int = 0;
         var _loc7_:Sprite = new Sprite();
         var _loc3_:Array = [param1.left,param1.right,param2.width];
         var _loc4_:Array = [param1.top,param1.bottom,param2.height];
         _loc7_.graphics.clear();
         var _loc6_:Number = 0;
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            _loc5_ = 0;
            _loc9_ = 0;
            while(_loc9_ < 3)
            {
               _loc7_.graphics.beginBitmapFill(param2);
               _loc7_.graphics.drawRect(_loc6_,_loc5_,_loc3_[_loc8_] - _loc6_,_loc4_[_loc9_] - _loc5_);
               _loc7_.graphics.endFill();
               _loc5_ = Number(_loc4_[_loc9_]);
               _loc9_++;
            }
            _loc6_ = Number(_loc3_[_loc8_]);
            _loc8_++;
         }
         _loc7_.scale9Grid = param1;
         return _loc7_;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboModeration(),function(param1:IHabboModeration):void
         {
            _moderation = param1;
         },false),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_1805):void
         {
            _gameManager = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         },false),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _communication.addHabboConnectionMessageEvent(new RoomChatSettingsMessageEvent(onRoomChatSettings));
         _communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
         _communication.addHabboConnectionMessageEvent(new AccountPreferencesEvent(onAccountPreferences));
         _communication.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onGuestRoomData));
         _communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         var _loc2_:Boolean = var_2750;
         var_2750 = true;
         if(!_loc2_ && var_2750)
         {
            var_2287 = new ChatBubbleFactory(this);
            if(!isDisabledInPreferences)
            {
               var_3049 = new ChatEventHandler(this);
               var_3150 = new RoomSessionEventHandler(this);
               var_2279 = new ChatHistoryBuffer(this);
            }
            if(_isInRoom)
            {
               roomEntered();
            }
         }
         else if(_loc2_ && !var_2750)
         {
            if(var_2287)
            {
               var_2287.dispose();
               var_2287 = null;
            }
            if(var_3049)
            {
               var_3049.dispose();
               var_3049 = null;
            }
            if(var_3150)
            {
               var_3150.dispose();
               var_3150 = null;
            }
            if(var_2279)
            {
               var_2279.dispose();
               var_2279 = null;
            }
            roomLeft();
         }
      }
      
      private function onGuestRoomData(param1:GetGuestRoomResultEvent) : void
      {
         if(var_2279 && !var_3891)
         {
            var_2279.insertRoomChange(param1.getParser().data);
         }
         var_3891 = true;
         var_3046 = param1.getParser().chatSettings;
         if(var_1992)
         {
            var_1992.refreshSettings();
         }
      }
      
      private function onRoomEnter(param1:RoomEntryInfoMessageEvent) : void
      {
         var_3891 = false;
         clear();
      }
      
      private function onRoomChatSettings(param1:RoomChatSettingsMessageEvent) : void
      {
         var_3046 = param1.getParser().chatSettings;
         if(_isInRoom && var_1992)
         {
            var_1992.refreshSettings();
         }
      }
      
      private function onAccountPreferences(param1:AccountPreferencesEvent) : void
      {
         var_3429 = param1.getParser().freeFlowChatDisabled;
         var_650 = param1.getParser().preferedChatStyle;
      }
      
      public function getRoomChangeBitmap() : BitmapData
      {
         return BitmapData(assets.getAssetByName("room_change").content);
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get gameManager() : class_1805
      {
         return _gameManager;
      }
      
      public function get localizations() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function roomEntered() : void
      {
         _isInRoom = true;
         if(var_2750 && var_2287 && var_3049 && var_3150)
         {
            var_1992 = new ChatFlowStage(this);
            var_2123 = new ChatFlowViewer(this,var_1992);
            var_3293 = new ChatHistoryScrollView(this,var_2279);
            _chatHistoryPulldown = new ChatHistoryTray(this,var_3293);
            var_2952 = new ChatViewController(this,var_2123,_chatHistoryPulldown);
         }
      }
      
      public function roomLeft() : void
      {
         if(_chatHistoryPulldown)
         {
            _chatHistoryPulldown.dispose();
            _chatHistoryPulldown = null;
         }
         if(var_3293)
         {
            var_3293.dispose();
            _chatHistoryPulldown = null;
         }
         if(var_2123)
         {
            var_2123.dispose();
            var_2123 = null;
         }
         if(var_1992)
         {
            var_1992.dispose();
            var_1992 = null;
         }
         if(var_2952)
         {
            var_2952.dispose();
            var_2952 = null;
         }
         _isInRoom = false;
      }
      
      public function insertChat(param1:ChatItem) : void
      {
         var _loc2_:PooledChatBubble = null;
         var _loc3_:Point = null;
         if(!var_2750 || !var_2279 || !var_1992 || isDisabledInPreferences)
         {
            return;
         }
         var_2279.insertChat(param1);
         try
         {
            _loc2_ = var_2287.getNewChatBubble(param1);
         }
         catch(e:Error)
         {
            if(e.errorID == 2015)
            {
               return;
            }
            throw e;
         }
         _loc3_ = var_1992.insertBubble(_loc2_);
         var_2123.insertBubble(_loc2_,_loc3_);
      }
      
      public function getScreenPointFromRoomLocation(param1:int, param2:IVector3d) : Point
      {
         var _loc9_:Point = null;
         var _loc5_:Point = null;
         if(_roomEngine == null || var_2123 == null || var_2123.rootDisplayObject.stage == null)
         {
            return ZERO_POINT;
         }
         var _loc3_:int = HabboComponentFlags.isRoomViewerMode(flags) ? 1 : -1;
         var _loc8_:IRoomGeometry = roomEngine.getRoomCanvasGeometry(param1,_loc3_);
         var _loc7_:Number = roomEngine.getRoomCanvasScale(param1);
         var _loc6_:Number = var_2123.rootDisplayObject.stage.stageWidth * _loc7_ / 2;
         var _loc4_:Number = var_2123.rootDisplayObject.stage.stageHeight * _loc7_ / 2;
         if(_loc8_ != null && param2 != null)
         {
            if((_loc9_ = _loc8_.getScreenPoint(param2)) != null)
            {
               _loc6_ += _loc9_.x * _loc7_;
               _loc4_ += _loc9_.y * _loc7_;
               if((_loc5_ = roomEngine.getRoomCanvasScreenOffset(param1)) != null)
               {
                  _loc6_ += _loc5_.x;
                  _loc4_ += _loc5_.y;
               }
            }
         }
         return new Point(_loc6_,_loc4_);
      }
      
      public function get chatFlowViewer() : ChatFlowViewer
      {
         return var_2123;
      }
      
      public function get chatBubbleFactory() : ChatBubbleFactory
      {
         return var_2287;
      }
      
      public function get chatHistoryScrollView() : ChatHistoryScrollView
      {
         return var_3293;
      }
      
      public function get displayObject() : DisplayObject
      {
         if(var_2952)
         {
            return var_2952.rootDisplayObject;
         }
         return null;
      }
      
      public function disableRoomMouseEventsLeftOfX(param1:int) : void
      {
         _roomEngine.mouseEventsDisabledLeftToX = param1;
      }
      
      public function selectAvatarWithChatItem(param1:ChatItem) : void
      {
         selectAvatar(param1.roomId,param1.userId);
      }
      
      public function selectAvatar(param1:int, param2:int) : void
      {
         var _loc5_:class_3490 = null;
         var _loc4_:class_3490 = null;
         if(_roomUI == null)
         {
            return;
         }
         var _loc3_:IRoomDesktop = _roomUI.getDesktop("hard_coded_room_id");
         _loc3_.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",param2,100));
         roomEngine.selectAvatar(param1,param2);
         var _loc6_:IRoomSession;
         if(_loc6_ = _roomSessionManager.getSession(param1))
         {
            if((_loc5_ = _loc6_.userDataManager.getUserDataByIndex(param2)) != null)
            {
               if((_loc4_ = _roomSessionManager.getSession(param1).userDataManager.getUserDataByIndex(param2)) && _moderation)
               {
                  _moderation.userSelected(_loc5_.webID,_loc4_.name);
               }
            }
         }
      }
      
      public function get roomChatSettings() : class_1732
      {
         return var_3046;
      }
      
      public function get roomChatBorderLimited() : Boolean
      {
         if(var_3046)
         {
            return var_3046.mode == 1;
         }
         return false;
      }
      
      public function clickHasToPropagate(param1:MouseEvent) : Boolean
      {
         return !!_roomUI ? _roomUI.mouseEventPositionHasContextMenu(param1) : false;
      }
      
      public function get chatStyleLibrary() : class_3511
      {
         return !!var_2287 ? var_2287.chatStyleLibrary : null;
      }
      
      public function get isDisabledInPreferences() : Boolean
      {
         return var_3429;
      }
      
      public function set isDisabledInPreferences(param1:Boolean) : void
      {
         var_3429 = param1;
         _communication.connection.send(new SetChatPreferencesMessageComposer(var_3429));
      }
      
      public function get preferedChatStyle() : int
      {
         return var_650;
      }
      
      public function set preferedChatStyle(param1:int) : void
      {
         var_650 = param1;
         _communication.connection.send(new class_152(var_650));
      }
      
      public function clear() : void
      {
         if(var_1992)
         {
            var_1992.clear();
         }
      }
      
      public function toggleVisibility() : void
      {
         if(isDisabledInPreferences || !var_2750 || !_chatHistoryPulldown)
         {
            return;
         }
         _chatHistoryPulldown.toggleHistoryVisibility();
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
   }
}
