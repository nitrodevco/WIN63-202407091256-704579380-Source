package com.sulake.core.utils {
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;

    public class LibraryLoaderQueue extends EventDispatcherWrapper implements IDisposable {

        protected static const MAX_SIMULTANEOUS_DOWNLOADS: int = 4;

        private var isDebugMode: Boolean = false;
        private var pausedLoaders: Array;
        private var activeLoaders: Array;

        public function LibraryLoaderQueue(debugMode: Boolean = false) {
            pausedLoaders = [];
            activeLoaders = [];
            isDebugMode = debugMode;
            super();
        }

        public function get length(): int {
            return pausedLoaders.length + activeLoaders.length;
        }

        override public function dispose(): void {
            if (!disposed) {
                disposeLoaders(activeLoaders);
                disposeLoaders(pausedLoaders);
                activeLoaders = null;
                pausedLoaders = null;
                super.dispose();
            }
        }

        private function disposeLoaders(loaderArray: Array): void {
            for each (var loader: LibraryLoader in loaderArray) {
                loader.dispose();
            }
        }

        public function push(loader: LibraryLoader): void {
            if (!disposed && !isUrlInQueue(loader.url) && !findLibraryLoaderByURL(loader.url)) {
                if (loader.paused) {
                    pausedLoaders.push(loader);
                } else {
                    activeLoaders.push(loader);
                }
                addLoaderEventListeners(loader);
                next();
            }
        }

        private function addLoaderEventListeners(loader: LibraryLoader): void {
            loader.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", libraryLoadedHandler);
            loader.addEventListener("LIBRARY_LOADER_EVENT_PROGRESS", loadProgressHandler);
            loader.addEventListener("LIBRARY_LOADER_EVENT_DISPOSE", loaderDisposeHandler);
            loader.addEventListener("LIBRARY_LOADER_EVENT_ERROR", loadErrorHandler);
        }

        private function next(): void {
            if (!disposed) {
                try {
                    while (activeLoaders.length < MAX_SIMULTANEOUS_DOWNLOADS && pausedLoaders.length > 0) {
                        var loader: LibraryLoader = pausedLoaders.shift();
                        activeLoaders.push(loader);
                        loader.resume();
                    }
                } catch (e: Error) {
                    trace("Error in LibraryLoaderQueue: " + e.message);
                }
            }
        }

        private function libraryLoadedHandler(event: class_43): void {
            var loader: LibraryLoader = event.target as LibraryLoader;
            if (loader) {
                removeLoader(loader);
            }
            next();
        }

        private function loadProgressHandler(event: class_43): void {
            // Handle progress update if needed
        }

        private function loaderDisposeHandler(event: class_43): void {
            var loader: LibraryLoader = event.target as LibraryLoader;
            removeLoader(loader);
            next();
        }

        private function loadErrorHandler(event: class_43): void {
            var loader: LibraryLoader = event.target as LibraryLoader;
            if (loader) {
                removeLoader(loader);
            }
            next();
        }

        private function removeLoader(loader: LibraryLoader): void {
            removeLoaderEventListeners(loader);
            try {
                removeFromArray(pausedLoaders, loader);
                removeFromArray(activeLoaders, loader);
            } catch (e: Error) {
                // Handle error if needed
            }
        }

        private function removeLoaderEventListeners(loader: LibraryLoader): void {
            loader.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", libraryLoadedHandler);
            loader.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS", loadProgressHandler);
            loader.removeEventListener("LIBRARY_LOADER_EVENT_DISPOSE", loaderDisposeHandler);
            loader.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", loadErrorHandler);
        }

        private function removeFromArray(array: Array, loader: LibraryLoader): void {
            var index: int = array.indexOf(loader);
            if (index > -1) {
                array.splice(index, 1);
            }
        }

        private function isUrlInQueue(url: String, checkQuery: Boolean = true): Boolean {
            if (!disposed) {
                if (checkQuery && url.indexOf("?") > -1) {
                    url = url.slice(0, url.indexOf("?"));
                }
                return isUrlInArray(pausedLoaders, url, checkQuery) || isUrlInArray(activeLoaders, url, checkQuery);
            }
            return false;
        }

        private function isUrlInArray(array: Array, url: String, checkQuery: Boolean): Boolean {
            for each (var loader: LibraryLoader in array) {
                if (checkQuery) {
                    if (loader.url.indexOf(url) == 0) {
                        return true;
                    }
                } else if (loader.url == url) {
                    return true;
                }
            }
            return false;
        }

        public function findLibraryLoaderByURL(url: String, checkQuery: Boolean = true): LibraryLoader {
            if (!disposed) {
                if (checkQuery && url.indexOf("?") > -1) {
                    url = url.slice(0, url.indexOf("?"));
                }
                return findLoaderByUrlInArray(activeLoaders, url, checkQuery);
            }
            return null;
        }

        private function findLoaderByUrlInArray(array: Array, url: String, checkQuery: Boolean): LibraryLoader {
            for each (var loader: LibraryLoader in array) {
                if (checkQuery) {
                    if (loader.url.indexOf(url) == 0) {
                        return loader;
                    }
                } else if (loader.url == url) {
                    return loader;
                }
            }
            return null;
        }
    }
}
