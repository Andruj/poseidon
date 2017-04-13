const sinon = require('sinon')

let adminStub;
let configStub;


const setup = (functions, admin) => {
    adminStub = sinon.stub(admin, 'initializeApp');
    configStub = sinon.stub(functions, 'config').returns({
        firebase: {
          databaseURL: 'https://not-a-project.firebaseio.com',
            storageBucket: 'not-a-project.appspot.com',
        }
        });
}

const restore = (functions, admin) => {
    configStub.restore()
    adminStub.restore()
}

module.exports = {
    setup, restore
};