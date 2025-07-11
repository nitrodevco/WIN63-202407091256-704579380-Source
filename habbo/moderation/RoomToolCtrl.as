package com.sulake.habbo.moderation
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1749;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1769;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_672;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_734;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_824;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_912;
   
   public class RoomToolCtrl implements IDisposable, ITrackedWindow
   {
       
      
      private var _main:ModerationManager;
      
      private var _flatId:int;
      
      private var var_47:class_1749;
      
      private var _frame:class_3514;
      
      private var var_19:IItemListWindow;
      
      private var _disposed:Boolean;
      
      private var _msgSelect:class_3520;
      
      private var var_2195:ITextFieldWindow;
      
      private var _includeInfo:Boolean = true;
      
      private var var_2936:class_3398;
      
      private var var_3350:class_3398;
      
      private var var_3374:class_3398;
      
      private var var_4231:IWindowContainer;
      
      public function RoomToolCtrl(param1:ModerationManager, param2:int)
      {
         super();
         _main = param1;
         _flatId = param2;
      }
      
      public static function getLowestPoint(param1:IWindowContainer) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindow = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if((_loc4_ = param1.getChildAt(_loc2_)).visible)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function moveChildrenToColumn(param1:IWindowContainer, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IWindow = null;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            if((_loc5_ = param1.getChildAt(_loc4_)) != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_3514(_main.getXmlWindow("roomtool_frame"));
         var _loc1_:IItemListWindow = _frame.findChildByName("list_cont") as IItemListWindow;
         var _loc2_:IWindowContainer = _loc1_.getListItemByName("room_cont") as IWindowContainer;
         var_4231 = _loc2_.findChildByName("room_data") as IWindowContainer;
         _loc2_.removeChild(var_4231);
         _main.messageHandler.addRoomInfoListener(this);
         _main.connection.send(new class_672(_flatId));
         class_14.log("BEGINNING TO SHOW: " + _flatId);
      }
      
      public function getType() : int
      {
         return 9;
      }
      
      public function getId() : String
      {
         return "" + _flatId;
      }
      
      public function getFrame() : class_3514
      {
         return _frame;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main.messageHandler.removeRoomEnterListener(this);
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         if(var_47 != null)
         {
            var_47.dispose();
            var_47 = null;
         }
         _main = null;
         var_19 = null;
         _msgSelect = null;
         var_2195 = null;
         var_2936 = null;
         var_3350 = null;
         var_3374 = null;
      }
      
      public function onRoomChange() : void
      {
         setSendButtonState("send_caution_but");
         setSendButtonState("send_message_but");
      }
      
      private function setSendButtonState(param1:String) : void
      {
         var _loc3_:Boolean = var_47 != null && var_47.flatId == _main.currentFlatId;
         var _loc2_:class_3357 = class_3357(_frame.findChildByName(param1));
         if(_loc3_ && _main.initMsg.roomAlertPermission)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      public function onRoomInfo(param1:class_1749) : void
      {
         if(_disposed)
         {
            return;
         }
         class_14.log("GOT ROOM INFO: " + param1.flatId + ", " + _flatId);
         if(param1.flatId != _flatId)
         {
            class_14.log("NOT THE SAME FLAT: " + param1.flatId + ", " + _flatId);
            return;
         }
         var_47 = param1;
         populate();
         _main.messageHandler.removeRoomInfoListener(this);
         _frame.visible = true;
         _main.messageHandler.addRoomEnterListener(this);
      }
      
      public function populate() : void
      {
         var_19 = IItemListWindow(_frame.findChildByName("list_cont"));
         var _loc1_:IWindow = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_2195 = ITextFieldWindow(_frame.findChildByName("message_input"));
         var_2195.procedure = onInputClick;
         _msgSelect = class_3520(_frame.findChildByName("msgTemplatesSelect"));
         prepareMsgSelect(_msgSelect);
         _msgSelect.procedure = onSelectTemplate;
         var_2936 = class_3398(_frame.findChildByName("kick_check"));
         var_3350 = class_3398(_frame.findChildByName("lock_check"));
         var_3374 = class_3398(_frame.findChildByName("changename_check"));
         refreshRoomData(var_47.room,"room_cont");
         setTxt("owner_name_txt",var_47.ownerName);
         setTxt("owner_in_room_txt",var_47.ownerInRoom ? "Yes" : "No");
         setTxt("user_count_txt","" + var_47.userCount);
         _frame.findChildByName("enter_room_but").procedure = onEnterRoom;
         _frame.findChildByName("chatlog_but").procedure = onChatlog;
         _frame.findChildByName("edit_in_hk_but").procedure = onEditInHk;
         _frame.findChildByName("send_caution_but").procedure = onSendCaution;
         _frame.findChildByName("send_message_but").procedure = onSendMessage;
         _main.initMsg.chatlogsPermission ? null : _frame.findChildByName("chatlog_but").disable();
         if(!_main.initMsg.roomKickPermission)
         {
            var_2936.disable();
         }
         _frame.findChildByName("owner_name_txt").procedure = onOwnerName;
         this.onRoomChange();
      }
      
      private function disposeItemFromList(param1:IItemListWindow, param2:IWindow) : void
      {
         var _loc3_:IWindow = param1.removeListItem(param2);
         if(_loc3_ != null)
         {
            _loc3_.dispose();
         }
      }
      
      private function refreshRoomData(param1:class_1769, param2:String) : void
      {
         var _loc6_:IWindowContainer = IWindowContainer(var_19.getListItemByName(param2));
         var _loc7_:IWindowContainer;
         if((_loc7_ = IWindowContainer(_loc6_.findChildByName("room_data"))) == null)
         {
            _loc7_ = _loc6_.addChild(var_4231.clone()) as IWindowContainer;
         }
         if(!param1.exists)
         {
            disposeItemFromList(var_19,_loc6_);
            disposeItemFromList(var_19,var_19.getListItemByName("event_spacing"));
            return;
         }
         var _loc4_:ITextWindow;
         (_loc4_ = ITextWindow(_loc7_.findChildByName("name"))).caption = param1.name;
         _loc4_.height = _loc4_.textHeight + 5;
         var _loc3_:ITextWindow = ITextWindow(_loc7_.findChildByName("desc"));
         _loc3_.caption = param1.desc;
         _loc3_.height = _loc3_.textHeight + 5;
         var _loc5_:IWindowContainer = IWindowContainer(_loc7_.findChildByName("tags_cont"));
         var _loc8_:ITextWindow;
         (_loc8_ = ITextWindow(_loc5_.findChildByName("tags_txt"))).caption = getTagsAsString(param1.tags);
         _loc8_.height = _loc8_.textHeight + 5;
         _loc5_.height = _loc8_.height;
         if(param1.tags.length < 1)
         {
            _loc7_.removeChild(_loc5_);
         }
         moveChildrenToColumn(_loc7_,_loc4_.y,0);
         _loc7_.height = getLowestPoint(_loc7_);
         _loc6_.height = _loc7_.height + 2 * _loc7_.y;
         class_14.log("XXXX: " + _loc6_.height + ", " + _loc7_.height + ", " + _loc4_.height + ", " + _loc3_.height + ", " + _loc5_.height + ", " + _loc8_.height);
      }
      
      private function getTagsAsString(param1:Array) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = "";
         for each(_loc3_ in param1)
         {
            if(_loc2_ == "")
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc2_ + ", " + _loc3_;
            }
         }
         return _loc2_;
      }
      
      private function setTxt(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_frame.findChildByName(param1));
         _loc3_.text = param2;
      }
      
      private function onOwnerName(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,var_47.ownerId),_frame,false,false,true);
      }
      
      private function onEnterRoom(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_14.log("Enter room clicked");
         _main.goToRoom(var_47.flatId);
      }
      
      private function onChatlog(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new ChatlogCtrl(new class_734(0,var_47.flatId),_main,4,var_47.flatId),_frame,false,false,true);
      }
      
      private function onEditInHk(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_14.log("Edit in hk clicked");
         _main.openHkPage("roomadmin.url","" + var_47.flatId);
      }
      
      private function onSendCaution(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_14.log("Sending caution...");
         act(true);
      }
      
      private function onSendMessage(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_14.log("Sending message...");
         act(false);
      }
      
      private function act(param1:Boolean) : void
      {
         if(_includeInfo || var_2195.text == "")
         {
            _main.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         var _loc2_:int = determineAction(param1,var_2936.isSelected);
         _main.connection.send(new class_824(_loc2_,var_2195.text,""));
         if(var_3350.isSelected || Boolean(var_3374.isSelected) || Boolean(var_2936.isSelected))
         {
            _main.connection.send(new class_912(var_47.flatId,var_3350.isSelected,var_3374.isSelected,var_2936.isSelected));
         }
         this.dispose();
      }
      
      private function determineAction(param1:Boolean, param2:Boolean) : int
      {
         if(param2)
         {
            return param1 ? 1 : 4;
         }
         return param1 ? 0 : 3;
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(!_includeInfo)
         {
            return;
         }
         var_2195.text = "";
         _includeInfo = false;
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function prepareMsgSelect(param1:class_3520) : void
      {
         class_14.log("MSG TEMPLATES: " + _main.initMsg.roomMessageTemplates.length);
         param1.populate(_main.initMsg.roomMessageTemplates);
      }
      
      private function onSelectTemplate(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc3_:String = String(_main.initMsg.roomMessageTemplates[_msgSelect.selection]);
         if(_loc3_ != null)
         {
            _includeInfo = false;
            var_2195.text = _loc3_;
         }
      }
   }
}
