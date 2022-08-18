suppressMessages(library(pbdMPI))

my_rank = comm.rank()
nranks = comm.size()
msg = paste0("Hello World! My name is Rank", my_rank,
             ". We are ", nranks, " identical siblings.")
cat(msg, "\n")

finalize()
