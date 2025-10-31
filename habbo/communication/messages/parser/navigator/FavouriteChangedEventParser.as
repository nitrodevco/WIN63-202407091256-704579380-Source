package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class FavouriteChangedEventParser implements IMessageParser {

        public function FavouriteChangedEventParser() {
            super();
        }
        private var var_1567: Boolean;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        public function get added(): Boolean {
            return var_1567;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._flatId = param1.readInteger();
            this.var_1567 = param1.readBoolean();
            return true;
        }
    }
}
