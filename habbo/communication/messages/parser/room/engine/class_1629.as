package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_1710

    [SecureSWF(rename="true")]
    public class class_1629 implements IMessageParser {

        public function class_1629() {
            super();
        }
        private var var_325: class_1710 = null;

        public function get data(): class_1710 {
            var _loc1_: class_1710 = var_325;
            if (_loc1_ != null) {
                _loc1_.setReadOnly();
            }
            return _loc1_;
        }

        public function flush(): Boolean {
            var_325 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_325 = class_1750.parseItemData(param1);
            var_325.ownerName = param1.readString();
            return true;
        }
    }
}
