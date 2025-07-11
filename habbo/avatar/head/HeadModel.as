package com.sulake.habbo.avatar.head
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_3554;
   
   public class HeadModel extends CategoryBaseModel implements class_3554
   {
       
      
      public function HeadModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("hr");
         initCategory("ha");
         initCategory("he");
         initCategory("ea");
         initCategory("fa");
         var_1618 = true;
         if(!var_1631)
         {
            var_1631 = new HeadView(this);
            if(var_1631)
            {
               var_1631.init();
            }
         }
      }
   }
}
