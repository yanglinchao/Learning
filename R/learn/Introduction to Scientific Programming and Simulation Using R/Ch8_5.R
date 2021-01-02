setClass("trapTransect",
         representation(distances = "numeric",
                        seed.counts = "numeric",
                        trap.area = "numeric"))

setMethod("initialize",
          "trapTransect",
          function(.Object,
                   distances = numeric(0),
                   seed.counts = numeric(0),
                   trap.area = numeric(0)){
            if(length(distances) != length(seed.counts))
              stop("Lengths of distances and counts differ.")
            if(length(trap.area) != 1)
              stop("Ambiguous trap area.")
            .Object@distances <- distances
            .Object@seed.counts <- seed.counts
            .Object@trap.area <- trap.area
            .Object
          })


s1 <- new("trapTransect",
          distances = 1:4,
          seed.counts = c(4, 3, 2, 0),
          trap.area = 0.0001)
s1

slotNames(s1)
s1@distances

setMethod("mean",
          signature(x = "trapTransect"),
          function(x, ...){
            weighted.mean(x@distances, w = x@seed.counts)
          })

setMethod("show",
          signature(object = "trapTransect"),
          function(object){
            str(object)
          })

mean(s1)
show(s1)
showMethods(classes = "trapTransect")
getMethod("mean", "trapTransect")
