package com.sulake.habbo.ui.widget.chooser
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.events.ChooserItem;
   
   public class ChooserView
   {
       
      
      private var var_1629:ChooserWidgetBase;
      
      private var var_617:String;
      
      private var _window:class_3514;
      
      private var _itemList:IItemListWindow;
      
      private var _items:Array;
      
      private var var_4206:Boolean;
      
      private var var_2038:int;
      
      private const COLOR_EVEN:uint = 4293848814;
      
      private const COLOR_ODD:uint = 0;
      
      private const COLOR_HILITE:uint = 4282169599;
      
      public function ChooserView(param1:ChooserWidgetBase, param2:String)
      {
         super();
         var_1629 = param1;
         var_617 = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      public function populate(param1:Array, param2:Boolean) : void
      {
         var _loc4_:ChooserItem = null;
         var _loc5_:IWindowContainer = null;
         var _loc6_:int = 0;
         var _loc7_:ITextWindow = null;
         if(var_1629 == null)
         {
            return;
         }
         if(_window == null)
         {
            createWindow();
         }
         if(_window == null || _itemList == null || param1 == null)
         {
            return;
         }
         _itemList.destroyListItems();
         var _loc3_:XmlAsset = XmlAsset(var_1629.assets.getAssetByName("chooser_item"));
         if(_loc3_ == null)
         {
            return;
         }
         _items = param1.slice();
         var_4206 = param2;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            if((_loc4_ = param1[_loc6_] as ChooserItem) != null)
            {
               if((_loc5_ = var_1629.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer) == null)
               {
                  return;
               }
               if((_loc7_ = _loc5_.findChildByName("itemtext") as ITextWindow) == null)
               {
                  return;
               }
               _loc5_.id = _loc6_;
               if(var_4206)
               {
                  _loc7_.text = _loc4_.name + " id: " + _loc4_.id;
               }
               else
               {
                  _loc7_.text = _loc4_.name;
               }
               _loc5_.color = !!(_loc6_ % 2) ? 0 : 4293848814;
               _loc5_.addEventListener("WME_CLICK",onListItemClicked);
               _itemList.addListItem(_loc5_);
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _itemList.numListItems)
         {
            if((_loc5_ = _itemList.getListItemAt(_loc6_) as IWindowContainer) != null)
            {
               _loc5_.width = _itemList.width;
            }
            _loc6_++;
         }
         var_2038 = -1;
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = XmlAsset(var_1629.assets.getAssetByName("chooser_view"));
         if(_loc1_ == null)
         {
            return;
         }
         _window = var_1629.windowManager.buildFromXML(_loc1_.content as XML) as class_3514;
         if(_window == null)
         {
            return;
         }
         _window.caption = var_617;
         _itemList = _window.findChildByName("item_list") as IItemListWindow;
         var _loc2_:IWindow = _window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onClose);
         }
         if(_window.parent != null)
         {
            _window.x = _window.parent.width - _window.width - 10;
            _window.y = 10;
         }
      }
      
      private function hideWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onListItemClicked(param1:WindowMouseEvent) : void
      {
         if(param1 == null || param1.window == null || _items == null)
         {
            return;
         }
         var _loc3_:int = param1.window.id;
         if(_loc3_ < 0 || _loc3_ > _items.length)
         {
            return;
         }
         var _loc2_:ChooserItem = _items[_loc3_] as ChooserItem;
         if(_loc2_ == null)
         {
            return;
         }
         var_1629.choose(_loc2_.id,_loc2_.category);
         highlightItem(_loc3_);
      }
      
      private function highlightItem(param1:int) : void
      {
         var _loc2_:IWindowContainer = null;
         if(_itemList == null || param1 < 0 || param1 > _itemList.numListItems || param1 == var_2038)
         {
            return;
         }
         if(var_2038 != -1)
         {
            _loc2_ = _itemList.getListItemAt(var_2038) as IWindowContainer;
            if(_loc2_ != null)
            {
               _loc2_.color = !!(var_2038 % 2) ? 0 : 4293848814;
            }
         }
         _loc2_ = _itemList.getListItemAt(param1) as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.color = 4282169599;
            var_2038 = param1;
         }
      }
      
      public function removeItem(param1:int, param2:int) : void
      {
         var _loc3_:ChooserItem = null;
         var _loc4_:int = 0;
         if(_items == null || _itemList == null)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_] as ChooserItem;
            if(_loc3_ != null)
            {
               if(_loc3_.id == param1 && _loc3_.category == param2)
               {
                  _items.splice(_loc4_,1);
                  break;
               }
            }
            _loc4_++;
         }
         populate(_items,var_4206);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hideWindow();
      }
   }
}
