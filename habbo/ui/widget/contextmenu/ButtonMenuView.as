package com.sulake.habbo.ui.widget.contextmenu
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   
   public class ButtonMenuView extends ContextInfoView
   {
      
      protected static const ICON_MARGIN:int = 8;
      
      protected static const LINK_COLOR_MODERATE_DEFAULT:uint = 16744755;
      
      protected static const LINK_COLOR_MODERATE_HOVER:uint = 16756591;
      
      protected static const ICON_VIP:String = "icon_vip";
      
      protected static const ICON_DUCKET:String = "icon_ducket";
      
      protected static const ICON_ARROW_LEFT:String = "arrow_left";
      
      protected static const ICON_ARROW_RIGHT:String = "arrow_right";
       
      
      protected var var_1640:IItemListWindow;
      
      public function ButtonMenuView(param1:class_3386)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         var_1640 = null;
         super.dispose();
      }
      
      protected function showButtonGrid(param1:String, param2:Boolean = true) : void
      {
         var _loc6_:int = 0;
         var _loc8_:IWindowContainer = null;
         var _loc7_:IBitmapWrapperWindow = null;
         if(!var_1640)
         {
            return;
         }
         var _loc3_:IItemGridWindow = var_1640.getListItemByName(param1) as IItemGridWindow;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.visible = param2;
         var _loc5_:int;
         var _loc4_:IIterator;
         if((_loc5_ = int((_loc4_ = _loc3_.iterator).length)) > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(_loc7_ = (_loc8_ = _loc4_[_loc6_] as IWindowContainer).findChildByTag("icon") as IBitmapWrapperWindow)
               {
                  setImageAsset(_loc7_,_loc7_.name,true);
               }
               _loc6_++;
            }
         }
      }
      
      protected function showButton(param1:String, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc11_:IIconWindow = null;
         var _loc8_:IIconWindow = null;
         if(!var_1640)
         {
            return;
         }
         var _loc6_:IWindowContainer;
         if(!(_loc6_ = var_1640.getListItemByName(param1) as IWindowContainer))
         {
            return;
         }
         _loc6_.visible = param2;
         var _loc7_:IWindowContainer = _loc6_.getChildByName("button") as IWindowContainer;
         param3 ||= param4;
         param3 ? _loc7_.enable() : Boolean(_loc7_.disable());
         var _loc10_:ITextWindow;
         (_loc10_ = _loc7_.getChildByName("label") as ITextWindow).textColor = param3 && !param4 ? 16777215 : 5789011;
         var _loc9_:IIconWindow;
         if(_loc9_ = _loc7_.getChildByName("icon") as IIconWindow)
         {
            _loc9_.color = param3 ? 13947341 : 5789011;
            if(_loc9_.tags.indexOf("arrow_left") != -1)
            {
               _loc9_.x = _loc10_.x + (_loc10_.width - _loc10_.textWidth) / 2 - _loc9_.width - 8;
            }
            if(_loc9_.tags.indexOf("arrow_right") != -1)
            {
               _loc9_.x = _loc10_.x + (_loc10_.width + _loc10_.textWidth) / 2 + 8;
            }
            _loc9_.visible = param4 || param5;
         }
         if(param4)
         {
            if(_loc11_ = _loc7_.getChildByName("icon_vip") as IIconWindow)
            {
               _loc11_.visible = param4;
            }
         }
         if(param5)
         {
            if(_loc8_ = _loc7_.getChildByName("icon_ducket") as IIconWindow)
            {
               _loc8_.visible = param5;
            }
         }
      }
      
      protected function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         if(param1.type == "WME_OVER")
         {
            if(param2.name == "button")
            {
               param2.color = param2.tags.indexOf("moderate") > -1 ? 4288230144 : 4282950861;
            }
            else if(param2.tags.indexOf("link") > -1)
            {
               if(param2.tags.indexOf("actions") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = 9552639;
               }
               else if(param2.tags.indexOf("moderate") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = 16756591;
               }
            }
            if(param2.name == "profile_link")
            {
               ITextWindow(IWindowContainer(param2).findChildByName("name")).textColor = 9552639;
            }
         }
         else if(param1.type == "WME_OUT")
         {
            if(param2.name == "button")
            {
               param2.color = 4281149991;
            }
            else if(param2.tags.indexOf("link") > -1)
            {
               if(param2.tags.indexOf("actions") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = 16777215;
               }
               else if(param2.tags.indexOf("moderate") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = 16744755;
               }
            }
            if(param2.name == "profile_link")
            {
               ITextWindow(IWindowContainer(param2).findChildByName("name")).textColor = 16777215;
            }
         }
      }
   }
}
