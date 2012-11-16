stack0 = []

var push = function(elem){
    return function(stack){
        var newStack = [elem].concat(stack);
        return {value:elem, stack:newStack};
    }
}

var pop = function(){
    return function(stack){
        var value = stack[0];
        var newStack = stack.slice(1);
        return {value:value, stack:newStack};
    }
}

var bind = function (operation, continuation) {
    return function(stack){
        //return continuation(operation(stack));
        var result = operation(stack);
        return continuation(result.value)(result.stack)
    }
}

var churn_result = function(value){
    return function(stack){
        return {value:value,stack:stack};
    }
}

var computation = bind(push(4), function() {
    return bind(push(5), function(){
        return bind(pop(), function(result1){
            return bind(pop(), function(result2){
                return churn_result(result1+":"+result2)
            });
        });
    });
});


var runStack = function (operation, initialStack){
    return operation(initialStack)
}

var evalStack = function (operation, initialStack){
    return operation(initialStack).value
}

var execStack = function (operation, initialStack){
    return operation(initialStack).stack
}
console.log(computation(stack0));

var sequence = function () {
    var args = [].slice.call(arguments);
    var monadicActions = args.slice(0, -1);
    var continuation = args.slice(-1)[0];
    return function(stack) {
        var initialState = {value: [], stack:stack};
        var state = monadicActions.reduce(function (state, action) {
            var result = action(state.stack);
            var value = state.value.concat(result.value);
            var stack = result.stack;
            return {value:value, stack:stack}
        }, initialState);

        var value = state.value.filter(function(value){
            return value != undefined;
        });

        return continuation.apply(this, value)(state.stack);
    };
};

var computation = sequence(
    push(4),
    push(5),
    pop(),
    pop(),

    function (pop1, pop2) {
        return churn_result(pop1 + " : " + pop2);
    }
);

var initialStack = [];
var result = computation(initialStack);
console.log(result)
            

