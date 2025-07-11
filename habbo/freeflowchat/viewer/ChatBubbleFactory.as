package com.sulake.habbo.freeflowchat.viewer
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.ChatHistoryEntryBitmapBubble;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.ChatHistoryRoomChangeEntry;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_3535;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatColours;
   import com.sulake.habbo.freeflowchat.viewer.simulation.BlankStyle;
   import com.sulake.habbo.freeflowchat.viewer.visualization.ChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyleLibrary;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.class_3595;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class ChatBubbleFactory implements IGetImageListener, IAvatarImageListener
   {
      
      private static const MAX_DISPOSABLE_BITMAPS:int = 30;
       
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_2784:ChatStyleLibrary;
      
      private var _avatarImageCache:Map;
      
      private var _petImageCache:Map;
      
      private var _avatarColorCache:Map;
      
      private var _petImageIdToFigureString:Map;
      
      private var var_2601:Array;
      
      private var var_3271:Vector.<PooledChatBubble>;
      
      private var var_388:int;
      
      public function ChatBubbleFactory(param1:HabboFreeFlowChat)
      {
         _avatarImageCache = new Map();
         _petImageCache = new Map();
         _avatarColorCache = new Map();
         _petImageIdToFigureString = new Map();
         var_2601 = [];
         var_3271 = new Vector.<PooledChatBubble>(0);
         super();
         var_1660 = param1;
         var_2784 = new ChatStyleLibrary(var_1660.assets);
         var_388 = var_1660.sessionDataManager.userId;
      }
      
      public function dispose() : void
      {
         discardOldBitmaps();
         var_2601 = [];
         var_2784.dispose();
         var_2784 = null;
         var_1660 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1660 == null;
      }
      
      public function getNewChatBubble(param1:ChatItem, param2:Boolean = false) : PooledChatBubble
      {
         var _loc11_:String = null;
         var _loc16_:IRoomObject = null;
         var _loc6_:String = null;
         var _loc20_:Boolean = false;
         var _loc9_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:String = null;
         var _loc13_:String = null;
         var _loc8_:String = null;
         var _loc15_:String = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc17_:PooledChatBubble = null;
         var _loc19_:ChatStyle = ChatStyle(var_2784.getStyle(param1.style));
         var _loc4_:class_3490 = var_1660.roomSessionManager.getSession(param1.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc12_:String = "";
         var _loc18_:uint = 0;
         var _loc5_:BitmapData = _loc19_.iconImage;
         if(param1.forcedFigure || param1.forcedUserName)
         {
            if(!_loc5_)
            {
               _loc5_ = getUserImage(param1.forcedFigure);
            }
            _loc12_ = param1.forcedUserName;
         }
         else if(_loc4_ != null)
         {
            _loc12_ = _loc4_.name;
            _loc11_ = _loc4_.figure;
            _loc18_ = _avatarColorCache.getValue(_loc11_);
            if(!_loc5_)
            {
               switch(_loc4_.type - 1)
               {
                  case 0:
                     _loc5_ = getUserImage(_loc11_);
                     break;
                  case 1:
                     _loc16_ = var_1660.roomEngine.getRoomObject(param1.roomId,_loc4_.roomObjectId,100);
                     _loc6_ = null;
                     if(_loc16_ != null)
                     {
                        _loc6_ = String(_loc16_.getModel().getString("figure_posture"));
                     }
                     _loc20_ = true;
                     _loc9_ = 32;
                     _loc21_ = 2;
                     _loc5_ = getPetImage(_loc11_,_loc21_,_loc20_,_loc9_,_loc6_);
               }
            }
         }
         if(param1.chatType == 3)
         {
            param1.text = !var_1660.localizations ? "" : String(var_1660.localizations.getLocalizationWithParams("widgets.chatbubble.respect","","username",_loc12_));
         }
         else if(param1.chatType == 4)
         {
            param1.text = !var_1660.localizations ? "" : String(var_1660.localizations.getLocalizationWithParams("widget.chatbubble.petrespect","","petname",_loc12_));
         }
         else if(param1.chatType == 6)
         {
            param1.text = !var_1660.localizations ? "" : String(var_1660.localizations.getLocalizationWithParams("widget.chatbubble.pettreat","","petname",_loc12_));
         }
         if(param1.chatType == 5)
         {
            _loc10_ = "widget.chatbubble.handitem";
            _loc13_ = String(var_1660.localizations.getLocalization("handitem" + param1.extraParam,"handitem" + param1.extraParam));
            var_1660.localizations.registerParameter(_loc10_,"username",_loc12_);
            var_1660.localizations.registerParameter(_loc10_,"handitem",_loc13_);
            param1.text = var_1660.localizations.getLocalizationRaw(_loc10_).value;
         }
         if(param1.chatType == 10)
         {
            _loc8_ = "widget.chatbubble.mutetime";
            _loc15_ = String(param1.extraParam % 60);
            _loc7_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam % 3600 / 60) : 0);
            _loc3_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam / 3600) : 0);
            var_1660.localizations.registerParameter(_loc8_,"hours",_loc3_);
            var_1660.localizations.registerParameter(_loc8_,"minutes",_loc7_);
            var_1660.localizations.registerParameter(_loc8_,"seconds",_loc15_);
            param1.text = var_1660.localizations.getLocalizationRaw(_loc8_).value;
         }
         if(var_3271.length > 0)
         {
            _loc17_ = var_3271.pop();
         }
         else
         {
            _loc17_ = new PooledChatBubble(var_1660);
         }
         filterHtml(param1,_loc19_);
         var _loc14_:Object = _loc19_.textFormat.color;
         ChatColours.applyColourToChat(param1,_loc19_);
         _loc17_.chatItem = param1;
         _loc17_.style = _loc19_;
         _loc17_.face = _loc5_;
         _loc17_.recreate(_loc12_,!!param1.forcedColor ? param1.forcedColor : _loc18_,var_1660.roomChatBorderLimited);
         _loc19_.textFormat.color = _loc14_;
         return _loc17_;
      }
      
      public function getNewEmptySpace(param1:int) : PooledChatBubble
      {
         var _loc4_:PooledChatBubble = null;
         var _loc5_:class_3595 = new BlankStyle();
         var _loc2_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",1);
         var _loc3_:ChatItem = new ChatItem(_loc2_,getTimer());
         if(var_3271.length > 0)
         {
            _loc4_ = var_3271.pop();
         }
         else
         {
            _loc4_ = new PooledChatBubble(var_1660);
         }
         _loc4_.chatItem = _loc3_;
         _loc4_.style = _loc5_;
         _loc4_.face = null;
         _loc4_.recreate("",0,false,19);
         return _loc4_;
      }
      
      public function getHistoryLineEntry(param1:ChatItem) : class_3535
      {
         var _loc11_:String = null;
         var _loc15_:IRoomObject = null;
         var _loc6_:String = null;
         var _loc20_:Boolean = false;
         var _loc9_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:String = null;
         var _loc13_:String = null;
         var _loc8_:String = null;
         var _loc14_:String = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc19_:ChatStyle = ChatStyle(var_2784.getStyle(param1.style));
         var _loc3_:class_3490 = var_1660.roomSessionManager.getSession(param1.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc12_:String = "";
         var _loc18_:uint = 0;
         var _loc4_:BitmapData = _loc19_.iconImage;
         var _loc5_:* = !(_loc3_ == null || _loc3_.webID == var_388);
         if(param1.forcedFigure || param1.forcedUserName)
         {
            if(!_loc4_)
            {
               _loc4_ = getUserImage(param1.forcedFigure);
            }
            _loc12_ = param1.forcedUserName;
         }
         else if(_loc3_ != null)
         {
            _loc12_ = _loc3_.name;
            _loc11_ = _loc3_.figure;
            _loc18_ = _avatarColorCache.getValue(_loc11_);
            if(!_loc4_)
            {
               switch(_loc3_.type - 1)
               {
                  case 0:
                  case 2:
                  case 3:
                     _loc4_ = getUserImage(_loc11_);
                     break;
                  case 1:
                     _loc15_ = var_1660.roomEngine.getRoomObject(param1.roomId,_loc3_.roomObjectId,100);
                     _loc6_ = null;
                     if(_loc15_ != null)
                     {
                        _loc6_ = String(_loc15_.getModel().getString("figure_posture"));
                     }
                     _loc20_ = false;
                     _loc9_ = 32;
                     _loc21_ = 2;
                     _loc4_ = getPetImage(_loc11_,_loc21_,_loc20_,_loc9_,_loc6_);
               }
            }
         }
         if(param1.chatType == 3)
         {
            param1.text = !!var_1660.localizations ? "" : String(var_1660.localizations.getLocalizationWithParams("widgets.chatbubble.respect","","username",_loc12_));
            _loc5_ = false;
         }
         else if(param1.chatType == 4)
         {
            param1.text = !!var_1660.localizations ? "" : String(var_1660.localizations.getLocalizationWithParams("widget.chatbubble.petrespect","","petname",_loc12_));
            _loc5_ = false;
         }
         else if(param1.chatType == 6)
         {
            param1.text = !!var_1660.localizations ? "" : String(var_1660.localizations.getLocalizationWithParams("widget.chatbubble.pettreat","","petname",_loc12_));
            _loc5_ = false;
         }
         if(param1.chatType == 5)
         {
            _loc10_ = "widget.chatbubble.handitem";
            _loc13_ = String(var_1660.localizations.getLocalizationWithParams("handitem" + param1.extraParam,"handitem" + param1.extraParam));
            param1.text = var_1660.localizations.getLocalizationWithParams(_loc10_,"","username",_loc12_,"handitem",_loc13_);
            _loc5_ = false;
         }
         if(param1.chatType == 10)
         {
            _loc8_ = "widget.chatbubble.mutetime";
            _loc14_ = String(param1.extraParam % 60);
            _loc7_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam % 3600 / 60) : 0);
            _loc2_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam / 3600) : 0);
            var_1660.localizations.registerParameter(_loc8_,"hours",_loc2_);
            var_1660.localizations.registerParameter(_loc8_,"minutes",_loc7_);
            var_1660.localizations.registerParameter(_loc8_,"seconds",_loc14_);
            param1.text = var_1660.localizations.getLocalizationRaw(_loc8_).value;
            _loc5_ = false;
         }
         filterHtml(param1,_loc19_);
         var _loc16_:ChatBubble = new ChatBubble(param1,_loc19_,_loc4_,_loc12_,!!param1.forcedColor ? param1.forcedColor : _loc18_,var_1660,1);
         var _loc17_:BitmapData = new BitmapData(_loc16_.width,_loc16_.height,true,0);
         _loc16_.drawToBitmap(_loc17_);
         return new ChatHistoryEntryBitmapBubble(param1,_loc5_,_loc12_,_loc17_,_loc19_.overlap);
      }
      
      private function filterHtml(param1:ChatItem, param2:ChatStyle) : void
      {
         if(!param2.allowHTML)
         {
            param1.text = param1.text.replace(/</g,"&lt;").replace(/>/g,"&gt;");
            param1.text = param1.text.replace(/&#[0-9]+;/g,"");
            param1.text = param1.text.replace(/&#x[0-9]+;/g,"");
         }
      }
      
      public function getHistoryRoomChangeEntry(param1:class_1675) : class_3535
      {
         return new ChatHistoryRoomChangeEntry(param1,var_1660);
      }
      
      public function recycle(param1:PooledChatBubble) : void
      {
         var_3271.push(param1);
      }
      
      public function getUserImage(param1:String) : BitmapData
      {
         var _loc5_:class_3374 = null;
         var _loc4_:IPartColor = null;
         var _loc3_:Boolean = var_1660.getBoolean("zoom.enabled");
         var _loc2_:BitmapData = _avatarImageCache.getValue(param1) as BitmapData;
         if(_loc2_ == null)
         {
            if((_loc5_ = var_1660.avatarRenderManager.createAvatarImage(param1,_loc3_ ? "h" : "sh",null,this)) != null)
            {
               _loc2_ = _loc5_.getCroppedImage("head",_loc3_ ? 0.5 : 1);
               _loc4_ = _loc5_.getPartColor("ch");
               _loc5_.dispose();
               if(_loc4_ != null)
               {
                  _avatarColorCache.add(param1,_loc4_.rgb);
               }
            }
         }
         if(_loc2_ != null)
         {
            _avatarImageCache.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function getPetImage(param1:String, param2:int, param3:Boolean, param4:int = 64, param5:String = null) : BitmapData
      {
         var _loc6_:PetFigureData = null;
         var _loc8_:int = 0;
         var _loc7_:* = 0;
         var _loc11_:Boolean = false;
         var _loc9_:class_3499 = null;
         var _loc10_:BitmapData;
         if((_loc10_ = _petImageCache.getValue(param1 + param5) as BitmapData) == null)
         {
            _loc8_ = (_loc6_ = new PetFigureData(param1)).typeId;
            _loc7_ = 0;
            _loc11_ = false;
            if(35 == _loc8_)
            {
               _loc11_ = true;
            }
            if((_loc9_ = var_1660.roomEngine.getPetImage(_loc8_,_loc6_.paletteId,_loc6_.color,new Vector3d(param2 * 45),param4,this,_loc11_,_loc7_,_loc6_.customParts,param5)) != null)
            {
               _loc10_ = _loc9_.data;
               if(_loc9_.id > 0)
               {
                  _petImageIdToFigureString.add(_loc9_.id,_loc6_.figureString);
               }
            }
            _avatarColorCache.add(param1,_loc6_.color);
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
      
      private function petImageReady(param1:String) : void
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
         if(var_2601.length > 30)
         {
            discardOldBitmaps();
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
         if(var_2601.length > 30)
         {
            discardOldBitmaps();
         }
      }
      
      private function discardOldBitmaps() : void
      {
         for each(var _loc1_ in var_2601)
         {
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
         }
      }
      
      public function get chatStyleLibrary() : ChatStyleLibrary
      {
         return var_2784;
      }
   }
}
