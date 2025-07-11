package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3592;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.motion.Combo;
   import com.sulake.core.window.motion.EaseOut;
   import com.sulake.core.window.motion.MoveTo;
   import com.sulake.core.window.motion.ResizeTo;
   import com.sulake.core.window.motion.class_3596;
   import com.sulake.habbo.friendbar.data.FriendNotification;
   import com.sulake.habbo.friendbar.data.IFriendNotification;
   import com.sulake.habbo.friendbar.data.IFriendEntity;
   import com.sulake.habbo.friendbar.view.tabs.tokens.AchievementToken;
   import com.sulake.habbo.friendbar.view.tabs.tokens.GameToken;
   import com.sulake.habbo.friendbar.view.tabs.tokens.MessengerToken;
   import com.sulake.habbo.friendbar.view.tabs.tokens.QuestToken;
   import com.sulake.habbo.friendbar.view.tabs.tokens.RoomEventToken;
   import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
   import flash.display.BitmapData;
   import flash.utils.getQualifiedClassName;
   
   public class FriendEntityTab extends Tab
   {
      
      private static const const_518:String = "entity_xml";
      
      private static const const_611:String = "facebook_piece_xml";
      
      private static const CONTROLS_PIECE_RESOURCE:String = "controls_piece_xml";
      
      protected static const PIECES:String = "pieces";
      
      protected static const const_603:String = "icons";
      
      protected static const HEADER:String = "header";
      
      protected static const PROFILE:String = "region_profile";
      
      protected static const const_268:String = "facebook";
      
      protected static const CONTROLS:String = "controls";
      
      protected static const CANVAS:String = "canvas";
      
      protected static const NAME:String = "name";
      
      protected static const MESSAGE:String = "btn_message";
      
      protected static const MESSAGE_ICON:String = "icon_message";
      
      protected static const VISIT:String = "btn_visit";
      
      protected static const ICON:String = "icon";
      
      protected static const LABEL:String = "label";
      
      protected static const NOTIFICATION:String = "notification";
      
      protected static const BTN_PROFILE:String = "button_profile";
      
      protected static const BTN_GAME:String = "btn_game";
      
      protected static const GAME_ICON:String = "icon_game";
      
      protected static const GAME_INVITE_ICON:String = "icon_game_invite";
      
      protected static const BUBBLE:String = "bubble";
      
      protected static const BUBBLE_MESSAGE:String = "bubble_message";
      
      protected static const BUBBLE_BUTTON_ACCEPT:String = "bubble_button_accept";
      
      protected static const const_660:String = "bubble_button_close";
      
      protected static const const_714:String = "bubble_click_region_reject";
      
      private static const DEFAULT_COLOR:uint = 10338138;
      
      private static const const_557:uint = 13891476;
      
      private static const TOKEN_ICON_TAG_NONE:String = null;
      
      private static const TOKEN_ICON_TAG_NOTIFY:String = "icon_tag_notify";
      
      private static const TOKEN_ICON_TAG_MESSAGE:String = "icon_tag_message";
      
      private static const TOKEN_ICON_TAG_GAME:String = "icon_tag_game";
      
      private static const const_422:Vector.<FriendEntityTab> = new Vector.<FriendEntityTab>();
      
      private static const const_420:Vector.<IWindowContainer> = new Vector.<IWindowContainer>();
       
      
      protected var var_1722:IFriendEntity;
      
      protected var var_1757:Vector.<Token>;
      
      protected var _isInGame:Boolean = false;
      
      protected var var_414:String;
      
      public function FriendEntityTab()
      {
         super();
      }
      
      public static function allocate(param1:IFriendEntity) : FriendEntityTab
      {
         var _loc2_:FriendEntityTab = const_422.length > 0 ? const_422.pop() : new FriendEntityTab();
         _loc2_.var_1708 = false;
         _loc2_.friend = param1;
         if(param1.notifications.length > 0)
         {
            for each(var _loc3_ in param1.notifications)
            {
               _loc2_.addNotificationToken(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private static function purgeEntityPieces(param1:IWindowContainer) : void
      {
         var _loc3_:IWindowContainer = null;
         var _loc4_:IItemListWindow;
         _loc3_ = (_loc4_ = IItemListWindow(param1.getChildByName("pieces"))).getListItemByName("facebook") as IWindowContainer;
         if(_loc3_)
         {
            _loc3_.dispose();
         }
         _loc3_ = _loc4_.getListItemByName("controls") as IWindowContainer;
         if(_loc3_)
         {
            _loc3_.dispose();
         }
         var _loc5_:Array = [];
         _loc4_.groupListItemsWithTag("notification",_loc5_);
         if(_loc5_.length > 0)
         {
            for each(var _loc2_ in _loc5_)
            {
               _loc2_.parent = null;
            }
         }
         param1.height = HEIGHT;
         param1.y = 0;
      }
      
      public function set friend(param1:IFriendEntity) : void
      {
         var_1722 = param1;
         refresh();
      }
      
      public function get friend() : IFriendEntity
      {
         return var_1722;
      }
      
      override public function recycle() : void
      {
         if(!disposed)
         {
            if(!var_1708)
            {
               if(_window)
               {
                  releaseFriendTabWindow(_window);
                  _window = null;
               }
               if(var_1757)
               {
                  while(var_1757.length > 0)
                  {
                     var_1757.pop().dispose();
                  }
                  var_1757 = null;
               }
               var_1722 = null;
               _isInGame = false;
               var_414 = "";
               var_1708 = true;
               const_422.push(this);
            }
         }
      }
      
      override public function select(param1:Boolean) : void
      {
         var _loc9_:IItemListWindow = null;
         var _loc6_:IWindowContainer = null;
         var _loc7_:IBitmapWrapperWindow = null;
         var _loc8_:Boolean = false;
         var _loc10_:ITextWindow = null;
         var _loc2_:IWindow = null;
         var _loc4_:IWindow = null;
         var _loc3_:IWindow = null;
         var _loc5_:String = null;
         if(!selected)
         {
            _loc9_ = IItemListWindow(window.getChildByName("pieces"));
            _loc8_ = false;
            if(friend.realName != null && friend.realName != "")
            {
               (_loc6_ = WINDOWING.buildFromXML(ASSETS.getAssetByName("facebook_piece_xml").content as XML) as IWindowContainer).name = "facebook";
               (_loc10_ = _loc6_.getChildByName("name") as ITextWindow).caption = friend.realName;
               if(!_loc10_.wordWrap)
               {
                  CROPPER.crop(_loc10_);
               }
               (_loc7_ = IBitmapWrapperWindow(_loc6_.getChildByName("icon"))).bitmap = ASSETS.getAssetByName(_loc7_.bitmapAssetName).content as BitmapData;
               _loc7_.width = _loc7_.bitmap.width;
               _loc7_.height = _loc7_.bitmap.height;
               _loc9_.addListItem(_loc6_);
               _loc8_ = true;
            }
            if(var_1757)
            {
               for each(var _loc11_ in var_1757)
               {
                  _loc9_.addListItem(_loc11_.windowElement);
                  _loc8_ = true;
               }
            }
            if(friend.online)
            {
               (_loc6_ = WINDOWING.buildFromXML(ASSETS.getAssetByName("controls_piece_xml").content as XML) as IWindowContainer).name = "controls";
               _loc2_ = _loc6_.getChildByName("btn_message");
               if(_loc2_)
               {
                  _loc2_.addEventListener("WME_CLICK",onButtonClick);
               }
               if(!_isInGame)
               {
                  if(_loc4_ = _loc6_.getChildByName("btn_game"))
                  {
                     _loc4_.visible = false;
                  }
                  _loc2_ = _loc6_.getChildByName("btn_visit");
                  if(_loc2_)
                  {
                     if(friend.allowFollow)
                     {
                        _loc2_.visible = true;
                        _loc2_.addEventListener("WME_CLICK",onButtonClick);
                     }
                     else
                     {
                        _loc2_.visible = false;
                     }
                  }
               }
               else
               {
                  _loc3_ = _loc6_.getChildByName("btn_visit");
                  if(_loc3_)
                  {
                     _loc3_.visible = false;
                  }
                  _loc2_ = _loc6_.getChildByName("btn_game");
                  if(_loc2_)
                  {
                     _loc5_ = String(var_1924.getLocalization("gamecenter." + var_414 + ".name"));
                     var_1924.registerParameter("friend.bar.game","game",_loc5_);
                     var_1924.registerParameter("friend.bar.game.tip","game",_loc5_);
                     _loc2_.visible = true;
                     _loc2_.addEventListener("WME_CLICK",onButtonClick);
                  }
               }
               _loc2_ = _loc6_.getChildByName("button_profile");
               if(_loc2_)
               {
                  _loc2_.addEventListener("WME_CLICK",onButtonClick);
               }
               _loc9_.addListItem(_loc6_);
               _loc8_ = true;
            }
            if(param1 && false && _loc8_ && class_3596.getMotionByTarget(window) == null)
            {
               class_3596.runMotion(new Combo(new EaseOut(new ResizeTo(window,80,window.width,_loc9_.height),3),new EaseOut(new MoveTo(window,80,window.x,HEIGHT - _loc9_.height),3)));
            }
            else
            {
               if(_loc8_)
               {
                  window.height = _loc9_.height;
               }
               window.y = HEIGHT - window.height;
            }
            super.select(param1);
            if(param1)
            {
               if(TRACKING)
               {
                  TRACKING.trackEventLog("FriendBar","","clicked","",friend.logEventId > 0 ? friend.logEventId : 0);
               }
               friend.logEventId = -1;
            }
         }
      }
      
      override public function deselect(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Token = null;
         if(selected)
         {
            if(_window)
            {
               purgeEntityPieces(_window);
               if(var_1757)
               {
                  _loc3_ = var_1757.length - 1;
                  while(_loc3_ > -1)
                  {
                     if((_loc4_ = var_1757[_loc3_]).viewOnce)
                     {
                        removeNotificationToken(_loc4_.typeCode,param1);
                     }
                     _loc3_--;
                  }
               }
            }
            super.deselect(param1);
         }
         var _loc2_:IWindow = _window.findChildByName("bubble");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      override protected function expose() : void
      {
         super.expose();
         _window.color = exposed ? 13891476 : 10338138;
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
      }
      
      override protected function conceal() : void
      {
         super.conceal();
         _window.color = exposed ? 13891476 : 10338138;
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
      }
      
      protected function refresh() : void
      {
         var _loc1_:IBitmapWrapperWindow = null;
         var _loc2_:IWindowContainer = null;
         if(!_window)
         {
            _window = allocateFriendTabWindow();
         }
         if(var_1722)
         {
            _window.id = var_1722.id;
            _loc2_ = IItemListWindow(_window.getChildByName("pieces")).getListItemByName("header") as IWindowContainer;
            _loc2_.findChildByName("name").caption = var_1722.name;
            CROPPER.crop(_loc2_.getChildByName("name") as ITextWindow);
            _loc1_ = IBitmapWrapperWindow(_loc2_.findChildByName("canvas"));
            if(var_1722.id > 0)
            {
               _loc1_.bitmap = VIEW.getAvatarFaceBitmap(var_1722.figure);
            }
            else
            {
               _loc1_.bitmap = VIEW.getGroupIconBitmap(var_1722.figure);
            }
            _loc1_.width = _loc1_.bitmap.width;
            _loc1_.height = _loc1_.bitmap.height;
         }
      }
      
      private function allocateFriendTabWindow() : IWindowContainer
      {
         var _loc1_:IWindowContainer = const_420.length > 0 ? const_420.pop() : WINDOWING.buildFromXML(ASSETS.getAssetByName("entity_xml").content as XML) as IWindowContainer;
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName("canvas"));
         var _loc4_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("header"));
         var _loc3_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("region_profile"));
         var _loc6_:IWindow = _loc1_.findChildByName("icons");
         var _loc2_:class_3592 = _loc1_.findChildByName("bubble") as class_3592;
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = WIDTH;
         _loc1_.height = HEIGHT;
         _loc1_.addEventListener("WME_CLICK",onMouseClick);
         _loc1_.addEventListener("WME_OVER",onMouseOver);
         _loc1_.addEventListener("WME_OUT",onMouseOut);
         _loc4_.addEventListener("WME_CLICK",onMouseClick);
         _loc4_.addEventListener("WME_OVER",onMouseOver);
         _loc4_.addEventListener("WME_OUT",onMouseOut);
         _loc3_.addEventListener("WME_CLICK",onProfileMouseEvent);
         _loc3_.toolTipCaption = var_1924.getLocalization("infostand.profile.link.tooltip","");
         _loc3_.toolTipDelay = 100;
         _loc6_.addEventListener("WME_CLICK",onMouseClick);
         _loc6_.addEventListener("WME_OVER",onMouseOver);
         _loc6_.addEventListener("WME_OUT",onMouseOut);
         _loc5_.disposesBitmap = true;
         _loc2_.procedure = bubbleEventProc;
         _loc2_.y = -(_loc2_.height + 5);
         _loc2_.visible = false;
         return _loc1_;
      }
      
      private function releaseFriendTabWindow(param1:IWindowContainer) : void
      {
         var _loc3_:IRegionWindow = null;
         var _loc5_:IWindow = null;
         var _loc2_:IRegionWindow = null;
         var _loc4_:IBitmapWrapperWindow = null;
         if(param1 && !param1.disposed)
         {
            param1.procedure = null;
            param1.removeEventListener("WME_CLICK",onMouseClick);
            param1.removeEventListener("WME_OVER",onMouseOver);
            param1.removeEventListener("WME_OUT",onMouseOut);
            _loc3_ = IRegionWindow(param1.findChildByName("header"));
            _loc3_.removeEventListener("WME_CLICK",onMouseClick);
            _loc3_.removeEventListener("WME_OVER",onMouseOver);
            _loc3_.removeEventListener("WME_OUT",onMouseOut);
            (_loc5_ = param1.findChildByName("icons")).removeEventListener("WME_CLICK",onMouseClick);
            _loc5_.removeEventListener("WME_OVER",onMouseClick);
            _loc5_.removeEventListener("WME_OUT",onMouseClick);
            _loc2_ = IRegionWindow(param1.findChildByName("region_profile"));
            _loc2_.removeEventListener("WME_CLICK",onProfileMouseEvent);
            param1.width = WIDTH;
            param1.height = HEIGHT;
            param1.color = 10338138;
            (_loc4_ = IBitmapWrapperWindow(param1.findChildByName("canvas"))).bitmap = null;
            ITextWindow(param1.findChildByTag("label")).underline = false;
            purgeEntityPieces(param1);
            if(const_420.indexOf(param1) == -1)
            {
               const_420.push(param1);
            }
         }
      }
      
      private function onButtonClick(param1:WindowMouseEvent) : void
      {
         if(!disposed && !recycled)
         {
            switch(param1.window.name)
            {
               case "btn_message":
               case "icon_message":
                  VIEW.removeMessengerNotifications();
                  if(DATA && var_1722)
                  {
                     DATA.startConversation(var_1722.id);
                     deselect(true);
                     if(param1.window.name == "icon_message")
                     {
                        VIEW.setMessengerIconNotify(false);
                     }
                  }
                  break;
               case "btn_visit":
                  if(DATA && var_1722)
                  {
                     DATA.followToRoom(var_1722.id);
                     deselect(true);
                  }
                  break;
               case "button_profile":
                  if(DATA && var_1722)
                  {
                     TRACKING.trackGoogle("extendedProfile","friendToolbar_friendButton");
                     DATA.showProfile(var_1722.id);
                     deselect(true);
                  }
                  break;
               case "btn_game":
               case "icon_game":
                  if(GAMES)
                  {
                     deselect(true);
                     GAMES.initGameDirectoryConnection();
                     DATA.sendGameButtonTracking(var_414);
                  }
                  break;
               case "icon_game_invite":
                  deselect(true);
                  showBubble();
            }
         }
      }
      
      private function showBubble() : void
      {
         var _loc1_:IWindow = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("bubble");
            _window.findChildByName("bubble_message").caption = var_1924.getLocalization("gamecenter." + var_414 + ".name");
            _loc1_.visible = true;
         }
      }
      
      protected function onProfileMouseEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_CLICK")
         {
            TRACKING.trackGoogle("extendedProfile","friendBar_friendAvatar");
            DATA.showProfile(var_1722.id);
            deselect(true);
         }
      }
      
      public function addNotificationToken(param1:IFriendNotification) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:Token = null;
         var _loc5_:IItemListWindow = null;
         var _loc4_:IWindow = null;
         removeNotificationToken(param1.typeCode,false);
         if(!var_1757)
         {
            var_1757 = new Vector.<Token>();
         }
         var _loc2_:Boolean = selected;
         if(_loc2_)
         {
            _loc6_ = var_1757;
            var_1757 = null;
            deselect(false);
            var_1757 = _loc6_;
         }
         var _loc3_:String = null;
         switch(param1.typeCode - -1)
         {
            case 0:
               (_loc7_ = new MessengerToken(friend,param1)).iconElement.name = "icon_message";
               _loc7_.iconElement.addEventListener("WME_CLICK",onButtonClick);
               _loc3_ = "icon_tag_message";
               break;
            case 1:
               (_loc7_ = new RoomEventToken(friend,param1)).iconElement.addEventListener("WME_CLICK",onMouseClick);
               _loc3_ = "icon_tag_notify";
               break;
            case 2:
               (_loc7_ = new AchievementToken(friend,param1,var_1924)).iconElement.addEventListener("WME_CLICK",onMouseClick);
               _loc3_ = "icon_tag_notify";
               break;
            case 3:
               (_loc7_ = new QuestToken(friend,param1)).iconElement.addEventListener("WME_CLICK",onMouseClick);
               _loc3_ = "icon_tag_notify";
               break;
            case 4:
               (_loc7_ = new GameToken(friend,param1)).iconElement.name = "icon_game";
               _loc7_.iconElement.addEventListener("WME_CLICK",onMouseClick);
               _loc3_ = "icon_tag_game";
               _isInGame = true;
               var_414 = _loc7_.notification.message;
               break;
            case 5:
               removeNotificationToken(3,true);
               _isInGame = false;
               return;
            default:
               throw new Error("Unknown friend notification type: " + param1.typeCode + "!");
         }
         if(_loc7_)
         {
            var_1757.push(_loc7_);
            if(_loc3_ != null)
            {
               if(!(_loc5_ = IItemListWindow(_window.findChildByName("icons"))).getListItemByTag(_loc3_))
               {
                  if((_loc4_ = _loc7_.iconElement).tags.indexOf(_loc3_) == -1)
                  {
                     _loc4_.tags.push(_loc3_);
                  }
                  _loc5_.addListItemAt(_loc4_,0);
               }
            }
         }
         if(_loc2_)
         {
            select(false);
         }
      }
      
      public function removeNotificationToken(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Token = null;
         if(!var_1757)
         {
            return;
         }
         _loc3_ = var_1757.length - 1;
         while(_loc3_ > -1)
         {
            if((_loc4_ = var_1757[_loc3_]).typeCode == param1)
            {
               var_1757.splice(_loc3_,1);
               if(param2)
               {
                  var_1722.notifications.splice(var_1722.notifications.indexOf(_loc4_.notification),1);
               }
               _loc4_.dispose();
               return;
            }
            _loc3_--;
         }
      }
      
      private function bubbleEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "bubble_button_accept":
               case "bubble_button_close":
               case "bubble_click_region_reject":
                  deselect(true);
            }
         }
      }
      
      public function toString() : String
      {
         return getQualifiedClassName(this) + " " + var_1722.name;
      }
   }
}
