This folder contains a subset of the Polybench benchmarks translated to MLIR.

# Dependencies

- Compile LLVM and SODA-OPT
- Compile Bambu HLS
- Add all binaries to path

# How to run?

```bash
# Navigate to one of the examples
cd code/gemm

# Execute a single example
./run_example.sh

# Execute all examples in the folder
./run_all.sh


# Collect number of cycles
grep -iIR "Total Cycles" | sort
```

# Summary of results

Results collected using the following scripts:

- [No High-Level Opts](scripts/outline-affine-for-optimize-none-bambu-soft-float-with-ssdcs.sh)
- [With High-Level Opts](scripts/outline-affine-for-optimize-full-bambu-soft-float-with-ssdcs.sh)

Important Bambu configurations:

- `soft-float`
- `BAMBU-BALANCED-MP`
- `ALL_BRAM`
- `2 Channels`

## Results

| Benchmark Name | Dimension |   | No High-Level Opts (Cycles) | With High-Level Opts (Cycles) |   | Speedup |
|----------------|----------:|---|----------------------------:|------------------------------:|---|--------:|
| bicg_2         |         2 |   |                          81 |                            18 |   |    4.50 |
| bicg_4         |         4 |   |                         326 |                            33 |   |    9.88 |
| bicg_8         |         8 |   |                        1290 |                            70 |   |   18.43 |
| gemm_2         |         2 |   |                         111 |                            19 |   |    5.84 |
| gemm_4         |         4 |   |                         858 |                            41 |   |   20.93 |
| gemm_8         |         8 |   |                        7050 |                           134 |   |   52.61 |
| gesummv_2      |         2 |   |                         102 |                            25 |   |    4.08 |
| gesummv_4      |         4 |   |                         362 |                            41 |   |    8.83 |
| gesummv_8      |         8 |   |                        1392 |                            97 |   |   14.35 |
| syr2k_2        |         2 |   |                         111 |                            23 |   |    4.83 |
| syr2k_4        |         4 |   |                         786 |                           339 |   |    2.32 |
| syr2k_8        |         8 |   |                        5410 |                          1793 |   |    3.02 |
| syrk_2         |         2 |   |                          85 |                            19 |   |    4.47 |
| syrk_4         |         4 |   |                         586 |                           273 |   |    2.15 |
| syrk_8         |         8 |   |                        3970 |                          1569 |   |    2.53 |


# Relevant Resources

- [PolyBench/C the Polyhedral Benchmark suite][1]
- [Polybench in MLIR by ScaleHLS][2]

[1]: https://web.cse.ohio-state.edu/~pouchet.2/software/polybench/
[2]: https://github.com/hanchenye/scalehls/tree/master/samples/polybench