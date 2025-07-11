package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameStatusData

    [SecureSWF(rename="true")]
    public class class_1554 implements IMessageParser {

        public function class_1554() {
            super();
        }

        private var _status: GameStatusData;

        public function get status(): GameStatusData {
            return _status;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _status = new GameStatusData(param1);
            return true;
        }
    }
}
