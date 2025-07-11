package com.sulake.habbo.window.utils
{
    import assets.class_14

    import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.class_3400;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ModalDialog implements IModalDialog
   {
      
      private static const MODAL_DIALOG_LAYER:int = 3;
      
      private static const COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.25,0.25,0.25);
      
      private static var var_1859:Stage = null;
      
      private static var _windowManager:HabboWindowManagerComponent;
      
      private static var _container:IWindowContainer;
      
      private static var var_3055:int;
       
      
      private var _disposed:Boolean;
      
      private var var_1980:IWindow;
      
      private var _background:IBitmapWrapperWindow;
      
      public function ModalDialog(param1:HabboWindowManagerComponent, param2:XML)
      {
         super();
         initialiseStaticMembers(param1);
         _background = modalContext.create("","",21,0,1,new Rectangle(0,0,1,1),null,_container,0) as IBitmapWrapperWindow;
         var_1980 = _windowManager.buildFromXML(param2,3);
         _container.addChild(var_1980);
         var_1980.center();
         _container.visible = true;
         refresh();
      }
      
      private static function initialiseStaticMembers(param1:HabboWindowManagerComponent) : void
      {
         if(var_1859 == null)
         {
            _windowManager = param1;
            var_1859 = _windowManager.context.displayObjectContainer.stage;
            _container = modalContext.create("","",4,0,0,new Rectangle(0,0,1,1),null,null,0) as IWindowContainer;
            var_1859.addEventListener("resize",onResize);
            var_1859.addEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private static function get modalContext() : class_3400
      {
         return _windowManager.getWindowContext(3);
      }
      
      private static function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc2_:class_3460 = null;
         var _loc9_:IWindow = null;
         var _loc3_:class_3400 = null;
         var _loc6_:IBitmapWrapperWindow = null;
         var _loc7_:IWindow = null;
         if(_container == null)
         {
            return;
         }
         var _loc8_:* = _container.numChildren == 0;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = _windowManager.getWindowContext(_loc4_).getDesktopWindow();
            _loc2_.visible = _loc8_;
            if(_loc8_)
            {
               for each(_loc9_ in _loc2_.iterator)
               {
                  _loc9_.invalidate();
               }
            }
            _loc4_++;
         }
         if(_loc8_)
         {
            return;
         }
         var _loc5_:Rectangle = new Rectangle(0,0,Math.max(1,var_1859.stageWidth),Math.max(1,var_1859.stageHeight));
         _container.rectangle = _loc5_;
         _loc4_ = 0;
         while(_loc4_ < _container.numChildren)
         {
            _loc9_ = _container.getChildAt(_loc4_);
            if(_loc4_ % 2 == 0)
            {
               _loc9_.rectangle = _loc5_;
               IBitmapWrapperWindow(_loc9_).bitmap = null;
            }
            else
            {
               _loc9_.center();
            }
            _loc4_++;
         }
         var _loc1_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,false,0);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc3_ = _windowManager.getWindowContext(_loc4_);
            if(_loc3_ != null)
            {
               try
               {
                  _loc1_.draw(class_3431(_loc3_.getDesktopWindow()).getDisplayObject());
               }
               catch(e:SecurityError)
               {
                  class_14.log("[ModalDialog] security error while drawing modal dialog:" + e.message);
               }
            }
            _loc4_++;
         }
         _loc1_.colorTransform(_loc1_.rect,COLOR_TRANSFORM);
         _loc4_ = 0;
         while(_loc4_ < _container.numChildren)
         {
            _loc9_ = _container.getChildAt(_loc4_);
            if(_loc4_ % 2 == 0)
            {
               _loc6_ = _loc9_ as IBitmapWrapperWindow;
               if(_loc4_ >= 2)
               {
                  _loc6_.bitmap = _loc1_.clone();
                  _loc1_ = _loc6_.bitmap;
                  _loc7_ = _container.getChildAt(_loc4_ - 1);
                  _loc1_.draw(WindowController(_loc7_).getGraphicContext(true),new Matrix(1,0,0,1,_loc7_.x,_loc7_.y),COLOR_TRANSFORM);
               }
               else
               {
                  _loc6_.bitmap = _loc1_;
               }
            }
            _loc9_.visible = _loc4_ >= _container.numChildren - 2;
            _loc9_.invalidate();
            _loc4_++;
         }
      }
      
      private static function onResize(param1:Event) : void
      {
         if(_container == null || _container.numChildren <= 0)
         {
            return;
         }
         var_3055 = 2;
         _container.getChildAt(_container.numChildren - 1).center();
      }
      
      private static function onEnterFrame(param1:Event) : void
      {
         if(_container == null || _container.numChildren <= 0)
         {
            return;
         }
         if(var_3055 > 0)
         {
            var_3055--;
            if(var_3055 == 0)
            {
               refresh();
            }
         }
      }
      
      public function get rootWindow() : IWindow
      {
         return var_1980;
      }
      
      public function get background() : IBitmapWrapperWindow
      {
         return _background;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_background != null)
            {
               _background.dispose();
               _background = null;
            }
            if(var_1980 != null)
            {
               var_1980.dispose();
               var_1980 = null;
            }
            refresh();
            if(_container != null && _container.numChildren == 0)
            {
               _container.visible = false;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
