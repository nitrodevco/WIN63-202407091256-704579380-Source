package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1233

    [SecureSWF(rename="true")]
    public class NftTransferFeeMessageEvent extends MessageEvent implements IMessageEvent {

        public function NftTransferFeeMessageEvent(param1: Function) {
            super(param1, class_1233);
        }

        public function getParser(): class_1233 {
            return _parser as class_1233;
        }
    }
}
