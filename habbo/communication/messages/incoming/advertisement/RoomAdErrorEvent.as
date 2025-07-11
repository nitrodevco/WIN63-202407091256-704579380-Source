package com.sulake.habbo.communication.messages.incoming.advertisement {
   import com.sulake.core.communication.messages.IMessageEvent
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.advertisement.class_1118

   [SecureSWF(rename="true")]
    public class RoomAdErrorEvent extends MessageEvent implements IMessageEvent {

        public function RoomAdErrorEvent(param1: Function) {
            super(param1, class_1118);
        }

        public function getParser(): class_1118 {
            return this._parser as class_1118;
        }
    }
}
