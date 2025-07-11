package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_1708

    public class class_1409 implements IMessageParser {

        public function class_1409() {
            super();
        }
        private var var_305: Vector.<class_1708> = null;

        public function get errors(): Vector.<class_1708> {
            return var_305;
        }

        public function flush(): Boolean {
            var_305 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_305 = new Vector.<class_1708>();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_305.push(new class_1708(param1));
                _loc3_ += 1;
            }
            return true;
        }
    }
}
