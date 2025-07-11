package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1235

    [SecureSWF(rename="true")]
    public class class_936 extends MessageEvent implements IMessageEvent {

        public function class_936(param1: Function) {
            super(param1, class_1235);
        }

        public function getParser(): class_1235 {
            return this._parser as class_1235;
        }
    }
}
