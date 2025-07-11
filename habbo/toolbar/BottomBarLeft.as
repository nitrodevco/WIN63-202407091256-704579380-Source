package com.sulake.habbo.toolbar
{
    import assets.class_14

    import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3651;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.motion.Dispose;
   import com.sulake.core.window.motion.DropBounce;
   import com.sulake.core.window.motion.EaseOut;
   import com.sulake.core.window.motion.JumpBy;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.core.window.motion.Queue;
   import com.sulake.core.window.motion.Wait;
   import com.sulake.core.window.motion.class_3596;
   import com.sulake.core.window.utils.class_3501;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.toolbar.memenu.MeMenuNewController;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BottomBarLeft implements ILinkEventTracker
   {
      
      private static const DEFAULT_LOCATION:Point = new Point(0,500);
      
      private static const LANDING_VIEW_LOCATION:Point = new Point(0,500);
      
      private static const ICON_BG_COLOR_OVER:uint = 7433577;
      
      private static const ICON_BG_COLOR_OUT:uint = 5723213;
      
      private static const ICON_MOUSE_OVER:String = "_hover";
      
      private static const ICON_MOUSE_OUT:String = "_normal";
      
      private static const COUNTER_MARGIN:int = 0;
      
      private static const ME_MENU_ICON_NAME:String = "icon_me_menu";
      
      private static const ICON_REGION_WIDTH:int = 45;
      
      private static const ICON_LABEL_HEIGHT:int = 20;
      
      private static const WINDOW_RIGHT_PADDING:int = 10;
      
      private static const COLLAPSED_MARGIN:int = 185;
       
      
      private var _window:IWindowContainer;
      
      private var name_1:IEventDispatcher;
      
      private var _disposed:Boolean;
      
      private var _toolbar:HabboToolbar;
      
      private var _assets:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _unseenItemCounters:Map;
      
      private var var_1899:IWindowContainer;
      
      private var var_4515:Boolean;
      
      private var var_2595:BitmapData;
      
      private var _left_arrow:IRegionWindow;
      
      private var _right_arrow:IRegionWindow;
      
      private var _buttonContainer:class_3651;
      
      private var var_3539:IStaticBitmapWrapperWindow;
      
      private var var_3480:String;
      
      private var var_4482:int;
      
      private var var_4400:int;
      
      private var var_4359:int;
      
      private var var_2202:Boolean = false;
      
      private var var_2280:MeMenuNewController;
      
      public function BottomBarLeft(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IEventDispatcher)
      {
         var _loc5_:IWindowContainer = null;
         super();
         _toolbar = param1;
         _windowManager = param2;
         _assets = param3;
         name_1 = param4;
         var_2280 = new MeMenuNewController(_toolbar,this);
         _unseenItemCounters = new Map();
         var _loc13_:XmlAsset = param3.getAssetByName("bottom_bar_left_xml") as XmlAsset;
         _window = param2.buildFromXML(_loc13_.content as XML) as IWindowContainer;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.addEventListener("WE_PARENT_RESIZED",onParentResized);
         _buttonContainer = _window.getChildByName("toolbar_items") as class_3651;
         var _loc14_:IWindowContainer = _window.getChildByName("arrow_container_left") as IWindowContainer;
         var _loc10_:IWindowContainer = _window.getChildByName("arrow_container_right") as IWindowContainer;
         _left_arrow = _loc14_.getChildByName("collapse_left") as IRegionWindow;
         _right_arrow = _loc10_.getChildByName("collapse_right") as IRegionWindow;
         if(_left_arrow)
         {
            _left_arrow.addEventListener("WME_CLICK",onCollapseToolsBar);
         }
         if(_right_arrow)
         {
            _right_arrow.addEventListener("WME_CLICK",onCollapseToolsBar);
         }
         var_3539 = _buttonContainer.getChildByName("line") as IStaticBitmapWrapperWindow;
         var _loc9_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc9_,-1);
         for each(var _loc7_ in _loc9_)
         {
            if(_loc7_ && _loc7_ is IRegionWindow)
            {
               _loc7_.addEventListener("WME_CLICK",onIconClick);
            }
         }
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_WIRED_MENU"),false);
         var _loc12_:Boolean;
         if(_loc12_ = param1.getBoolean("games_icon_enabled"))
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),true);
         }
         else
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),false);
         }
         var _loc11_:XmlAsset = param3.getAssetByName("new_items_label_xml") as XmlAsset;
         var_1899 = param2.buildFromXML(_loc11_.content as XML,2) as IWindowContainer;
         if(var_1899 == null)
         {
            throw new Error("Failed to construct toolbar label from XML!");
         }
         if(_loc5_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR")) as IWindowContainer)
         {
            _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"),_loc5_);
         }
         if(_loc5_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU")) as IWindowContainer)
         {
            _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"),_loc5_);
         }
         if(_loc5_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY")) as IWindowContainer)
         {
            _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"),_loc5_);
         }
         var _loc8_:IWindowContainer;
         (_loc8_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowContainer).addChild(var_1899);
         _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"),_loc8_);
         var _loc15_:ITextWindow = var_1899.findChildByName("new_textfield") as ITextWindow;
         var _loc6_:ILocalization;
         if((_loc6_ = param1.localization.getLocalizationRaw("toolbar.new_additions.notification")) != null)
         {
            _loc15_.text = _loc6_.value;
         }
         var_1899.visible = false;
         var_1899.x = _loc8_.width - var_1899.width - 0;
         var_1899.y = 0;
         var_4515 = isNewItemsNotificationEnabled();
         checkSize();
         (param1 as Component).context.addLinkEventTracker(this);
      }
      
      private function onPanicButton(param1:WindowMouseEvent, param2:*) : void
      {
         _toolbar.toggleWindowVisibility("PANIC");
      }
      
      private function onParentResized(param1:WindowEvent) : void
      {
         checkSize();
      }
      
      private function checkSize() : void
      {
         if(!_window || !_windowManager)
         {
            return;
         }
         _left_arrow.visible = !var_2202;
         _right_arrow.visible = var_2202;
         _window.y = _window.desktop.height - _window.height;
         _window.width = 45 * calculateNewWidth() + 10 + 150;
         if(!var_2202)
         {
            if(var_2280 != null)
            {
               var_2280.reposition();
            }
         }
         _window.invalidate();
      }
      
      public function dispose() : void
      {
         if(var_2280 != null)
         {
            var_2280.dispose();
            var_2280 = null;
         }
         if(var_2595 != null)
         {
            var_2595.dispose();
            var_2595 = null;
         }
         if(_unseenItemCounters != null)
         {
            _unseenItemCounters.dispose();
            _unseenItemCounters = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1899 != null)
         {
            var_1899.dispose();
            var_1899 = null;
         }
         if(_windowManager)
         {
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"));
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"));
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"));
         }
         if(_toolbar)
         {
            (_toolbar as Component).context.removeLinkEventTracker(this);
            _toolbar = null;
         }
         _windowManager = null;
         _assets = null;
         _disposed = true;
         if(name_1)
         {
            name_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      private function disableCatalogIcon() : void
      {
         var _loc1_:IWindowContainer = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowContainer;
         _loc1_.blend = 0.5;
         _loc1_.disable();
      }
      
      public function onCatalogEvent(param1:CatalogEvent) : void
      {
         var _loc2_:IWindowContainer = null;
         var _loc3_:String = null;
         switch(param1.type)
         {
            case "CATALOG_INITIALIZED":
               _loc2_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowContainer;
               _loc2_.blend = 1;
               _loc2_.enable();
               _loc3_ = _toolbar.getProperty("open.catalog.page");
               if(_loc3_.length > 0 && _toolbar.catalog)
               {
                  _toolbar.catalog.openCatalogPage("hc_membership");
                  _toolbar.setProperty("open.catalog.page","");
               }
               break;
            case "CATALOG_NOT_READY":
               disableCatalogIcon();
               break;
            case "CATALOG_NEW_ITEMS_SHOW":
               if(var_1899 != null && var_4515)
               {
                  var_1899.visible = true;
               }
               break;
            case "CATALOG_NEW_ITEMS_HIDE":
               if(var_1899 != null)
               {
                  var_1899.visible = false;
               }
         }
      }
      
      public function onWiredMenuEvent(param1:WiredMenuEvent) : void
      {
         var _loc2_:IWindowContainer = null;
         var _loc3_:* = param1.type;
         if("WIRED_MENU_BUTTON_PREFERENCE_CHANGED" === _loc3_)
         {
            _loc2_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_WIRED_MENU")) as IWindowContainer;
            _loc2_.visible = _toolbar.roomEvents != null && _toolbar.roomEvents.showToolbarMenuButton();
         }
         checkSize();
      }
      
      public function setToolbarState(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         if(param1 == "HTE_STATE_HIDDEN")
         {
            _window.visible = false;
            return;
         }
         _window.visible = true;
         if(param1 != "HTE_STATE_COLLAPSED")
         {
            var_3480 = param1;
         }
         var _loc7_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc7_,-1);
         switch(param1)
         {
            case "HTE_STATE_GAME_CENTER_VIEW":
               _loc3_ = "VISIBLE_GAME_CENTER";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_HOTEL_VIEW":
               _loc3_ = "VISIBLE_HOTEL";
               _window.position = LANDING_VIEW_LOCATION;
               break;
            case "HTE_STATE_NOOB_NOT_HOME":
               _loc3_ = "VISIBLE_NOOB";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HETE_STATE_NOOB_HOME":
               _loc3_ = "VISIBLE_ROOM";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_ROOM_VIEW":
               _loc3_ = "VISIBLE_ROOM";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_COLLAPSED":
               _loc3_ = "VISIBLE_COLLAPSED";
               _window.position = DEFAULT_LOCATION;
         }
         var _loc4_:Boolean = param1 == "HTE_STATE_ROOM_VIEW" || param1 == "HETE_STATE_NOOB_HOME" || param1 == "HTE_STATE_NOOB_NOT_HOME" || var_2202 && (var_3480 == "HTE_STATE_ROOM_VIEW" || var_3480 == "HETE_STATE_NOOB_HOME" || var_3480 == "HTE_STATE_NOOB_NOT_HOME");
         for each(var _loc2_ in _loc7_)
         {
            if(_loc2_)
            {
               _loc2_.visible = _loc2_.tags.indexOf(_loc3_) >= 0;
               if(_loc2_.name == "QUESTS" && !var_2202)
               {
                  _loc2_.visible &&= !_toolbar.getBoolean("toolbar.hide.quests");
               }
               else if(_loc2_.name == "STORIES" && !var_2202)
               {
                  _loc2_.visible &&= _toolbar.getBoolean("toolbar.stories.enabled");
               }
               else if(_loc2_.name == "BUILDER" && !var_2202)
               {
                  _loc2_.visible &&= _toolbar.getBoolean("builders.club.enabled");
               }
               else if(_loc2_.name == "GAMES")
               {
                  _loc2_.visible &&= _toolbar.getBoolean("games_icon_enabled");
               }
               else if(_loc2_.name == "CAMERA")
               {
                  _loc5_ = _toolbar.getProperty("camera.launch.ui.position");
                  _loc6_ = _toolbar.sessionDataManager.isPerkAllowed("CAMERA");
                  _loc2_.visible = _loc4_ && _loc5_ == "bottom-icons" && _loc6_;
               }
               else if(_loc2_.name == "WIRED_MENU")
               {
                  _loc2_.visible = _loc4_ && _toolbar.roomEvents != null && _toolbar.roomEvents.showToolbarMenuButton();
               }
            }
         }
         checkSize();
      }
      
      public function iconVisibility(param1:String, param2:Boolean) : void
      {
         var _loc3_:IWindowContainer = _window.findChildByName(param1) as IWindowContainer;
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
         checkSize();
      }
      
      public function calculateNewWidth() : int
      {
         var _loc3_:Array = [];
         var _loc2_:int = 1;
         _window.groupChildrenWithTag("TOGGLE",_loc3_,-1);
         for each(var _loc1_ in _loc3_)
         {
            if(_loc1_ && _loc1_.visible)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function onNaviHover(param1:WindowMouseEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_toolbar.navigator == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_OVER":
               _loc2_ = getIconLocation("HTIE_ICON_NAVIGATOR");
               _toolbar.navigator.showToolbarHover(new Point(_loc2_.right + 15,_loc2_.y));
               break;
            case "WME_OUT":
               _toolbar.navigator.hideToolbarHover(true);
         }
      }
      
      private function onIconHoverMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowContainer = param1.target as IWindowContainer;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:class_3437 = _loc2_.findChildByTag("ICON_BORDER") as class_3437;
         var _loc4_:class_3501 = _loc2_.findChildByTag("ICON_BMP") as class_3501;
         class_14.log(param1);
         switch(param1.type)
         {
            case "WME_OVER":
               setIconHoverState(_loc4_,"_hover");
               setIconBgHoverState(_loc3_,"_hover");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
               break;
            case "WME_OUT":
               setIconHoverState(_loc4_,"_normal");
               setIconBgHoverState(_loc3_,"_normal");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
         }
      }
      
      private function setIconHoverState(param1:class_3501, param2:String) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc4_:IBitmapWrapperWindow = null;
         if(param1 is IStaticBitmapWrapperWindow)
         {
            _loc3_ = param1 as IStaticBitmapWrapperWindow;
            _loc3_.assetUri = _loc3_.name + param2;
         }
         else if(param1 is IBitmapWrapperWindow)
         {
            if((_loc4_ = param1 as IBitmapWrapperWindow).name == "icon_me_menu")
            {
               _loc4_.bitmap = var_2595;
            }
         }
      }
      
      private function setIconBgHoverState(param1:IWindowContainer, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2 == "_hover")
         {
            param1.color = 7433577;
         }
         else
         {
            param1.color = 5723213;
         }
      }
      
      private function onIconClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = String(IWindow(param1.target).name);
         _toolbar.toggleWindowVisibility(_loc2_);
         _windowManager.hideMatchingHint(_loc2_);
      }
      
      public function setIconBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:String = null;
         if(!param2)
         {
            return;
         }
         var _loc5_:* = param1;
         if("HTIE_ICON_MEMENU" === _loc5_)
         {
            _loc3_ = "icon_me_menu";
            setMeMenuIconBitmaps(param2);
         }
         var _loc4_:class_3501;
         if((_loc4_ = _window.findChildByName(_loc3_) as class_3501) != null)
         {
            setIconHoverState(_loc4_,"_normal");
         }
      }
      
      private function getIconName(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "HTIE_ICON_CATALOGUE":
               _loc2_ = "icons_toolbar_catalogue";
               break;
            case "HTIE_ICON_INVENTORY":
               _loc2_ = "icons_toolbar_inventory";
               break;
            case "HTIE_ICON_MEMENU":
               _loc2_ = "MEMENU";
               break;
            case "HTIE_ICON_NAVIGATOR":
               _loc2_ = "icons_toolbar_navigator";
               break;
            case "HTIE_ICON_QUESTS":
               _loc2_ = "icons_toolbar_quests";
               break;
            case "HTIE_ICON_GAMES":
               _loc2_ = "icons_toolbar_games";
               break;
            case "HTIE_ICON_STORIES":
               _loc2_ = "icons_toolbar_stories";
               break;
            case "HTIE_ICON_RECEPTION":
               _loc2_ = "icons_toolbar_reception";
               break;
            case "HTIE_ICON_BUILDER":
               _loc2_ = "icons_toolbar_builder";
               break;
            case "HTIE_ICON_CAMERA":
               _loc2_ = "icons_toolbar_camera";
               break;
            case "HTIE_ICON_WIRED_MENU":
               _loc2_ = "icons_toolbar_wired_menu";
         }
         return _loc2_;
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc4_:IWindow = null;
         var _loc2_:Rectangle = new Rectangle();
         var _loc5_:String = null;
         if((_loc5_ = getIconName(param1)) != null)
         {
            _loc4_ = _window.findChildByName(_loc5_);
         }
         if(_loc4_ != null && _loc4_.visible)
         {
            _loc4_.getGlobalRectangle(_loc2_);
            return _loc2_;
         }
         var _loc3_:Rectangle = var_2280.getIconPosition(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         return null;
      }
      
      public function geIcon(param1:String) : IWindow
      {
         var _loc3_:IWindow = null;
         var _loc2_:String = getIconName(param1);
         _loc3_ = _window.findChildByName(_loc2_);
         if(!_loc3_)
         {
            _loc3_ = var_2280.getIcon(param1);
         }
         return _loc3_;
      }
      
      private function setMeMenuIconBitmaps(param1:BitmapData) : void
      {
         if(var_2595 != null)
         {
            var_2595.dispose();
         }
         if(param1 != null)
         {
            var_2595 = param1.clone();
         }
         param1.dispose();
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
      
      public function getUnseenItemCounter(param1:String) : IWindowContainer
      {
         var _loc2_:IWindowContainer = null;
         var _loc4_:String;
         if(!(_loc4_ = HabboToolbarIconEnum.getIconName(param1)))
         {
            class_14.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:IWindowContainer = _unseenItemCounters.getValue(param1) as IWindowContainer;
         if(!_loc3_)
         {
            _loc3_ = _windowManager.createUnseenItemCounter();
            _loc2_ = _window.findChildByName(_loc4_) as IWindowContainer;
            if(_loc2_)
            {
               _loc2_.addChild(_loc3_);
               _loc3_.x = _loc2_.width - _loc3_.width - 0;
               _loc3_.y = 0;
               _unseenItemCounters.add(param1,_loc3_);
            }
         }
         return _loc3_;
      }
      
      public function isNewItemsNotificationEnabled() : Boolean
      {
         return _toolbar.getBoolean("toolbar.new_additions.notification.enabled");
      }
      
      public function animateToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion
      {
         var _loc14_:IWindow = null;
         var _loc11_:int = 20;
         var _loc16_:int = !!param2 ? param2.width : _loc11_;
         var _loc19_:int = !!param2 ? param2.height : _loc11_;
         var _loc18_:IBitmapWrapperWindow = _windowManager.create("ToolBarTransition",21,0,0,new Rectangle(param3,param4,_loc16_,_loc19_)) as IBitmapWrapperWindow;
         if(param2)
         {
            _loc18_.bitmap = param2;
            _loc18_.disposesBitmap = true;
            _loc18_.filters = [new GlowFilter(16777215,1,2,2,255,1,false,false)];
         }
         _windowManager.getDesktop(2).addChild(_loc18_);
         var _loc7_:String = null;
         if((_loc7_ = getIconName(param1)) != null)
         {
            _loc14_ = _window.findChildByName(_loc7_);
         }
         if(!_loc14_)
         {
            _loc18_.dispose();
            return null;
         }
         var _loc12_:Rectangle = new Rectangle();
         _loc18_.getGlobalRectangle(_loc12_);
         var _loc10_:Rectangle = new Rectangle();
         _loc14_.getGlobalRectangle(_loc10_);
         var _loc13_:int = _loc12_.x - _loc10_.x;
         var _loc15_:int = _loc12_.y - _loc10_.y;
         var _loc5_:Number = Math.sqrt(_loc13_ * _loc13_ + _loc15_ * _loc15_);
         var _loc8_:int = 500 - Math.abs(1 / _loc5_ * 100 * 500 * 0.5);
         var _loc9_:int = 20;
         var _loc17_:String = "ToolBarBouncing[ " + _loc7_ + " ]";
         if(!class_3596.getMotionByTag(_loc17_))
         {
            class_3596.runMotion(new Queue(new Wait(_loc8_ + 8),new DropBounce(_loc14_,400,12))).tag = _loc17_;
         }
         var _loc6_:Motion = new Queue(new EaseOut(new JumpBy(_loc18_,_loc8_,_loc10_.x - _loc12_.x + _loc9_,_loc10_.y - _loc12_.y,100,1),1),new Dispose(_loc18_));
         return class_3596.runMotion(_loc6_);
      }
      
      public function set onDuty(param1:Boolean) : void
      {
         var _loc2_:IWindow = _window.findChildByName("guide_icon");
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function set unseenAchievementCount(param1:int) : void
      {
         var_4400 = param1;
      }
      
      public function set unseenMiniMailMessageCount(param1:int) : void
      {
         var_4482 = param1;
      }
      
      public function set unseenForumsCount(param1:int) : void
      {
         var_4359 = param1;
      }
      
      public function get unseenMeMenuCount() : int
      {
         return var_4482 + var_4400 + var_4359;
      }
      
      public function get memenu() : MeMenuNewController
      {
         return var_2280;
      }
      
      public function get linkPattern() : String
      {
         return "toolbar/";
      }
      
      private function onCollapseToolsBar(param1:WindowMouseEvent) : void
      {
         var_2202 = !var_2202;
         if(var_2202)
         {
            setToolbarState("HTE_STATE_COLLAPSED");
         }
         else
         {
            setToolbarState(var_3480);
         }
         checkSize();
         _toolbar.roomUI.triggerbottomBarResize();
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "memenu":
               memenu.toggleVisibility();
               break;
            case "highlight":
               if(_loc2_.length <= 2)
               {
                  return;
               }
               switch(_loc2_[2])
               {
                  case "catalog":
                     _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"));
                     break;
                  case "navigator":
                     _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
                     break;
                  case "memenu":
                     _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"));
               }
               break;
            default:
               class_14.log("Toolbar unknown link-type received: " + _loc2_[1]);
         }
      }
      
      public function getToolbarAreaWidth() : int
      {
         if(!var_3539 || !var_3539.parent)
         {
            return 0;
         }
         return var_2202 ? 185 : var_3539.x + var_3539.parent.x;
      }
   }
}
