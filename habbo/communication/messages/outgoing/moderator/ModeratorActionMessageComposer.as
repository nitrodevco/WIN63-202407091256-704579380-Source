package com.sulake.habbo.communication.messages.outgoing.moderator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class ModeratorActionMessageComposer implements IMessageComposer, IDisposable {

        public static const const_305: int = 0;

        public static const const_46: int = 1;

        public static const const_318: int = 3;

        public static const const_317: int = 4;

        public function ModeratorActionMessageComposer(param1: int, param2: String, param3: String) {
            var_20 = [];
            super();
            this.var_20.push(param1);
            this.var_20.push(param2);
            this.var_20.push(param3);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return this.var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
