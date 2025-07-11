package com.sulake.habbo.avatar.legs
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_3554;
   
   public class LegsModel extends CategoryBaseModel implements class_3554
   {
       
      
      public function LegsModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("lg");
         initCategory("sh");
         initCategory("wa");
         var_1618 = true;
         if(!var_1631)
         {
            var_1631 = new LegsView(this);
            if(var_1631)
            {
               var_1631.init();
            }
         }
      }
   }
}
