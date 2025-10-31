package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.ActivityPointsMessageEventParser

    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class ActivityPointsMessageEvent extends MessageEvent implements IMessageEvent {

        public function ActivityPointsMessageEvent(param1: Function) {
            super(param1, ActivityPointsMessageEventParser);
        }

        public function get points(): Dictionary {
            return (_parser as ActivityPointsMessageEventParser).points;
        }
    }
}
