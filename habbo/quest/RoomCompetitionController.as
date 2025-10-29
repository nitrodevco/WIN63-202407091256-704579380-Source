package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1339;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_157;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_749;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_913;
   import com.sulake.habbo.communication.messages.incoming.competition.CompetitionVotingInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.competition.CompetitionEntrySubmitResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.class_1018;
   
   public class RoomCompetitionController implements IDisposable, IGetImageListener
   {
      
      private static const INDENT_LEFT:int = 270;
      
      private static const INDENT_RIGHT:int = 200;
      
      private static const INDENT_TOP:int = 4;
       
      
      private var _window:IWindowContainer;
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_891:String;
      
      private var var_4921:int;
      
      private var var_4151:int;
      
      private var _submit:Boolean;
      
      private var _dontShowAgain:Boolean;
      
      private var _hideTimer:Timer;
      
      private var var_152:int;
      
      private var var_2461:Map;
      
      public function RoomCompetitionController(param1:HabboQuestEngine)
      {
         _hideTimer = new Timer(3000,1);
         var_2461 = new Map();
         super();
         _questEngine = param1;
         _hideTimer.addEventListener("timer",onHideTimer);
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(_hideTimer)
         {
            _hideTimer.removeEventListener("timer",onHideTimer);
            _hideTimer.reset();
            _hideTimer = null;
         }
         if(var_2461)
         {
            var_2461.dispose();
            var_2461 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      private function setText(param1:IWindow, param2:String, param3:String) : void
      {
         var _loc5_:* = param2 + "." + param3;
         var _loc4_:String;
         if((_loc4_ = String(_questEngine.localization.getLocalization(_loc5_,""))) == "")
         {
            _loc5_ = param2;
            _loc4_ = String(_questEngine.localization.getLocalization(_loc5_,""));
         }
         if(_loc4_ == "")
         {
            param1.visible = false;
         }
         else
         {
            param1.visible = true;
            _questEngine.localization.registerParameter(_loc5_,"competition_name",getCompetitionName());
            _questEngine.localization.registerParameter(_loc5_,"votes","" + var_4151);
            param1.caption = "${" + _loc5_ + "}";
         }
      }
      
      public function onCompetitionVotingInfo(param1:CompetitionVotingInfoMessageEvent) : void
      {
         var_4151 = param1.getParser().votesRemaining;
         var _loc2_:Boolean = param1.getParser().isVotingAllowedForUser;
         var _loc3_:int = param1.getParser().resultCode;
         refreshContent(param1.getParser().goalId,false,param1.getParser().goalCode,_loc3_.toString());
         setInfoRegionProc(_loc3_ == 1 ? onTalents : onSeeParticipants);
         getActionButton().procedure = onVote;
         getActionButton().visible = var_4151 > 0 && _loc2_;
         getButtonInfoText().visible = _loc2_;
      }
      
      public function onCompetitionEntrySubmitResult(param1:CompetitionEntrySubmitResultMessageEvent) : void
      {
         if(param1.getParser().result == 5)
         {
            return;
         }
         refreshContent(param1.getParser().goalId,true,param1.getParser().goalCode,"" + param1.getParser().result);
         var_152 = param1.getParser().result;
         if(var_152 == 2)
         {
            setInfoRegionProc(null);
            getActionButton().procedure = onConfirm;
         }
         else if(var_152 == 6)
         {
            setInfoRegionProc(onGoToHotelView);
            getActionButton().procedure = onAccept;
         }
         else if(var_152 == 1)
         {
            setInfoRegionProc(onGoToHotelView);
            getActionButton().procedure = onSubmit;
         }
         else if(var_152 == 3)
         {
            setInfoRegionProc(onCatalogLink);
            getActionButton().visible = false;
            refreshRequiredFurnis(param1);
            getRequiredFurnisWindow().visible = true;
         }
         else if(var_152 == 0)
         {
            setInfoRegionProc(onGoToHotelView);
            getActionButton().procedure = onClose;
         }
         else if(var_152 == 4)
         {
            setInfoRegionProc(null);
            getActionButton().procedure = null;
            getActionButton().visible = false;
         }
         else if(var_152 == 5)
         {
            setInfoRegionProc(null);
            getActionButton().procedure = onOpenNavigator;
            getActionButton().visible = true;
         }
      }
      
      private function setInfoRegionProc(param1:Function) : void
      {
         getInfoRegion().procedure = param1;
         getInfoRegion().setParamFlag(1,param1 != null);
      }
      
      public function refreshContent(param1:int, param2:Boolean, param3:String, param4:String) : void
      {
         var_4921 = param1;
         var_891 = param3;
         _submit = param2;
         prepare();
         setTexts(param2 ? "submit" : "vote",param4);
         getActionButton().visible = true;
         setPromoImage();
         showAndPositionWindow();
         getRequiredFurnisWindow().visible = false;
         _window.findChildByName("dont_show_again_container").visible = false;
         _window.findChildByName("normal_container").visible = true;
      }
      
      private function setPromoImage() : void
      {
         getVoteImage().visible = !_submit;
         getSubmitImage().visible = _submit;
      }
      
      private function showAndPositionWindow() : void
      {
         _window.visible = true;
         var _loc1_:Rectangle = _window.desktop.rectangle;
         _window.x = 270;
         _window.y = 4;
         _window.width = _loc1_.width - 270 - 200;
         _window.activate();
      }
      
      private function refreshRequiredFurnis(param1:CompetitionEntrySubmitResultMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc4_:Array = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc8_:IWindowContainer = null;
         var _loc2_:class_3499 = null;
         var _loc9_:Array = param1.getParser().requiredFurnis;
         _loc3_ = 0;
         while(_loc3_ < _loc9_.length)
         {
            _loc7_ = String((_loc4_ = (_loc5_ = String(_loc9_[_loc3_])).split("*"))[0]);
            _loc6_ = String(_loc4_.length > 1 ? _loc4_[1] : "");
            _loc8_ = getRequiredFurniWindow(_loc3_ + 1);
            if(_loc5_ == null)
            {
               _loc8_.visible = false;
            }
            else
            {
               _loc8_.visible = true;
               _loc8_.findChildByName("tick_icon").visible = !param1.getParser().isMissing(_loc5_);
               _loc2_ = _questEngine.roomEngine.getGenericRoomObjectImage(_loc7_,_loc6_,new Vector3d(180,0,0),1,this);
               if(_loc2_.id != 0)
               {
                  var_2461.add(_loc2_.id,_loc3_);
               }
               setRequiredFurniImage(_loc3_,_loc2_.data);
            }
            _loc3_++;
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(var_2461.getValue(param1) != null)
         {
            setRequiredFurniImage(var_2461.getValue(param1),param2);
            var_2461.remove(param1);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setRequiredFurniImage(param1:int, param2:BitmapData) : void
      {
         var _loc4_:IWindowContainer = getRequiredFurniWindow(param1 + 1);
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc4_.findChildByName("furni_icon"));
         var _loc3_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         if(param2 != null)
         {
            _loc3_.copyPixels(param2,param2.rect,new Point((_loc3_.width - param2.width) / 2,(_loc3_.height - param2.height) / 2));
            _loc5_.bitmap = _loc3_;
         }
      }
      
      private function getCompetitionName() : String
      {
         var _loc1_:String = "roomcompetition." + var_891 + ".name";
         return _questEngine.localization.getLocalization(_loc1_,_loc1_);
      }
      
      private function setTexts(param1:String, param2:String) : void
      {
         setText(getCaption(),"roomcompetition.caption." + param1,param2);
         setText(getInfoText(),"roomcompetition.info." + param1,param2);
         setText(getActionButton(),"roomcompetition.button." + param1,param2);
         setText(getButtonInfoText(),"roomcompetition.buttoninfo." + param1,param2);
         onResize();
      }
      
      private function onResize() : void
      {
         getInfoRegion().y = getCaption().y + getCaption().textHeight + 5;
      }
      
      public function onRoomExit() : void
      {
         close();
      }
      
      public function onRoomEnter(param1:RoomEntryInfoMessageEvent) : void
      {
         close();
         var _loc3_:class_1339 = param1.getParser();
         var _loc2_:Boolean = _questEngine.getInteger("new.identity",0) == 0 || !_questEngine.getBoolean("new.identity.hide.ui");
         if(!_dontShowAgain && _loc2_)
         {
            _submit = _loc3_.owner;
            _questEngine.send(new class_913());
         }
      }
      
      public function sendRoomCompetitionInit() : void
      {
         _questEngine.send(new class_913());
      }
      
      public function onContextChanged() : void
      {
         if(_window != null && Boolean(_window.visible) && _submit)
         {
            _questEngine.send(new class_749(var_891,0));
         }
      }
      
      private function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
         var_891 = "";
      }
      
      private function prepare() : void
      {
         var _loc1_:int = 0;
         if(_window == null)
         {
            _loc1_ = 1;
            _window = IWindowContainer(_questEngine.getXmlWindow("RoomCompetition",_loc1_));
            _window.findChildByName("close_region").procedure = onClose;
            _questEngine.windowManager.getWindowContext(_loc1_).getDesktopWindow().addEventListener("WE_RESIZED",onDesktopResized);
            _window.findChildByName("dont_show_again_region").procedure = onDontShowAgain;
         }
      }
      
      private function onCatalogLink(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.catalog.openCatalogPage(_questEngine.getProperty("competition." + var_891 + ".catalogPage"));
         }
      }
      
      private function onOpenNavigator(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.navigator.open();
         }
      }
      
      private function onGoToHotelView(param1:WindowEvent, param2:IWindow = null) : void
      {
         var _loc3_:HabboToolbarEvent = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
            _loc3_.iconId = "HTIE_ICON_RECEPTION";
            _questEngine.toolbar.events.dispatchEvent(_loc3_);
         }
      }
      
      private function onSeeParticipants(param1:WindowEvent, param2:IWindow = null) : void
      {
      }
      
      private function onTalents(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.tracking.trackTalentTrackOpen(_questEngine.sessionDataManager.currentTalentTrack,"roomcompetition");
            _questEngine.send(new class_1018(_questEngine.sessionDataManager.currentTalentTrack));
         }
      }
      
      private function onAccept(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.send(new class_749(var_891,1));
         }
      }
      
      private function onSubmit(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.send(new class_749(var_891,2));
         }
      }
      
      private function onConfirm(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.send(new class_749(var_891,3));
         }
      }
      
      private function onVote(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.send(new class_157(var_891));
         }
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow = null) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WME_CLICK")
         {
            if(_submit && var_152 == 0)
            {
               close();
               return;
            }
            _loc3_ = "roomcompetition.dontshowagain.info." + (_submit ? "submit" : "vote");
            _window.findChildByName("dont_show_info_txt").caption = _questEngine.localization.getLocalization(_loc3_,_loc3_);
            _window.findChildByName("dont_show_again_container").visible = true;
            _window.findChildByName("normal_container").visible = false;
            _hideTimer.reset();
            _hideTimer.start();
         }
      }
      
      private function onDontShowAgain(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _dontShowAgain = true;
            close();
         }
      }
      
      private function getInfoRegion() : IWindow
      {
         return _window.findChildByName("info_region");
      }
      
      private function getInfoText() : IWindow
      {
         return _window.findChildByName("info_txt");
      }
      
      private function getButtonInfoText() : IWindow
      {
         return _window.findChildByName("button_info_txt");
      }
      
      private function getActionButton() : IWindow
      {
         return _window.findChildByName("action_button");
      }
      
      private function getCaption() : ITextWindow
      {
         return ITextWindow(_window.findChildByName("caption_txt"));
      }
      
      private function getRequiredFurnisWindow() : IWindow
      {
         return _window.findChildByName("required_furnis_itemgrid");
      }
      
      private function getVoteImage() : IWindow
      {
         return _window.findChildByName("vote_image");
      }
      
      private function getSubmitImage() : IWindow
      {
         return _window.findChildByName("submit_image");
      }
      
      private function getRequiredFurniWindow(param1:int) : IWindowContainer
      {
         var _loc3_:int = 0;
         var _loc4_:IItemGridWindow = IItemGridWindow(_window.findChildByName("required_furnis_itemgrid"));
         var _loc2_:IWindowContainer = IWindowContainer(_loc4_.getGridItemAt(0));
         if(_loc4_.numGridItems < param1)
         {
            _loc3_ = 0;
            while(_loc3_ < param1 - _loc4_.numGridItems)
            {
               _loc4_.addGridItem(_loc2_.clone());
               _loc3_++;
            }
         }
         return IWindowContainer(_loc4_.getGridItemAt(param1 - 1));
      }
      
      private function onDesktopResized(param1:WindowEvent) : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            onResize();
         }
      }
      
      public function set dontShowAgain(param1:Boolean) : void
      {
         _dontShowAgain = param1;
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         close();
      }
   }
}
