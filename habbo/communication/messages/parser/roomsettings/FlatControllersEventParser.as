package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1734

    [SecureSWF(rename="true")]
    public class FlatControllersEventParser implements IMessageParser {

        public function FlatControllersEventParser() {
            super();
        }
        private var var_369: int;
        private var var_726: Array;

        public function get roomId(): int {
            return var_369;
        }

        public function get controllers(): Array {
            return var_726;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_369 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_726.push(new class_1734(param1));
                _loc2_++;
            }
            return true;
        }

        public function flush(): Boolean {
            var_726 = [];
            return true;
        }
    }
}
