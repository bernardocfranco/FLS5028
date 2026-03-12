# A simple R script for data analysis

# 1. Create a simple dataset
data <- data.frame(
  id = 1:10,
  score = c(85, 92, 78, 90, 88, 76, 95, 89, 82, 91),
  group = c("A", "B", "A", "B", "A", "A", "B", "B", "A", "B")
)

# 2. Print a summary of the dataset
print("Summary of the dataset:")
print(summary(data))

# 3. Calculate the average score
average_score <- mean(data$score)
print(paste("The average score is:", average_score))

# 4. Perform a simple linear regression
model <- lm(score ~ id, data = data)
print("Linear Regression Summary:")
print(summary(model))

# 5. Save a simple plot (Optional: requires graphics device)
# pdf("score_plot.pdf")
# plot(data$id, data$score, main="Scores by ID", xlab="ID", ylab="Score", col="blue", pch=19)
# dev.off()
