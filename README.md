# Approximate-Multiplier

This project implements a 4×4 approximate multiplier designed with a customized Dadda tree reduction combined with smart use of compressors to achieve a low-error (7.09% Mean Relative Error over all 256 input combinations), efficient hardware architecture (12 LUTs, an improvement over the exact multiplier which uses 16 LUTs) . The core idea is to prune carries with very low probability of being 1 andusing compressors to reduce stages whenever required thereby reducing hardware complexity and power consumption while maintaining acceptable accuracy.

