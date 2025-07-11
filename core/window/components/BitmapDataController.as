package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.enum.PivotPoint;
   import com.sulake.core.window.theme.class_3538;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_3501;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapDataController extends WindowController implements class_3501
   {
       
      
      protected var _bitmapData:BitmapData;
      
      protected var var_2932:uint;
      
      protected var var_2971:Boolean;
      
      protected var var_2905:Boolean;
      
      protected var var_2571:Number;
      
      protected var var_2650:Number;
      
      protected var var_3360:Boolean;
      
      protected var _etchingColor:uint;
      
      protected var _etchingPoint:Point;
      
      protected var var_3783:Boolean;
      
      private var var_2983:Boolean;
      
      private var var_2891:Boolean;
      
      private var var_1239:Number;
      
      public function BitmapDataController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         _etchingPoint = new Point(0,-1);
         var _loc12_:class_3538 = param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3);
         var_2932 = PivotPoint.pivotFromName(String(_loc12_.method_20("pivot_point").value));
         var_2971 = Boolean(_loc12_.method_20("stretched_x").value);
         var_2905 = Boolean(_loc12_.method_20("stretched_y").value);
         var_2571 = Number(_loc12_.method_20("zoom_x").value);
         var_2650 = Number(_loc12_.method_20("zoom_y").value);
         var_2983 = Boolean(_loc12_.method_20("wrap_x").value);
         var_2891 = Boolean(_loc12_.method_20("wrap_y").value);
         var_1239 = Number(_loc12_.method_20("rotation").value);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         _bitmapData = null;
         super.dispose();
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return var_2932;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         var_2932 = param1;
      }
      
      public function get stretchedX() : Boolean
      {
         return var_2971;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         var_2971 = param1;
      }
      
      public function get stretchedY() : Boolean
      {
         return var_2905;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         var_2905 = param1;
      }
      
      public function get zoomX() : Number
      {
         return var_2571;
      }
      
      public function set zoomX(param1:Number) : void
      {
         var_2571 = param1;
         fitSize();
      }
      
      public function get zoomY() : Number
      {
         return var_2650;
      }
      
      public function set zoomY(param1:Number) : void
      {
         var_2650 = param1;
         fitSize();
      }
      
      public function get greyscale() : Boolean
      {
         return var_3360;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         var_3360 = param1;
      }
      
      public function get etchingColor() : uint
      {
         return _etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _etchingColor = param1;
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return var_3783;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         var_3783 = param1;
         fitSize();
      }
      
      override public function get etchingPoint() : Point
      {
         return _etchingPoint;
      }
      
      override public function set etching(param1:Array) : void
      {
         etchingColor = param1[0];
         _etchingPoint = new Point(param1[1],param1[2]);
      }
      
      public function get wrapX() : Boolean
      {
         return var_2983;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
         var_2983 = param1;
      }
      
      public function get wrapY() : Boolean
      {
         return var_2891;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
         var_2891 = param1;
      }
      
      public function get rotation() : Number
      {
         return var_1239;
      }
      
      public function set rotation(param1:Number) : void
      {
         var_1239 = param1;
      }
      
      protected function fitSize() : void
      {
         if(var_3783 && _bitmapData != null)
         {
            width = Math.abs(_bitmapData.width * var_2571);
            height = Math.abs(_bitmapData.height * var_2650);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("pivot_point",PivotPoint.PIVOT_NAMES[var_2932]));
         _loc1_.push(createProperty("stretched_x",var_2971));
         _loc1_.push(createProperty("stretched_y",var_2905));
         _loc1_.push(createProperty("wrap_x",var_2983));
         _loc1_.push(createProperty("wrap_y",var_2891));
         _loc1_.push(createProperty("zoom_x",var_2571));
         _loc1_.push(createProperty("zoom_y",var_2650));
         _loc1_.push(createProperty("greyscale",var_3360));
         _loc1_.push(createProperty("etching_color",_etchingColor));
         _loc1_.push(createProperty("fit_size_to_contents",var_3783));
         _loc1_.push(createProperty("rotation",var_1239));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "pivot_point":
                  var_2932 = PivotPoint.pivotFromName(String(_loc2_.value));
                  break;
               case "stretched_x":
                  var_2971 = Boolean(_loc2_.value);
                  break;
               case "stretched_y":
                  var_2905 = Boolean(_loc2_.value);
                  break;
               case "zoom_x":
                  var_2571 = Number(_loc2_.value);
                  break;
               case "zoom_y":
                  var_2650 = Number(_loc2_.value);
                  break;
               case "wrap_x":
                  var_2983 = Boolean(_loc2_.value);
                  break;
               case "wrap_y":
                  var_2891 = Boolean(_loc2_.value);
                  break;
               case "greyscale":
                  var_3360 = Boolean(_loc2_.value);
                  break;
               case "etching_color":
                  _etchingColor = uint(_loc2_.value);
                  break;
               case "fit_size_to_contents":
                  fitSizeToContents = _loc2_.value as Boolean;
                  break;
               case "rotation":
                  var_1239 = Number(_loc2_.value);
                  break;
            }
         }
         super.properties = param1;
      }
   }
}
