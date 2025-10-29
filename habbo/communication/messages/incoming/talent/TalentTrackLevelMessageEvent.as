package com.sulake.habbo.communication.messages.incoming.talent {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.talent.class_1313

    [SecureSWF(rename="true")]
    public class TalentTrackLevelMessageEvent extends MessageEvent implements IMessageEvent {

        public function TalentTrackLevelMessageEvent(param1: Function) {
            super(param1, class_1313);
        }

        public function getParser(): class_1313 {
            return _parser as class_1313;
        }
    }
}
