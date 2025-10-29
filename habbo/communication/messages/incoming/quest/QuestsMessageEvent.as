package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1265

    [SecureSWF(rename="true")]
    public class QuestsMessageEvent extends MessageEvent implements IMessageEvent {

        public function QuestsMessageEvent(param1: Function) {
            super(param1, class_1265);
        }

        public function getParser(): class_1265 {
            return _parser as class_1265;
        }
    }
}
