# How to test: 
#   iex(1)> Fibonacci.start
#   iex(2)> Fibonacci.calc [112,23,45,677,899]
#   iex(3)> Fibonacci.calc 12

defmodule FibCalc do
    def init() do 
      :ets.new(:fib_series, [:set, :public,:named_table]) 
      :ets.insert(:fib_series,{0,0})
      :ets.insert(:fib_series,{1,1})
      :ets.insert(:fib_series,{:maximum,1})
      :ets.new(:results_count, [:set, :public,:named_table])
    end
    
    
    def calc(num) when is_list(num)==true do
        num |> Enum.map(fn x -> 
                 Task.async(fn -> res = fib_p(x)
                                store_and_incr(x,res)
                            end)
                        end) 
            |> Enum.map(fn y ->
                          Task.await(y) 
                        end)
    end

    
    def calc(num) do 
        res = fib_p(num)
        store_and_incr(num,res)
    end
    
    
    def get_history do
        :ets.match_object(:results_count, {:"$0", :"$1", :"$2"})
                 |> Enum.map(fn {num, res, _count} ->  
                                %{num => res} 
                             end)
    end                     
    
    
    def get_count do
        :ets.match_object(:results_count, {:"$0", :"$1", :"$2"})
                 |> Enum.map(fn {num, _res, count} ->  
                                %{num => count} 
                             end)
    end                         
    
                       
    def store_and_incr(num,res) do
        case :ets.lookup(:results_count,num) do
            [] -> 
                :ets.insert(:results_count,{num,res,0})
                :ets.update_counter(:results_count,num,{3,1})
                res
             _ ->
                :ets.update_counter(:results_count,num,{3,1})
                res
        end
    end
    
    
    def fib_p(num) when num < 0, do: "This is a negative number"
      def fib_p(num) do
         case :ets.lookup(:fib_series,num) do
           [{_, result}] -> result
           [] ->
             [{_, maximum}] = :ets.lookup(:fib_series,:maximum)
             [{_, n1}] = :ets.lookup(:fib_series, maximum)
             [{_, n2}] = :ets.lookup(:fib_series, maximum - 1)
             :ets.insert(:fib_series,{maximum + 1, n1 + n2})
             :ets.insert(:fib_series,{:maximum, maximum + 1})
             fib_p(num)
         end
      end
     
 end