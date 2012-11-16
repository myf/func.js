push = (elem)->
    (stack)->
        newStack = [elem].concat(stack)
        value:elem,stack:newStack
        
pop = ->
    (stack)->
        value = stack[0]
        newStack = stack.slice(1)
        value:value,stack:newStack

bind = (operation, continuation)->
    (stack)->
        result = operation(stack)
        continuation(result.value)(result.stack)

churn_result = (value)->
    (stack)->
        value:value,stack:stack

computation = bind push(4), ()->
    bind push(5), ()->
        bind pop(), (result1)->
            bind pop(), (result2)->
                churn_result(result1+":"+result2)

console.log computation([])

