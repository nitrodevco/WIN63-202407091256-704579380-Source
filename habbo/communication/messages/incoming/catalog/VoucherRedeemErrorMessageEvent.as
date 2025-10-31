package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemErrorMessageEventParser

    [SecureSWF(rename="true")]
    public class VoucherRedeemErrorMessageEvent extends MessageEvent implements IMessageEvent {

        public function VoucherRedeemErrorMessageEvent(param1: Function) {
            super(param1, VoucherRedeemErrorMessageEventParser);
        }

        public function get errorCode(): String {
            return (_parser as VoucherRedeemErrorMessageEventParser).errorCode;
        }
    }
}
