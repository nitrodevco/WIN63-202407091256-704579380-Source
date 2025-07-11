package com.sulake.habbo.communication.messages.outgoing.roomsettings {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class class_166 implements IMessageComposer, IDisposable {

        public static var var_1615: Boolean = true;

        public static var var_1610: Boolean = false;

        public function class_166(param1: int, param2: Boolean, param3: String) {
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2);
            var_20.push(param3);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
