package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import flash.geom.ColorTransform;
   
   public class PlayListEditorItemListView
   {
       
      
      private var var_2695:IItemListWindow;
      
      private var _items:Array;
      
      private var var_1629:PlayListEditorWidget;
      
      private var var_1741:PlayListEditorItem;
      
      private var var_2660:int = -1;
      
      private var var_3032:int = -1;
      
      public function PlayListEditorItemListView(param1:PlayListEditorWidget, param2:IItemListWindow)
      {
         super();
         var_2695 = param2;
         var_1629 = param1;
         var_1741 = null;
      }
      
      public function get selectedItemIndex() : int
      {
         return var_2660;
      }
      
      public function destroy() : void
      {
         if(var_2695 == null)
         {
            return;
         }
         var_2695.destroyListItems();
      }
      
      public function refresh(param1:Array, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc5_:ColorTransform = null;
         var _loc4_:PlayListEditorItem = null;
         if(var_2695 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var_3032 = -1;
         _items = [];
         var_2695.destroyListItems();
         for each(var _loc6_ in param1)
         {
            _loc3_ = String(_loc6_.name);
            _loc7_ = _loc6_.creator;
            _loc5_ = var_1629.getDiskColorTransformFromSongData(_loc6_.songData);
            (_loc4_ = new PlayListEditorItem(var_1629,_loc3_,_loc7_,_loc5_)).window.procedure = itemEventProc;
            _loc4_.removeButton.procedure = itemEventProc;
            var_2695.addListItem(_loc4_.window);
            _items.push(_loc4_);
         }
         setItemIndexPlaying(param2);
      }
      
      public function setItemIndexPlaying(param1:int) : void
      {
         var _loc2_:PlayListEditorItem = null;
         if(_items == null)
         {
            return;
         }
         if(param1 < 0)
         {
            for each(var _loc3_ in _items)
            {
               _loc3_.setIconState("PLEI_ICON_STATE_NORMAL");
            }
            return;
         }
         if(param1 >= _items.length)
         {
            return;
         }
         if(var_3032 >= 0 && var_3032 < _items.length)
         {
            _loc2_ = _items[var_3032] as PlayListEditorItem;
            _loc2_.setIconState("PLEI_ICON_STATE_NORMAL");
         }
         _loc2_ = _items[param1] as PlayListEditorItem;
         _loc2_.setIconState("PLEI_ICON_STATE_PLAYING");
         var_3032 = param1;
      }
      
      public function deselectAny() : void
      {
         if(var_1741 != null)
         {
            var_1741.deselect();
            var_1741 = null;
            var_2660 = -1;
         }
      }
      
      private function itemEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1.type == "WME_DOUBLE_CLICK";
         if(param1.type == "WME_CLICK" || _loc3_)
         {
            if(param2.name == "button_remove_from_playlist" || _loc3_)
            {
               if(var_1741 != null)
               {
                  var_1741.deselect();
               }
               if(var_2660 > -1)
               {
                  var_1629.sendRemoveFromPlayListMessage(var_2660);
               }
               var_1741 = null;
               var_2660 = -1;
            }
            else
            {
               if(var_1741 != null)
               {
                  var_1741.deselect();
               }
               if((_loc4_ = var_2695.getListItemIndex(param1.window)) != -1)
               {
                  var_2660 = _loc4_;
                  var_1741 = _items[_loc4_];
                  var_1741.select();
                  if(param2.name == "button_remove_from_playlist")
                  {
                     var_1629.sendRemoveFromPlayListMessage(_loc4_);
                  }
                  if(var_1629.mainWindowHandler != null)
                  {
                     var_1629.mainWindowHandler.musicInventoryView.deselectAny();
                  }
               }
            }
         }
      }
   }
}
