suppressMessages(library(pbdMPI))

my_rank = comm.rank()
ranks = comm.size()
msg = paste0("Hello World! My name is Rank", my_rank,
             ". We are ", ranks, " identical siblings.")
cat(msg, "\n")

finalize()
