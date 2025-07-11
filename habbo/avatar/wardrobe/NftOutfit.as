package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   
   public class NftOutfit extends Outfit
   {
       
      
      private var var_846:String;
      
      public function NftOutfit(param1:HabboAvatarEditor, param2:String, param3:String, param4:String)
      {
         super(param1,param3,param4);
         this.var_846 = param2;
      }
      
      public function get tokenId() : String
      {
         return var_846;
      }
   }
}
