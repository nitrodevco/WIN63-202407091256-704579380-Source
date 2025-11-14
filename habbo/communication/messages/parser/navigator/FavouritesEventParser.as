package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.IMessageParser;

    [SecureSWF(rename = "true")]
        public class FavouritesEventParser implements IMessageParser
        {

            public function FavouritesEventParser()
            {
                super();
            }
            private var var_1452:int;
        private var var_721:Array;

        public function get limit():int
        {
            return var_1452;
        }

        public function get favouriteRoomIds():Array
        {
            return var_721;
        }

        public function flush():Boolean
        {
            var_721 = [];
            return true;
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc3_:int = 0;
            this.var_1452 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_)
            {
                var_721.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }
    }
}
