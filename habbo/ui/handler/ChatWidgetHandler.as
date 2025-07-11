package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.game.events.GameChatEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.roomchat.RoomChatWidget;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.PointMath;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ChatWidgetHandler implements IRoomWidgetHandler, IAvatarImageListener, IGetImageListener
   {
       
      
      private var var_318:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _avatarImageCache:Map = null;
      
      private var _petImageCache:Map = null;
      
      private var _avatarColorCache:Map = null;
      
      private var _petImageIdToFigureString:Map = null;
      
      private var var_2601:Array;
      
      private var var_26:IConnection = null;
      
      private var var_3135:Number = 0;
      
      private var var_2518:Point = null;
      
      private var var_2514:Vector3d;
      
      private var var_1629:RoomChatWidget;
      
      public function ChatWidgetHandler()
      {
         var_2601 = [];
         var_2514 = new Vector3d();
         super();
         _avatarImageCache = new Map();
         _petImageCache = new Map();
         _avatarColorCache = new Map();
         _petImageIdToFigureString = new Map();
      }
      
      public function set widget(param1:RoomChatWidget) : void
      {
         var_1629 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get type() : String
      {
         return "RWE_CHAT_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_26 = param1;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BitmapData = null;
         var_318 = true;
         _container = null;
         var_2518 = null;
         if(_avatarImageCache != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _avatarImageCache.length)
            {
               _loc1_ = _avatarImageCache.getWithIndex(_loc3_) as BitmapData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            _avatarImageCache.dispose();
            _avatarImageCache = null;
         }
         if(_petImageCache != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _petImageCache.length)
            {
               _loc1_ = _petImageCache.getWithIndex(_loc3_) as BitmapData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            _petImageCache.dispose();
            _petImageCache = null;
         }
         for each(var _loc2_ in var_2601)
         {
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
         }
         var_2601 = [];
         if(_avatarColorCache != null)
         {
            _avatarColorCache.dispose();
            _avatarColorCache = null;
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return new Array(0);
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         param1.type;
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSCE_CHAT_EVENT","gce_game_chat"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomSessionChatEvent = null;
         var _loc20_:IRoomObject = null;
         var _loc34_:IRoomGeometry = null;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc3_:IVector3d = null;
         var _loc13_:Point = null;
         var _loc6_:Point = null;
         var _loc5_:class_3490 = null;
         var _loc26_:String = null;
         var _loc29_:* = 0;
         var _loc11_:BitmapData = null;
         var _loc8_:int = 0;
         var _loc17_:int = 0;
         var _loc15_:Boolean = false;
         var _loc21_:String = null;
         var _loc18_:int = 0;
         var _loc16_:int = 0;
         var _loc36_:int = 0;
         var _loc23_:int = 0;
         var _loc25_:String = null;
         var _loc12_:IRoomObject = null;
         var _loc14_:String = null;
         var _loc24_:String = null;
         var _loc27_:String = null;
         var _loc7_:String = null;
         var _loc10_:String = null;
         var _loc22_:String = null;
         var _loc19_:String = null;
         var _loc4_:String = null;
         var _loc28_:String = null;
         var _loc30_:IRoomObject = null;
         var _loc31_:class_3490 = null;
         var _loc9_:String = null;
         if(_container.freeFlowChat && !_container.freeFlowChat.isDisabledInPreferences)
         {
            return;
         }
         var _loc35_:Event = null;
         switch(param1.type)
         {
            case "RSCE_CHAT_EVENT":
               _loc2_ = param1 as RoomSessionChatEvent;
               if(_loc2_ != null)
               {
                  if((_loc20_ = _container.roomEngine.getRoomObject(_loc2_.session.roomId,_loc2_.userId,100)) != null)
                  {
                     if((_loc34_ = _container.roomEngine.getRoomCanvasGeometry(_loc2_.session.roomId,_container.getFirstCanvasId())) != null)
                     {
                        updateWidgetPosition();
                        _loc32_ = 0;
                        _loc33_ = 0;
                        _loc3_ = _loc20_.getLocation();
                        if((_loc13_ = _loc34_.getScreenPoint(_loc3_)) != null)
                        {
                           _loc32_ = _loc13_.x;
                           _loc33_ = _loc13_.y;
                           if((_loc6_ = _container.roomEngine.getRoomCanvasScreenOffset(_loc2_.session.roomId,_container.getFirstCanvasId())) != null)
                           {
                              _loc32_ += _loc6_.x;
                              _loc33_ += _loc6_.y;
                           }
                        }
                        _loc5_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc2_.userId);
                        _loc26_ = "";
                        _loc29_ = 0;
                        _loc11_ = null;
                        _loc8_ = 32;
                        _loc17_ = 2;
                        _loc15_ = true;
                        _loc21_ = null;
                        _loc18_ = _loc2_.chatType;
                        _loc16_ = _loc2_.style;
                        _loc36_ = 0;
                        _loc23_ = -1;
                        if(_loc5_ != null)
                        {
                           _loc36_ = _loc5_.type;
                           _loc25_ = _loc5_.figure;
                           switch(_loc36_ - 1)
                           {
                              case 0:
                                 _loc11_ = getUserImage(_loc25_);
                                 break;
                              case 1:
                                 if((_loc12_ = getRoomUserObject(_loc5_.roomObjectId)) != null)
                                 {
                                    _loc21_ = String(_loc12_.getModel().getString("figure_posture"));
                                 }
                                 _loc11_ = getPetImage(_loc25_,_loc17_,_loc15_,_loc8_,_loc21_);
                                 _loc23_ = new PetFigureData(_loc25_).typeId;
                                 break;
                              case 2:
                              case 3:
                                 _loc16_ = 2;
                           }
                           _loc29_ = _avatarColorCache.getValue(_loc25_);
                           _loc26_ = _loc5_.name;
                        }
                        _loc14_ = _loc2_.text;
                        if(_loc18_ == 5)
                        {
                           _loc24_ = "widget.chatbubble.handitem";
                           _loc27_ = String(_container.localization.getLocalization("handitem" + _loc2_.extraParam,"handitem" + _loc2_.extraParam));
                           _container.localization.registerParameter(_loc24_,"username",_loc26_);
                           _container.localization.registerParameter(_loc24_,"handitem",_loc27_);
                           _loc14_ = String(_container.localization.getLocalizationRaw(_loc24_).value);
                           _loc16_ = 1;
                        }
                        if(_loc18_ == 10)
                        {
                           _loc7_ = "widget.chatbubble.mutetime";
                           _loc10_ = String(_loc2_.extraParam % 60);
                           _loc22_ = String(_loc2_.extraParam > 0 ? Math.floor(_loc2_.extraParam % 3600 / 60) : 0);
                           _loc19_ = String(_loc2_.extraParam > 0 ? Math.floor(_loc2_.extraParam / 3600) : 0);
                           _container.localization.registerParameter(_loc7_,"hours",_loc19_);
                           _container.localization.registerParameter(_loc7_,"minutes",_loc22_);
                           _container.localization.registerParameter(_loc7_,"seconds",_loc10_);
                           _loc14_ = String(_container.localization.getLocalizationRaw(_loc7_).value);
                           _loc16_ = 1;
                        }
                        if(_loc18_ == 7 || _loc18_ == 8 || _loc18_ == 9)
                        {
                           _loc4_ = "widget.chatbubble.petrevived";
                           if(_loc18_ == 8)
                           {
                              _loc4_ = "widget.chatbubble.petrefertilized";
                           }
                           else if(_loc18_ == 9)
                           {
                              _loc4_ = "widget.chatbubble.petspeedfertilized";
                           }
                           _loc28_ = "";
                           if((_loc30_ = getRoomUserObject(_loc2_.extraParam)) != null)
                           {
                              if((_loc31_ = _loc2_.session.userDataManager.getUserDataByIndex(_loc30_.getId())) != null)
                              {
                                 _loc28_ = _loc31_.name;
                              }
                           }
                           _container.localization.registerParameter(_loc4_,"petName",_loc26_);
                           _container.localization.registerParameter(_loc4_,"userName",_loc28_);
                           _loc14_ = String(_container.localization.getLocalizationRaw(_loc4_).value);
                           _loc16_ = 1;
                        }
                        _loc9_ = "RWCUE_EVENT_CHAT";
                        _loc35_ = new RoomWidgetChatUpdateEvent(_loc9_,_loc2_.userId,_loc14_,_loc26_,100,_loc36_,_loc23_,_loc32_,_loc33_,_loc11_,_loc29_,_loc2_.session.roomId,_loc18_,_loc16_,_loc2_.links);
                     }
                  }
               }
               break;
            case "gce_game_chat":
               gameChatEventHandler(param1 as GameChatEvent);
         }
         if(_container != null && _container.events != null && _loc35_ != null)
         {
            _container.events.dispatchEvent(_loc35_);
         }
      }
      
      private function getRoomUserObject(param1:int) : IRoomObject
      {
         return container.roomEngine.getRoomObject(container.roomEngine.activeRoomId,param1,100);
      }
      
      public function getUserImage(param1:String) : BitmapData
      {
         var _loc4_:class_3374 = null;
         var _loc3_:IPartColor = null;
         var _loc2_:BitmapData = _avatarImageCache.getValue(param1) as BitmapData;
         if(_loc2_ == null)
         {
            if((_loc4_ = _container.avatarRenderManager.createAvatarImage(param1,"h",null,this)) != null)
            {
               _loc2_ = _loc4_.getCroppedImage("head",0.5);
               _loc3_ = _loc4_.getPartColor("ch");
               _loc4_.dispose();
               if(_loc3_ != null)
               {
                  _avatarColorCache.add(param1,_loc3_.rgb);
               }
            }
         }
         if(_loc2_ != null)
         {
            _avatarImageCache.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function gameChatEventHandler(param1:GameChatEvent) : void
      {
         var_1629.addChatMessage(param1.message,param1.name,param1.locX,getUserImage(param1.figure),param1.color,param1.notify);
      }
      
      public function update() : void
      {
         updateWidgetPosition();
      }
      
      private function updateWidgetPosition() : void
      {
         var _loc3_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:RoomWidgetRoomViewUpdateEvent = null;
         var _loc1_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         if(_container == null || _container.roomSession == null || _container.roomEngine == null || _container.events == null)
         {
            return;
         }
         var _loc2_:int = _container.getFirstCanvasId();
         var _loc9_:int = _container.roomSession.roomId;
         var _loc6_:RoomGeometry;
         if((_loc6_ = _container.roomEngine.getRoomCanvasGeometry(_loc9_,_loc2_) as RoomGeometry) != null)
         {
            _loc3_ = 1;
            if(var_3135 > 0)
            {
               _loc3_ = _loc6_.scale / var_3135;
            }
            if(var_2518 == null)
            {
               var_2514.x = 0;
               var_2514.y = 0;
               var_2514.z = 0;
               var_2518 = _loc6_.getScreenPoint(var_2514);
               var_3135 = _loc6_.scale - 10;
            }
            _loc7_ = "";
            _loc8_ = null;
            var_2514.x = 0;
            var_2514.y = 0;
            var_2514.z = 0;
            _loc1_ = _loc6_.getScreenPoint(var_2514);
            if(_loc1_ != null)
            {
               if((_loc4_ = _container.roomEngine.getRoomCanvasScreenOffset(_loc9_,_loc2_)) != null)
               {
                  _loc1_.offset(_loc4_.x,_loc4_.y);
               }
               if(_loc1_.x != var_2518.x || _loc1_.y != var_2518.y)
               {
                  if((_loc5_ = PointMath.sub(_loc1_,PointMath.mul(var_2518,_loc3_))).x != 0 || _loc5_.y != 0)
                  {
                     _loc7_ = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
                     _loc8_ = new RoomWidgetRoomViewUpdateEvent(_loc7_,null,_loc5_);
                     _container.events.dispatchEvent(_loc8_);
                  }
                  var_2518 = _loc1_;
               }
            }
            if(_loc6_.scale != var_3135)
            {
               _loc7_ = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
               _loc8_ = new RoomWidgetRoomViewUpdateEvent(_loc7_,null,null,_loc6_.scale);
               _container.events.dispatchEvent(_loc8_);
               var_3135 = _loc6_.scale;
            }
         }
      }
      
      public function petImageReady(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         if(_petImageCache)
         {
            _loc2_ = _petImageCache.remove(param1) as BitmapData;
            if(_loc2_ != null)
            {
               var_2601.push(_loc2_);
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         if(_avatarImageCache)
         {
            _loc2_ = _avatarImageCache.remove(param1) as BitmapData;
            if(_loc2_ != null)
            {
               var_2601.push(_loc2_);
            }
         }
      }
      
      private function getPetImage(param1:String, param2:int, param3:Boolean, param4:int = 64, param5:String = null) : BitmapData
      {
         var _loc6_:PetFigureData = null;
         var _loc8_:int = 0;
         var _loc7_:* = 0;
         var _loc11_:* = false;
         var _loc9_:class_3499 = null;
         var _loc10_:BitmapData;
         if((_loc10_ = _petImageCache.getValue(param1 + param5) as BitmapData) == null)
         {
            _loc8_ = (_loc6_ = new PetFigureData(param1)).typeId;
            _loc7_ = 0;
            _loc11_ = _loc8_ != 15;
            if((_loc9_ = _container.roomEngine.getPetImage(_loc8_,_loc6_.paletteId,_loc6_.color,new Vector3d(param2 * 45),param4,this,_loc11_,_loc7_,_loc6_.customParts,param5)) != null)
            {
               _loc10_ = _loc9_.data;
               if(_loc9_.id > 0)
               {
                  _petImageIdToFigureString.add(_loc9_.id,_loc6_.figureString);
               }
            }
         }
         if(_loc10_ != null)
         {
            _petImageCache.add(param1 + param5,_loc10_);
         }
         return _loc10_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = _petImageIdToFigureString.remove(param1);
         if(_loc3_ != null)
         {
            petImageReady(_loc3_);
            if(_petImageCache)
            {
               _petImageCache.add(_loc3_,param2);
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}
