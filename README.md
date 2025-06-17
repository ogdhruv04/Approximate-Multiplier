# Approximate-Multiplier

This project implements a 4×4 unsigned approximate multiplier designed with a customized Dadda tree reduction combined with smart use of compressors to achieve a low-error (7.09% Mean Relative Error over all 256 input combinations), efficient hardware architecture (12 LUTs, an improvement over the exact multiplier which uses 16 LUTs) . The core idea is to prune carries with very low probability of being 1 andusing compressors to reduce stages whenever required thereby reducing hardware complexity and power consumption while maintaining acceptable accuracy.

# Algorithm

![image](https://github.com/user-attachments/assets/dc3c4188-cd12-4e48-a58e-71cdbbc743bb)

For our design, we have used this approximate full adder as it simplifies computation, resources utilized while maintaining a respectable accuracy, where output S is correct in 6/8 input combinations and Cout is correct in 7/8 combinations.

![image](https://github.com/user-attachments/assets/953fe9f7-de49-4aa9-875a-fac46ac2dce5)

For this particular half adder, we have not utilized any particular approximations as we used it in higher multiplication stages holding more weightage (MSB).

We have also used this 4x2 approximate compressor which takes four equally-weighted bits and returns one sum bit and one carry bit that is one position higher — effectively replacing two full adders with a single, faster and approximate unit helpful for reducing multiplication columns.



