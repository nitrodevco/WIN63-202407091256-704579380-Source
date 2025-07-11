package com.sulake.habbo.avatar.torso
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_3554;
   
   public class TorsoModel extends CategoryBaseModel implements class_3554
   {
       
      
      public function TorsoModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("cc");
         initCategory("ch");
         initCategory("ca");
         initCategory("cp");
         var_1618 = true;
         if(!var_1631)
         {
            var_1631 = new TorsoView(this);
            if(var_1631)
            {
               var_1631.init();
            }
         }
      }
   }
}
