from fillMatrix import recordTimes


def naive(A, B):
    result = [[sum(a * b for a, b in zip(A_row, B_col))
               for B_col in zip(*B)]
              for A_row in A]
    return result


if __name__ == '__main__':

    recordTimes("delaunay_n10.mtx", naive, "naive")
    # recordTimes("bcspwr05.mtx", naive, "naive")
    # recordTimes("bcspwr07.mtx", naive, "naive")
    # recordTimes("bcspwr08.mtx", naive, "naive")
    # recordTimes("bcsstk08.mtx", naive, "naive")
