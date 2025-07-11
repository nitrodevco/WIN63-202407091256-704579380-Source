package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   import com.sulake.habbo.communication.messages.incoming.avatar.class_1717;
   
   public class WardrobeModel implements ISideContentModel
   {
       
      
      private var var_319:HabboAvatarEditor;
      
      private var var_1631:WardrobeView;
      
      private var var_1699:Map;
      
      private var var_1618:Boolean = false;
      
      public function WardrobeModel(param1:HabboAvatarEditor)
      {
         super();
         var_319 = param1;
      }
      
      public function dispose() : void
      {
         var_319 = null;
         for each(var _loc1_ in var_1699)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         var_1699 = null;
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         var_1618 = false;
      }
      
      public function reset() : void
      {
         var_1618 = false;
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         if(var_1631)
         {
            var_1631.dispose();
         }
         var_1631 = new WardrobeView(this);
         if(var_319.handler != null)
         {
            var_319.handler.getWardrobe();
         }
         if(var_1699)
         {
            for each(var _loc2_ in var_1699)
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         var_1699 = new Map();
         _loc1_ = 1;
         while(_loc1_ <= 10)
         {
            var_1699.add(_loc1_,new WardrobeSlot(var_1631.slotWindowTemplate,var_319,_loc1_,isSlotEnabled(_loc1_)));
            _loc1_++;
         }
         var_1618 = true;
         updateView();
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return var_319;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!var_1618)
         {
            init();
         }
         return var_1631.getWindowContainer();
      }
      
      private function updateView() : void
      {
         var_1631.update();
      }
      
      public function updateSlots(param1:int, param2:Array) : void
      {
         var _loc3_:WardrobeSlot = null;
         if(!var_1618)
         {
            return;
         }
         if(!param2)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: outfits is null!");
         }
         if(!var_1699)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: _slots is null!");
         }
         for each(var _loc4_ in param2)
         {
            _loc3_ = var_1699.getValue(_loc4_.slotId) as WardrobeSlot;
            if(_loc3_)
            {
               _loc3_.update(_loc4_.figureString,_loc4_.gender,isSlotEnabled(_loc3_.id));
            }
         }
      }
      
      private function isSlotEnabled(param1:int) : Boolean
      {
         if(param1 <= 5)
         {
            return var_319.manager.sessionData.hasClub;
         }
         return var_319.manager.sessionData.hasVip;
      }
      
      public function get slots() : Array
      {
         return var_1699.getValues();
      }
   }
}
