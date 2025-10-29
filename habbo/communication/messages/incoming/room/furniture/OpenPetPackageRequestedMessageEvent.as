package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1613

    [SecureSWF(rename="true")]
    public class OpenPetPackageRequestedMessageEvent extends MessageEvent implements IMessageEvent {

        public function OpenPetPackageRequestedMessageEvent(param1: Function) {
            super(param1, class_1613);
        }

        public function getParser(): class_1613 {
            return _parser as class_1613;
        }
    }
}
