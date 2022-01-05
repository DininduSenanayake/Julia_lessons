# ...
sequences = read_sequences(infile)

counts = DefaultDict{String, Int8}(0)
for seq in sequences
    for i = 1:length(seq)-k+1
        kmer = seq[i : i+k-1]
        counts[kmer] += 1
    end
end 
# ...
