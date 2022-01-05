# Below we take a look at a simple 1-d explicit heat diffusion equation, requiring a small stencil, and see how it compares across the languges.
# ...
for i in 2:ngrid+1
  @inbounds temp[i] = 0.
end

temp[1] = tleft
temp[ngrid+2] = tright

for iteration in 1:ntimesteps
  for i in 2:ngrid+1
      @inbounds temp_new[i] = temp[i] + kappa*dt/(dx*dx)*
                      (temp[i-1] - 2*temp[i] + temp[i+1])
  end
  for i in 2:ngrid+1
      @inbounds temp[i] = temp_new[i]
  end
end
# ...