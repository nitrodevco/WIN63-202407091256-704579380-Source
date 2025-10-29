package com.sulake.habbo.toolbar.memenu
{
    import assets.class_14

    import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.toolbar.BottomBarLeft;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   
   public class MeMenuNewController implements IDisposable
   {
      
      public static const USE_GUIDE_TOOL:String = "USE_GUIDE_TOOL";
       
      
      private var _toolbar:HabboToolbar;
      
      private var var_1733:BottomBarLeft;
      
      private var _window:IWindowContainer;
      
      private var var_3889:MeMenuNewIconLoader;
      
      private var var_2010:MeMenuSettingsMenuView;
      
      private var _unseenItemCounters:Map;
      
      public function MeMenuNewController(param1:HabboToolbar, param2:BottomBarLeft)
      {
         super();
         _unseenItemCounters = new Map();
         _toolbar = param1;
         var_1733 = param2;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("me_menu_new_view_xml") as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,2) as IWindowContainer;
         if(!_toolbar.getBoolean("guides.enabled"))
         {
            setGuideToolVisibility(false);
         }
         if(!_toolbar.getBoolean("classic.collectibles.hub.enabled") || !_toolbar.getBoolean("collectibles.hub.enabled"))
         {
            setCollectiblesVisibility(false);
         }
         setMinimailVisibility(false);
         var_3889 = new MeMenuNewIconLoader(_toolbar);
         _window.visible = false;
         _window.procedure = windowProcedure;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc7_:IRegionWindow = null;
         var _loc6_:IStaticBitmapWrapperWindow = null;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc5_:ITextWindow = null;
         var _loc3_:IHabboNavigator = null;
         var _loc8_:String = null;
         if(param2 is IRegionWindow)
         {
            _loc6_ = (_loc7_ = param2 as IRegionWindow).findChildByName(param2.name + "_icon_color") as IStaticBitmapWrapperWindow;
            _loc4_ = _loc7_.findChildByName(param2.name + "_icon_grey") as IStaticBitmapWrapperWindow;
            _loc5_ = _loc7_.findChildByName("field_text") as ITextWindow;
            switch(param1.type)
            {
               case "WME_OVER":
                  if(_loc6_ != null && _loc4_ != null)
                  {
                     _loc6_.visible = true;
                     _loc4_.visible = false;
                     if(_loc5_ != null)
                     {
                        _loc5_.textColor = 2215924;
                     }
                  }
                  break;
               case "WME_OUT":
                  if(_loc6_ != null && _loc4_ != null)
                  {
                     _loc6_.visible = false;
                     _loc4_.visible = true;
                     if(_loc5_ != null)
                     {
                        _loc5_.textColor = 16777215;
                     }
                  }
                  break;
               case "WME_CLICK":
                  _window.visible = false;
                  if(_toolbar != null)
                  {
                     switch(param2.name)
                     {
                        case "profile":
                           _toolbar.connection.send(new GetExtendedProfileMessageComposer(_toolbar.sessionDataManager.userId));
                           break;
                        case "minimail":
                           HabboWebTools.openMinimail("#mail/inbox/");
                           break;
                        case "rooms":
                           _loc3_ = _toolbar.navigator;
                           if(_loc3_ != null)
                           {
                              _loc3_.showOwnRooms();
                           }
                           break;
                        case "talents":
                           _loc8_ = _toolbar.sessionDataManager.currentTalentTrack;
                           _toolbar.connection.send(new GetTalentTrackMessageComposer(_loc8_));
                           break;
                        case "settings":
                           break;
                        case "achievements":
                           _toolbar.questEngine.showAchievements();
                           break;
                        case "guide":
                           _toolbar.toggleWindowVisibility("GUIDE");
                           break;
                        case "clothes":
                           _toolbar.context.createLinkEvent("avatareditor/open");
                           break;
                        case "forums":
                           _toolbar.context.createLinkEvent("groupforum/list/my");
                           break;
                        case "collectibles":
                           _toolbar.context.createLinkEvent("collectibles/open");
                     }
                  }
                  break;
            }
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         if(param1.iconId == "HTIE_ICON_MEMENU")
         {
            toggleVisibility();
         }
         else
         {
            _window.visible = false;
            if(var_2010 != null)
            {
               var_2010.dispose();
               var_2010 = null;
            }
         }
      }
      
      private function setGuideToolVisibility(param1:Boolean) : void
      {
         _window.findChildByName("guide").visible = param1;
         _window.height = param1 ? _window.findChildByName("guide").bottom + 5 : _window.findChildByName("achievements").bottom + 5;
      }
      
      private function setCollectiblesVisibility(param1:Boolean) : void
      {
         _window.findChildByName("collectibles").visible = param1;
      }
      
      private function setMinimailVisibility(param1:Boolean) : void
      {
         _window.findChildByName("minimail").visible = param1;
      }
      
      public function toggleVisibility() : void
      {
         var _loc1_:Boolean = false;
         if(var_2010 != null)
         {
            var_2010.dispose();
            var_2010 = null;
         }
         _window.visible = !_window.visible;
         if(_window.visible)
         {
            if(!toolbar.getBoolean("talent.track.enabled"))
            {
               _window.findChildByName("talents").visible = false;
            }
            if(_toolbar.getBoolean("guides.enabled"))
            {
               _loc1_ = _toolbar.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL");
               setGuideToolVisibility(_loc1_);
            }
         }
         reposition();
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_2010 != null)
         {
            var_2010.dispose();
            var_2010 = null;
         }
         var_3889.dispose();
         var_3889 = null;
         _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         var_1733 = null;
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
      
      public function get toolbar() : HabboToolbar
      {
         return _toolbar;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function reposition() : void
      {
         _window.x = 3;
         _window.y = var_1733.window.top - _window.height;
      }
      
      public function getIconPosition(param1:String) : Rectangle
      {
         var _loc2_:Rectangle = null;
         var _loc3_:IWindow = _window.findChildByName(param1);
         if(_loc3_)
         {
            _loc2_ = _loc3_.rectangle;
            _loc2_.x += _window.x + _loc3_.width / 2;
            _loc2_.y += _window.y + _loc3_.height / 2;
            _window.visible = true;
         }
         return _loc2_;
      }
      
      public function getIcon(param1:String) : IWindow
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_)
         {
            _window.visible = true;
         }
         return _loc2_;
      }
      
      public function getUnseenItemCounter(param1:String) : IWindowContainer
      {
         var _loc2_:IWindowContainer = null;
         var _loc4_:*;
         if(!(_loc4_ = param1))
         {
            class_14.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:IWindowContainer = _unseenItemCounters.getValue(param1) as IWindowContainer;
         if(!_loc3_)
         {
            _loc3_ = _toolbar.windowManager.createUnseenItemCounter();
            _loc2_ = _window.findChildByName(_loc4_) as IWindowContainer;
            if(_loc2_)
            {
               _loc2_.addChild(_loc3_);
               _loc3_.x = _loc2_.width - _loc3_.width - 5;
               _loc3_.y = 5;
               _unseenItemCounters.add(param1,_loc3_);
            }
         }
         return _loc3_;
      }
      
      public function set unseenAchievementsCount(param1:int) : void
      {
         setUnseenItemCount("achievements",param1);
      }
      
      public function set unseenMinimailsCount(param1:int) : void
      {
         setUnseenItemCount("minimail",param1);
      }
      
      public function set unseenForumsCount(param1:int) : void
      {
         setUnseenItemCount("forums",param1);
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:IWindowContainer = getUnseenItemCounter(param1);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = " ";
         }
         else if(param2 > 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = param2.toString();
         }
         else
         {
            _loc3_.visible = false;
         }
      }
   }
}
