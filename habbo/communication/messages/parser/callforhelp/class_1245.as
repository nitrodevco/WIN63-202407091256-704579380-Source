package com.sulake.habbo.communication.messages.parser.callforhelp {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1746

    [SecureSWF(rename="true")]
    public class class_1245 implements IMessageParser {

        public function class_1245() {
            super();
        }
        private var var_217: Vector.<class_1746>;
        private var _disposed: Boolean;

        public function get callForHelpCategories(): Vector.<class_1746> {
            return var_217;
        }

        public function flush(): Boolean {
            if (_disposed) {
                return true;
            }
            _disposed = true;
            for each(var _loc1_ in var_217) {
                _loc1_.dispose();
            }
            var_217 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_217 = new Vector.<class_1746>();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_217.push(new class_1746(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
