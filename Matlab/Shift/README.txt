Sweep script to adjust all parameters and look at the results is called:
   sweep_script.m
   
use print_script.m to quickly generate data for Verilog module verification

general issues:
      - if not already done, replace all calls to Matlab function fi with custom function
         fixed_point(...) and adjust the parameters in the correct way
         -> it is much faster that way than using Matlabs built-in fixed point arithmetic