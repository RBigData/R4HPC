library(flexiblas)
flexiblas_avail()
flexiblas_version()
flexiblas_current_backend()
flexiblas_list()
flexiblas_list_loaded()

getthreads = function() {
  flexiblas_get_num_threads()
}
setthreads = function(thr, label = "") {
  cat(label, "Setting", thr, "threads\n")
  flexiblas_set_num_threads(thr)
}
setback = function(backend, label = "") {
  cat(label, "Setting", backend, "backend\n")
  flexiblas_switch(flexiblas_load_backend(backend))
}

#' PT
#' A function to time one or more R expressions after setting the number of
#' threads available to the BLAS library.
#' 
#' !!
#' DO NOT USE PT RECURSIVELY
#'
#' Use: 
#' variable-for-result = PT(your-num-threads, a-quoted-text-comment, {
#'   expression
#'   expression
#'   ...
#'   expression-to-assign
#' })
PT = function(threads, text = "", expr) {
  setthreads(threads, label = text)
  print(system.time({result = {expr}}))
  result
}
