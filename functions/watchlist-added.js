const functions = require('firebase-functions');

module.exports = functions.database.ref('/users/{userId}/regions/{regionId}/watchlist/{watchlistId}')
    .onWrite(event => {
        console.log(event.data.val());
        return true;
    });