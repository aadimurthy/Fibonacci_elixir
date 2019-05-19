defmodule Fib.Router do
    use Plug.Router
  
    plug :match
    plug :dispatch
    plug Plug.Parsers, parsers: [:json],
                       pass: ["application/json"],
                       json_decoder: Poison
  
    post "/input" do
        {:ok, data, _conn} = read_body(conn)
        %{"input" => input} = Poison.decode!(~s(#{data}))
        result  = FibCalc.calc input
        send_resp(conn, 200,  Poison.encode!(%{result: result}))
    end

    get "/count" do
        count = FibCalc.get_count
        send_resp(conn, 200, Poison.encode!(count))
    end

    get "/history" do
         history = FibCalc.get_history
         send_resp(conn, 200, Poison.encode!(history))
    end
  
    match _ do
      send_resp(conn, 404, "Oops!")
    end
end