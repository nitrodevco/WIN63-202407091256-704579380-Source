package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class SelectorListController extends SelectorController implements ISelectorListWindow
   {
       
      
      protected var var_2036:int = 0;
      
      private var var_3777:Boolean = false;
      
      private var var_2786:Boolean;
      
      public function SelectorListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_4597 = false;
      }
      
      public function get spacing() : int
      {
         return var_2036;
      }
      
      public function set spacing(param1:int) : void
      {
         var_2036 = param1;
         updateSelectableRegion();
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         if(param2.type == "WE_CHILD_ADDED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_RESIZED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_RELOCATED")
         {
            updateSelectableRegion();
         }
         return super.update(param1,param2);
      }
      
      private function updateSelectableRegion() : void
      {
         var _loc4_:IWindow = null;
         var _loc3_:* = 0;
         if(var_3777)
         {
            return;
         }
         var_3777 = true;
         var _loc2_:uint = numSelectables;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = getSelectableAt(_loc3_);
            if(var_2786)
            {
               _loc4_.y = _loc1_;
               _loc1_ += _loc4_.height + var_2036;
            }
            else
            {
               _loc4_.x = _loc1_;
               _loc1_ += _loc4_.width + var_2036;
            }
            _loc3_++;
         }
         var_3777 = false;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",var_2036));
         _loc1_.push(createProperty("vertical",var_2786));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  if(_loc2_.value != var_2036)
                  {
                     spacing = _loc2_.value as int;
                  }
                  break;
               case "vertical":
                  if(_loc2_.value != var_2786)
                  {
                     vertical = _loc2_.value as Boolean;
                  }
                  break;
            }
         }
         super.properties = param1;
      }
      
      public function get vertical() : Boolean
      {
         return var_2786;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         var_2786 = param1;
         updateSelectableRegion();
      }
   }
}
