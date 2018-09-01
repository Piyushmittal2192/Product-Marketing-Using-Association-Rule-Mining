# use library arules for handling tranasction data
# use library arulesViz for visulizationof transaction data 
library(arules)
library(arulesViz)

set.seed(42)
setwd("E:/UTD Spring 2018/Course Content/BA with R/Data Set")

# read the data and create transaction objects 
transaction <- read.transactions("transactions.csv", format = "single", sep = ",", cols = c("Transaction", "Product"), rm.duplicates = FALSE)
View(transaction)

#item frequency bar plot for inspecting the item frequency distribution for objects based on rules
itemFrequencyPlot(transaction,topN=10,type="relative")

# find the association rules 
rules <- apriori(transaction, parameter = list(supp = 0.03, conf = 0.20, minlen = 2, maxlen = 4))
# sort the rules
rules <- sort(rules, by="lift", decreasing=TRUE)

# find no. of rules
rules

# Limit value of output to 4 digits
options(digits=4)

# Show rules and summary, count represents appearance of lhs and rhs
summary(rules)
# summary displays only 9 rules so inspect 9 rules
inspect(rules[1:9])
inspect(tail(rules))

# Remove duplicate rules
redundant_index <- is.redundant(rules)
pruned_rules <- rules[!redundant_index]
# find summary
summary(pruned_rules)
# summary displays only 9 rules so inspecting 9 rules
inspect(pruned_rules[1:9])
#plot(rules, measure = c("support", "lift"), shading = "confidence")
#plot(rules, method = "two-key plot")
#interactive plot for association rules
plot(rules, measure=c("support", "lift"), shading = "confidence",interactive = TRUE)
