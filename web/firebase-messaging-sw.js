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
            // ✅ App is open — Flutter onMessage handles it, skip SW notification
            console.log('[SW] Skipping — Flutter will handle foreground notification');
            return;
        }

        // App is minimized/closed — SW shows it
        return self.registration.showNotification(
            payload.notification?.title ?? 'New Message',
            {
                body: payload.notification?.body ?? '',
                icon: '/icons/Icon-192.png',
                badge: '/icons/Icon-192.png',
                data: payload.data ?? {},
            }
        );
    });
});

self.addEventListener('notificationclick', (event) => {
    console.log('[SW] Notification clicked:', event);
    event.notification.close();

    const url = event.notification.data?.url ?? '/';
    event.waitUntil(
        self.clients.matchAll({ type: 'window', includeUncontrolled: true })
            .then((clients) => {
                for (const client of clients) {
                    if ('focus' in client) return client.focus();
                }
                return self.clients.openWindow(url);
            })
    );
});