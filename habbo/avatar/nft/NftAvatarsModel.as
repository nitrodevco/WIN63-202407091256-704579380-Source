package com.sulake.habbo.avatar.nft
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.class_3554;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   import com.sulake.habbo.communication.messages.parser.nft.NftWardrobeItem;
   import com.sulake.habbo.communication.messages.incoming.nft.class_240;
   import com.sulake.habbo.communication.messages.outgoing.nft.GetUserNftWardrobeMessageComposer;
   
   public class NftAvatarsModel extends CategoryBaseModel implements class_3554
   {
       
      
      private var _nftAvatars:Array;
      
      private var var_3206:class_240;
      
      public function NftAvatarsModel(param1:HabboAvatarEditor)
      {
         super(param1);
         _nftAvatars = [];
         requestNftAvatars(param1);
      }
      
      private function requestNftAvatars(param1:HabboAvatarEditor) : void
      {
         if(param1.manager.communication)
         {
            var_3206 = new class_240(onUserNftWardrobeMessage);
            param1.manager.communication.addHabboConnectionMessageEvent(var_3206);
            param1.manager.communication.connection.send(new GetUserNftWardrobeMessageComposer());
         }
      }
      
      private function onUserNftWardrobeMessage(param1:class_240) : void
      {
         for each(var _loc2_ in param1.getParser().nftAvatars)
         {
            _nftAvatars.push(new NftOutfit(var_319,_loc2_.tokenId,_loc2_.figureString,_loc2_.gender));
         }
      }
      
      override public function dispose() : void
      {
         if(controller && var_3206)
         {
            controller.manager.communication.removeHabboConnectionMessageEvent(var_3206);
            var_3206 = null;
         }
         _nftAvatars = null;
         super.dispose();
      }
      
      override protected function init() : void
      {
         if(!var_1631)
         {
            var_1631 = new NftAvatarsView(this);
         }
         var_1631.init();
         var_1618 = true;
      }
      
      public function selectNftAvatar(param1:int) : void
      {
         var _loc2_:NftOutfit = _nftAvatars[param1];
         if(_loc2_ != null)
         {
            if(_loc2_.figure == "")
            {
               return;
            }
            var_319.setNftOutfit(_loc2_);
            var_319.loadAvatarInEditor(_loc2_.figure,_loc2_.gender,var_319.clubMemberLevel);
         }
      }
      
      public function getNftAvatarByTokenId(param1:String) : NftOutfit
      {
         var _loc3_:* = 0;
         var _loc2_:NftOutfit = null;
         _loc3_ = 0;
         while(_loc3_ < _nftAvatars.length)
         {
            _loc2_ = _nftAvatars[_loc3_];
            if(_loc2_.tokenId == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function get nftAvatars() : Array
      {
         return _nftAvatars;
      }
      
      override public function switchCategory(param1:String = "") : void
      {
      }
      
      override public function getCategoryData(param1:String) : CategoryData
      {
         return null;
      }
      
      override public function selectPart(param1:String, param2:int) : void
      {
      }
   }
}
