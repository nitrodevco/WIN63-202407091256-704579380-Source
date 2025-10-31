package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.room.engine.AreaHideMessageData

    [SecureSWF(rename="true")]
    public class AreaHideMessageEventParser implements IMessageParser {

        public function AreaHideMessageEventParser() {
            super();
        }
        private var var_387: AreaHideMessageData;

        public function get areaHideMessageData(): AreaHideMessageData {
            return var_387;
        }

        public function flush(): Boolean {
            var_387 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_387 = new AreaHideMessageData(param1);
            return true;
        }
    }
}
