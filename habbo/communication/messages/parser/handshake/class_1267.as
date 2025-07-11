package com.sulake.habbo.communication.messages.parser.handshake {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1267 implements IMessageParser {

        public function class_1267() {
            super();
        }
        private var _id: int;
        private var _figure: String;

        private var _sex: String;

        private var _customData: String;
        private var _directMail: Boolean;
        private var _respectTotal: int;
        private var _respectLeft: int;
        private var _petRespectLeft: int;
        private var _streamPublishingAllowed: Boolean;
        private var _lastAccessDate: String;
        private var _nameChangeAllowed: Boolean;
        private var _accountSafetyLocked: Boolean = false;

        private var _name: String;

        public function get name(): String {
            return this._name;
        }

        private var _realName: String;

        public function get realName(): String {
            return this._realName;
        }

        public function get id(): int {
            return this._id;
        }

        public function get figure(): String {
            return this._figure;
        }

        public function get sex(): String {
            return this._sex;
        }

        public function get customData(): String {
            return this._customData;
        }

        public function get directMail(): Boolean {
            return this._directMail;
        }

        public function get respectTotal(): int {
            return this._respectTotal;
        }

        public function get respectLeft(): int {
            return this._respectLeft;
        }

        public function get petRespectLeft(): int {
            return this._petRespectLeft;
        }

        public function get streamPublishingAllowed(): Boolean {
            return this._streamPublishingAllowed;
        }

        public function get lastAccessDate(): String {
            return this._lastAccessDate;
        }

        public function get nameChangeAllowed(): Boolean {
            return this._nameChangeAllowed;
        }

        public function get accountSafetyLocked(): Boolean {
            return _accountSafetyLocked;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._id = param1.readInteger();
            this._name = param1.readString();
            this._figure = param1.readString();
            this._sex = param1.readString();
            this._customData = param1.readString();
            this._realName = param1.readString();
            this._directMail = param1.readBoolean();
            this._respectTotal = param1.readInteger();
            this._respectLeft = param1.readInteger();
            this._petRespectLeft = param1.readInteger();
            this._streamPublishingAllowed = param1.readBoolean();
            this._lastAccessDate = param1.readString();
            this._nameChangeAllowed = param1.readBoolean();
            this._accountSafetyLocked = param1.readBoolean();
            return true;
        }
    }
}
