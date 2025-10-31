package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.UniqueMachineIDEventParser

    [SecureSWF(rename="true")]
    public class UniqueMachineIDEvent extends MessageEvent implements IMessageEvent {

        public function UniqueMachineIDEvent(param1: Function) {
            super(param1, UniqueMachineIDEventParser);
        }

        public function get machineID(): String {
            return getParser().machineID;
        }

        private function getParser(): UniqueMachineIDEventParser {
            return this._parser as UniqueMachineIDEventParser;
        }
    }
}
