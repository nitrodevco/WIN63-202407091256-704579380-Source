package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1562

    [SecureSWF(rename="true")]
    public class SeasonalCalendarDailyOfferMessageEvent extends MessageEvent implements IMessageEvent {

        public function SeasonalCalendarDailyOfferMessageEvent(param1: Function) {
            super(param1, class_1562);
        }

        public function get offer(): class_1501 {
            return class_1562(parser).offerData;
        }

        public function get pageId(): int {
            return class_1562(parser).pageId;
        }
    }
}
