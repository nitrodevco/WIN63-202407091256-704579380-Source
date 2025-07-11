package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.contextmenu.class_3386;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangePostureMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   
   public class OwnAvatarMenuView extends AvatarContextInfoButtonView
   {
      
      private static const MODE_NORMAL:int = 0;
      
      private static const MODE_CLUB_DANCES:int = 1;
      
      private static const MODE_NAME_CHANGE:int = 2;
      
      private static const MODE_EXPRESSIONS:int = 3;
      
      private static const MODE_SIGNS:int = 4;
      
      private static const MODE_CHANGE_LOOKS:int = 5;
      
      private static var var_4870:Boolean = false;
       
      
      private var var_47:class_3630;
      
      private var var_1263:int;
      
      public function OwnAvatarMenuView(param1:AvatarInfoWidget)
      {
         super(param1 as class_3386);
         var_1782 = false;
      }
      
      public static function setup(param1:OwnAvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:class_3630) : void
      {
         param1.var_47 = param6;
         if(!var_4870 && param1.widget.configuration.getInteger("new.identity",0) > 0 && Boolean(param1.widget.configuration.getBoolean("new.user.reception.enabled")))
         {
            param1.var_1263 = 0;
            OwnAvatarMenuView.var_4870 = true;
         }
         else if(param1.widget.isDancing && param1.widget.hasClub && !param1.widget.hasEffectOn)
         {
            param1.var_1263 = 1;
         }
         else if(param6.allowNameChange && param1.widget.useMinimizedOwnAvatarMenu)
         {
            param1.var_1263 = 2;
         }
         else
         {
            param1.var_1263 = 0;
         }
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         var_47 = null;
         super.dispose();
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc4_:IItemGridWindow = null;
         var _loc3_:IIterator = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:IWindowContainer = null;
         var _loc2_:IWindowContainer = null;
         var _loc7_:IRegionWindow = null;
         if(!var_1629 || !var_1629.assets || !var_1629.windowManager)
         {
            return;
         }
         if(var_1974)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_1629.assets.getAssetByName("own_avatar_menu")).content as XML;
               _window = var_1629.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            var_1640 = _window.findChildByName("buttons") as IItemListWindow;
            var_1640.procedure = buttonEventProc;
            _loc3_ = (_loc4_ = _window.findChildByName("signs_grid") as IItemGridWindow).iterator;
            _loc5_ = int(_loc3_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_ = (_loc8_ = _loc3_[_loc6_] as IWindowContainer).findChildByName("button") as IWindowContainer;
               _loc2_.procedure = gridEventProc;
               _loc6_++;
            }
            if(_loc7_ = _window.findChildByName("profile_link") as IRegionWindow)
            {
               _loc7_.procedure = buttonEventProc;
               _loc7_.toolTipCaption = widget.localizations.getLocalization("infostand.profile.link.tooltip","Click to view profile");
               _loc7_.toolTipDelay = 100;
            }
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      public function updateButtons() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(!_window || !var_47 || !var_1640)
         {
            return;
         }
         var_1640.autoArrangeItems = false;
         var _loc3_:int = var_1640.numListItems;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var_1640.getListItemAt(_loc4_).visible = false;
            _loc4_++;
         }
         var _loc5_:Boolean = widget.isCurrentUserRiding;
         switch(var_1263)
         {
            case 0:
               showButton("change_name",var_47.allowNameChange);
               showButton("decorate",decorateModeSupported() && (var_47.myRoomControllerLevel >= 1 || var_47.amIOwner));
               showButton("change_looks");
               showButton("dance_menu",widget.hasClub && !_loc5_,!widget.hasEffectOn);
               showButton("dance",!widget.hasClub && !widget.isDancing && !_loc5_,!widget.hasEffectOn);
               showButton("dance_stop",!widget.hasClub && widget.isDancing && !_loc5_);
               if(!(var_1629.windowManager as Component).getBoolean("memenu.effects.widget.disabled"))
               {
                  showButton("effects",!_loc5_);
               }
               showButton("handitem",var_47.carryItemType > 0 && var_47.carryItemType < 999999 && Boolean(widget.configuration.getBoolean("handitem.drop.enabled")) && !widget.handler.roomEngine.activeRoomHasHanditemControlBlocked);
               _loc1_ = Boolean(widget.configuration.getBoolean("avatar.expressions_menu.enabled"));
               showButton(_loc1_ ? "expressions" : "wave");
               _loc2_ = Boolean(widget.configuration.getBoolean("avatar.signs.enabled"));
               showButton("signs",_loc2_);
               showButton("wired_inspect",widget.handler.container.userDefinedRoomEvents.showInspectButton());
               break;
            case 1:
               showButton("dance_stop",true,widget.isDancing);
               showButton("dance_1");
               showButton("dance_2");
               showButton("dance_3");
               showButton("dance_4");
               showButton("back");
               break;
            case 2:
               showButton("change_name");
               showButton("more");
               break;
            case 3:
               showButton("wave",true,!widget.isSwimming);
               showButton("laugh",true,!widget.hasEffectOn && !widget.isSwimming && widget.hasVip,!widget.hasVip);
               showButton("blow",true,!widget.hasEffectOn && !widget.isSwimming && widget.hasVip,!widget.hasVip);
               showButton("idle",true);
               if(widget.configuration.getBoolean("avatar.sitting.enabled") && !widget.isSwimming && !_loc5_)
               {
                  showButton("sit",widget.ownAvatarPosture == "std");
                  showButton("stand",widget.canStandUp);
               }
               showButton("back");
               break;
            case 4:
               showButtonGrid("signs_grid");
               showButton("back");
               break;
            case 5:
               showButton("change_looks");
               showButton("more");
         }
         var_1640.autoArrangeItems = true;
         var_1640.visible = true;
      }
      
      private function gridEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc4_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc4_ = true;
               _loc7_ = "_";
               _loc3_ = !!param2.parent.name ? param2.parent.name : "";
               _loc6_ = _loc3_.substr(0,_loc3_.lastIndexOf(_loc7_));
               _loc5_ = parseInt(_loc3_.substr(_loc3_.lastIndexOf(_loc7_) + 1));
               var _loc8_:* = _loc6_;
               if("sign" === _loc8_)
               {
                  widget.sendSignRequest(_loc5_);
                  HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","sign",null,_loc5_);
               }
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc4_)
         {
            var_1629.removeView(this,false);
         }
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:RoomWidgetMessage = null;
         var _loc5_:IWindow = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               if((_loc5_ = (param2 as IWindowContainer).getChildByName("icon_vip")) != null && _loc5_.visible && !widget.hasVip)
               {
                  var_1629.catalog.openClubCenter();
                  return;
               }
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "change_name":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE");
                     break;
                  case "decorate":
                     if(decorateModeSupported())
                     {
                        widget.isUserDecorating = true;
                     }
                     break;
                  case "change_looks":
                     widget.openAvatarEditor();
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","clothes");
                     break;
                  case "expressions":
                     _loc3_ = false;
                     changeMode(3);
                     break;
                  case "sit":
                     _loc4_ = new RoomWidgetChangePostureMessage(1);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","sit");
                     break;
                  case "stand":
                     _loc4_ = new RoomWidgetChangePostureMessage(0);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","stand");
                     break;
                  case "wave":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.WAVE);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","wave");
                     break;
                  case "blow":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.BLOW);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","blow");
                     break;
                  case "jump":
                     break;
                  case "laugh":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.LAUGH);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","laugh");
                     break;
                  case "idle":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.const_423);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","idle");
                     break;
                  case "dance_menu":
                     _loc3_ = false;
                     changeMode(1);
                     break;
                  case "dance":
                     _loc4_ = new RoomWidgetDanceMessage(1);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_start");
                     break;
                  case "dance_stop":
                     _loc4_ = new RoomWidgetDanceMessage(0);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_stop");
                     break;
                  case "dance_1":
                  case "dance_2":
                  case "dance_3":
                  case "dance_4":
                     _loc4_ = new RoomWidgetDanceMessage(parseInt(param2.parent.name.charAt(param2.parent.name.length - 1)));
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_start");
                     break;
                  case "effects":
                     _loc4_ = new RoomWidgetRequestWidgetMessage("RWRWM_EFFECTS");
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","effects");
                     break;
                  case "signs":
                     _loc3_ = false;
                     changeMode(4);
                     break;
                  case "back":
                     _loc3_ = false;
                     changeMode(0);
                     break;
                  case "more":
                     _loc3_ = false;
                     widget.useMinimizedOwnAvatarMenu = false;
                     changeMode(0);
                     break;
                  case "handitem":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_DROP_CARRY_ITEM",var_418);
                     break;
                  case "wired_inspect":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_WIRED_INSPECT",var_418);
               }
            }
            if(param2.name == "profile_link")
            {
               _loc3_ = true;
               _loc4_ = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",userId,"ownAvatarContextMenu");
            }
            if(_loc4_)
            {
               var_1629.messageListener.processWidgetMessage(_loc4_);
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_ && !_disposed)
         {
            var_1629.removeView(this,false);
         }
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_1629 as AvatarInfoWidget;
      }
      
      private function changeMode(param1:int) : void
      {
         var_1263 = param1;
         updateButtons();
      }
      
      private function decorateModeSupported() : Boolean
      {
         return widget.hasClub;
      }
   }
}
