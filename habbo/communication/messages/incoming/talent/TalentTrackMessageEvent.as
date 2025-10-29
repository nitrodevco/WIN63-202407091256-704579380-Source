package com.sulake.habbo.communication.messages.incoming.talent {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.talent.class_1193

    [SecureSWF(rename="true")]
    public class TalentTrackMessageEvent extends MessageEvent implements IMessageEvent {

        public function TalentTrackMessageEvent(param1: Function) {
            super(param1, class_1193);
        }

        public function getParser(): class_1193 {
            return _parser as class_1193;
        }
    }
}
