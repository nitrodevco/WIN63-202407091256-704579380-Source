package com.sulake.habbo.avatar.view
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.avatar.HabboAvatarEditorManager;
   import flash.geom.Rectangle;
   
   public class AvatarEditorNameSuggestionListRenderer
   {
       
      
      private const MARGIN_X:int = 5;
      
      private const MARGIN_Y:int = 5;
      
      private var var_480:HabboAvatarEditorManager;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var var_4900:int = 0;
      
      private var var_3496:Rectangle = null;
      
      public function AvatarEditorNameSuggestionListRenderer(param1:HabboAvatarEditorManager)
      {
         super();
         this.var_480 = param1;
      }
      
      public function dispose() : void
      {
         var_480 = null;
      }
      
      public function render(param1:Array, param2:IWindowContainer) : int
      {
         var _loc7_:IWindow = null;
         var _loc4_:ITextWindow = null;
         var _loc5_:int = 0;
         while(param2.numChildren > 0)
         {
            (_loc7_ = param2.removeChildAt(0)).dispose();
         }
         param2.parent.invalidate();
         var_4900 = 0;
         _offsetX = 0;
         _offsetY = 0;
         var_3496 = param2.rectangle;
         var_3496.height = 150;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = createItem(param1[_loc5_] as String);
            if(fit(_loc4_))
            {
               param2.addChild(_loc4_);
            }
            else
            {
               _loc4_.dispose();
            }
            _loc5_++;
         }
         var _loc6_:int;
         if((_loc6_ = param2.numChildren) == 0)
         {
            return 0;
         }
         var _loc3_:IWindow = param2.getChildAt(param2.numChildren - 1);
         return _loc3_.bottom;
      }
      
      private function fit(param1:IWindow) : Boolean
      {
         if(param1.width > var_3496.width || param1.width < 2)
         {
            return false;
         }
         if(_offsetY + param1.height > var_3496.height)
         {
            return false;
         }
         if(_offsetX + param1.width > var_3496.width)
         {
            _offsetX = 0;
            _offsetY += param1.height + 5;
            return fit(param1);
         }
         param1.x += _offsetX;
         param1.y += _offsetY;
         _offsetX += param1.width + 5;
         return true;
      }
      
      private function createItem(param1:String) : ITextWindow
      {
         var _loc2_:ITextWindow = var_480.windowManager.buildFromXML(XML(HabboAvatarEditorCom.avatar_editor_name_change_item)) as ITextWindow;
         if(_loc2_ == null)
         {
            return null;
         }
         _loc2_.text = param1;
         return _loc2_;
      }
   }
}
