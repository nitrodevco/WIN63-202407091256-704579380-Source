package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import flash.geom.Rectangle;
   
   public class TabContextController extends WindowController implements ITabContextWindow, IIterable
   {
      
      private static const TAG_TAB_CONTEXT_SELECTOR:String = "_SELECTOR";
      
      private static const TAG_TAB_CONTEXT_CONTENT:String = "_CONTENT";
       
      
      protected var var_3182:ISelectorListWindow;
      
      protected var var_4027:IWindowContainer;
      
      private var var_3777:Boolean = false;
      
      private var var_78:Boolean = false;
      
      public function TabContextController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var _loc12_:Array = [];
         groupChildrenWithTag("_INTERNAL",_loc12_,-1);
         for each(var _loc13_ in _loc12_)
         {
            _loc13_.style = _style;
            _loc13_.procedure = selectorEventProc;
         }
         var_78 = true;
      }
      
      public function get selector() : ISelectorListWindow
      {
         if(var_3182 == null)
         {
            var_3182 = findChildByTag("_SELECTOR") as ISelectorListWindow;
            if(var_3182 != null)
            {
               var_3182.procedure = selectorEventProc;
            }
         }
         return var_3182;
      }
      
      public function get container() : IWindowContainer
      {
         if(var_4027 == null)
         {
            var_4027 = findChildByTag("_CONTENT") as IWindowContainer;
         }
         return var_4027;
      }
      
      public function get iterator() : IIterator
      {
         return var_78 ? selector.iterator : null;
      }
      
      public function get numTabItems() : uint
      {
         return var_3182.numSelectables;
      }
      
      public function addTabItem(param1:ITabButtonWindow) : ITabButtonWindow
      {
         return selector.addSelectable(param1) as ITabButtonWindow;
      }
      
      public function addTabItemAt(param1:ITabButtonWindow, param2:uint) : ITabButtonWindow
      {
         return selector.addSelectableAt(param1,param2) as ITabButtonWindow;
      }
      
      public function removeTabItem(param1:ITabButtonWindow) : void
      {
         selector.removeSelectable(param1);
      }
      
      public function getTabItemAt(param1:uint) : ITabButtonWindow
      {
         return selector.getSelectableAt(param1) as ITabButtonWindow;
      }
      
      public function getTabItemByName(param1:String) : ITabButtonWindow
      {
         return selector.getSelectableByName(param1) as ITabButtonWindow;
      }
      
      public function getTabItemByID(param1:uint) : ITabButtonWindow
      {
         return selector.getSelectableByID(param1) as ITabButtonWindow;
      }
      
      public function getTabItemIndex(param1:ITabButtonWindow) : uint
      {
         return selector.getSelectableIndex(param1);
      }
      
      private function selectorEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_SELECTED")
         {
            notifyEventListeners(param1);
         }
      }
   }
}
