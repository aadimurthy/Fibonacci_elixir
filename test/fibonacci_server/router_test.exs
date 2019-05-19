defmodule FibonacciServer.RouterTest do
    use ExUnit.Case, async: true
    use Plug.Test
    require  Poison

    @opts Fib.Router.init([])

    setup_all do
        Application.stop(:fibonacci_server)
        Application.start(:fibonacci_server)
    end

    test "it returns the Fibonnaci result in JSON format with single number as input" do
        # Create a test connection
        conn = conn(:post, "/input", Poison.encode!(%{:input=>100}))
    
        # Invoke the plug
        conn = Fib.Router.call(conn, @opts)
    
        # Assert the response
        assert conn.status == 200
        assert Poison.decode(conn.resp_body) == {:ok, %{"result" => 354224848179261915075}}
      end
    
    
    test "it returns the Fibonnaci result in JSON format with list(multilple numbbers) as input" do
        # Create a test connection
        conn = conn(:post, "/input", Poison.encode!(%{:input=>[10,30,20,40]}))
    
        # Invoke the plug
        conn = Fib.Router.call(conn, @opts)
    
        # Assert the response
        assert conn.status == 200
        assert Poison.decode(conn.resp_body) == {:ok, %{"result" => [55, 832040, 6765, 102334155]}}
      end

      test "it returns the Fibonnaci result in JSON format with list(single numbber) as input" do
        # Create a test connection
        conn = conn(:post, "/input", Poison.encode!(%{:input=>[100]}))
    
        # Invoke the plug
        conn = Fib.Router.call(conn, @opts)
    
        # Assert the response
        assert conn.status == 200
        assert Poison.decode(conn.resp_body) == {:ok, %{"result" => [354224848179261915075]}}
      end  


    test "it returns the group and count from the history of numbers requested in JSON format" do
        # Create a test connection
        conn = conn(:get, "/count")
    
        # Invoke the plug
        conn = Fib.Router.call(conn, @opts)
    
        # Assert the response and status
        assert conn.state == :sent
        assert conn.status == 200
        assert Poison.decode(conn.resp_body) == {:ok, [%{"40" => 1}, %{"20" => 1}, %{"10" => 1}, %{"100" => 2}, %{"30" => 1}]}
      end  


    test "it lists the history of the requested numbers in JSON format" do
        # Create a test connection
        conn = conn(:get, "/history")
    
        # Invoke the plug
        conn = Fib.Router.call(conn, @opts)
    
        # Assert the response and status
        assert conn.state == :sent
        assert conn.status == 200
        assert Poison.decode(conn.resp_body) == {:ok, [%{"40" => 102334155}, %{"20" => 6765}, %{"10" => 55}, %{"100" => 354224848179261915075}, %{"30" => 832040}]}
    end 
    
    test "it returns the error for wrong end point" do
        # Create a test connection
        conn = conn(:get, "/")
    
        # Invoke the plug
        conn = Fib.Router.call(conn, @opts)
    
        # Assert the response and status
        assert conn.state == :sent
        assert conn.status == 404
        assert conn.resp_body == "Oops!"
    end    
      
end