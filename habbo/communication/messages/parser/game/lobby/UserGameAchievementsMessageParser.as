package com.sulake.habbo.communication.messages.parser.game.lobby {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.class_1525

    public class UserGameAchievementsMessageParser implements IMessageParser {

        public function UserGameAchievementsMessageParser() {
            super();
        }
        private var var_474: int;
        private var var_275: class_1525;

        public function get gameTypeId(): int {
            return var_474;
        }

        public function get achievements(): Array {
            return var_275.achievements;
        }

        public function get defaultCategory(): String {
            return var_275.defaultCategory;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_474 = param1.readInteger();
            var_275 = new class_1525();
            var_275.parse(param1);
            return true;
        }
    }
}
