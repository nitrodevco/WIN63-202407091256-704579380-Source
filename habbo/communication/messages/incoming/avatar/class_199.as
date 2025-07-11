package com.sulake.habbo.communication.messages.incoming.avatar {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.avatar.class_1610

    [SecureSWF(rename="true")]
    public class class_199 extends MessageEvent implements IMessageEvent {

        public function class_199(param1: Function) {
            super(param1, class_1610);
        }

        public function get figure(): String {
            return (_parser as class_1610).figure;
        }

        public function get gender(): String {
            return (_parser as class_1610).gender;
        }

        private function getParser(): class_1610 {
            return this._parser as class_1610;
        }
    }
}
