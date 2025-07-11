package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.utils.class_419;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.enum.class_3821;
   import flash.geom.Rectangle;
   
   public class BalloonWidget implements class_3583
   {
      
      public static const TYPE:String = "balloon";
      
      private static const ARROW_PIVOT_KEY:String = "balloon:arrow_pivot";
      
      private static const ARROW_DISPLACEMENT_KEY:String = "balloon:arrow_displacement";
      
      private static const ARROW_PIVOT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_pivot","up, center","String",false,class_3821.ALL);
      
      private static const ARROW_DISPLACEMENT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_displacement",0,"int");
      
      private static const ARROW_ASSET_PREFIX:String = "illumina_light_balloon_arrow_";
      
      private static const ARROW_FREE_PADDING:int = 6;
      
      private static const ARROW_LENGTH:int = 6;
      
      private static const ARROW_WIDTH:int = 9;
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_3661:Boolean = false;
      
      private var var_2149:Boolean = false;
      
      private var var_509:IWindowContainer;
      
      private var var_1738:IWindowContainer;
      
      private var var_3011:IStaticBitmapWrapperWindow;
      
      private var var_2641:String;
      
      private var var_2831:int;
      
      public function BalloonWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_2641 = String(ARROW_PIVOT_DEFAULT.value);
         var_2831 = int(ARROW_DISPLACEMENT_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("balloon_xml").content as XML) as IWindowContainer;
         var_3011 = var_509.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         var_1738 = var_509.findChildByName("border") as IWindowContainer;
         syncFlags();
         var_1759.addEventListener("WE_RESIZE",onChange);
         var_1759.addEventListener("WE_RESIZED",onChange);
         var_1738.addEventListener("WE_RESIZE",onChange);
         var_1738.addEventListener("WE_RESIZED",onChange);
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1738 != null)
            {
               var_1738.removeEventListener("WE_RESIZE",onChange);
               var_1738.removeEventListener("WE_RESIZED",onChange);
               var_1738 = null;
            }
            var_3011 = null;
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_1759 != null)
            {
               var_1759.removeEventListener("WE_RESIZE",onChange);
               var_1759.removeEventListener("WE_RESIZED",onChange);
               var_1759.rootWindow = null;
               var_1759 = null;
            }
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
         return var_1738 == null ? EmptyIterator.INSTANCE : var_1738.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(ARROW_PIVOT_DEFAULT.withValue(var_2641));
         _loc1_.push(ARROW_DISPLACEMENT_DEFAULT.withValue(var_2831));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         var_3661 = true;
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "balloon:arrow_pivot":
                  arrowPivot = String(_loc2_.value);
                  break;
               case "balloon:arrow_displacement":
                  arrowDisplacement = int(_loc2_.value);
                  break;
            }
         }
         var_3661 = false;
         refresh();
      }
      
      public function get arrowPivot() : String
      {
         return var_2641;
      }
      
      public function set arrowPivot(param1:String) : void
      {
         var_2641 = param1;
         clearFlags();
         refresh();
         syncFlags();
         refresh();
      }
      
      public function get arrowDisplacement() : int
      {
         return var_2831;
      }
      
      public function set arrowDisplacement(param1:int) : void
      {
         var_2831 = param1;
         refresh();
      }
      
      private function onChange(param1:WindowEvent) : void
      {
         refresh();
      }
      
      private function syncFlags() : void
      {
         if(var_1738 != null)
         {
            var_1738.setParamFlag(131072,var_1759.getParamFlag(131072));
            var_1738.setParamFlag(147456,var_1759.getParamFlag(147456));
         }
      }
      
      private function clearFlags() : void
      {
         if(var_1738 != null)
         {
            var_1738.setParamFlag(131072,false);
            var_1738.setParamFlag(147456,false);
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(var_3661 || var_2149 || _disposed || var_1738 == null)
         {
            return;
         }
         var _loc4_:String;
         switch(_loc4_ = class_3821.directionFromPivot(var_2641))
         {
            case "up":
            case "down":
               _loc1_ = int(var_1738.width);
               _loc3_ = var_1738.height + 6 - 1;
               break;
            case "left":
            case "right":
               _loc1_ = var_1738.width + 6 - 1;
               _loc3_ = int(var_1738.height);
         }
         var_2149 = true;
         if(var_1759.testParamFlag(147456))
         {
            var_509.width = _loc1_;
            var_509.height = _loc3_;
         }
         else if(var_1759.testParamFlag(131072))
         {
            var_509.width = Math.max(var_1759.width,_loc1_);
            var_509.height = Math.max(var_1759.height,_loc3_);
         }
         else
         {
            var_509.width = var_1759.width;
            var_509.height = var_1759.height;
         }
         var_1759.width = var_509.width;
         var_1759.height = var_509.height;
         var_2149 = false;
         var_3011.assetUri = "illumina_light_balloon_arrow_" + _loc4_;
         switch(_loc4_)
         {
            case "up":
            case "down":
               switch(class_3821.positionFromPivot(var_2641))
               {
                  case "minimum":
                     _loc2_ = 6;
                     break;
                  case "middle":
                     _loc2_ = (var_509.width - 9) / 2;
                     break;
                  case "maximum":
                     _loc2_ = var_509.width - 6 - 9;
               }
               var_2149 = true;
               var_1738.rectangle = new Rectangle(0,_loc4_ == "up" ? 6 - 1 : 0,var_509.width,var_509.height + 1 - 6);
               var_2149 = false;
               var_3011.rectangle = new Rectangle(class_419.clamp(_loc2_ + var_2831,6,var_509.width - 6),_loc4_ == "up" ? 0 : var_1738.bottom - 1,9,6);
               break;
            case "left":
            case "right":
               switch(class_3821.positionFromPivot(var_2641))
               {
                  case "minimum":
                     _loc2_ = 6;
                     break;
                  case "middle":
                     _loc2_ = (var_509.height - 9) / 2;
                     break;
                  case "maximum":
                     _loc2_ = var_509.height - 6 - 9;
               }
               var_2149 = true;
               var_1738.rectangle = new Rectangle(_loc4_ == "left" ? 6 - 1 : 0,0,var_509.width + 1 - 6,var_509.height);
               var_2149 = false;
               var_3011.rectangle = new Rectangle(_loc4_ == "left" ? 0 : var_1738.right - 1,class_419.clamp(_loc2_ + var_2831,6,var_509.height - 6),6,9);
         }
      }
   }
}
