The report: The report is a high level description of the software developed and the problem statement. 
Zipped Folder Contents:

- **EDA.ipynb**: Does some rudimentary exploratory data analysis for the dataset. 
- **Cleaning_files.ipynb**: As you mentioned in the meeting, there are some issues with python notebooks, they are resource hungry and if the printed outputs exceeds a certain amount, it renders the notebook ineffective. This notebook contains a function called Remove_Output that removes the output of the notebook and the following cell copies the content of the notebook to a new notebook. 
- **Graph Creation.ipynb:** It contains the code that creates the input dataframe to a graph. A graph consists of nodes and edges. Nodes represent the unique treatment. A unique treatment is defined as jv_id+treatment_name+year. An edge between two nodes represents that these two jobs can be merged meaning that they are either 3 years apart or within 1km radius of each other. This notebook also contains a code to calculate the Haversine distance function. (please note that the utility of this notebook is to create skeleton code for anyone who might be interested in creating a graph based solution. )
- **Graph Contraction.ipynb:** Contains skeleton code for a potential graph contraction strategy. This notebook loads already created graph and has the following functions and data structures:
  - **_unit_costs_**= represents the unit costs, and categories for different treatments. 
  - **_calculate_percentage_change=_** takes in the initial budget matrix (df) and the updated budget matrix (df) and calculates the percentage changes between corresponding entries. 
  - **_calculate_budget_change:_** Takes as input (graph, node_a,node_b,initial_bugets,unit_costs). calculates the effect on the budget matrix as a result of merging two nodes (percentage change) 
  - **_calculate_budget_change_node_level:_** Takes as input (graph, node_a,node_b,initial_bugets,unit_costs). calculates the effect on the budget matrix as a result of merging two nodes (absolute change) 
  - **_calculate_cumulative_effect_from_nodes:_** Takes in a subsets of node couples in the form of list of two member tuples. each member of the list is a tuple consisting of two jobs that are to be merged together. (absolute change).
  - **_calculate_cumulative_effect_from_nodes_percentage:_** Takes in a subsets of node couples in the form of list of two member tuples. each member of the list is a tuple consisting of two jobs that are to be merged together. (percentage change)
  - **_sort_nodes_by_max_percentage_change:_** It finds all the edges of the given node. (All jobs compatible with this job) and sorts them in terms of the maximum change each merger can cause. (Can be used to create a greedy randomised control list for a potential GRASP solution). 
  - _**pick_random_node:**_ Picks a random node from the graph with specified category and year given the unit_costs and graph.
  - has_exceeded_limit: If the given budget matrix violates the 15% change limit.
  - get_categories_and_nodes: Get all the categories and years in the given graph. 
- Matrix Solution: Contains code for a potential grasp based optimization of the given forward works program and uses or has the following functions. 
  - Distance Function: Calculates Haversine Distance between two latitudes and longitudes. (uses numba just in time compilation, the same is also convrted into a cython function that can also be used and is in core_logic.pyx) 
  - check_compatibility functions takes in two unique jobs and finds if they are compatible to each other. 
Then the compatibility matrix is populated for all the jobs.
Then the compatibility matrix is saved in a .csv file. 
Using a list comprehension all the pair of compatible jobs are identified. 
  - merge_jobs functions takes in any two jobs merges them and calculates the difference to the initial budgets using unit costs. 
  - calculate_cumulative_changes: It takes in a subset of jobs pairs and measures the cumulative effect of applying all the job merges from the pairs. 
  - percentage_change: It takes in a list of a pair of jobs and calculates the parentage change to the budget matrix as a result of all the merges. 
  - fitness_score: Is a function that takes in a series of jobs and calculates the fitness of the solution. 
It is 0 if any of the budget change entries exceeds 15
Otherwise it is equal to the length of the subset. 
  - fitness_score_improved: It also adds the entries to of the budget matrix to the length while setting it to zero in the case any of them exceeds 15.
  - initialize_solution: It creates a random subset of compatible jobs taking in the maximum and minimum size as well as the list of compatible jobs.
  - generate_subset: It takes in a list of jobs and generates equal and unique subsets. 
  - merge_optimal_pairs: Takes in an FWP and list of pair of jobs and merges them to create another df and saves it to a csv file. 
  - feasible_solution: Takes in a subset of jobs and finds if that is a feasible solution. find_optimal_subset: Takes in (initial_budgets, compatible_jobs, dataset, unit_costs, max_iterations=1000, initial_subset_size=5), it iterates for a 1000 iterations adds 5 random jobs to the existing jobs and tries to find the maximum sized subset of compatible jobs. 
  - find_optimal_subset_grasp: It takes in the same inputs but uses a greedy strategy. Initially it takes some random jobs finds the categories, years with minimum budget change, finds 5 such jobs and continues. It finds almost twice as many jobs, 
There are some other functions that are part of the skelton code that can be used to develop a solution, 
Feel free to ask any questions about the code and solutions. 