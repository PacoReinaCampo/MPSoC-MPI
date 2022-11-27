###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              Peripheral-NTM for MPSoC                                         ##
##              Neural Turing Machine for MPSoC                                  ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2022-2023 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           ##
##                                                                               ##
###################################################################################

import numpy as np 

class MatrixMathStatitics:
  def __init__(self, data_in, mean):
    self.data_in = data_in
    self.mean = mean

  def ntm_matrix_mean(self):

    data_out = []

    # calculating mean
    for i in range(len(data_in)):
      data_out.append([])

      for j in range(len(data_in[i])):
        temporal = 0.0

        for k in range(len(data_in[i][j])):
          temporal += data_in[i][j][k]/len(data_in[i][j])

        data_out[i].append(temporal)

    return data_out

  def ntm_matrix_deviation(self):

    data_out = []

    # calculating deviation
    for i in range(len(data_in)):
      data_out.append([])

      for j in range(len(data_in[i])):
        temporal = 0.0

        for k in range(len(data_in[i][j])):
          temporal += (data_in[i][j][k] - mean[i][j]) * (data_in[i][j][k] - mean[i][j]) / len(data_in[i][j])

        data_out[i].append(temporal)

    return data_out


data_in = np.random.rand(3,3,3)

mean = np.random.rand(3,3)


math_statitics = MatrixMathStatitics(data_in, mean)
test_statitics = MatrixMathStatitics(data_in, mean)


np.testing.assert_array_equal(math_statitics.ntm_matrix_mean(), test_statitics.ntm_matrix_mean())

np.testing.assert_array_equal(math_statitics.ntm_matrix_deviation(), test_statitics.ntm_matrix_deviation())
