package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class CreateGuildMessageComposer implements IMessageComposer {

        public function CreateGuildMessageComposer(param1: String, param2: String, param3: int, param4: int, param5: int, param6: Array) {
            var _loc7_: int = 0;
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
            var_47.push(param4);
            var_47.push(param5);
            var_47.push(param6.length);
            _loc7_ = 0;
            while (_loc7_ < param6.length) {
                var_47.push(int(param6[_loc7_]));
                _loc7_++;
            }
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
