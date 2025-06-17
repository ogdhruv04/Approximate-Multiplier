# Approximate-Multiplier

This project implements a 4×4 unsigned approximate multiplier designed with a customized Dadda tree reduction combined with smart use of compressors to achieve a low-error (7.09% Mean Relative Error over all 256 input combinations), efficient hardware architecture (12 LUTs, an improvement over the exact multiplier which uses 16 LUTs) . The core idea is to prune carries with very low probability of being 1 andusing compressors to reduce stages whenever required thereby reducing hardware complexity and power consumption while maintaining acceptable accuracy.

# Algorithm

![image](https://github.com/user-attachments/assets/dc3c4188-cd12-4e48-a58e-71cdbbc743bb)

For our design, we have used this approximate full adder as it simplifies computation and resources utilized while maintaining a respectable accuracy, where output S is correct in 6/8 input combinations and Cout is correct in 7/8 combinations.

![image](https://github.com/user-attachments/assets/953fe9f7-de49-4aa9-875a-fac46ac2dce5)

For this particular half adder, we have not utilized any particular approximations as we used it in higher multiplication stages holding more weight (MSB), furthermore it is much lesser computationally expensive than the other blocks.

We have also used this 4×2 approximate compressor which takes four equally‑weighted bits and returns one sum bit and one carry bit that is one position higher — effectively replacing two full adders with a single, faster, approximate unit helpful for reducing multiplication columns.

![image](https://github.com/user-attachments/assets/608e5355-579a-4ab3-9ebb-779ad90c5795)

We generate the 4×4 array of partial products pij = Ai & Bj, which can be visualized (grouped by output weight) as:

![image](https://github.com/user-attachments/assets/74c1eae1-7c8c-4fc6-ae40-65f3d608a1d1)

A visualization for the multiplication tree

![image](https://github.com/user-attachments/assets/d53fb590-525a-47e3-912f-3aa404c91ab0)

Result[0] and Result[1] (the two rightmost columns) are easily without requiring a lot of calculations.
![image](https://github.com/user-attachments/assets/25c95861-57d6-4871-9f5e-7449dde11e26)

For the computation of the third column, we have not considered the carry due to the second rightmost column majorly as it has a less probability of propagating and inducing errors in the higher significant bits. This makes it easier for us to now use the approximate full adder to reduce this column in one stage as it has 3 variables to obtain result[2] and input carry for the next column,

![image](https://github.com/user-attachments/assets/c7c176ba-e625-465a-93cf-01e99e971475)

For the middle column, since it has the most amount of variables (4) and a carry input, it requires the most expensive computation. We first reduced it into 2 variables by using our approximate 4x2 compressor and then utilized our approximate full adder to evaluate the result[3] for this column in 2 stages.

![image](https://github.com/user-attachments/assets/c6313c0e-c196-4ad2-817d-d2a66be0975a)

Calculations for the rest of the result bits, result[4] consists of 3 input variables and a carry which is simplified with the help of the 4x2 compressor considered here in a single stage. 

Result[5] consists of 2 input variables and a carry which can be dealt similarly with the approx full adder that we designed.
Finally, for Result[6] and Result[7], as it consists of the previous carry and a single input variable p33, it is computed using an exact half adder as these leading bits hold significant weightage to the accuracy of the multiplier.


















