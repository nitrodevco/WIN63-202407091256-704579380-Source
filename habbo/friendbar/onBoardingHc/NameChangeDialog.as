package com.sulake.habbo.friendbar.onBoardingHc
{
    import assets.class_3859

    import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.Dimmer;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.NineSplitSprite;
   import onBoardingHcUi.WaitIndicator;
   import com.sulake.habbo.communication.messages.parser.avatar.class_1162;
   import com.sulake.habbo.communication.messages.parser.avatar.class_1164;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.avatar.class_242;
   import com.sulake.habbo.communication.messages.outgoing.avatar.class_390;
   
   public class NameChangeDialog implements IDisposable
   {
      
      private static const IDLE_TIME_MS:int = 500;
       
      
      private var input_error_alert_hitch_png:Class;
      
      protected var _style:int = 1;
      
      private var _disposed:Boolean;
      
      protected var _context:IBoardingContext;
      
      private var var_4571:Boolean;
      
      protected var var_1710:Sprite;
      
      private var var_3301:Dimmer;
      
      protected var var_1639:TextField;
      
      protected var _submitButton:Button;
      
      protected var _skipButton:Button;
      
      private var var_87:Sprite;
      
      protected var var_1863:Bitmap;
      
      protected var var_2375:Bitmap;
      
      private var _inputClickedAlready:Boolean;
      
      protected var var_1795:Bitmap;
      
      private var var_2200:Timer;
      
      protected var var_1806:WaitIndicator;
      
      protected var _container:Sprite;
      
      private var var_4920:String;
      
      protected var _inputDefaultString:String;
      
      protected var var_1805:Sprite;
      
      protected var _dialogWidth:int;
      
      private var var_4841:IMessageEvent;
      
      private var var_4521:IMessageEvent;
      
      public function NameChangeDialog(param1:IBoardingContext, param2:Sprite, param3:int)
      {
         input_error_alert_hitch_png = class_3859;
         super();
         _context = param1;
         _container = param2;
         _dialogWidth = param3;
         init();
         var_4841 = param1.communicationManager.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(onChangeUserNameResult));
         var_4521 = param1.communicationManager.addHabboConnectionMessageEvent(new CheckUserNameResultMessageEvent(onCheckUserNameResult));
         var_2200 = new Timer(500,1);
         var_2200.addEventListener("timer",onIdleTimer);
      }
      
      private function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1162 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         claimNameResponse(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
      }
      
      private function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1164 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         checkNameResponse(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
      }
      
      protected function init() : void
      {
         var _loc5_:Bitmap = null;
         var_1710 = LoaderUI.createFrame(_context.getLocalization("rename.title","Pick a name for your character"),"",new Rectangle(-_dialogWidth / 2,0,_dialogWidth,1),_style);
         var _loc4_:int = 23;
         var _loc3_:int = _dialogWidth - _loc4_ * 2;
         var _loc1_:int = _dialogWidth - 12;
         var_1710.x = 5;
         var _loc10_:Boolean = false;
         var _loc6_:TextField;
         (_loc6_ = LoaderUI.createTextField(_context.getLocalization("rename.subtitle","You are a unique and beautiful snowflake."),20,0,true,false,false,_loc10_)).x = _loc4_;
         LoaderUI.addEtching(_loc6_);
         var _loc8_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.description","In Habbo, we all sign in using a unique name, so go ahead and enter yours. There\'s no need to use your real one - stage names are perfectly ok."),12,0,false,true,false,_loc10_);
         var_1710.addChild(_loc8_);
         _loc8_.x = _loc4_;
         _loc8_.width = _loc3_;
         LoaderUI.addEtching(_loc8_);
         var _loc2_:Sprite = new Sprite();
         var_1795 = NineSplitSprite.INPUT_FIELD.render(_loc3_,50);
         _loc2_.addChild(var_1795);
         var_1710.addChild(_loc2_);
         _loc2_.x = _loc4_;
         var _loc7_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.accepted","WE ACCEPT LETTERS AND NUMBERS. NOT VISA OR MASTERCARD."),9,4342338,true,false,false,_loc10_);
         var_1710.addChild(_loc7_);
         _loc7_.x = _loc4_ + 5;
         LoaderUI.addEtching(_loc7_);
         var _loc11_:TextField;
         (_loc11_ = LoaderUI.createTextField(_context.getLocalization("rename.warning","Once you\'ve selected a name for your character, you can\'t change it anymore, so please pay a bit of attention to your selection."),16,4342338,false,true,false,false)).width = _loc3_ - 66;
         LoaderUI.addEtching(_loc11_);
         _loc5_ = NineSplitSprite.BORDER_SUNK.render(_loc3_,_loc11_.height + 24);
         var_1805 = new Sprite();
         if(_loc5_)
         {
            var_1805.addChild(_loc5_);
         }
         var_1805.addChild(_loc11_);
         _loc11_.x = 50;
         _loc11_.y = 12;
         var_1710.addChild(var_1805);
         var_1805.x = _loc4_;
         _inputDefaultString = _context.getLocalization("name","Click here to type a name");
         var_1639 = LoaderUI.createTextField(_inputDefaultString,14,8947848,true,false,true,false);
         var_1710.addChild(var_1639);
         var_1639.x = _loc2_.x + 16;
         var_1639.y = _loc2_.y + int((_loc2_.height - var_1639.height) / 2);
         var_1639.width = _loc2_.width - 30;
         var_1639.addEventListener("click",onInputClicked);
         var_1639.addEventListener("change",onInputChange);
         var_1806 = new WaitIndicator(_style);
         var_1710.addChild(var_1806);
         var_1806.y = _loc2_.y + int(_loc2_.height / 2);
         var_1806.x = _loc2_.x + _loc2_.width - int(var_1863.width / 2) - 15;
         var_1806.visible = false;
         _loc2_.addEventListener("click",onInputBackgroundClicked);
         var _loc9_:int = -50;
         LoaderUI.resizeFrame(var_1710,_dialogWidth,_loc9_);
         var_1710.y = -(int(_loc9_ / 2));
         var_3301 = new Dimmer();
         _container.addChild(var_1710);
      }
      
      private function onIdleTimer(param1:TimerEvent) : void
      {
         checkName(var_1639.text);
      }
      
      public function setNameClaimed(param1:Boolean) : void
      {
         var_4571 = param1;
      }
      
      protected function onInputChange(param1:Event) : void
      {
         if(var_2200 != null)
         {
            var_2200.reset();
            var_2200.start();
         }
         removeIndicators();
      }
      
      protected function onInputBackgroundClicked(param1:MouseEvent) : void
      {
         _context.stage.focus = var_1639;
         onInputClicked(null);
      }
      
      protected function onInputClicked(param1:Event) : void
      {
         if(_inputClickedAlready)
         {
            return;
         }
         _inputClickedAlready = true;
         var_1639.text = "";
         var_1639.textColor = _style == 2 ? 6710886 : 0;
         var_1639.removeEventListener("click",onInputClicked);
         onInputChange(null);
      }
      
      public function submitName() : void
      {
         claimName(var_1639.text);
      }
      
      private function get nameChanged() : Boolean
      {
         return var_1639 != null && var_1639.text != _context.getLocalization("name",_inputDefaultString);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _context.communicationManager.removeHabboConnectionMessageEvent(var_4841);
         _context.communicationManager.removeHabboConnectionMessageEvent(var_4521);
         if(var_3301)
         {
            _container.removeChild(var_3301);
         }
         if(var_1710)
         {
            _container.removeChild(var_1710);
         }
         if(var_1806 != null)
         {
            var_1806.dispose();
            var_1806 = null;
         }
         var_3301 = null;
         var_1639 = null;
         _submitButton = null;
         _skipButton = null;
         var_87 = null;
         var_1863 = null;
         var_1795 = null;
         var_1710 = null;
         _context = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function claimNameResponse(param1:int, param2:Object, param3:Array) : void
      {
         nameIsCorrect = false;
         switch(param1)
         {
            case ChangeUserNameResultMessageEvent.var_1586:
               nameIsCorrect = true;
               _context.nameChangeCompleted();
               _context.editorFinished();
               break;
            case ChangeUserNameResultMessageEvent.var_1596:
               showErrorMessage(_context.getLocalization("rename.error.too_long","OOPS! YOUR NAME\'S TOO LONG TO REMEMBER"));
               break;
            case ChangeUserNameResultMessageEvent.var_1592:
               showErrorMessage(_context.getLocalization("rename.error.too_short","OOPS! YOUR NAME\'S TOO SHORT TO PRONOUNCE."));
               break;
            case ChangeUserNameResultMessageEvent.var_1604:
               showErrorMessage(_context.getLocalization("rename.error.words","OOPS! THINK HARDER - THAT\'S NOT A VERY NICE NAME."));
               break;
            case ChangeUserNameResultMessageEvent.var_1590:
            case ChangeUserNameResultMessageEvent.var_1617:
               showErrorMessage(_context.getLocalization("rename.error.taken","OOPS! SOMEONE\'S ALREADY USING THAT NAME."));
         }
      }
      
      public function claimNameFailed(param1:String) : void
      {
      }
      
      private function claimName(param1:String) : void
      {
         if(var_4571)
         {
            _context.nameChangeCompleted();
         }
         _context.communicationManager.connection.send(new class_390(param1));
         _context.nameChangeCompleted();
      }
      
      public function checkNameResponse(param1:int, param2:String, param3:Array) : void
      {
         if(var_1639 == null || var_1639.text != param2)
         {
            return;
         }
         if(var_1806 != null)
         {
            var_1806.visible = false;
         }
         nameIsCorrect = false;
         switch(param1)
         {
            case ChangeUserNameResultMessageEvent.var_1586:
               nameIsCorrect = true;
               break;
            case ChangeUserNameResultMessageEvent.var_1596:
               showErrorMessage(_context.getLocalization("rename.error.too_long","OOPS! YOUR NAME\'S TOO LONG TO REMEMBER"));
               break;
            case ChangeUserNameResultMessageEvent.var_1592:
               showErrorMessage(_context.getLocalization("rename.error.too_short","OOPS! YOUR NAME\'S TOO SHORT TO PRONOUNCE."));
               break;
            case ChangeUserNameResultMessageEvent.var_1604:
               showErrorMessage(_context.getLocalization("rename.error.words","OOPS! THINK HARDER - THAT\'S NOT A VERY NICE NAME."));
               break;
            case ChangeUserNameResultMessageEvent.var_1590:
            case ChangeUserNameResultMessageEvent.var_1617:
               showErrorMessage(_context.getLocalization("rename.error.taken","OOPS! SOMEONE\'S ALREADY USING THAT NAME."));
         }
         if(var_1805 != null)
         {
            var_1805.visible = !nameIsCorrect;
            _context.showHideButtons(nameIsCorrect);
         }
      }
      
      public function checkNameFailed(param1:String) : void
      {
      }
      
      private function checkName(param1:String) : void
      {
         if(!param1 || param1.length == 0)
         {
            return;
         }
         _context.communicationManager.connection.send(new class_242(param1));
         if(var_1806 != null)
         {
            var_1806.visible = true;
         }
      }
      
      protected function get nameIsCorrect() : Boolean
      {
         return var_1863 != null && var_1863.visible;
      }
      
      protected function set nameIsCorrect(param1:Boolean) : void
      {
         param1 = true;
         if(var_1863 != null)
         {
            var_1863.visible = param1;
         }
         if(var_2375 != null)
         {
            var_2375.visible = !param1;
         }
         if(_submitButton != null)
         {
            _submitButton.active = true;
            if(_style == 2)
            {
               _submitButton.visible = true;
               _submitButton.active = nameChanged ? param1 : true;
            }
            else
            {
               _submitButton.visible = param1 && nameChanged;
            }
         }
         if(_skipButton != null)
         {
            if(_style == 2)
            {
               _skipButton.visible = nameChanged;
            }
         }
      }
      
      private function showErrorMessage(param1:String) : void
      {
         var _loc5_:TextField = null;
         var _loc4_:Bitmap = null;
         var _loc2_:Shape = null;
         var _loc3_:int = var_1795.width;
         var _loc6_:int = var_1795.height;
         var_1795.bitmapData = _style == 2 ? NineSplitSprite.INPUT_ERROR_HITCH.render(_loc3_,_loc6_).bitmapData : NineSplitSprite.INPUT_ERROR.render(_loc3_,_loc6_).bitmapData;
         removeIndicators();
         if(var_2375 != null)
         {
            var_2375.visible = true;
         }
         if(_style == 1)
         {
            _loc5_ = LoaderUI.createTextField(param1,9,16777215,true);
            _loc4_ = LoaderUI.createBalloon(_loc5_.width + 30,_loc5_.height + 17,-1,true,11411485);
            var_87 = new Sprite();
            var_87.addChild(_loc4_);
            var_87.addChild(_loc5_);
            _loc5_.x = 15;
            _loc5_.y = 14;
         }
         else
         {
            _loc5_ = LoaderUI.createTextField(param1,10,16777215);
            _loc2_ = LoaderUI.createScale9GridShapeFromImage(Bitmap(new input_error_alert_hitch_png()).bitmapData,new Rectangle(3,3,5,5));
            _loc3_ = var_1795.width;
            if(_loc5_.width > _loc3_)
            {
               _loc3_ = _loc5_.width + 20;
            }
            _loc2_.width = _loc3_;
            _loc2_.height = var_1795.height - 11;
            var_87 = new Sprite();
            var_87.addChild(_loc2_);
            var_87.addChild(_loc5_);
            _loc5_.x = 16;
            _loc5_.y = int((_loc2_.height - _loc5_.height) / 2);
         }
         var_1710.addChild(var_87);
         if(_style == 1)
         {
            var_87.x = int((var_1710.width - var_87.width) / 2);
            var_87.y = var_1795.parent.y + var_1795.height;
            var_87.filters = [new GlowFilter(0,0.24,6,6)];
         }
         else
         {
            var_87.x = var_1795.parent.x;
            var_87.y = var_1795.parent.y + var_1795.height + 4;
         }
      }
      
      private function removeIndicators() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(var_87 != null && var_1710.contains(var_87))
         {
            _loc1_ = var_1795.width;
            _loc2_ = var_1795.height;
            var_1795.bitmapData = _style == 2 ? NineSplitSprite.INPUT_CORRECTED_HITCH.render(_loc1_,_loc2_).bitmapData : NineSplitSprite.INPUT_CORRECTED.render(_loc1_,_loc2_).bitmapData;
            var_1710.removeChild(var_87);
         }
         var_1863.visible = false;
         if(var_2375 != null)
         {
            var_2375.visible = false;
         }
      }
      
      public function set preSelectedGender(param1:String) : void
      {
         var_4920 = param1;
      }
   }
}
