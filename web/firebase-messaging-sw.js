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

// Handle background messages
messaging.onBackgroundMessage((payload) => {
    console.log('Background message received:', payload);

    const { title, body, icon } = payload.notification;

    self.registration.showNotification(title, {
        body: body,
        icon: icon || '/icons/Icon-192.png',
        badge: '/icons/Icon-192.png',
        data: payload.data,
    });
});

// Handle notification click
self.addEventListener('notificationclick', (event) => {
    event.notification.close();
    const url = event.notification.data?.url || '/';
    event.waitUntil(clients.openWindow(url));
});