package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1139

    [SecureSWF(rename="true")]
    public class class_931 extends MessageEvent implements IMessageEvent {

        public function class_931(param1: Function) {
            super(param1, class_1139);
        }

        public function getParser(): class_1139 {
            return this._parser as class_1139;
        }
    }
}
