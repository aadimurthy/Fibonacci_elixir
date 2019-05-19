defmodule FibonacciServer.FibCalcTest do
  use ExUnitProperties
  use ExUnit.Case, async: true
  

  test "It returns fibonaaci for a single given number" do
    assert FibCalc.calc(100) == 354224848179261915075
    assert FibCalc.calc(27)  == 196418
    assert FibCalc.calc(1)   == 1 
  end

  test "It accept a list of numbers to calculate and return the result" do
    assert FibCalc.calc([12,34,55,72,99]) == [144, 5702887, 139583862445, 498454011879264, 218922995834555169026]
    assert FibCalc.calc([1,3,4,5]) == [1, 2, 3, 5]
    assert FibCalc.calc([92])  == [7540113804746346429]
  end

 # property "Property based testing: Random Input" do
 #   check all int <- positive_integer() do
 #       res = FibCalc.calc(int)
 #       n1 = (5*res*res+4)
 #       n2 = (5*res*res-4)
 #       sqrn1= round(:math.sqrt(n1))
 #       sqrn2= round(:math.sqrt(n2))
 #       val1 = (sqrn1*sqrn1==n1)
 #       val2 = (sqrn2*sqrn2==n2)
 #       assert (val1 || val2) == true
 #     end
 # end

property "Property based testing: Random Integer as Input" do
     check all int <- integer(2..100) do
     assert FibCalc.calc(int) == FibCalc.calc(int-1)+ FibCalc.calc(int-2)
    end
  end

#  property "Property based testing: Random List as Input"  do
#    check all list <- list_of(integer(4..10), min_length: 2) do
#    feb_list = FibCalc.calc(list)
#    assert FibCalc.calc(hd(feb_list)) == FibCalc.calc(hd(feb_list)-1)+ FibCalc.calc(hd(feb_list)-2)
#  end
# end


end
