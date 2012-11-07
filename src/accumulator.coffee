#changing state with closure
module.exports =
    accumulator:()->
        i = 0
        return ()->
            i++

