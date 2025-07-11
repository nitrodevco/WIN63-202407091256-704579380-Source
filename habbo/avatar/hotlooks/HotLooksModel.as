package com.sulake.habbo.avatar.hotlooks
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.class_3554;
   import com.sulake.habbo.avatar.wardrobe.*;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.outgoing.hotlooks.class_632;
   import com.sulake.habbo.communication.messages.incoming.hotlooks.class_1104;
   import com.sulake.habbo.communication.messages.incoming.hotlooks.class_1636;
   
   public class HotLooksModel extends CategoryBaseModel implements class_3554
   {
      
      public static const CATEGORY_HOT_LOOKS:String = "hot_looks";
      
      public static const CATEGORY_MY_LOOKS:String = "my_looks";
      
      private static const MAXIMUM_HOT_LOOKS:int = 20;
       
      
      private var var_729:Dictionary;
      
      private var var_3164:class_1104;
      
      public function HotLooksModel(param1:HabboAvatarEditor)
      {
         super(param1);
         var_729 = new Dictionary();
         var_729["M"] = [];
         var_729["F"] = [];
         var_729["M.index"] = 0;
         var_729["F.index"] = 0;
         requestHotLooks(param1);
      }
      
      private function requestHotLooks(param1:HabboAvatarEditor) : void
      {
         if(param1.manager.communication)
         {
            var_3164 = new class_1104(onHotLooksMessage);
            param1.manager.communication.addHabboConnectionMessageEvent(var_3164);
            param1.manager.communication.connection.send(new class_632(20));
         }
      }
      
      private function onHotLooksMessage(param1:class_1104) : void
      {
         for each(var _loc2_ in param1.getParser().hotLooks)
         {
            (var_729[_loc2_.gender.toUpperCase()] as Array).push(new Outfit(var_319,_loc2_.figureString,_loc2_.gender));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_3164)
         {
            if(controller && controller.manager && controller.manager.communication)
            {
               controller.manager.communication.removeHabboConnectionMessageEvent(var_3164);
            }
            var_3164 = null;
         }
         var_729 = null;
      }
      
      override protected function init() : void
      {
         if(!var_1631)
         {
            var_1631 = new HotLooksView(this);
         }
         var_1631.init();
         var_1618 = true;
      }
      
      public function selectHotLook(param1:int) : void
      {
         var _loc2_:Array = var_729[var_319.gender];
         var _loc3_:Outfit = _loc2_[param1];
         if(_loc3_ != null)
         {
            if(_loc3_.figure == "")
            {
               return;
            }
            var_319.loadAvatarInEditor(_loc3_.figure,_loc3_.gender,var_319.clubMemberLevel);
         }
      }
      
      public function get hotLooks() : Array
      {
         return var_729[var_319.gender];
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
