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

## Batch run

parallel --will-cite --jobs 2 < jobs.txt
grep -iIR "Total cycles"

## Collect Results



# Summary of results

Results collected using the following scripts:

- [No High-Level Opts](scripts/outline-affine_for-opt_none-bambu-soft_float-with_ssdcs.sh)
- [With High-Level Opts](scripts/outline-affine_for-opt_full-bambu-soft_float-with_ssdcs.sh)

Important Bambu configurations:

- `soft-float`
- `BAMBU-BALANCED-MP`
- `ALL_BRAM`
- `2 Channels`

## Results

Speedup results given benchmark and problem dimensions (missing values require tiling). 

|             | 2    | 4    | 8     | 16   |
|-------------|------|------|-------|------|
| atax        | 3.6  | 8.8  | 19.5  | 29.6 |
| bicg        | 5.6  | 10.5 | 25.8  | 32.8 |
| gesummv     | 5.1  | 13.0 | 26.7  | 35.4 |
| mvt         | 5.7  | 13.8 | 25.7  | 32.7 |
| doitgen     | 11.0 | 15.0 | 33.7  |      |
| gemm        | 6.4  | 28.4 | 92.1  |      |
| gemver      | 4.3  | 12.4 | 31.7  |      |
| two_mm      | 7.0  | 32.0 | 114.5 |      |
| three_mm    | 10.0 | 43.6 |       |      |
| symm        | 15.3 | 88.5 |       |      |


# Relevant Resources

- [PolyBench/C the Polyhedral Benchmark suite][1]
- [Polybench in MLIR by ScaleHLS][2]

[1]: https://web.cse.ohio-state.edu/~pouchet.2/software/polybench/
[2]: https://github.com/hanchenye/scalehls/tree/master/samples/polybench