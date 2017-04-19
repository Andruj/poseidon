const apiKey = "AIzaSyA40Ox4yGic0PW4z9mJSwxp3U4Wi3vsTag";
const authDomain = "poseidon-ed88d.firebaseapp.com";
const databaseURL = "https://poseidon-ed88d.firebaseio.com";
const storageBucket = "poseidon-ed88d.appspot.com";
const messagingSenderId = "74668054832";

firebase.initializeApp({ apiKey, authDomain, databaseURL, storageBucket, messagingSenderId });

firebase.auth().onAuthStateChanged(user => {
  if (user) {
    const messaging = firebase.messaging();
    messaging.onTokenRefresh(() => {
      messaging.getToken().then(token => {
      firebase.database().ref(`users/${user.uid}`).update({ token });
    });
    });
    messaging.requestPermission()
    .then(function() {
      console.log('messaging.js -- notification permission granted.');
      return messaging.getToken()
    })
    .then(token => {
      console.log('messaging.js -- saving token to user: ' + user.uid);
       firebase.database().ref(`users/${user.uid}`).update({ token });
    })
    .catch(function(err) {
      console.log('messaging.js -- unable to get permission to notify.', err);
    });

  console.log('messaging.js -- setting up message responses.');
  messaging.onMessage(function(payload) {
    console.log("messaging.js -- message received. ", payload);
  });

  }
});
