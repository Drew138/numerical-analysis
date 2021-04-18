

# A = [[12, 7, 3],
#     [4, 5, 6],
#     [7, 8, 9]]

# # take a 3x4 matrix
# B = [[5, 8, 1, 2],
#     [6, 7, 3, 0],
#     [4, 5, 9, 1]]

def read_matrices():
    pass


def naive(A, B):
    result = [[sum(a * b for a, b in zip(A_row, B_col))
               for B_col in zip(*B)]
              for A_row in A]
    return result


if __name__ == '__main__':
    A, B = read_matrices()
    res = naive(A, B)
    print(res)
