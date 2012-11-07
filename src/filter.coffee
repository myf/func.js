_ = require 'underscore'

module.exports = class filter
    @numbers = _.range(10)
    @odds = _(numbers).filter (x) ->
    x % 2 isnt 0

