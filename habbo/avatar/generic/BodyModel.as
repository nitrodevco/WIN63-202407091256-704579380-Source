package com.sulake.habbo.avatar.generic
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
   import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.class_3554;
   
   public class BodyModel extends CategoryBaseModel implements class_3554, IAvatarImageListener
   {
       
      
      public function BodyModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("hd");
         var_1618 = true;
         if(!var_1631)
         {
            var_1631 = new BodyView(this);
            if(var_1631)
            {
               var_1631.init();
            }
         }
      }
      
      override public function switchCategory(param1:String = "") : void
      {
         var_1631.switchCategory(param1);
      }
      
      override public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:CategoryData;
         if((_loc4_ = var_1357[param1]) == null)
         {
            return;
         }
         _loc4_.selectColorIndex(param2,param3);
         var _loc5_:AvatarEditorGridColorItem;
         if((_loc5_ = _loc4_.getSelectedColor(param3)).isDisabledForWearing)
         {
            var_319.openHabboClubAdWindow();
            return;
         }
         var_319.figureData.savePartSetColourId(param1,_loc4_.getSelectedColorIds(),true);
         updateSelectionsFromFigure("hd");
      }
      
      override protected function updateSelectionsFromFigure(param1:String) : void
      {
         var _loc2_:CategoryData = getFaceCategoryData();
         if(!_loc2_)
         {
            return;
         }
         updateIconImage(_loc2_);
      }
      
      private function getFaceCategoryData() : CategoryData
      {
         if(!var_1357)
         {
            return null;
         }
         var _loc1_:CategoryData = var_1357["hd"];
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc3_:int = var_319.figureData.getPartSetId("hd");
         var _loc2_:Array = var_319.figureData.getColourIds("hd");
         _loc1_.selectPartId(_loc3_);
         _loc1_.selectColorIds(_loc2_);
         return _loc1_;
      }
      
      private function updateIconImage(param1:CategoryData, param2:String = null) : void
      {
         var _loc5_:String = null;
         var _loc4_:class_3374 = null;
         for each(var _loc3_ in param1.parts)
         {
            if(_loc3_.partSet)
            {
               _loc5_ = var_319.figureData.getFigureStringWithFace(_loc3_.id);
               if(param2 == null || param2 == _loc5_)
               {
                  _loc4_ = var_319.manager.avatarRenderManager.createAvatarImage(_loc5_,"h",null,this);
                  _loc3_.iconImage = _loc4_.getCroppedImage("head");
                  _loc4_.dispose();
               }
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:CategoryData = getFaceCategoryData();
         if(!_loc2_)
         {
            return;
         }
         updateIconImage(_loc2_,param1);
      }
   }
}
