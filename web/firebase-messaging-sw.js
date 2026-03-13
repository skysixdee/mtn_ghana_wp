importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyDnY55cFvXqQ3HpuCQJn1FFWWKyyLUdpUc",
    authDomain: "mtnhost-65a8b.firebaseapp.com",
    projectId: "mtnhost-65a8b",
    storageBucket: "mtnhost-65a8b.firebasestorage.app",
    messagingSenderId: "608854775651",
    appId: "1:608854775651:web:40e3732249dc02c5eee556",
});

// ✅ Auto-detect base path from SW file location
// Works for any base href: '/', '/crbt-web-portal/', '/any/path/'
const SW_URL = self.location.pathname;
const BASE_PATH = SW_URL.substring(0, SW_URL.lastIndexOf('/') + 1);
console.log('[SW] Auto-detected BASE_PATH:', BASE_PATH);

// ✅ Cache name — bump version when you deploy new build
const CACHE_NAME = 'crbt-cache-v1';

// ✅ All paths are dynamic — no hardcoding needed
const OFFLINE_URLS = [
    BASE_PATH,
    `${BASE_PATH}index.html`,
    `${BASE_PATH}main.dart.js`,
    `${BASE_PATH}flutter.js`,
    `${BASE_PATH}manifest.json`,
    `${BASE_PATH}flutter_bootstrap.js`,
    `${BASE_PATH}icons/Icon-192.png`,
    `${BASE_PATH}icons/Icon-512.png`,
];

// ─────────────────────────────────────────
// INSTALL — cache all assets
// ─────────────────────────────────────────
self.addEventListener('install', (event) => {
    console.log('[SW] Installing — BASE_PATH:', BASE_PATH);
    self.skipWaiting();

    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            console.log('[SW] Caching URLs:', OFFLINE_URLS);
            // ✅ addAll fails if any URL fails — use individual adds to be safe
            return Promise.allSettled(
                OFFLINE_URLS.map(url =>
                    cache.add(url).catch(err => {
                        console.log('[SW] Failed to cache:', url, err);
                    })
                )
            );
        })
    );
});

// ─────────────────────────────────────────
// ACTIVATE — clean old caches
// ─────────────────────────────────────────
self.addEventListener('activate', (event) => {
    console.log('[SW] Activating...');

    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames
                    .filter((name) => name !== CACHE_NAME)
                    .map((name) => {
                        console.log('[SW] Deleting old cache:', name);
                        return caches.delete(name);
                    })
            );
        })
    );
});

// ─────────────────────────────────────────
// FETCH — serve from cache when offline
// ─────────────────────────────────────────
self.addEventListener('fetch', (event) => {
    console.log('[SW] Fetching:', event.request.url); // add this
    console.log('Offline — serving from cache:Sky1', event.request.url);
    if (event.request.method !== 'GET') return;
    console.log('Offline — serving from cache: Sky2', event.request.url);
    event.respondWith(
        fetch(event.request)
            .then((response) => {
                // Online — update cache with fresh response
                const responseClone = response.clone();
                caches.open(CACHE_NAME).then((cache) => {
                    cache.put(event.request, responseClone);
                });
                return response;
            })
            .catch(() => {
                // Offline — serve from cache
                console.log('[SW] Offline — serving from cache:', event.request.url);
                return caches.match(event.request).then((cachedResponse) => {
                    if (cachedResponse) return cachedResponse;

                    // ✅ Fallback to index.html using dynamic BASE_PATH
                    if (event.request.mode === 'navigate') {
                        return caches.match(`${BASE_PATH}index.html`);
                    }

                    return new Response('Offline', { status: 503 });
                });
            })
    );
});

// ─────────────────────────────────────────
// FCM BACKGROUND MESSAGES
// ─────────────────────────────────────────
const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
    console.log('[SW] Background message:', payload);

    self.clients.matchAll({
        type: 'window',
        includeUncontrolled: true
    }).then((clients) => {
        const appIsVisible = clients.some(c => c.visibilityState === 'visible');
        console.log('[SW] App visible:', appIsVisible);

        if (appIsVisible) {
            console.log('[SW] Skipping — Flutter handles foreground');
            return;
        }

        return self.registration.showNotification(
            payload.notification?.title ?? 'New Message',
            {
                body: payload.notification?.body ?? '',
                // ✅ Dynamic icon paths
                icon: `${BASE_PATH}icons/Icon-192.png`,
                badge: `${BASE_PATH}icons/Icon-192.png`,
                data: payload.data ?? {},
            }
        );
    });
});

// ─────────────────────────────────────────
// NOTIFICATION CLICK
// ─────────────────────────────────────────
self.addEventListener('notificationclick', (event) => {
    console.log('[SW] Notification clicked');
    event.notification.close();

    // ✅ Dynamic fallback URL
    const url = event.notification.data?.url ?? BASE_PATH;

    event.waitUntil(
        self.clients.matchAll({ type: 'window', includeUncontrolled: true })
            .then((clients) => {
                for (const client of clients) {
                    // ✅ Dynamic base path check
                    if (client.url.includes(BASE_PATH) && 'focus' in client) {
                        return client.focus();
                    }
                }
                return self.clients.openWindow(url);
            })
    );
});
/*
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyDnY55cFvXqQ3HpuCQJn1FFWWKyyLUdpUc",
    authDomain: "mtnhost-65a8b.firebaseapp.com",
    projectId: "mtnhost-65a8b",
    storageBucket: "mtnhost-65a8b.firebasestorage.app",
    messagingSenderId: "608854775651",
    appId: "1:608854775651:web:40e3732249dc02c5eee556",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
    console.log('[SW] Background message:', payload);

    self.clients.matchAll({
        type: 'window',
        includeUncontrolled: true
    }).then((clients) => {
        const appIsVisible = clients.some(c => c.visibilityState === 'visible');
        console.log('[SW] App visible:', appIsVisible);

        if (appIsVisible) {
            console.log('[SW] Skipping — Flutter will handle foreground notification');
            return;
        }

        return self.registration.showNotification(
            payload.notification?.title ?? 'New Message',
            {
                body: payload.notification?.body ?? '',
                icon: '/crbt-web-portal/icons/Icon-192.png',  // ✅ changed
                badge: '/crbt-web-portal/icons/Icon-192.png',  // ✅ changed
                data: payload.data ?? {},
            }
        );
    });
});

self.addEventListener('notificationclick', (event) => {
    console.log('[SW] Notification clicked:', event);
    event.notification.close();

    // ✅ changed — open correct base path
    const url = event.notification.data?.url ?? '/crbt-web-portal/';

    event.waitUntil(
        self.clients.matchAll({ type: 'window', includeUncontrolled: true })
            .then((clients) => {
                for (const client of clients) {
                    if (client.url.includes('/crbt-web-portal/') && 'focus' in client) {
                        return client.focus();  // ✅ only focus if it's the right app
                    }
                }
                return self.clients.openWindow(url);  // ✅ open correct URL
            })
    );
});
*/
