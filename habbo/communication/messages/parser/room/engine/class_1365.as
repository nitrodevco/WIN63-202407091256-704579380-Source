package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.room.IStuffData
    import com.sulake.habbo.room.object.data.LegacyStuffData

    [SecureSWF(rename="true")]
    public class class_1365 implements IMessageParser {

        public function class_1365() {
            super();
        }
        private var var_280: int = 0;
        private var var_149: int = 0;
        private var var_47: IStuffData;

        public function get id(): int {
            return var_280;
        }

        public function get state(): int {
            return var_149;
        }

        public function get data(): IStuffData {
            return var_47;
        }

        public function flush(): Boolean {
            var_149 = 0;
            var_47 = new LegacyStuffData() as IStuffData;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var _loc3_: String = param1.readString();
            var_280 = int(_loc3_);
            var_47 = class_1642.parseStuffData(param1);
            var _loc2_: Number = parseFloat(var_47.getLegacyString());
            if (!isNaN(_loc2_)) {
                var_149 = int(var_47.getLegacyString());
            }
            return true;
        }
    }
}
