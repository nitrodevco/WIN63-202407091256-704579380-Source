package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1682 implements IDisposable {

        public function class_1682(param1: IMessageDataWrapper) {
            super();
            var_560 = param1.readString();
            var_373 = param1.readInteger();
            var_451 = param1.readInteger();
        }
        private var var_560: String;
        private var var_373: int;
        private var var_451: int;
        private var var_318: Boolean = false;

        public function get disposed(): Boolean {
            return var_318;
        }

        public function get pattern(): String {
            return var_560;
        }

        public function get startIndex(): int {
            return var_373;
        }

        public function get endIndex(): int {
            return var_451;
        }

        public function dispose(): void {
            var_318 = true;
            var_560 = "";
            var_373 = -1;
            var_451 = -1;
        }
    }
}
