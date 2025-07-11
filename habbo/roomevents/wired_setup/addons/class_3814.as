package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3814 extends DefaultAddonType
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3814()
      {
         super();
      }
      
      private static function getIntState(param1:class_3398) : int
      {
         return !!param1.isSelected ? 1 : 0;
      }
      
      private static function select(param1:class_3398, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      override public function get code() : int
      {
         return class_3833.var_4972;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         _cont = cont;
         select(getKeepAltitudeInput(),param1.getBoolean(0));
         select(getMoveThroughFurniCheckbox(),param1.getBoolean(1));
         select(getMoveThroughUsersCheckbox(),param1.getBoolean(2));
         select(getBlockByFurniCheckbox(),param1.getBoolean(3));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getIntState(getKeepAltitudeInput()));
         _loc1_.push(getIntState(getMoveThroughFurniCheckbox()));
         _loc1_.push(getIntState(getMoveThroughUsersCheckbox()));
         _loc1_.push(getIntState(getBlockByFurniCheckbox()));
         return _loc1_;
      }
      
      private function getKeepAltitudeInput() : class_3398
      {
         return class_3398(_cont.findChildByName("keep_altitude_checkbox"));
      }
      
      private function getMoveThroughFurniCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("move_through_furni_checkbox"));
      }
      
      private function getMoveThroughUsersCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("move_through_users_checkbox"));
      }
      
      private function getBlockByFurniCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("block_by_furni_checkbox"));
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.physics." + param1;
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.physics." + param1;
      }
   }
}
