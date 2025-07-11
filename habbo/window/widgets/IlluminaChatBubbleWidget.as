package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   
   public class IlluminaChatBubbleWidget implements IIlluminaChatBubbleWidget
   {
      
      public static const TYPE:String = "illumina_chat_bubble";
      
      private static const const_968:String = "illumina_chat_bubble:flipped";
      
      private static const USER_NAME_KEY:String = "illumina_chat_bubble:user_name";
      
      private static const FIGURE_KEY:String = "illumina_chat_bubble:figure";
      
      private static const MESSAGE_KEY:String = "illumina_chat_bubble:message";
      
      private static const FLIPPED_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:flipped",false,"Boolean");
      
      private static const USER_NAME_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:user_name","","String");
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:figure","","String");
      
      private static const MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:message","","String");
      
      private static var RESIZING_OFFSETS:int = 10;
       
      
      private var var_4012:ITextWindow;
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var var_3159:Boolean;
      
      private var _userName:ILabelWindow;
      
      private var var_2656:IWindow;
      
      private var _avatarWidget:IAvatarImageWidget;
      
      private var var_2425:IWindow;
      
      private var _postTime:class_3614;
      
      private var _offline:IRegionWindow;
      
      private var _arrowPoint:IStaticBitmapWrapperWindow;
      
      private var var_3089:Boolean;
      
      private var var_1976:IItemListWindow;
      
      private var var_4265:IItemListWindow;
      
      private var var_2933:Array;
      
      private var var_4626:int = 0;
      
      public function IlluminaChatBubbleWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_3159 = Boolean(FLIPPED_DEFAULT.value);
         var_2933 = [];
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_chat_bubble_xml").content as XML) as IWindowContainer;
         var_1976 = var_509.findChildByName("message_container") as IItemListWindow;
         var_4012 = var_1976.getListItemByName("message_template") as ITextWindow;
         var_1976.removeListItem(var_4012);
         var_4265 = var_509.findChildByName("spaced_message_container") as IItemListWindow;
         _userName = var_509.findChildByName("user_name") as ILabelWindow;
         var _loc3_:IWidgetWindow = var_509.findChildByName("user_avatar") as IWidgetWindow;
         var_2656 = _loc3_.parent;
         _avatarWidget = _loc3_.widget as IAvatarImageWidget;
         var_2425 = var_509.findChildByName("bubble_wrapper");
         _postTime = IWidgetWindow(var_509.findChildByName("post_time")).widget as class_3614;
         _offline = var_509.findChildByName("offline_placeholder") as IRegionWindow;
         _offline.height = 0;
         _arrowPoint = var_509.findChildByName("arrow_point") as IStaticBitmapWrapperWindow;
         var_509.findChildByName("message_region").setParamFlag(1,false);
         var_509.procedure = rootProcedure;
         userName = String(USER_NAME_DEFAULT.value);
         figure = String(FIGURE_DEFAULT.value);
         setMessages(getMessagesFromProperty(String(MESSAGE_DEFAULT.value)));
         var_1759.rootWindow = var_509;
         var_1759.setParamFlag(147456);
         var_509.width = var_1759.width;
      }
      
      public static function getMessagesFromProperty(param1:String) : Array
      {
         var _loc2_:Array = param1.split("\t");
         if(_loc2_.length == 1 && _loc2_[0] == "")
         {
            return [];
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
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
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(FLIPPED_DEFAULT.withValue(flipped));
         _loc1_.push(USER_NAME_DEFAULT.withValue(userName));
         _loc1_.push(FIGURE_DEFAULT.withValue(figure));
         _loc1_.push(MESSAGE_DEFAULT.withValue(getMessages().join("\t")));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_chat_bubble:flipped":
                  flipped = Boolean(_loc2_.value);
                  break;
               case "illumina_chat_bubble:user_name":
                  userName = String(_loc2_.value);
                  break;
               case "illumina_chat_bubble:figure":
                  figure = String(_loc2_.value);
                  break;
               case "illumina_chat_bubble:message":
                  setMessages(getMessagesFromProperty(String(_loc2_.value)));
                  break;
            }
         }
      }
      
      public function get flipped() : Boolean
      {
         return var_3159;
      }
      
      public function set flipped(param1:Boolean) : void
      {
         var_3159 = param1;
         refresh();
      }
      
      public function get userName() : String
      {
         return _userName.caption.slice(0,-1);
      }
      
      public function set userName(param1:String) : void
      {
         _userName.caption = param1 + ":";
      }
      
      public function get userId() : int
      {
         return _avatarWidget.userId;
      }
      
      public function set userId(param1:int) : void
      {
         _avatarWidget.userId = param1;
      }
      
      public function get figure() : String
      {
         return _avatarWidget.figure;
      }
      
      public function set figure(param1:String) : void
      {
         _avatarWidget.figure = param1;
      }
      
      public function get timeStamp() : Number
      {
         return _postTime.timeStamp;
      }
      
      public function set timeStamp(param1:Number) : void
      {
         _postTime.timeStamp = param1;
      }
      
      public function set friendOnlineStatus(param1:Boolean) : void
      {
         _offline.height = !param1 ? 16 : 0;
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc3_:ITextWindow = null;
         if(var_3089)
         {
            return;
         }
         var_3089 = true;
         var_509.limits.minWidth = var_509.width;
         var_509.limits.maxWidth = var_509.width;
         var_509.height = var_2425.bottom;
         var_2425.width = var_509.width - var_2656.width;
         var _loc2_:int = var_2425.width / RESIZING_OFFSETS;
         if(_loc2_ != var_4626)
         {
            _loc1_ = 0;
            while(_loc1_ < var_1976.numListItems)
            {
               _loc3_ = var_1976.getListItemAt(_loc1_) as ITextWindow;
               _loc3_.width = var_2425.width - 5;
               _loc1_ += 1;
            }
            var_4626 = _loc2_;
         }
         var_1976.width = var_2425.width;
         var_4265.width = var_2425.width;
         _avatarWidget.direction = var_3159 ? 4 : 2;
         if(var_3159)
         {
            var_2656.x = var_509.width - var_2656.width;
            _arrowPoint.zoomX = 1;
            _arrowPoint.x = var_2656.x;
            var_2425.x = 0;
         }
         else
         {
            var_2656.x = 0;
            _arrowPoint.zoomX = -1;
            _arrowPoint.x = var_2656.right - _arrowPoint.width;
            var_2425.x = var_2656.right;
         }
         var_509.limits.setEmpty();
         _arrowPoint.invalidate();
         var_3089 = false;
      }
      
      private function rootProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param1.type)
         {
            case "WE_RESIZED":
               refresh();
               break;
            case "WE_CHILD_RESIZED":
               refresh();
               break;
            case "WME_CLICK":
               if(userId > 0 && param2.name == "user_name_region")
               {
                  _windowManager.communication.connection.send(new class_322(userId));
               }
         }
      }
      
      public function get numMessages() : int
      {
         return var_1976.numListItems;
      }
      
      public function getMessage(param1:int) : String
      {
         return var_1976.getListItemAt(param1).caption;
      }
      
      public function setMessage(param1:int, param2:String) : void
      {
         while(param1 >= numMessages)
         {
            var_1976.addListItem(createMessage());
            var_2933.push(0);
         }
         var_1976.getListItemAt(param1).caption = param2;
      }
      
      public function appendMessage(param1:String, param2:Boolean = false, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         if(param2)
         {
            _loc4_ = 0;
            var_1976.addListItemAt(createMessage(),0);
            var_2933.splice(_loc4_,0,0);
         }
         else
         {
            _loc4_ = numMessages;
         }
         setMessage(_loc4_,param1);
         setAwaitingConfirmationId(_loc4_,param3);
      }
      
      private function setMessages(param1:Array) : void
      {
         var_1976.removeListItems();
         var_2933.length = 0;
         for each(var _loc2_ in param1)
         {
            appendMessage(_loc2_);
         }
      }
      
      public function getMessages() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < numMessages)
         {
            _loc1_.push(getMessage(_loc2_));
            _loc2_ += 1;
         }
         return _loc1_;
      }
      
      public function setAwaitingConfirmationId(param1:int, param2:int) : void
      {
         var _loc3_:ITextWindow = var_1976.getListItemAt(param1) as ITextWindow;
         _loc3_.textColor = param2 > 0 ? 9079434 : 0;
         var_2933[param1] = param2;
      }
      
      public function clearAwaitingConfirmationId(param1:int) : void
      {
         var _loc2_:ITextWindow = var_1976.getListItemAt(param1) as ITextWindow;
         _loc2_.textColor = 0;
         var_2933[param1] = 0;
      }
      
      public function getAwaitingConfirmationId(param1:int) : int
      {
         return var_2933[param1];
      }
      
      private function createMessage() : ITextWindow
      {
         return var_4012.clone() as ITextWindow;
      }
   }
}
