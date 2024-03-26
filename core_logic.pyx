import numpy as np

def calculate_distance(lat1, lon1, lat2, lon2):
    R = 6373.0
    lat1, lon1, lat2, lon2 = np.radians(lat1), np.radians(lon1), np.radians(lat2), np.radians(lon2)
    dlon, dlat = lon2 - lon1, lat2 - lat1
    a = np.sin(dlat / 2)**2 + np.cos(lat1) * np.cos(lat2) * np.sin(dlon / 2)**2
    c = 2 * np.arctan2(np.sqrt(a), np.sqrt(1 - a))
    distance = R * c
    return distance

def are_treatments_compatible(row_i, row_j):
    for i, row_i in enumerate(dataset.itertuples()):
        for j, row_j in enumerate(dataset.itertuples()):
            if i != j:
                for treatment_col_i, year_i in zip(treatments_columns, treatment_years):
                    for treatment_col_j, year_j in zip(treatments_columns, treatment_years):
                        if (
                            distances[i, j] <= 1
                            and abs(year_i - year_j) <= 3
                        ):