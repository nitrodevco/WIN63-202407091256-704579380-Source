package com.sulake.habbo.friendbar.onBoardingHc
{
    import assets.class_3767
    import assets.class_3768
    import assets.class_3769
    import assets.class_3770
    import assets.class_3830

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.AvatarEditor;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.Background;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.RoomPicker;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import onBoardingHcUi.LoaderUI;
   
   public class OnBoardingHcFlow extends Sprite implements IBoardingContext, IDisposable
   {
      
      public static const const_616:String = "NewUserFlowFinished";
      
      private static const LOGO_AREA_HEIGHT:int = 95;
      
      private static const MAIN_AREA_MARGIN:int = 0;
      
      public static const AVATAR_NAME_CHANGE:int = 0;
      
      public static const const_945:int = 1;
      
      public static var ubuntu_regular:Class = class_3770;
      
      public static var ubuntu_bold:Class = class_3768;
      
      public static var ubuntu_italic:Class = class_3769;
      
      public static var ubuntu_bold_italic:Class = class_3767;
      
      private static const habbo_logo_png:Class = class_3830;
       
      
      private var _background:Background;
      
      private var _avatarEditor:AvatarEditor;
      
      private var var_1933:Sprite;
      
      private var var_1710:NameChangeDialog;
      
      private var var_1967:Sprite;
      
      private var var_3960:RoomPicker;
      
      private var var_318:Boolean;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var var_87:Sprite;
      
      private var var_4877:Boolean;
      
      private var var_4571:Boolean;
      
      private var _mainSprite:Sprite;
      
      private var var_727:Sprite;
      
      private var _selectedName:String;
      
      private var _isFemale:Boolean;
      
      private var var_2004:TextField;
      
      private var var_4930:TextField;
      
      private var _showHcItems:Boolean;
      
      private var var_3333:int = 535;
      
      private var _nameAreaWidth:int = 400;
      
      private var var_361:Array;
      
      public function OnBoardingHcFlow(param1:IAvatarRenderManager, param2:IHabboLocalizationManager, param3:IHabboCommunicationManager)
      {
         var_361 = [];
         super();
         _avatarRenderManager = param1;
         _localizationManager = param2;
         _communicationManager = param3;
      }
      
      public function dispose() : void
      {
         if(var_318)
         {
            return;
         }
         if(_background)
         {
            removeChild(_background);
            _background.dispose();
            _background = null;
         }
         if(_avatarEditor)
         {
            _avatarEditor.dispose();
            _avatarEditor = null;
         }
         if(var_1710)
         {
            var_1710.dispose();
            var_1710 = null;
         }
         if(var_1933)
         {
            var_1933 = null;
         }
         if(var_1967 != null)
         {
            var_1967 = null;
         }
         if(_mainSprite != null)
         {
            removeChild(_mainSprite);
            _mainSprite = null;
         }
         _avatarRenderManager = null;
         _localizationManager = null;
         _communicationManager = null;
         stage.removeChild(this);
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function init(param1:Array) : void
      {
         var_361 = param1;
         stage.addEventListener("resize",onStageResize);
         _background = new Background();
         addChild(_background);
         var_727 = new Sprite();
         addChild(var_727);
         var _loc2_:Bitmap = new habbo_logo_png();
         _loc2_.x = 40;
         _loc2_.y = 40;
         var_727.addChild(_loc2_);
         _mainSprite = new Sprite();
         addChild(_mainSprite);
         _mainSprite.y = 95;
         _mainSprite.x = 0;
         _avatarEditor = new AvatarEditor(this);
         _avatarEditor.showHcItems(_showHcItems);
         _mainSprite.addChild(_avatarEditor);
         var_1933 = new Sprite();
         var_1933.x = var_3333;
         var_1933.y = 95;
         var_1933.visible = true;
         _mainSprite.addChild(var_1933);
         var_1967 = new Sprite();
         var_1967.x = 0;
         var_1967.y = 95;
         var_1967.visible = false;
         _mainSprite.addChild(var_1967);
         if(isRoomPickingNeeded)
         {
            var_3960 = new RoomPicker(this,var_1967);
            var_3960.fetchThumbnails();
         }
         if(!var_361)
         {
            dispatchEvent(new Event("NewUserFlowFinished"));
            return;
         }
         if(var_361.indexOf(0) >= 0)
         {
         }
         if(var_361.indexOf(1) >= 0)
         {
         }
         if(var_361.indexOf(0) >= 0)
         {
            startNameChange();
         }
         else
         {
            startRoomPicking();
         }
      }
      
      public function setHcVisibility(param1:Boolean) : void
      {
         _showHcItems = param1;
      }
      
      private function onStageResize(param1:Event) : void
      {
         if(disposed)
         {
            return;
         }
         layoutMainElements();
      }
      
      private function layoutMainElements() : void
      {
         var _loc2_:int = 0;
         if(_background != null)
         {
            _background.resize();
         }
         if(var_1967)
         {
            var_1967.x = 0;
         }
         if(!var_2004)
         {
            var_2004 = LoaderUI.createTextField("intro",40,16777215,false,true,false,false,"left");
            var_2004.x = 185;
            var_2004.y = 45;
            var_2004.width = 500;
            var_2004.multiline = false;
            var_2004.thickness = 50;
            var_727.addChild(var_2004);
         }
         var _loc1_:int = _mainSprite.width + 20;
         if(stage.stageWidth > _loc1_)
         {
            _loc2_ = (stage.stageWidth - _loc1_) / 2;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _mainSprite.x = _loc2_;
         }
         else
         {
            _mainSprite.x = 0;
         }
         if(_avatarEditor)
         {
            _avatarEditor.x = 0;
            var_3333 = _avatarEditor.x + _avatarEditor.width - 125;
         }
         if(var_1933)
         {
            var_1933.x = var_3333;
         }
         _mainSprite.y = 95;
      }
      
      public function getLocalization(param1:String, param2:String = null) : String
      {
         if(!_localizationManager)
         {
            return param2;
         }
         return _localizationManager.getLocalization(param1,param2);
      }
      
      public function getProperty(param1:String, param2:String = null) : String
      {
         if(!_localizationManager)
         {
            return param2;
         }
         var _loc3_:String = String(_localizationManager.getProperty(param1));
         return !!_loc3_ ? _loc3_ : param2;
      }
      
      public function showErrorMessage(param1:String) : void
      {
         var _loc3_:TextField = LoaderUI.createTextField(param1,9,16777215,true);
         LoaderUI.addEtching(_loc3_,true);
         var _loc2_:Bitmap = LoaderUI.createBalloon(_loc3_.width + 30,_loc3_.height + 17,-1,true,11411485);
         if(var_87)
         {
            removeChild(var_87);
         }
         var_87 = new Sprite();
         var_87.addChild(_loc2_);
         var_87.addChild(_loc3_);
         _loc3_.x = 15;
         _loc3_.y = 14;
         _mainSprite.addChild(var_87);
         var_87.x = 766;
         var_87.y = 577;
         var_87.filters = [new GlowFilter(0,0.24,6,6)];
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get selectedName() : String
      {
         return _selectedName;
      }
      
      public function get isFemale() : Boolean
      {
         return _isFemale;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function editorFinished() : void
      {
         if(isRoomPickingNeeded)
         {
            startRoomPicking();
         }
         else
         {
            dispatchEvent(new Event("NewUserFlowFinished"));
         }
      }
      
      public function setHcMembership(param1:Boolean) : void
      {
         var_4877 = param1;
      }
      
      public function submitName() : void
      {
         if(var_1710 != null && var_1933.visible)
         {
            var_1710.submitName();
         }
         else
         {
            nameChangeCompleted();
            editorFinished();
         }
      }
      
      private function startNameChange() : void
      {
         if(!var_1710)
         {
            var_1710 = new HitchNameChangeDialog(this,var_1933,getNameAreaWidth());
         }
         if(var_1967)
         {
            var_1967.visible = false;
         }
         var_1933.visible = true;
         var_1933.x = var_3333;
         var_1710.preSelectedGender = _avatarEditor.gender;
         layoutMainElements();
         showChooseStyleHeader();
      }
      
      public function setNameGender(param1:String, param2:Boolean) : void
      {
         _selectedName = param1;
         _isFemale = param2;
      }
      
      public function setIsFemale(param1:Boolean) : void
      {
         _isFemale = param1;
      }
      
      public function nameChangeCompleted(param1:Boolean = true) : void
      {
         var_4571 = param1;
         _avatarEditor.nameChangeCompleted(param1);
      }
      
      public function showHideButtons(param1:Boolean) : void
      {
         _avatarEditor.showHideButtons(param1);
      }
      
      private function get isRoomPickingNeeded() : Boolean
      {
         return var_361.indexOf(1) >= 0;
      }
      
      private function startRoomPicking() : void
      {
         if(var_3960 == null)
         {
            return;
         }
         _avatarEditor.visible = false;
         _avatarEditor.showHideGrid(false);
         var_1933.visible = false;
         var_1967.visible = true;
         var_3960.init();
         layoutMainElements();
         showPickRoomHeader();
      }
      
      public function showPickRoomHeader() : void
      {
         if(var_2004)
         {
            var_2004.width = 650;
            var_2004.htmlText = getLocalization("onboarding.choose.your.room","Choose your room");
         }
      }
      
      public function showChooseStyleHeader() : void
      {
         if(var_2004)
         {
            var_2004.width = 650;
            var_2004.htmlText = getLocalization("onboarding.choose.your.style","My looks");
         }
      }
      
      public function roomPickingCompleted() : void
      {
         dispatchEvent(new Event("NewUserFlowFinished"));
      }
      
      public function get debugText() : TextField
      {
         return null;
      }
      
      public function getNameAreaX() : int
      {
         return var_3333;
      }
      
      public function getNameAreaWidth() : int
      {
         return _nameAreaWidth;
      }
   }
}
