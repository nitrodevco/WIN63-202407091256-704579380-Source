package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PlaceObjectMessageComposer implements IMessageComposer {

        public function PlaceObjectMessageComposer(param1: int, param2: int, param3: String, param4: int, param5: int, param6: int) {
            super();
            var_455 = param1;
            var_1114 = param2;
            var_1126 = param3;
            var_31 = param4;
            var_28 = param5;
            var_643 = param6;
        }
        private var var_455: int;
        private var var_1114: int;
        private var var_1126: String;
        private var var_31: int = 0;
        private var var_28: int = 0;
        private var var_643: int = 0;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            switch (var_1114 - 10) {
                case 0:
                    return [var_455 + " " + var_31 + " " + var_28 + " " + var_643];
                case 10:
                    return [var_455 + " " + var_1126];
                default:
                    return [];
            }
        }
    }
}
