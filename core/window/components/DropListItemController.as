package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class DropListItemController extends ContainerButtonController implements class_3478, ITouchAwareWindow
   {
       
      
      public function DropListItemController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get menu() : class_3520
      {
         var _loc1_:IWindow = parent;
         while(_loc1_)
         {
            if(_loc1_ is class_3520)
            {
               break;
            }
            _loc1_ = _loc1_.parent;
         }
         return _loc1_ as class_3520;
      }
      
      public function get value() : IWindow
      {
         return getChildAt(0);
      }
      
      public function set value(param1:IWindow) : void
      {
         var _loc2_:IWindow = getChildAt(0);
         if(_loc2_ != param1)
         {
            removeChildAt(0);
            if(param1)
            {
               addChild(param1);
            }
         }
      }
   }
}
