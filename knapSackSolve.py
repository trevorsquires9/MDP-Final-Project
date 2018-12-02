"""
Created on Aug  30 

@author: tsquire

Description: Solving the knapsack problem (see below) using dynamic programming

max 3x1 + x2 + 6x3
s.t 4x1 + 5x2 + 10x3 <= 20
"""

import numpy as np

c = np.array([3,1,6])
a= np.array([4,5,10])
d= 20
n= c.size


def KnapSackSolve(costs,weights,cap,varNum):
    valMat = np.zeros([varNum,cap+1])
    decMat = np.zeros([varNum,cap+1])
    for i in range(varNum-1,-1,-1):
        for j in range(cap+1):
            range2Check = int(j/weights[i])
            maxVal = 0
            maxPos = -1
            for k in range(range2Check+1):
                if i == varNum-1:
                    val = k*costs[i]
                else:
                    val = k*costs[i]+valMat[i+1,j-k*weights[i]]
                if val >= maxVal:
                    maxVal = val
                    maxPos = k
            valMat[i,j] = maxVal
            decMat[i,j] = maxPos
    return valMat,decMat

def EvalSolu(valMat,decMat,costs,weights,cap,varNum):
    x = np.zeros(varNum)
    currentCap = cap
    totalCost = 0
    for i in range(varNum):
        x[i] = decMat[i,currentCap]
        totalCost += x[i]*costs[i]
        currentCap -= int(x[i]*weights[i])
    return x,totalCost

valMat,decMat = KnapSackSolve(c,a,d,n)
solu,totalCost = EvalSolu(valMat,decMat,c,a,d,n)
