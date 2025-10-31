package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_1765

    [SecureSWF(rename="true")]
    public class ObjectUpdateMessageEventParser implements IMessageParser {

        public function ObjectUpdateMessageEventParser() {
            super();
        }
        private var var_47: class_1765 = null;

        public function get data(): class_1765 {
            var _loc1_: class_1765 = var_47;
            if (_loc1_ != null) {
                _loc1_.setReadOnly();
            }
            return _loc1_;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_47 = class_1642.parseObjectData(param1);
            return true;
        }
    }
}
