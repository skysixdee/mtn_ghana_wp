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

// ✅ BACKGROUND: Tab hidden or closed — service worker handles this
messaging.onBackgroundMessage((payload) => {
    console.log('[SW] Background message:', payload);

    // Browser auto-shows this notification
    self.registration.showNotification(
        payload.notification?.title ?? 'New Message',
        {
            body: payload.notification?.body ?? '',
            icon: '/icons/Icon-192.png',
            badge: '/icons/Icon-192.png',
            data: payload.data ?? {},
            // Optional: actions buttons on notification
            actions: [
                { action: 'open', title: 'Open App' },
                { action: 'dismiss', title: 'Dismiss' }
            ]
        }
    );
});

// ✅ Handle notification click — bring app to focus
self.addEventListener('notificationclick', (event) => {
    event.notification.close();

    if (event.action === 'dismiss') return;

    const urlToOpen = event.notification.data?.url ?? '/';

    event.waitUntil(
        clients.matchAll({ type: 'window', includeUncontrolled: true })
            .then((windowClients) => {
                // If app tab already open, focus it
                for (const client of windowClients) {
                    if (client.url === urlToOpen && 'focus' in client) {
                        return client.focus();
                    }
                }
                // Otherwise open new tab
                return clients.openWindow(urlToOpen);
            })
    );
});