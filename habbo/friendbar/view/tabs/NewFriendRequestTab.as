package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3592;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.data.FriendEntity;
   import com.sulake.habbo.friendbar.data.FriendRequest;
   import com.sulake.habbo.friendbar.data.IFriendRequest;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class NewFriendRequestTab extends NewFriendEntityTab
   {
      
      protected static const REQUEST_WINDOW_RESOURCE:String = "friend_request_tab_xml";
      
      protected static const BUBBLE:String = "bubble";
      
      protected static const MESSAGE:String = "message";
      
      protected static const BUTTON_ACCEPT:String = "button_accept";
      
      protected static const const_545:String = "button_close";
      
      protected static const REGION_REJECT:String = "click_region_reject";
      
      protected static const REGION_REJECT_TEXT:String = "link_reject";
      
      private static const DEFAULT_COLOR:uint = 16435481;
      
      private static const const_557:uint = 16767334;
      
      private static const REGION_REJECT_COLOR_EXPOSED:uint = 16770666;
      
      private static const REGION_REJECT_COLOR_NORMAL:uint = 16777215;
      
      private static var var_4055:NewFriendRequestTab;
       
      
      private var var_4978:String;
      
      public function NewFriendRequestTab()
      {
         super();
         _window = allocateRequestTabWindow();
         if(_window)
         {
            _window.findChildByName("bubble").visible = false;
         }
      }
      
      public static function allocate(param1:IFriendRequest) : NewFriendRequestTab
      {
         var _loc3_:IBitmapWrapperWindow = null;
         var _loc2_:NewFriendRequestTab = !!var_4055 ? var_4055 : new NewFriendRequestTab();
         _loc2_.var_1708 = false;
         if(_loc2_.friend)
         {
            if(_loc2_.friend.figure != param1.figure)
            {
               _loc3_ = IBitmapWrapperWindow(_loc2_._window.findChildByName("canvas"));
               _loc3_.bitmap = VIEW.getAvatarFaceBitmap(param1.figure);
            }
         }
         _loc2_.friend = new FriendEntity(param1.id,param1.name,null,null,-1,false,false,param1.figure,0,null);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            releaseRequestTabWindow(_window);
            _window = null;
         }
         super.dispose();
      }
      
      override public function recycle() : void
      {
         if(!disposed)
         {
            if(!var_1708)
            {
               var_1722 = null;
               var_1708 = true;
               var_4055 = this;
            }
         }
      }
      
      override public function select(param1:Boolean) : void
      {
         var _loc2_:IWindow = null;
         if(!selected)
         {
            if(_window)
            {
               _loc2_ = _window.findChildByName("bubble");
               if(_loc2_)
               {
                  _loc2_.visible = true;
               }
            }
            super.select(param1);
         }
      }
      
      override public function deselect(param1:Boolean) : void
      {
         var _loc2_:IWindow = null;
         if(selected)
         {
            if(_window)
            {
               _loc2_ = _window.findChildByName("bubble");
               if(_loc2_)
               {
                  _loc2_.visible = false;
               }
            }
            super.deselect(param1);
         }
      }
      
      override protected function expose() : void
      {
         super.expose();
         _window.color = exposed ? 16767334 : 16435481;
      }
      
      override protected function conceal() : void
      {
         super.conceal();
         _window.color = exposed ? 16767334 : 16435481;
      }
      
      private function allocateRequestTabWindow() : IWindowContainer
      {
         var _loc9_:BitmapDataAsset = null;
         var _loc1_:IWindowContainer = WINDOWING.buildFromXML(ASSETS.getAssetByName("friend_request_tab_xml").content as XML) as IWindowContainer;
         var _loc7_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName("canvas"));
         var _loc6_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("header"));
         var _loc3_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("region_profile"));
         var _loc8_:IWindow = _loc1_.findChildByName("icons");
         var _loc2_:class_3592 = _loc1_.findChildByName("bubble") as class_3592;
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = WIDTH;
         _loc1_.height = HEIGHT;
         _loc1_.addEventListener("WME_CLICK",onMouseClick);
         _loc1_.addEventListener("WME_OVER",onMouseOver);
         _loc1_.addEventListener("WME_OUT",onMouseOut);
         _loc6_.addEventListener("WME_CLICK",onMouseClick);
         _loc6_.addEventListener("WME_OVER",onMouseOver);
         _loc6_.addEventListener("WME_OUT",onMouseOut);
         _loc3_.addEventListener("WME_CLICK",onProfileMouseEvent);
         _loc3_.toolTipCaption = var_1924.getLocalization("infostand.profile.link.tooltip","");
         _loc3_.toolTipDelay = 100;
         _loc8_.addEventListener("WME_CLICK",onMouseClick);
         _loc8_.addEventListener("WME_OVER",onMouseOver);
         _loc8_.addEventListener("WME_OUT",onMouseOut);
         _loc7_.disposesBitmap = true;
         _loc2_.procedure = bubbleEventProc;
         _loc2_.y = -(_loc2_.height - (_loc2_.height - _loc2_.margins.bottom)) - 1;
         var _loc5_:IRegionWindow;
         (_loc5_ = WINDOWING.create("ICON",5,0,1,new Rectangle(0,0,25,25)) as IRegionWindow).mouseThreshold = 0;
         var _loc4_:IBitmapWrapperWindow;
         (_loc4_ = WINDOWING.create("BITMAP",21,0,16,new Rectangle(0,0,25,25)) as IBitmapWrapperWindow).disposesBitmap = false;
         if(_loc9_ = ASSETS.getAssetByName("plus_friend_icon_png") as BitmapDataAsset)
         {
            _loc4_.bitmap = _loc9_.content as BitmapData;
         }
         _loc5_.addChild(_loc4_);
         IItemListWindow(_loc1_.findChildByName("icons")).addListItemAt(_loc5_,0);
         return _loc1_;
      }
      
      private function releaseRequestTabWindow(param1:IWindowContainer) : void
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
            param1.color = 16435481;
            (_loc4_ = IBitmapWrapperWindow(param1.findChildByName("canvas"))).bitmap = null;
            ITextWindow(param1.findChildByTag("label")).underline = false;
         }
      }
      
      private function bubbleEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_accept":
                  DATA.acceptFriendRequest(var_1722.id);
                  break;
               case "button_close":
                  if(selected)
                  {
                     VIEW.deSelect(true);
                  }
                  break;
               case "button_profile":
                  TRACKING.trackGoogle("extendedProfile","friendBar_friendRequestButton");
                  DATA.showProfile(var_1722.id);
                  break;
               case "click_region_reject":
                  DATA.declineFriendRequest(var_1722.id);
            }
         }
         else if(param1.type == "WME_OVER")
         {
            if(param2.name == "click_region_reject")
            {
               ITextWindow(IWindowContainer(param2).getChildByName("link_reject")).textColor = 16770666;
            }
            if(param2.name == "button_profile")
            {
               IIconWindow(IWindowContainer(param2).findChildByName("icon")).style = 22;
            }
            if(param2.name == "region_profile")
            {
               ITextWindow(IWindowContainer(param2).getChildByName("name")).underline = true;
            }
         }
         else if(param1.type == "WME_OUT")
         {
            if(param2.name == "click_region_reject")
            {
               ITextWindow(IWindowContainer(param2).getChildByName("link_reject")).textColor = 16777215;
            }
            if(param2.name == "button_profile")
            {
               IIconWindow(IWindowContainer(param2).findChildByName("icon")).style = 21;
            }
            if(param2.name == "region_profile")
            {
               ITextWindow(IWindowContainer(param2).getChildByName("name")).underline = false;
            }
         }
      }
      
      public function avatarImageReady(param1:FriendRequest, param2:BitmapData) : void
      {
         var _loc4_:IBitmapWrapperWindow = null;
         var _loc3_:BitmapData = null;
         if(!disposed)
         {
            if(friend)
            {
               if(friend.figure == param1.figure)
               {
                  if(_loc4_ = _window.findChildByName("canvas") as IBitmapWrapperWindow)
                  {
                     _loc3_ = VIEW.getAvatarFaceBitmap(param1.figure);
                     if(_loc3_)
                     {
                        _loc4_.bitmap = _loc3_;
                        _loc4_.width = _loc3_.width;
                        _loc4_.height = _loc3_.height;
                     }
                  }
               }
            }
         }
      }
   }
}
