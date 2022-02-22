

>* What parallelization options exist in Julia?
>* How is multithreading used? 
>* How is multiprocessing used?
>* What are SharedArrays?

Julia has inbuilt automatic parallelism. Consider the multiplication of two large arrays:

```julia
A = rand(10000,10000)
B = rand(10000,10000)
