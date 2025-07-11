package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1798;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.class_3420;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class WidgetWindowController extends WindowController implements IWidgetWindow
   {
       
      
      private var var_3890:class_1798;
      
      private var var_4009:String = "";
      
      private var var_1629:class_3420;
      
      public function WidgetWindowController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_3890 = param5.getWidgetFactory();
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1629 != null)
            {
               var_1629.dispose();
               var_1629 = null;
            }
            var_3890 = null;
            super.dispose();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = var_1629 != null ? var_1629.properties : [];
         _loc1_.unshift(createProperty("widget_type",var_4009));
         return super.properties.concat(_loc1_);
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc3_:String = null;
         for each(var _loc2_ in param1)
         {
            if(_loc2_.key == "widget_type")
            {
               _loc3_ = String(_loc2_.value);
               if(var_4009 != _loc3_)
               {
                  if(var_1629 != null)
                  {
                     removeChildAt(0);
                     var_1629.dispose();
                  }
                  var_1629 = var_3890.createWidget(String(_loc2_.value),this);
                  var_4009 = _loc3_;
               }
               break;
            }
         }
         if(var_1629 != null)
         {
            var_1629.properties = param1;
         }
         super.properties = param1;
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         var _loc2_:Array = [];
         groupChildrenWithTag("_COLORIZE",_loc2_,-1);
         for each(var _loc3_ in _loc2_)
         {
            _loc3_.color = param1;
         }
      }
      
      public function get iterator() : IIterator
      {
         return var_1629 != null ? var_1629.iterator : EmptyIterator.INSTANCE;
      }
      
      public function get widget() : class_3420
      {
         return var_1629;
      }
      
      public function get rootWindow() : IWindow
      {
         return getChildAt(0);
      }
      
      public function set rootWindow(param1:IWindow) : void
      {
         removeChildAt(0);
         if(param1 == null)
         {
            return;
         }
         addChild(param1);
         if(param1.tags.indexOf("_EXCLUDE") < 0)
         {
            param1.tags.push("_EXCLUDE");
         }
      }
   }
}
