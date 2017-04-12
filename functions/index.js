var functions = require('firebase-functions');

 // Create and Deploy Your First Cloud Functions
 // https://firebase.google.com/docs/functions/write-firebase-functions

exports.onWatchlistAdded = functions.database.ref('/users/{userId}/regions/{regionId}/watchlist')
    .onWrite(event => {
        console.log(event.data.val());
    });