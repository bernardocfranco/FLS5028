# Chord Diagram in R using ggplot2 and ggraph
# Dataset: HairEyeColor (Standard R dataset)

# Necessary libraries (Ensure they are installed: install.packages(c("tidyverse", "ggraph", "igraph")))
library(tidyverse)
library(ggraph)
library(igraph)

# 1. Prepare the dataset (HairEyeColor is a 3D contingency table)
# We'll aggregate across sex to look at Hair vs. Eye color for all individuals
data_table <- margin.table(HairEyeColor, c(1, 2))
df <- as.data.frame(as.table(data_table))

# 2. Convert to an igraph object for ggraph
# We filter out 0 values to keep the plot clean
edges <- df %>%
  filter(Freq > 0) %>%
  rename(from = Hair, to = Eye, weight = Freq)

# 3. Create a graph object
# To make it "chord-like", we treat it as a directed relationship
graph <- graph_from_data_frame(edges, directed = TRUE)

# 4. Generate the beautiful Chord-like diagram
# Using a circular layout and bezier curves for connections
plot <- ggraph(graph, layout = 'linear', circular = TRUE) + 
  # Draw the connections (chords) with transparency based on weight
  geom_edge_diagonal(aes(width = weight, color = node1.name), alpha = 0.5) +
  # Draw the nodes (the Hair/Eye color labels)
  geom_node_point(aes(color = name), size = 8) +
  geom_node_text(aes(label = name), repel = TRUE, size = 5, fontface = "bold") +
  # Styling for the "beautiful" look
  scale_edge_width(range = c(0.5, 4)) +
  scale_edge_color_brewer(palette = "Set3") +
  scale_color_brewer(palette = "Set3") +
  theme_void() +
  labs(
    title = "Chord Diagram: Relationship between Hair and Eye Color",
    subtitle = "Visualized with ggplot2 and ggraph using the HairEyeColor dataset",
    caption = "Source: Standard R HairEyeColor dataset",
    edge_width = "Frequency"
  ) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold", margin = margin(b = 10)),
    plot.subtitle = element_text(hjust = 0.5, size = 12, italic = TRUE, margin = margin(b = 20)),
    plot.margin = margin(20, 20, 20, 20)
  )

# 5. Display the plot
print(plot)

# 6. Save the plot to a PNG file
ggsave("chord_diagram.png", plot, width = 10, height = 10, dpi = 300, bg = "white")

print("Chord diagram generated and saved as 'chord_diagram.png'.")
