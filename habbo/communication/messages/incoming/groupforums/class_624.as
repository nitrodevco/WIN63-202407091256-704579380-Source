package com.sulake.habbo.communication.messages.incoming.groupforums {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.groupforums.class_1237

    [SecureSWF(rename="true")]
    public class class_624 extends MessageEvent implements IMessageEvent {

        public function class_624(param1: Function) {
            super(param1, class_1237);
        }

        public function getParser(): class_1237 {
            return this._parser as class_1237;
        }
    }
}
