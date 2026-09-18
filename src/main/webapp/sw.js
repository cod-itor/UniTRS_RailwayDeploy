const CACHE_NAME = 'unitrs-pwa-v1';
const OFFLINE_URL = 'offline.html';

const PRECACHE_ASSETS = [
    'offline.html',
    'manifest.json',
    'static/icons/icon-192.png',
    'static/icons/icon-512.png',
    'static/icons/icon-maskable-512.png',
    'static/icons/apple-touch-icon.png',
    'static/icons/favicon.png',
    'static/icons/icon.svg',
    'static/js/pwa.js'
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            return cache.addAll(PRECACHE_ASSETS);
        }).then(() => self.skipWaiting())
    );
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cache) => {
                    if (cache !== CACHE_NAME) {
                        return caches.delete(cache);
                    }
                })
            );
        }).then(() => self.clients.claim())
    );
});

self.addEventListener('fetch', (event) => {
    const request = event.request;

    if (request.method !== 'GET') {
        return;
    }

    const url = new URL(request.url);

    if (request.mode === 'navigate') {
        event.respondWith(
            fetch(request).catch(async () => {
                const cache = await caches.open(CACHE_NAME);
                const cachedOffline = await cache.match(OFFLINE_URL);
                return cachedOffline || new Response('Offline - please reconnect to internet.', {
                    status: 503,
                    statusText: 'Service Unavailable',
                    headers: { 'Content-Type': 'text/plain' }
                });
            })
        );
        return;
    }

    const isStaticAsset = url.pathname.includes('/static/') ||
                          url.pathname.endsWith('.css') ||
                          url.pathname.endsWith('.js') ||
                          url.pathname.endsWith('.png') ||
                          url.pathname.endsWith('.svg') ||
                          url.pathname.endsWith('.woff2') ||
                          url.origin.includes('cdn.jsdelivr.net') ||
                          url.origin.includes('fonts.googleapis.com') ||
                          url.origin.includes('fonts.gstatic.com');

    if (isStaticAsset) {
        event.respondWith(
            caches.match(request).then((cachedResponse) => {
                const fetchPromise = fetch(request).then((networkResponse) => {
                    if (networkResponse && networkResponse.status === 200) {
                        const responseToCache = networkResponse.clone();
                        caches.open(CACHE_NAME).then((cache) => {
                            cache.put(request, responseToCache);
                        });
                    }
                    return networkResponse;
                }).catch(() => cachedResponse);

                return cachedResponse || fetchPromise;
            })
        );
    }
});
