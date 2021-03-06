

>* What parallelization options exist in Julia?
>* How is multithreading used? 
>* How is multiprocessing used?
>* What are SharedArrays?

Julia has inbuilt automatic parallelism. Consider the multiplication of two large arrays:

```julia
A = rand(10000,10000)
B = rand(10000,10000)

A*B
```

If we run this in a Julia session and monitor the resource usage (e.g. via `top`) we can see that all cores on our computers are used!

