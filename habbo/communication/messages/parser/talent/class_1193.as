package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1193 implements IMessageParser {

        public function class_1193() {
            super();
        }
        private var _talentTrack: class_1716;

        public function flush(): Boolean {
            _talentTrack = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _talentTrack = new class_1716();
            _talentTrack.parse(param1);
            return true;
        }

        public function getTalentTrack(): class_1716 {
            return _talentTrack;
        }
    }
}
