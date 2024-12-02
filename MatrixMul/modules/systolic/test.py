import numpy as np

# Định nghĩa hai ma trận
A = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])

B = np.array([
    [10, 11, 12],
    [13, 14, 15],
    [16, 17, 18]
])

# Hàm nhân hai ma trận
def matrix_multiply(matrix_a, matrix_b):
    if matrix_a.shape[1] != matrix_b.shape[0]:
        raise ValueError("Số cột của ma trận A phải bằng số hàng của ma trận B")
    result = np.dot(matrix_a, matrix_b)
    return result

# Tính toán kết quả
result = matrix_multiply(A, B)

# In kết quả
print("Ma trận A:")
print(A)
print("\nMa trận B:")
print(B)
print("\nKết quả của phép nhân ma trận A và B:")
print(result)
