package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendlist.RelationshipStatusEnum;
   import com.sulake.habbo.ui.widget.contextmenu.ButtonMenuView;
   import com.sulake.habbo.ui.widget.contextmenu.class_3386;
   import flash.geom.Rectangle;
   
   public class AvatarContextInfoButtonView extends ButtonMenuView
   {
       
      
      protected var var_418:int;
      
      protected var _userName:String;
      
      protected var var_1347:int;
      
      protected var var_3898:Boolean;
      
      protected var var_871:int;
      
      public function AvatarContextInfoButtonView(param1:class_3386)
      {
         super(param1);
      }
      
      public static function setup(param1:AvatarContextInfoButtonView, param2:int, param3:String, param4:int, param5:int, param6:Boolean = false, param7:Boolean = false) : void
      {
         param1.var_418 = param2;
         param1._userName = param3;
         param1.var_1347 = param5;
         param1.var_871 = param4;
         param1.var_3898 = param6;
         param1.var_1782 = param7;
         setupContext(param1);
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get userType() : int
      {
         return var_1347;
      }
      
      public function get roomIndex() : int
      {
         return var_871;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get allowNameChange() : Boolean
      {
         return var_3898;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc3_:IWindow = null;
         if(!var_1629 || !var_1629.assets || !var_1629.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = var_1629.assets.getAssetByName("avatar_info_widget").content as XML;
            _window = var_1629.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
            if(!_window)
            {
               return;
            }
         }
         var _loc2_:IWindow = _window.findChildByName("name");
         _loc2_.caption = _userName;
         updateRelationshipStatus();
         if(!var_3898)
         {
            _window.findChildByName("change_name_container").visible = false;
            _window.height = 39;
         }
         else
         {
            _loc3_ = _window.findChildByName("change_name_container");
            _loc3_.visible = true;
            _window.height = 39 + _loc3_.height;
            addMouseClickListener(_window.findChildByName("change_name_container"),clickHandler);
         }
         activeView = _window;
      }
      
      override protected function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -var_1701.height;
         if(var_1347 == 1 || var_1347 == 3 || var_1347 == 4)
         {
            _loc2_ += param1.height > 50 ? 25 : 0;
         }
         else
         {
            _loc2_ -= 4;
         }
         return _loc2_;
      }
      
      protected function updateRelationshipStatus() : void
      {
         var _loc1_:IStaticBitmapWrapperWindow = null;
         if(var_1629 && var_1629.friendList)
         {
            _loc1_ = IStaticBitmapWrapperWindow(_window.findChildByName("relationship_status"));
            _loc1_.assetUri = "relationship_status_" + RelationshipStatusEnum.statusAsString(var_1629.friendList.getRelationshipStatus(userId));
         }
      }
   }
}
