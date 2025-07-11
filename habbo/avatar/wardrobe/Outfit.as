package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IOutfit;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import flash.display.BitmapData;
   
   public class Outfit implements IOutfit, IAvatarImageListener
   {
       
      
      private var var_319:HabboAvatarEditor;
      
      private var var_426:String;
      
      private var var_129:String;
      
      private var var_1631:OutfitView;
      
      private var var_318:Boolean;
      
      public function Outfit(param1:HabboAvatarEditor, param2:String, param3:String)
      {
         super();
         var_319 = param1;
         var_1631 = new OutfitView(param1.manager.windowManager,param1.manager.assets,param2 != "");
         switch(param3)
         {
            case "M":
            case "m":
            case "M":
               param3 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param3 = "F";
         }
         var_426 = param2;
         var_129 = param3;
         update();
      }
      
      public function dispose() : void
      {
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         var_426 = null;
         var_129 = null;
         var_318 = true;
         var_319 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function update() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:Boolean = var_319.manager.getBoolean("zoom.enabled");
         var _loc2_:class_3374 = var_319.manager.avatarRenderManager.createAvatarImage(figure,_loc3_ ? "h" : "sh",var_129,this);
         if(_loc2_)
         {
            _loc2_.setDirection("full",4);
            _loc1_ = _loc2_.getImage("full",true,_loc3_ ? 0.5 : 1);
            if(var_1631 && _loc1_)
            {
               var_1631.update(_loc1_);
            }
            _loc2_.dispose();
         }
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function get gender() : String
      {
         return var_129;
      }
      
      public function get view() : OutfitView
      {
         return var_1631;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         update();
      }
   }
}
