package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class ScrollBarLiftController extends InteractiveController implements class_3493
   {
       
      
      protected var var_3679:Number;
      
      protected var var_3934:Number;
      
      protected var _scrollBar:ScrollBarController;
      
      public function ScrollBarLiftController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_3679 = 0;
         var_3934 = 0;
         param4 = uint((param4 = uint((param4 |= 32) | 32768)) | 257);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var _loc12_:* = param7;
         while(_loc12_ != null)
         {
            if(_loc12_ is IScrollbarWindow)
            {
               _scrollBar = ScrollBarController(_loc12_);
               _loc12_ = null;
            }
            else
            {
               _loc12_ = _loc12_.parent;
            }
         }
         if(_scrollBar.horizontal)
         {
            limits.minWidth = width;
         }
         else
         {
            limits.minHeight = height;
         }
      }
      
      public function get scrollbarOffsetX() : Number
      {
         return var_3679;
      }
      
      public function get scrollbarOffsetY() : Number
      {
         return var_3934;
      }
      
      public function set scrollbarOffsetX(param1:Number) : void
      {
      }
      
      public function set scrollbarOffsetY(param1:Number) : void
      {
      }
      
      override public function offset(param1:Number, param2:Number) : void
      {
         var _loc3_:WindowEvent = null;
         super.offset(param1,param2);
         var_3679 = this.x != 0 ? this.x / (_parent.width - width) : 0;
         var_3934 = this.y != 0 ? this.y / (_parent.height - height) : 0;
         if(_parent != _scrollBar)
         {
            _loc3_ = WindowEvent.allocate("WE_CHILD_RELOCATED",this,null);
            _scrollBar.update(this,_loc3_);
            _loc3_.recycle();
         }
      }
   }
}
