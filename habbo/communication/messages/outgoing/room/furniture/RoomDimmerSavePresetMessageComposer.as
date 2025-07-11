package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class RoomDimmerSavePresetMessageComposer implements IMessageComposer {

        public function RoomDimmerSavePresetMessageComposer(param1: int, param2: int, param3: String, param4: int, param5: Boolean, param6: int) {
            super();
            _presetNumber = param1;
            var_1485 = param2;
            var_1063 = param3;
            var_1202 = param4;
            var_1012 = param5;
            var_455 = param6;
        }
        private var _presetNumber: int;
        private var var_1485: int;
        private var var_1063: String;
        private var var_1202: int;
        private var var_1012: Boolean;
        private var var_455: int;

        public function getMessageArray(): Array {
            return [_presetNumber, var_1485, var_1063, var_1202, var_1012, false, var_455];
        }

        public function dispose(): void {
        }
    }
}
