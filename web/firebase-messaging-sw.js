// are not available in the service worker.
importScripts('https://www.gstatic.com/firebasejs/3.6.7/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/3.6.7/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing in the
// messagingSenderId.
firebase.initializeApp({
  'messagingSenderId': '74668054832'
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
