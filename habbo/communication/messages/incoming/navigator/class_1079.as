package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1180

    [SecureSWF(rename="true")]
    public class class_1079 extends MessageEvent {

        public function class_1079(param1: Function) {
            super(param1, class_1180);
        }

        public function get globalId(): String {
            return (this._parser as class_1180).globalId;
        }

        public function get convertedId(): int {
            return (this._parser as class_1180).convertedId;
        }

        public function getParser(): class_1180 {
            return _parser as class_1180;
        }
    }
}
