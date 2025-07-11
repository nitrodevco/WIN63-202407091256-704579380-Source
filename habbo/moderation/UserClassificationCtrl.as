package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.userclassification.UserClassificationData;
   import com.sulake.habbo.util.VisitUserUtil;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UserClassificationCtrl implements IDisposable, ITrackedWindow
   {
      
      private static var CLASSIFICATION_ROW_POOL:Array = [];
      
      private static var CLASSIFICATION_ROW_POOL_MAX_SIZE:int = 200;
       
      
      private var _main:ModerationManager;
      
      private var _frame:class_3514;
      
      private var var_19:IItemListWindow;
      
      private var var_4207:int;
      
      private var var_4907:Array;
      
      private var _disposed:Boolean;
      
      private var var_2563:IWindowContainer;
      
      private var var_2303:Timer;
      
      private var var_3593:Array;
      
      public function UserClassificationCtrl(param1:ModerationManager, param2:int)
      {
         var_3593 = [];
         super();
         _main = param1;
         var_4207 = param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         var_2303 = new Timer(300,1);
         var_2303.addEventListener("timer",onResizeTimer);
         _main.messageHandler.addUserClassificationListener(this);
         _frame = class_3514(_main.getXmlWindow("userclassification_frame"));
         var_19 = IItemListWindow(_frame.findChildByName("userclassification_list"));
         var_2563 = var_19.getListItemAt(0) as IWindowContainer;
         var_19.removeListItems();
         _frame.procedure = onWindow;
         var _loc1_:IWindow = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
      }
      
      public function onUserClassification(param1:int, param2:Array) : void
      {
         if(param1 != var_4207)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         this.var_4907 = param2;
         _frame.caption = "";
         populate();
         onResizeTimer(null);
         _frame.visible = true;
         _main.messageHandler.removeUserClassificationListener(this);
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in var_4907)
         {
            populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      private function populateRoomRow(param1:UserClassificationData, param2:Boolean) : void
      {
         var _loc5_:IWindowContainer = getRoomRowWindow();
         var _loc3_:uint = param2 ? 4288861930 : 4294967295;
         _loc5_.color = _loc3_;
         var _loc6_:IWindow;
         (_loc6_ = _loc5_.findChildByName("user_name_txt")).caption = param1.username;
         _loc6_.color = _loc3_;
         var _loc4_:ITextWindow;
         (_loc4_ = ITextWindow(_loc5_.findChildByName("visit_room_txt"))).color = _loc3_;
         var _loc7_:ITextWindow;
         (_loc7_ = ITextWindow(_loc5_.findChildByName("user_classification_txt"))).text = param1.classType;
         if(!_main || !_main.isModerator)
         {
            _loc7_.visible = false;
            _loc4_.visible = false;
         }
         addClassificationRowToList(_loc5_,var_19);
         if(_main && _main.isModerator)
         {
            new OpenUserInfo(_frame,_main,_loc6_,param1.userId);
            new VisitUserUtil(_main,_loc4_,param1.userId);
         }
      }
      
      private function addClassificationRowToList(param1:IWindowContainer, param2:IItemListWindow) : void
      {
         param2.addListItem(param1);
         var_3593.push(param1);
      }
      
      private function getRoomRowWindow() : IWindowContainer
      {
         if(CLASSIFICATION_ROW_POOL.length > 0)
         {
            return CLASSIFICATION_ROW_POOL.pop() as IWindowContainer;
         }
         return IWindowContainer(var_2563.clone());
      }
      
      private function storeClassificationRowWindow(param1:IWindowContainer) : void
      {
         var _loc3_:IWindow = null;
         var _loc2_:IWindow = null;
         if(CLASSIFICATION_ROW_POOL.length < CLASSIFICATION_ROW_POOL_MAX_SIZE)
         {
            _loc3_ = param1.findChildByName("user_name_txt");
            _loc3_.procedure = null;
            _loc2_ = param1.findChildByName("visit_room_txt");
            _loc2_.procedure = null;
            param1.width = var_2563.width;
            param1.height = var_2563.height;
            CLASSIFICATION_ROW_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         if(!this.var_2303.running)
         {
            this.var_2303.reset();
            this.var_2303.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(var_19.parent);
         var _loc5_:IWindow = _loc3_.getChildByName("scroller") as IWindow;
         var _loc4_:* = var_19.scrollableRegion.height > var_19.height;
         var _loc2_:int = 17;
         if(_loc5_.visible)
         {
            if(!_loc4_)
            {
               _loc5_.visible = false;
               var_19.width += _loc2_;
            }
         }
         else if(_loc4_)
         {
            _loc5_.visible = true;
            var_19.width -= _loc2_;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_19 != null)
         {
            var_19.removeListItems();
            var_19.dispose();
            var_19 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _main = null;
         if(var_2303 != null)
         {
            var_2303.stop();
            var_2303.removeEventListener("timer",onResizeTimer);
            var_2303 = null;
         }
         for each(_loc1_ in var_3593)
         {
            storeClassificationRowWindow(_loc1_);
         }
         if(var_2563 != null)
         {
            var_2563.dispose();
            var_2563 = null;
         }
         var_3593 = [];
      }
      
      public function getType() : int
      {
         return 6;
      }
      
      public function getId() : String
      {
         return "" + var_4207;
      }
      
      public function getFrame() : class_3514
      {
         return _frame;
      }
   }
}
