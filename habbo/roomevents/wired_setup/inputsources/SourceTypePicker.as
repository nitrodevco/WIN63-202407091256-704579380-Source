package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_3463;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class SourceTypePicker
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _container:IWindowContainer;
      
      private var var_2365:IWindowContainer;
      
      private var var_85:class_3599;
      
      private var var_752:Map;
      
      private var var_1905:SourceTypeOption;
      
      private var var_3407:IRegionWindow;
      
      private var var_3555:SourceTypeOption = null;
      
      private var var_3962:SourceTypeOption = null;
      
      private var _disposed:Boolean = false;
      
      public function SourceTypePicker(param1:HabboUserDefinedRoomEvents, param2:IWindowContainer, param3:class_3599)
      {
         var_752 = new Map();
         super();
         _roomEvents = param1;
         _container = param2;
         var_2365 = IWindowContainer(_container.findChildByName("moveable_container"));
         var_85 = param3;
         var_3407 = sourceOptionsList.getListItemAt(0) as IRegionWindow;
         sourceOptionsList.removeListItems();
      }
      
      public function setOptions(param1:Array, param2:int) : void
      {
         var _loc5_:SourceTypeOption = null;
         if(var_1905 != null)
         {
            var_1905.deactivate();
            var_1905 = null;
         }
         var_3555 = null;
         var_3962 = null;
         marginLeft.color = 4280427042;
         marginRight.color = 4280427042;
         var _loc3_:IItemListWindow = sourceOptionsList;
         _loc3_.removeListItems();
         for each(var _loc4_ in param1)
         {
            if(!var_752.hasKey(_loc4_))
            {
               _loc5_ = new SourceTypeOption(this,var_3407.clone() as IRegionWindow,_loc4_);
               var_752.add(_loc4_,_loc5_);
            }
            else
            {
               _loc5_ = var_752.getValue(_loc4_);
            }
            if(var_3555 == null)
            {
               var_3555 = _loc5_;
            }
            var_3962 = _loc5_;
            _loc3_.addListItem(_loc5_.container);
            if(_loc4_ == param2)
            {
               var_1905 = _loc5_;
            }
         }
         if(var_1905 != null)
         {
            var_1905.activate();
         }
         else if(param1.length > 0)
         {
            onClick(var_752.getValue(param1[0]));
         }
      }
      
      internal function colorHasUpdated(param1:SourceTypeOption) : void
      {
         if(param1 == var_3555)
         {
            marginLeft.color = 4278190080 | param1.backgroundColor();
         }
         if(param1 == var_3962)
         {
            marginRight.color = 4278190080 | param1.backgroundColor();
         }
      }
      
      public function set disabled(param1:Boolean) : void
      {
         var _loc2_:Number = param1 ? 0.5 : 1;
         marginLeft.blend = _loc2_;
         marginRight.blend = _loc2_;
         for each(var _loc3_ in var_752)
         {
            _loc3_.disabled = param1;
         }
      }
      
      internal function onClick(param1:SourceTypeOption) : void
      {
         if(param1 == var_1905)
         {
            return;
         }
         if(var_1905 != null)
         {
            var_1905.deactivate();
            var_1905 = null;
         }
         if(param1 != null)
         {
            var_1905 = param1;
            var_1905.activate();
            var_85.sourceType = var_1905.option;
         }
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_3407.dispose();
         var_3407 = null;
         var_752.dispose();
         var_752 = null;
         for each(var _loc1_ in var_752.getValues())
         {
            _loc1_.dispose();
         }
      }
      
      public function restoreLayout() : void
      {
         IWindowContainer(var_2365.parent).removeChild(var_2365);
         _container.addChild(var_2365);
      }
      
      public function moveLayoutTo(param1:IWindowContainer) : *
      {
         IWindowContainer(_container).removeChild(var_2365);
         param1.addChild(var_2365);
      }
      
      public function get moveableContainer() : IWindowContainer
      {
         return var_2365;
      }
      
      private function get marginLeft() : class_3463
      {
         return class_3463(var_2365.findChildByName("margin_item_color_left"));
      }
      
      private function get marginRight() : class_3463
      {
         return class_3463(var_2365.findChildByName("margin_item_color_right"));
      }
      
      private function get sourceOptionsList() : IItemListWindow
      {
         return IItemListWindow(var_2365.findChildByName("source_options_list"));
      }
   }
}
