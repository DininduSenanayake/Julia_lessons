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