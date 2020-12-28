const { searchProduct, searchMarket } = require('./product')

var assert = require('chai').assert;
describe('Tests', function () {
    describe('product responses', function () {
        it('should return array', function (done) {
            searchProduct('huawei telefon')
                .then(response => {
                    assert.isArray(response, 'response is array')
                    done()
                })
        }).timeout(20000)
    });
    describe('market responses', function () {
        it('should return array', function (done) {
            searchMarket('köpek maması')
                .then(response => {
                    assert.isArray(response, 'response is array')
                    done()
                })
        }).timeout(20000)
    });
})