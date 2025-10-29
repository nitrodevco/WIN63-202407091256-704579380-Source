package com.sulake.habbo.communication.messages.outgoing.landingview {
    import com.sulake.core.communication.messages.IMessageComposer
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class GetPromoArticlesMessageComposer implements IMessageComposer, IDisposable {

        public function GetPromoArticlesMessageComposer() {
            super();
        }

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return [];
        }

        public function dispose(): void {
        }
    }
}
