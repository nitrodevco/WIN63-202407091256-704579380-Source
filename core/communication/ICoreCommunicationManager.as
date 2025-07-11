package com.sulake.core.communication {
    import com.sulake.core.communication.connection.IConnection
    import com.sulake.core.communication.connection.class_26
    import com.sulake.core.runtime.IUnknown

    public interface ICoreCommunicationManager extends IUnknown {

        function createConnection(param1: class_26 = null): IConnection;
    }
}
