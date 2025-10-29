package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1278

    [SecureSWF(rename="true")]
    public class CollectibleWalletAddressesMessageEvent extends MessageEvent implements IMessageEvent {

        public function CollectibleWalletAddressesMessageEvent(param1: Function) {
            super(param1, class_1278);
        }

        public function getParser(): class_1278 {
            return _parser as class_1278;
        }
    }
}
