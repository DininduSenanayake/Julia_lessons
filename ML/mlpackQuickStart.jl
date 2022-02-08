using CSV
using DataFrames
using Libz
using mlpack

# Load the dataset from an online URL.  Replace with 'covertype.csv.gz' if you
# want to use on the full dataset.
df = CSV.read(ZlibInflateInputStream(open(download(
        "http://www.mlpack.org/datasets/covertype-small.csv.gz"))))


# Split the labels.
labels = df[!, :label][:]
dataset = select!(df, Not(:label))

# Split the dataset using mlpack.  The output comes back as a dictionary,
# which we'll unpack for clarity of code.
test, test_labels, train, train_labels = mlpack.preprocess_split(
    input=dataset,
    input_labels=labels,
    test_ratio=0.3)

# Train a random forest.
rf_model, _, _ = mlpack.random_forest(training=train,
                              labels=train_labels,
                              print_training_accuracy=true,
                              num_trees=10,
                              minimum_leaf_size=3)
# Predict the labels of the test points.
_, predictions, _ = mlpack.random_forest(input_model=rf_model,
                                         test=test)


# Now print the accuracy.  The third return value ('probabilities'), which we
# ignored here, could also be used to generate an ROC curve.
correct = sum(predictions .== test_labels)
print("$(correct) out of $(length(test_labels)) test points correct " *
    "($(correct / length(test_labels) * 100.0)%).\n")

