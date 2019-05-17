# How to test: 
#   iex(1)> Fibonacci.start_link
#   iex(2)> Fibonacci.calc [112,23,45,677,899]
#   iex(3)> Fibonacci.calc 12


defmodule Fibonacci do
  def start_link, do: Agent.start_link(fn -> %{ 0 => 0, 1 => 1, :maximum => 1 } end, name: __MODULE__)
 
def calc(num) when is_list(num)==true do
    num |> Enum.map(fn x -> 
                      Task.async(fn -> fib_p(x)  end) end) 
        |> Enum.map(fn y ->
                      Task.await(y) end)
end

def calc(num), do: fib_p(num)


def fib_p(num) when num < 0, do: "This is a negative number"
  def fib_p(num) do
 	case Agent.get(__MODULE__, &Map.fetch(&1, num)) do
 	  {:ok, result} -> result
 	  _ ->
 		{:ok, maximum} = Agent.get(__MODULE__, &Map.fetch(&1, :maximum))
 		{:ok, n1} = Agent.get(__MODULE__, &Map.fetch(&1, maximum))
 		{:ok, n2} = Agent.get(__MODULE__, &Map.fetch(&1, maximum - 1))
 		Agent.update(__MODULE__, &Map.put(&1, maximum + 1, n1 + n2))
 		Agent.update(__MODULE__, &Map.put(&1, :maximum, maximum + 1))
 		fib_p(num)
 	end
  end
 
end