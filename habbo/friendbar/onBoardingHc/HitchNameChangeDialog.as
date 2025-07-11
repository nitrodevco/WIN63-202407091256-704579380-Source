package com.sulake.habbo.friendbar.onBoardingHc
{
    import assets.class_3857
    import assets.class_3858

    import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.NineSplitSprite;
   import onBoardingHcUi.WaitIndicator;
   
   public class HitchNameChangeDialog extends NameChangeDialog
   {
       
      
      private var icon_name_ok_png:Class;
      
      private var icon_name_alert_png:Class;
      
      public function HitchNameChangeDialog(param1:IBoardingContext, param2:Sprite, param3:int)
      {
         icon_name_ok_png = class_3858;
         icon_name_alert_png = class_3857;
         super(param1,param2,param3);
      }
      
      override protected function init() : void
      {
         _style = 2;
         var_1710 = LoaderUI.createFrame("","",new Rectangle(-_dialogWidth / 2,0,_dialogWidth,1),_style);
         _container.addChild(var_1710);
         var _loc5_:int = 0;
         var _loc4_:int = 330;
         var _loc1_:int = _dialogWidth - 12;
         var _loc8_:Boolean = false;
         var _loc2_:Sprite = new Sprite();
         var_1795 = NineSplitSprite.INPUT_FIELD_HITCH.render(_loc4_,31);
         _loc2_.addChild(var_1795);
         var_1710.addChild(_loc2_);
         _loc2_.x = _loc5_;
         var _loc7_:Bitmap = null;
         var _loc3_:TextField = LoaderUI.createTextField(_context.getLocalization("onboarding.characters.tip","TIP: There are tons of Habbos created every day"),18,8309486,false,true,false,false);
         _loc3_.width = _loc4_ - 32;
         var _loc6_:TextField;
         (_loc6_ = LoaderUI.createTextField(_context.getLocalization("onboarding.creative.tip","be creative! You can also use these special characters"),18,8309486,false,true,false,false)).width = _loc4_ - 32;
         var_1805 = new Sprite();
         var _loc9_:Bitmap;
         (_loc9_ = LoaderUI.createBalloon(295,230,45,false,995918,"down")).y = 90;
         var_1805.addChild(_loc9_);
         var_1805.addChild(_loc3_);
         var_1805.addChild(_loc6_);
         _loc3_.x = 16;
         _loc3_.y = _loc9_.y + (_loc9_.height - (_loc3_.height + _loc6_.height)) / 2;
         _loc3_.width = 250;
         var_1805.visible = false;
         _loc6_.x = 16;
         _loc6_.y = _loc3_.y + _loc3_.height + 20;
         _loc6_.width = 250;
         if(_loc7_ != null)
         {
            var_1805.addChild(_loc7_);
            _loc7_.x = 16;
            _loc7_.y = int((var_1805.height - _loc7_.height) / 2);
         }
         var_1710.addChild(var_1805);
         var_1805.x = _loc5_;
         _inputDefaultString = _context.getLocalization("name","Enter name here");
         var_1639 = LoaderUI.createTextField(_inputDefaultString,18,6710886,true,false,true,false);
         var_1710.addChild(var_1639);
         var_1639.x = _loc2_.x + 16;
         var_1639.y = _loc2_.y + int((_loc2_.height - var_1639.height) / 2);
         var_1639.width = _loc2_.width - 30;
         var_1639.addEventListener("click",onInputClicked);
         var_1639.addEventListener("change",onInputChange);
         var_1863 = new icon_name_ok_png();
         var_1710.addChild(var_1863);
         var_1863.y = _loc2_.y + int((_loc2_.height - var_1863.height) / 2);
         var_1863.x = _loc2_.x + _loc2_.width - var_1863.width - 7;
         var_2375 = new icon_name_alert_png();
         var_1710.addChild(var_2375);
         var_2375.x = var_1863.x;
         var_2375.y = var_1863.y;
         nameIsCorrect = false;
         var_1806 = new WaitIndicator(_style);
         var_1710.addChild(var_1806);
         var_1806.y = _loc2_.y + int(_loc2_.height / 2) + 2;
         var_1806.x = _loc2_.x + _loc2_.width - int(var_1863.width / 2) - 7;
         var_1806.visible = false;
         _loc2_.addEventListener("click",onInputBackgroundClicked);
         var_1710.y = -50;
      }
   }
}
