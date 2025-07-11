package com.sulake.habbo.communication.messages.incoming.groupforums {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.groupforums.class_1481

    [SecureSWF(rename="true")]
    public class class_782 extends MessageEvent implements IMessageEvent {

        public function class_782(param1: Function) {
            super(param1, class_1481);
        }

        public function getParser(): class_1481 {
            return this._parser as class_1481;
        }
    }
}
