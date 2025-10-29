package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SetAreaHideDataComposer implements IMessageComposer {

        public function SetAreaHideDataComposer(param1: int, param2: int, param3: int, param4: int, param5: int, param6: Boolean, param7: Boolean, param8: Boolean) {
            super();
            var_603 = param1;
            var_797 = param2;
            var_1094 = param3;
            _width = param4;
            _length = param5;
            var_958 = param6;
            var_834 = param7;
            var_787 = param8;
        }
        private var var_603: int;
        private var var_797: int;
        private var var_1094: int;
        private var _width: int;
        private var _length: int;
        private var var_958: Boolean;
        private var var_834: Boolean;
        private var var_787: Boolean;

        public function getMessageArray(): Array {
            return [var_603, var_797, var_1094, _width, _length, var_958, var_834, var_787];
        }

        public function dispose(): void {
        }
    }
}
