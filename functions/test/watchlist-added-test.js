const admin =  require('firebase-admin');
const functions = require('firebase-functions');
const env = require('./stub-environment');

const chai = require('chai');
const sinon = require('sinon');
const chaiAsPromised = require("chai-as-promised");

chai.use(chaiAsPromised);
const assert = chai.assert;



describe('onWatchlistAdded', () => {
  let backend;

  before(() => {
    env.setup(functions, admin);
    onWatchlistAdded = require('../watchlist-added.js');
  });

  after(env.restore);

  it('should upper case input and write it to /uppercase', () => {
      const fakeEvent = {
        data: new functions.database.DeltaSnapshot(null, null, null, 'input'),
      };
      return assert.eventually.equal(onWatchlistAdded(fakeEvent), true);
      // [END verifyDataWrite]
})
});