#this stack mutates state
stack = []
console.log "stack: #{stack}"
stack.push 4
console.log "stack: #{stack}"
stack.push 5
console.log "stack: #{stack}"
stack.pop()
console.log "stack: #{stack}"
stack.pop()
console.log "stack: #{stack}"

#solution to avoid mutable state is to constract a new
#state container every time we need mutation.

push = (element, stack)->
    newStack = [element].concat(stack)
    {value:element,stack:newStack}

pop =  (stack)->
    value = stack[0]
    newStack = stack.slice 1
    {value:value,stack:newStack}

###
stack0 = []
console.log "stack0: #{stack0}"
stack1 = push(4, stack0)
console.log "stack1: #{stack1.value}, #{stack1.stack}"
stack2 = push(5, stack1.stack)
console.log "stack2: #{stack2.value}, #{stack2.stack}"
result0 = pop stack2.stack
console.log "result0: #{result0.value}, #{result0.stack}"
result1 = pop result0.stack
console.log "result1: #{result1.value}, #{result1.stack}"
###

bind = (value, continuation)->
    return continuation(value)

stack0 = []

finalResult = bind push(4,stack0), (result0)->
    bind push(5,result0.stack), (result1)->
        bind pop(result1.stack), (result2)->
            bind pop(result2.stack), (result3)->
                m =
                    value2:result2.value
                    value3:result3.value
                    stack:result3.stack
                return m

m = finalResult
console.log "value2 is #{m.value2}"
console.log "value3 is #{m.value3}"
console.log m.stack

