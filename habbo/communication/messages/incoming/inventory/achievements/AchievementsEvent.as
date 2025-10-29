package com.sulake.habbo.communication.messages.incoming.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.class_1525

    [SecureSWF(rename="true")]
    public class AchievementsEvent extends MessageEvent implements IMessageEvent {

        public function AchievementsEvent(param1: Function) {
            super(param1, class_1525);
        }

        public function getParser(): class_1525 {
            return _parser as class_1525;
        }
    }
}
