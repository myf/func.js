push = (element)->
    (stack)->
        value = element
        newStack = [element].concat(stack)
        {value:value,stack:newStack}

pop = ()->
    (stack)->
        value = stack[0]
        newStack = stack.slice(1)
        {value:value,stack:newStack}

