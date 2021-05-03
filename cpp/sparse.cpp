#include <cstdio>
#include <chrono>
#include <vector>
#include <bits/stdc++.h>
#include <iostream>
#include <fstream>
#include "readFile.hpp"

using namespace std;
using namespace std::chrono;

struct hash_pair
{
    template <class T1, class T2>
    size_t operator()(const pair<T1, T2> &p) const
    {
        auto hash1 = hash<T1>{}(p.first);
        auto hash2 = hash<T2>{}(p.second);
        return hash1 ^ hash2;
    }
};

class SparseMatrix
{
private:
    int rows;
    int cols;
    unordered_map<pair<double, double>, double, hash_pair> S;

public:
    SparseMatrix(int rows, int cols, vector<vector<double>> &matrix)
    {
        this->rows = rows;
        this->cols = cols;
        this->S = this->to_sparse(matrix);
    }

    unordered_map<pair<int, int>, double, hash_pair> *to_sparse(vector<vector<double>> &matrix)
    {
        unordered_map<pair<int, int>, double, hash_pair> *S = new unordered_map<pair<int, int>, double, hash_pair>;
        for (int i = 0; i < matrix.size(); ++i)
        {
            for (int j = 0; j < matrix[i].size(); ++j)
            {
                if (matrix[i][j])
                    S[i, j] = matrix[i][j];
            }
        }
        return S;
    }

    // static SparseMatrix *from_dense(vector<vector<double>> &matrix)
    // {
    //     int rows = matrix.size(), cols = matrix[0].size();
    //     unordered_map<pair<double, double>, double, hash_pair> S = this->to_sparse(rows, cols, matrix);
    //     return new SparseMatrix(rows, cols, S);
    // }

    unordered_map<pair<int, int>, double, hash_pair> *multiply(SparseMatrix *B)
    {
        unordered_map<pair<int, int>, double, hash_pair> *C = new unordered_map<pair<int, int>, double, hash_pair>;
        for (auto &keyA : this->S)
        {
            for (auto &keyB : B->S)
            {
                if (keyA.first.second == keyB.first.first)
                {
                    int x = (int)keyA.first.first, y = (int)keyB.first.second;
                    C[x, y] += keyA.second * keyB.second;
                }
            }
        }
        return C;
    }
};

void recordTimes(string filename)
{
    string directory = "../matrices/" + filename;
    std::ofstream myfile;
    myfile.open("../benchmarks.csv", std::ios_base::app); // append instead of overwrite
    vector<vector<double>> matrix = fill_matrix(directory);
    vector<vector<double>> res(matrix.size(), vector<double>(matrix[0].size(), 0.));

    SparseMatrix sparse(matrix.size(), matrix[0].size(), matrix);
    {
        auto start = high_resolution_clock::now();
        sparse.multiply(&sparse);
        auto stop = high_resolution_clock::now();
        auto duration = duration_cast<milliseconds>(stop - start);
        myfile << "cpp,sparse," << filename << "," << res.size() << "," << duration.count() << "\n";
    }
    myfile.close();
}

int main()
{
    recordTimes("can_256.mtx");
    // recordTimes("bcspwr05.mtx");
    // recordTimes("bcspwr07.mtx");
    // recordTimes("bcspwr08.mtx");
    // recordTimes("bcsstk08.mtx");
}

//! g++ sparse.cpp readFile.cpp -o out
// https://www.youtube.com/watch?v=3cdeehULUBo