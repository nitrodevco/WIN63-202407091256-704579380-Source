package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class SharedVariable {

        public function SharedVariable(param1: IMessageDataWrapper) {
            super();
            var_369 = param1.readInteger();
            _roomName = param1.readString();
            var_824 = new WiredVariable(param1);
        }
        private var var_824: WiredVariable;
        private var var_369: int;

        private var _roomName: String;

        public function get roomName(): String {
            return _roomName;
        }

        public function get wiredVariable(): WiredVariable {
            return var_824;
        }

        public function get roomId(): int {
            return var_369;
        }
    }
}
