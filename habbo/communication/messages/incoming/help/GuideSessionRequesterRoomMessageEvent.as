package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1603

    [SecureSWF(rename="true")]
    public class GuideSessionRequesterRoomMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuideSessionRequesterRoomMessageEvent(param1: Function) {
            super(param1, class_1603);
        }

        public function getParser(): class_1603 {
            return _parser as class_1603;
        }
    }
}
