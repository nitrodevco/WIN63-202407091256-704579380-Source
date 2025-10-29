package com.sulake.habbo.communication.messages.incoming.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.class_1430

    [SecureSWF(rename="true")]
    public class AchievementsScoreEvent extends MessageEvent implements IMessageEvent {

        public function AchievementsScoreEvent(param1: Function) {
            super(param1, class_1430);
        }

        public function getParser(): class_1430 {
            return _parser as class_1430;
        }
    }
}
