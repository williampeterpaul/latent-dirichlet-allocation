source("packages.R")
source("configuration.R")
source("preprocess.R")
source("query.R")

# Produce documentTermMatrix
documentTermMatrix = produceDtm(data$content)
documentTermMatrix.nonEmpty = unique(documentTermMatrix$i)

# Remove empty documents from matrix
documentTermMatrix = documentTermMatrix[documentTermMatrix.nonEmpty,]
removed = data[-documentTermMatrix.nonEmpty,]
data = data[documentTermMatrix.nonEmpty,]

# Lda model with Gibbs sampling
topicModel = LDA(
  documentTermMatrix,
  topics,
  method = "Gibbs",
  control = list(seed = 1, burnin = 1000, thin = 100, iter = 1000)
)

terms = as.data.frame(terms(topicModel, 200))
gamma = as.data.frame(posterior(topicModel, documentTermMatrix)$topics)

data = cbind(data, cbind(
  topic = apply(gamma, 1, function(x) { paste(names(gamma)[which(x == max(x))], collapse = ",") }),
  gamma = apply(gamma, 1, function(x) { max(x) })
))