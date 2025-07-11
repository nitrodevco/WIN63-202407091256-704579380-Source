package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1653
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1663
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1691

    [SecureSWF(rename="true")]
    public class class_1368 implements IMessageParser {

        public function class_1368() {
            super();
        }
        private var var_47: class_1663;
        private var var_1370: class_1653;

        private var _promotedRooms: class_1691;

        public function get promotedRooms(): class_1691 {
            return _promotedRooms;
        }

        public function get data(): class_1663 {
            return var_47;
        }

        public function get adRoom(): class_1653 {
            return var_1370;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1663(param1);
            var _loc2_: int = param1.readInteger();
            if (_loc2_ > 0) {
                var_1370 = new class_1653(param1);
            }
            _promotedRooms = new class_1691(param1);
            return true;
        }
    }
}
