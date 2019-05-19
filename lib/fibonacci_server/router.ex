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
        body = 
        FibCalc.get_count
        |> Poison.encode!
        send_resp(conn, 200, body)
    end

    get "/history" do
        body = 
         FibCalc.get_history
         |> Poison.encode!
         send_resp(conn, 200,body)
    end
  
    match _ do
      send_resp(conn, 404, "Oops!")
    end
end