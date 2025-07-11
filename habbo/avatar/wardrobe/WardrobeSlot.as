package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IOutfit;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class WardrobeSlot implements IOutfit, IAvatarImageListener
   {
       
      
      private var var_319:HabboAvatarEditor;
      
      private var var_426:String;
      
      private var var_129:String;
      
      private var var_1479:Boolean;
      
      private var var_1631:IWindowContainer;
      
      private var var_2121:IBitmapWrapperWindow;
      
      private var var_888:int;
      
      private var var_318:Boolean;
      
      public function WardrobeSlot(param1:IWindow, param2:HabboAvatarEditor, param3:int, param4:Boolean, param5:String = null, param6:String = null)
      {
         super();
         var_319 = param2;
         var_888 = param3;
         createView(param1);
         update(param5,param6,param4);
      }
      
      public function get id() : int
      {
         return var_888;
      }
      
      public function update(param1:String, param2:String, param3:Boolean) : void
      {
         switch(param2)
         {
            case "M":
            case "m":
            case "M":
               param2 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param2 = "F";
         }
         var_426 = param1;
         var_129 = param2;
         var_1479 = param3;
         updateView();
      }
      
      private function createView(param1:IWindow) : void
      {
         var_1631 = param1.clone() as IWindowContainer;
         var_1631.procedure = eventHandler;
         var_1631.visible = false;
         var_2121 = var_1631.findChildByName("image") as IBitmapWrapperWindow;
      }
      
      public function dispose() : void
      {
         var_319 = null;
         var_426 = null;
         var_129 = null;
         var_2121 = null;
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function updateView() : void
      {
         var _loc1_:BitmapData = null;
         var _loc5_:class_3374 = null;
         var _loc9_:BitmapDataAsset = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:Boolean = true;
         var _loc6_:Boolean = var_319.manager.getBoolean("zoom.enabled");
         if(var_426 && var_1479)
         {
            if(_loc5_ = var_319.manager.avatarRenderManager.createAvatarImage(figure,_loc6_ ? "h" : "sh",var_129,this))
            {
               _loc5_.setDirection("full",4);
               _loc1_ = _loc5_.getCroppedImage("full",_loc6_ ? 0.5 : 1);
               _loc5_.dispose();
            }
         }
         else if(_loc9_ = var_319.manager.windowManager.assets.getAssetByName("avatar_editor_wardrobe_empty_slot") as BitmapDataAsset)
         {
            _loc1_ = _loc9_.content as BitmapData;
            _loc8_ = false;
         }
         if(!_loc1_)
         {
            return;
         }
         if(var_2121)
         {
            if(var_2121.bitmap)
            {
               var_2121.bitmap.dispose();
            }
            var_2121.bitmap = new BitmapData(var_2121.width,var_2121.height,true,0);
            _loc3_ = (var_2121.width - _loc1_.width) / 2;
            _loc4_ = (var_2121.height - _loc1_.height) / 2;
            var_2121.bitmap.draw(_loc1_,new Matrix(1,0,0,1,_loc3_,_loc4_));
         }
         if(_loc8_)
         {
            _loc1_.dispose();
         }
         var _loc7_:class_3489;
         if(_loc7_ = var_1631.findChildByName("set_button") as class_3489)
         {
            _loc7_.visible = var_1479;
         }
         var _loc2_:class_3489 = var_1631.findChildByName("get_button") as class_3489;
         if(_loc2_)
         {
            _loc2_.visible = var_1479 && var_426 != null;
         }
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!var_319.verifyClubLevel())
         {
            return;
         }
         switch(param2.name)
         {
            case "set_button":
               var_426 = var_319.figureData.getFigureString();
               var_129 = var_319.gender;
               var_319.handler.saveWardrobeOutfit(var_888,this);
               updateView();
               break;
            case "get_button":
            case "get_figure":
               if(var_426)
               {
                  var_319.setNftOutfit(null);
                  var_319.loadAvatarInEditor(var_426,var_129,var_319.clubMemberLevel);
               }
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
      
      public function get view() : IWindowContainer
      {
         return var_1631;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateView();
      }
   }
}
