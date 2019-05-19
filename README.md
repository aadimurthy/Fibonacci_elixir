# FibonacciServer

Components used: 

#### Plug:
a simple HTTP server from scratch using the PlugCowboy Elixir library. Cowboy is a simple HTTP server for Erlang and Plug will provide us with a connection adapter for that web server.
Currently our server configured to run at http://localhost:8080

#### Poison:
fastest JSON library for Elixir.

#### StreamData (ExUnitProperties)
Provides macros for property-based testing and helps in generating random test data

#### Coverex
Elixir test Coverage tool


### Installation 

```
1)  mix deps.get
 
2)  mix run --no-halt
 
```

### To run test cases 
```
 mix test --seed 0 --trace
```

### To test coverage

```
mix test --seed 0 --trace --cover
```

### To check APIs 
```

Input : 

$ curl -X POST   http://127.0.0.1:8080/input   -H 'Content-Type: application/json'   -d '{"input": [0,1,100]}'
{"result":[0,1,354224848179261915075]}

$ curl -X POST   http://127.0.0.1:8080/input   -H 'Content-Type: application/json'   -d '{"input": [12,34,56,77]}'
{"result":[144,5702887,225851433717,5527939700884757]}

$ curl -X POST   http://127.0.0.1:8080/input   -H 'Content-Type: application/json'   -d '{"input": 100}'
{"result":354224848179261915075}

$ curl -X POST   http://127.0.0.1:8080/input   -H 'Content-Type: application/json'   -d '{"input": [23]}'
{"result":[28657]}

Count: 

curl -X GET   http://127.0.0.1:8080/count 
[{"77":1},{"1":3},{"56":1},{"23":1},{"12":1},{"34":1},{"0":3},{"100":4}]

History : 

$ curl -X GET   http://127.0.0.1:8080/history 
[{"77":5527939700884757},{"1":1},{"56":225851433717},{"23":28657},{"12":144},{"34":5702887},{"0":0},{"100":354224848179261915075}]

```





 
 



