package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class ObjectIdAndValuePair {

        public function ObjectIdAndValuePair(param1: IMessageDataWrapper) {
            super();
            var_455 = param1.readInteger();
            _value = param1.readInteger();
        }
        private var var_455: int;

        private var _value: int;

        public function get value(): int {
            return _value;
        }

        public function get objectId(): int {
            return var_455;
        }
    }
}
