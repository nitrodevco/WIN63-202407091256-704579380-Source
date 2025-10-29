package com.sulake.habbo.communication.messages.incoming.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.class_1433

    [SecureSWF(rename="true")]
    public class AchievementEvent extends MessageEvent implements IMessageEvent {

        public function AchievementEvent(param1: Function) {
            super(param1, class_1433);
        }

        public function getParser(): class_1433 {
            return _parser as class_1433;
        }
    }
}
