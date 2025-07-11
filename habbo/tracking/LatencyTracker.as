package com.sulake.habbo.tracking {
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.tracking.class_448;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;

    public class LatencyTracker implements IDisposable {
        private var isTracking: Boolean = false;
        private var currentTestId: int = 0;
        private var interval: int = 0;
        private var reportIndex: int = 0;
        private var reportDelta: int = 0;
        private var lastTestTime: int = 0;
        private var lastAverageLatency: int = 0;
        private var latencies: Array;
        private var latencyMap: Map;
        private var habboTracking: HabboTracking;

        public function LatencyTracker(tracking: HabboTracking) {
            super();
            this.habboTracking = tracking;
        }

        public function dispose(): void {
            if (disposed) {
                return;
            }
            isTracking = false;
            if (latencyMap != null) {
                latencyMap.dispose();
                latencyMap = null;
            }
            latencies = null;
            habboTracking = null;
        }

        public function init(): void {
            interval = habboTracking.getInteger("latencytest.interval", 20000);
            reportIndex = habboTracking.getInteger("latencytest.report.index", 100);
            reportDelta = habboTracking.getInteger("latencytest.report.delta", 3);
            if (interval < 1) {
                return;
            }

            latencyMap = new Map();
            latencies = [];
            isTracking = true;
        }

        public function update(deltaTime: uint, currentTime: int): void {
            if (!isTracking) {
                return;
            }
            if (currentTime - lastTestTime > interval) {
                testLatency();
            }
        }

        private function testLatency(): void {
            lastTestTime = getTimer();
            latencyMap.add(currentTestId, lastTestTime);
            habboTracking.send(new class_448(currentTestId));
            currentTestId++;
        }

        public function onPingResponse(event: LatencyPingResponseMessageEvent): void {
            if (latencyMap == null || latencies == null) {
                return;
            }

            var parser: LatencyPingResponseMessageParser = event.getParser();
            var requestTime: int = latencyMap.getValue(parser.requestId);
            latencyMap.remove(parser.requestId);
            var latency: int = getTimer() - requestTime;
            latencies.push(latency);

            if (latencies.length == reportIndex && reportIndex > 0) {
                calculateAndReportLatencies();
            }
        }

        private function calculateAndReportLatencies(): void {
            var totalLatency: int = 0;
            var validLatencies: int;
            var averageLatency: int;

            for each (var latency: int in latencies) {
                totalLatency += latency;
            }
            averageLatency = totalLatency / latencies.length;

            totalLatency = 0;
            validLatencies = 0;
            for each (latency in latencies) {
                if (latency < averageLatency * 2) {
                    totalLatency += latency;
                    validLatencies++;
                }
            }

            if (validLatencies == 0) {
                latencies = [];
                return;
            }

            var adjustedAverage: int = totalLatency / validLatencies;
            if (Math.abs(averageLatency - lastAverageLatency) > reportDelta || lastAverageLatency == 0) {
                lastAverageLatency = averageLatency;
                var report: LatencyPingReportMessageComposer = new LatencyPingReportMessageComposer(averageLatency, adjustedAverage, latencies.length);
                habboTracking.send(report);
            }

            latencies = [];
        }

        public function get disposed(): Boolean {
            return habboTracking == null;
        }
    }
}
