package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1673 implements IDisposable {

        public function class_1673(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var_247 = [];
            super();
            var_891 = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_247.push(new class_1773(param1));
                _loc3_++;
            }
        }
        private var var_891: String;
        private var var_247: Array;

        public function get disposed(): Boolean {
            return var_247 == null;
        }

        public function get hof(): Array {
            return var_247;
        }

        public function get goalCode(): String {
            return var_891;
        }

        public function dispose(): void {
            var_247 = null;
        }
    }
}
