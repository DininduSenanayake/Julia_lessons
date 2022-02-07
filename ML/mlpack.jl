#this is a simple example of how to use the mlpack Principal Component Analysis method on a randon dataset

using mlpack

x = rand(5,5);
print("Input data:\n",x)

print("\nPerforming PCS on dataset.")
y = mlpack.pca(x,new_dimensionality=5)

print("\nPCA result:\n",y)