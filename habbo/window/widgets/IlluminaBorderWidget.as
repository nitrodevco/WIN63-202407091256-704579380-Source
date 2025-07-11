package com.sulake.habbo.window.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class IlluminaBorderWidget implements IIlluminaBorderWidget
   {
      
      public static const TYPE:String = "illumina_border";
      
      public static const BORDER_STYLE_ILLUMINA_LIGHT:String = "illumina_light";
      
      public static const BORDER_STYLE_ILLUMINA_DARK:String = "illumina_dark";
      
      public static const BORDER_STYLES:Array = ["illumina_light","illumina_dark"];
      
      public static const BORDER_STYLE_KEY:String = "illumina_border:border_style";
      
      private static const CONTENT_CHILD_KEY:String = "illumina_border:content_child";
      
      private static const CONTENT_PADDING_KEY:String = "illumina_border:content_padding";
      
      private static const SIDE_PADDING_KEY:String = "illumina_border:side_padding";
      
      private static const CHILD_MARGIN_KEY:String = "illumina_border:child_margin";
      
      private static const TOP_LEFT_CHILD_KEY:String = "illumina_border:top_left_child";
      
      private static const TOP_CENTER_CHILD_KEY:String = "illumina_border:top_center_child";
      
      private static const TOP_RIGHT_CHILD_KEY:String = "illumina_border:top_right_child";
      
      private static const BOTTOM_LEFT_CHILD_KEY:String = "illumina_border:bottom_left_child";
      
      private static const BOTTOM_CENTER_CHILD_KEY:String = "illumina_border:bottom_center_child";
      
      private static const BOTTOM_RIGHT_CHILD_KEY:String = "illumina_border:bottom_right_child";
      
      private static const LANDING_VIEW_MODE_KEY:String = "illumina_border:landing_view_mode";
      
      private static const CONTENT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_child","","String");
      
      private static const CONTENT_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_padding",5,"uint");
      
      private static const SIDE_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:side_padding",15,"uint");
      
      private static const CHILD_MARGIN_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:child_margin",3,"uint");
      
      private static const TOP_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_left_child","","String");
      
      private static const TOP_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_center_child","","String");
      
      private static const TOP_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_right_child","","String");
      
      private static const BOTTOM_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_left_child","","String");
      
      private static const BOTTOM_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_center_child","","String");
      
      private static const BOTTOM_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_right_child","","String");
      
      private static const LANDING_VIEW_MODE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:landing_view_mode",false,"Boolean");
      
      private static const MATRIX:Matrix = new Matrix();
      
      private static const TOP_LEFT:String = "top_left";
      
      private static const TOP:String = "top_center";
      
      private static const TOP_RIGHT:String = "top_right";
      
      private static const RIGHT:String = "center_right";
      
      private static const BOTTOM_RIGHT:String = "bottom_right";
      
      private static const BOTTOM:String = "bottom_center";
      
      private static const BOTTOM_LEFT:String = "bottom_left";
      
      private static const const_436:String = "center_left";
      
      private static const BORDER_PIECES:Array = ["top_left","top_center","top_right","center_right","bottom_right","bottom_center","bottom_left","center_left"];
       
      
      private var var_3152:Dictionary;
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var var_1696:IBitmapWrapperWindow;
      
      private var var_1875:BitmapData;
      
      private var _children:IWindowContainer;
      
      private var var_3661:Boolean = false;
      
      private var var_2149:Boolean = false;
      
      private var var_3615:String;
      
      private var var_2874:String;
      
      private var var_2858:uint;
      
      private var var_2951:uint;
      
      private var _childMargin:uint;
      
      private var var_2965:String;
      
      private var var_2813:String;
      
      private var var_2854:String;
      
      private var var_2861:String;
      
      private var var_2805:String;
      
      private var var_2852:String;
      
      private var var_2803:Boolean;
      
      public function IlluminaBorderWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_2874 = String(CONTENT_CHILD_DEFAULT.value);
         var_2858 = uint(CONTENT_PADDING_DEFAULT.value);
         var_2951 = uint(SIDE_PADDING_DEFAULT.value);
         _childMargin = uint(CHILD_MARGIN_DEFAULT.value);
         var_2965 = String(TOP_LEFT_CHILD_DEFAULT.value);
         var_2813 = String(TOP_CENTER_CHILD_DEFAULT.value);
         var_2854 = String(TOP_RIGHT_CHILD_DEFAULT.value);
         var_2861 = String(BOTTOM_LEFT_CHILD_DEFAULT.value);
         var_2805 = String(BOTTOM_CENTER_CHILD_DEFAULT.value);
         var_2852 = String(BOTTOM_RIGHT_CHILD_DEFAULT.value);
         var_2803 = Boolean(LANDING_VIEW_MODE_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_border_xml").content as XML) as IWindowContainer;
         var_1696 = var_509.getChildByName("canvas") as IBitmapWrapperWindow;
         _children = var_509.getChildByName("children") as IWindowContainer;
         borderStyle = String(var_1759.getDefaultProperty("illumina_border:border_style").value);
         var_1759.addEventListener("WE_RESIZE",onChange);
         var_1759.addEventListener("WE_RESIZED",onChange);
         _children.addEventListener("WE_CHILD_ADDED",onChange);
         _children.addEventListener("WE_CHILD_REMOVED",onChange);
         _children.addEventListener("WE_CHILD_RELOCATED",onChange);
         _children.addEventListener("WE_CHILD_RESIZED",onChange);
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
      }
      
      private function onChange(param1:WindowEvent) : void
      {
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1875 != null)
            {
               var_1875.dispose();
               var_1875 = null;
            }
            if(var_1696 != null)
            {
               var_1696.removeEventListener("WE_RESIZE",onChange);
               var_1696.removeEventListener("WE_RESIZED",onChange);
               var_1696 = null;
            }
            if(_children != null)
            {
               _children.removeEventListener("WE_CHILD_ADDED",onChange);
               _children.removeEventListener("WE_CHILD_REMOVED",onChange);
               _children.removeEventListener("WE_CHILD_RELOCATED",onChange);
               _children.removeEventListener("WE_CHILD_RESIZED",onChange);
               _children = null;
            }
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            var_3152 = null;
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return _children.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(var_1759.createProperty("illumina_border:border_style",var_3615));
         _loc1_.push(CONTENT_CHILD_DEFAULT.withValue(var_2874));
         _loc1_.push(CONTENT_PADDING_DEFAULT.withValue(var_2858));
         _loc1_.push(SIDE_PADDING_DEFAULT.withValue(var_2951));
         _loc1_.push(CHILD_MARGIN_DEFAULT.withValue(_childMargin));
         _loc1_.push(TOP_LEFT_CHILD_DEFAULT.withValue(var_2965));
         _loc1_.push(TOP_CENTER_CHILD_DEFAULT.withValue(var_2813));
         _loc1_.push(TOP_RIGHT_CHILD_DEFAULT.withValue(var_2854));
         _loc1_.push(BOTTOM_LEFT_CHILD_DEFAULT.withValue(var_2861));
         _loc1_.push(BOTTOM_CENTER_CHILD_DEFAULT.withValue(var_2805));
         _loc1_.push(BOTTOM_RIGHT_CHILD_DEFAULT.withValue(var_2852));
         _loc1_.push(LANDING_VIEW_MODE_DEFAULT.withValue(var_2803));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         var_3661 = true;
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_border:border_style":
                  borderStyle = String(_loc2_.value);
                  break;
               case "illumina_border:content_child":
                  contentChild = String(_loc2_.value);
                  break;
               case "illumina_border:content_padding":
                  contentPadding = uint(_loc2_.value);
                  break;
               case "illumina_border:side_padding":
                  sidePadding = uint(_loc2_.value);
                  break;
               case "illumina_border:child_margin":
                  childMargin = uint(_loc2_.value);
                  break;
               case "illumina_border:top_left_child":
                  topLeftChild = String(_loc2_.value);
                  break;
               case "illumina_border:top_center_child":
                  topCenterChild = String(_loc2_.value);
                  break;
               case "illumina_border:top_right_child":
                  topRightChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_left_child":
                  bottomLeftChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_center_child":
                  bottomCenterChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_right_child":
                  bottomRightChild = String(_loc2_.value);
                  break;
               case "illumina_border:landing_view_mode":
                  landingViewMode = Boolean(_loc2_.value);
                  break;
            }
         }
         var_3661 = false;
         refresh();
      }
      
      public function get borderStyle() : String
      {
         return var_3615;
      }
      
      public function set borderStyle(param1:String) : void
      {
         var_3615 = param1;
         var_3152 = new Dictionary();
         for each(var _loc2_ in BORDER_PIECES)
         {
            var_3152[_loc2_] = _windowManager.assets.getAssetByName(var_3615 + "_border_" + _loc2_);
         }
         refresh();
      }
      
      public function get contentChild() : String
      {
         return var_2874;
      }
      
      public function set contentChild(param1:String) : void
      {
         var_2874 = param1 != null ? param1 : "";
         refresh();
      }
      
      public function get contentPadding() : uint
      {
         return var_2858;
      }
      
      public function set contentPadding(param1:uint) : void
      {
         var_2858 = param1;
         refresh();
      }
      
      public function get sidePadding() : uint
      {
         return var_2951;
      }
      
      public function set sidePadding(param1:uint) : void
      {
         var_2951 = param1;
         refresh();
      }
      
      public function get childMargin() : uint
      {
         return _childMargin;
      }
      
      public function set childMargin(param1:uint) : void
      {
         _childMargin = param1;
         refresh();
      }
      
      public function get topLeftChild() : String
      {
         return var_2965;
      }
      
      public function set topLeftChild(param1:String) : void
      {
         var_2965 = param1 != null ? param1 : "";
         refresh();
      }
      
      public function get topCenterChild() : String
      {
         return var_2813;
      }
      
      public function set topCenterChild(param1:String) : void
      {
         var_2813 = param1 != null ? param1 : "";
         refresh();
      }
      
      public function get topRightChild() : String
      {
         return var_2854;
      }
      
      public function set topRightChild(param1:String) : void
      {
         var_2854 = param1 != null ? param1 : "";
         refresh();
      }
      
      public function get bottomLeftChild() : String
      {
         return var_2861;
      }
      
      public function set bottomLeftChild(param1:String) : void
      {
         var_2861 = param1 != null ? param1 : "";
         refresh();
      }
      
      public function get bottomCenterChild() : String
      {
         return var_2805;
      }
      
      public function set bottomCenterChild(param1:String) : void
      {
         var_2805 = param1 != null ? param1 : "";
         refresh();
      }
      
      public function get bottomRightChild() : String
      {
         return var_2852;
      }
      
      public function set bottomRightChild(param1:String) : void
      {
         var_2852 = param1 != null ? param1 : "";
         refresh();
      }
      
      public function get landingViewMode() : Boolean
      {
         return var_2803;
      }
      
      public function set landingViewMode(param1:Boolean) : void
      {
         var_2803 = param1;
         refresh();
      }
      
      private function getPiece(param1:String) : BitmapDataAsset
      {
         return var_3152[param1];
      }
      
      private function getChildHeight(param1:String) : int
      {
         var _loc2_:IWindow = _children.getChildByName(param1);
         return param1 != null && param1.length > 0 && _loc2_ != null ? _loc2_.height : 0;
      }
      
      private function get topPadding() : int
      {
         return Math.max(getChildHeight(var_2813),Math.max(getChildHeight(var_2965),getChildHeight(var_2854))) / 2;
      }
      
      private function get bottomPadding() : int
      {
         return Math.max(getChildHeight(var_2805),Math.max(getChildHeight(var_2861),getChildHeight(var_2852))) / 2;
      }
      
      private function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:BitmapDataAsset = null;
         var _loc6_:BitmapData = null;
         var _loc13_:Rectangle = null;
         var _loc4_:Rectangle = null;
         var _loc1_:int = 0;
         var _loc8_:int = 0;
         if(var_3661 || var_2149 || disposed)
         {
            return;
         }
         var_509.limits.setEmpty();
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
         var _loc2_:IWindow = _children.getChildByName(var_2874);
         if(_loc2_ != null)
         {
            _loc3_ = Math.max(1,_loc2_.width + 2 * var_2858);
            _loc9_ = Math.max(1,_loc2_.height + 2 * var_2858 + topPadding + bottomPadding);
            var_2149 = true;
            if(var_1759.testParamFlag(131072))
            {
               var_509.limits.minWidth = _loc3_;
               var_509.limits.minHeight = _loc9_;
            }
            if(var_1759.testParamFlag(147456))
            {
               var_509.limits.minWidth = _loc3_;
               var_509.limits.minHeight = _loc9_;
               var_509.limits.maxWidth = _loc3_;
               var_509.limits.maxHeight = _loc9_;
            }
            var_2149 = false;
         }
         if(var_1875 == null || var_1875.width != var_509.width || var_1875.height != var_509.height)
         {
            var_1696.width = var_509.width;
            var_1696.height = var_509.height;
            _children.width = var_509.width;
            _children.height = var_509.height;
            if(var_1875 != null)
            {
               var_1875.dispose();
            }
            var_1875 = new BitmapData(var_1696.width,var_1696.height,true,0);
            var_1696.bitmap = var_1875;
         }
         var _loc12_:Rectangle = var_1696.rectangle;
         _loc12_.y = _loc12_.y + topPadding;
         _loc12_.height -= topPadding + bottomPadding;
         var_1875.lock();
         var_1875.fillRect(new Rectangle(0,0,var_1696.width,var_1696.height),0);
         for(var _loc5_ in var_3152)
         {
            if(!((_loc10_ = getPiece(_loc5_)) == null || var_2803 && (_loc5_ == "top_left" || _loc5_ == "center_left" || _loc5_ == "bottom_left")))
            {
               _loc6_ = _loc10_.content as BitmapData;
               _loc13_ = _loc10_.rectangle;
               _loc4_ = new Rectangle(_loc12_.x,_loc12_.y,_loc13_.width,_loc13_.height);
               switch(_loc5_)
               {
                  case "top_left":
                     break;
                  case "top_center":
                     _loc4_.x += getPiece("top_left").rectangle.width;
                     _loc4_.width = _loc12_.width - getPiece("top_left").rectangle.width - getPiece("top_right").rectangle.width;
                     break;
                  case "top_right":
                     _loc4_.x += _loc12_.width - _loc13_.width;
                     break;
                  case "center_right":
                     _loc4_.x += _loc12_.width - _loc13_.width;
                     _loc4_.y += getPiece("top_right").rectangle.height;
                     _loc4_.height = _loc12_.height - getPiece("top_right").rectangle.height - getPiece("bottom_right").rectangle.height;
                     break;
                  case "bottom_right":
                     _loc4_.x += _loc12_.width - _loc13_.width;
                     _loc4_.y += _loc12_.height - _loc13_.height;
                     break;
                  case "bottom_center":
                     _loc4_.x += getPiece("bottom_left").rectangle.width;
                     _loc4_.y += _loc12_.height - _loc13_.height;
                     _loc4_.width = _loc12_.width - getPiece("bottom_left").rectangle.width - getPiece("bottom_right").rectangle.width;
                     if(var_2803)
                     {
                        _loc1_ = _loc4_.width / 2;
                        _loc4_.x += _loc1_;
                        _loc4_.width -= _loc1_;
                     }
                     break;
                  case "bottom_left":
                     _loc4_.y += _loc12_.height - _loc13_.height;
                     break;
                  case "center_left":
                     _loc4_.y += getPiece("top_left").rectangle.height;
                     _loc4_.height = _loc12_.height - getPiece("top_left").rectangle.height - getPiece("bottom_left").rectangle.height;
                     break;
                  default:
                     continue;
               }
               MATRIX.a = _loc4_.width / _loc13_.width;
               MATRIX.d = _loc4_.height / _loc13_.height;
               MATRIX.tx = _loc4_.x - _loc13_.x * MATRIX.a;
               MATRIX.ty = _loc4_.y - _loc13_.y * MATRIX.d;
               var_1875.draw(_loc6_,MATRIX,null,null,_loc4_,false);
            }
         }
         var _loc11_:Array = [var_2965,var_2813,var_2854,var_2861,var_2805,var_2852];
         for each(var _loc7_ in _children.iterator)
         {
            if(_loc7_.name != null && _loc7_.name.length > 0)
            {
               if((_loc8_ = _loc11_.indexOf(_loc7_.name)) < 0)
               {
                  if(_loc7_.name == var_2874)
                  {
                     _loc7_.x = _loc12_.x + contentPadding;
                     _loc7_.y = _loc12_.y + contentPadding;
                     _loc7_.visible = true;
                  }
                  else
                  {
                     _loc7_.visible = false;
                  }
               }
               else
               {
                  switch(_loc8_ % 3)
                  {
                     case 0:
                        _loc7_.x = Math.min(var_2951,var_1696.width - _loc7_.width);
                        break;
                     case 1:
                        _loc7_.x = Math.max(var_1696.width - _loc7_.width,0) / 2;
                        break;
                     case 2:
                        _loc7_.x = Math.max(var_1696.width - _loc7_.width - var_2951,0);
                  }
                  if(_loc8_ < 3)
                  {
                     _loc7_.y = topPadding - _loc7_.height / 2;
                  }
                  else
                  {
                     _loc7_.y = var_1696.height - (bottomPadding + _loc7_.height / 2);
                  }
                  _loc7_.visible = true;
                  var_1875.fillRect(new Rectangle(_loc7_.x - _childMargin,_loc7_.y,_loc7_.width + _childMargin * 2,_loc7_.height),0);
               }
            }
            else
            {
               _loc7_.visible = false;
            }
         }
         var_1875.unlock();
         var_1696.invalidate();
      }
   }
}
