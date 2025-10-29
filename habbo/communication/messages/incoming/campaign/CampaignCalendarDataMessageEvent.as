package com.sulake.habbo.communication.messages.incoming.campaign {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.campaign.class_1499

    [SecureSWF(rename="true")]
    public class CampaignCalendarDataMessageEvent extends MessageEvent implements IMessageEvent {

        public function CampaignCalendarDataMessageEvent(param1: Function) {
            super(param1, class_1499);
        }

        public function getParser(): class_1499 {
            return _parser as class_1499;
        }
    }
}
