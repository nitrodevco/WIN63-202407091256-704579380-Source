package com.sulake.habbo.communication.messages.incoming.avatar {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.avatar.class_1450

    [SecureSWF(rename="true")]
    public class class_332 extends MessageEvent implements IMessageEvent {

        public static const const_264: int = 0;

        public static const const_389: int = 1;

        public function class_332(param1: Function) {
            super(param1, class_1450);
        }

        public function get outfits(): Array {
            return getParser().outfits;
        }

        public function get state(): int {
            return getParser().state;
        }

        private function getParser(): class_1450 {
            return this._parser as class_1450;
        }
    }
}
