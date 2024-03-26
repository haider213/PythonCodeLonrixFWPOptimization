
import numpy as np
cimport numpy as np
def calculate_distance(lat1, lon1, lat2, lon2):
    R = 6373.0
    lat1, lon1, lat2, lon2 = np.radians(lat1), np.radians(lon1), np.radians(lat2), np.radians(lon2)
    dlon, dlat = lon2 - lon1, lat2 - lat1
    a = np.sin(dlat / 2)**2 + np.cos(lat1) * np.cos(lat2) * np.sin(dlon / 2)**2
    c = 2 * np.arctan2(np.sqrt(a), np.sqrt(1 - a))
    distance = R * c
    return distance

def cythonized_function(np.ndarray[np.float64_t, ndim=2] distances,
                         np.ndarray[int, ndim=1] treatments_columns,
                         np.ndarray[int, ndim=1] treatment_years,
                         np.ndarray[int, ndim=1] jv_IDs,
                         object G):
    cdef int i, j, year_i, year_j
    cdef double distance
    cdef str treatment_id_i, treatment_id_j

    for i in range(distances.shape[0]):
        for j in range(distances.shape[1]):
            if i != j:
                for treatment_col_i, year_i in zip(treatments_columns, treatment_years):
                    for treatment_col_j, year_j in zip(treatments_columns, treatment_years):
                        distance = distances[i, j]
                        if distance <= 1 and abs(year_i - year_j) <= 3:
                            return True

