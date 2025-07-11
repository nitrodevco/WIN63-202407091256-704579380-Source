package com.sulake.habbo.communication.messages.parser.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1695

    [SecureSWF(rename="true")]
    public class class_1530 implements IMessageParser {

        public function class_1530() {
            super();
        }

        private var _liftedRooms: Vector.<class_1695>;

        public function get liftedRooms(): Vector.<class_1695> {
            return _liftedRooms;
        }

        public function flush(): Boolean {
            _liftedRooms = new Vector.<class_1695>();
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _liftedRooms.push(new class_1695(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
