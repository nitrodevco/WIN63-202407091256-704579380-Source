package com.sulake.core.communication {
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.connection.class_26;
    import com.sulake.core.communication.connection.class_3349;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IUpdateReceiver;

    [SecureSWF(rename="true")]
    public class CoreCommunicationManager extends Component implements ICoreCommunicationManager, IUpdateReceiver {

        private var connections: Array;

        public function CoreCommunicationManager(context: IContext, flags: uint = 0) {
            super(context, flags);
            connections = [];
            registerUpdateReceiver(this, 0);
        }

        override public function dispose(): void {
            removeUpdateReceiver(this);
            for each (var connection: IConnection in connections) {
                connection.dispose();
            }
            connections = null;
            super.dispose();
        }

        public function createConnection(connectionParams: class_26 = null): IConnection {
            var connection: IConnection = new class_3349(this, connectionParams);
            connections.push(connection);
            return connection;
        }

        public function update(deltaTime: uint): void {
            var i: int = 0;
            while (i < connections.length) {
                var connection: IConnection = connections[i];
                connection.processReceivedData();
                if (disposed) {
                    return;
                }
                if (connection.disposed) {
                    connections.splice(i, 1);
                } else {
                    i++;
                }
            }
        }
    }
}