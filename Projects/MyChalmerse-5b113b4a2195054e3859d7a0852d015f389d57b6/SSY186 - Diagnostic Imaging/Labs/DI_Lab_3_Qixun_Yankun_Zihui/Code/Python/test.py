# Created by Qixun Qu
# quqixun@gmail.com
# 2017/05/06


# This script is to implement the trained model
# to segment brain tissues in a new slice.


import numpy as np
from dataset import Dataset
from test_model import TestModel


T1_path = 'data/t1_icbm_normal_1mm_pn0_rf0.mnc'
T2_path = 'data/t2_icbm_normal_1mm_pn0_rf0.mnc'
PD_path = 'data/pd_icbm_normal_1mm_pn0_rf0.mnc'
GT_path = 'data/phantom_1.0mm_normal_crisp.mnc'

ds = Dataset()

ds.load_data(T1_path, 'T1', norm=True)
ds.load_data(T2_path, 'T2', norm=True)
ds.load_data(PD_path, 'PD', norm=True)
ds.load_data(GT_path, 'GT')

# Generate training and validation data
CSF_mask = ds.get_mask(ds.GT, values=1, label=1)
GM_mask = ds.get_mask(ds.GT, values=[2, 8], label=2)
WM_mask = ds.get_mask(ds.GT, values=3, label=3)
GT_mask = CSF_mask + GM_mask + WM_mask

# Read a file which consists of all indices of slices
# that can be used for testing purpose
f = open('idx.txt', 'r')
idx = [int(l.split('\n')[0]) for l in f.readlines()]
idx = np.sort(np.array(idx))

idx_median = int(np.median(idx))
idx_pos = np.where(idx == idx_median)[0]

# Use the median index of slice as a test case
# if len(idx_pos) == 0:
    # slice_no = np.where(idx == (idx_median + 1))[0]
# else:
    # slice_no = idx_pos

# Or you can appoint a slice between 0 and len(idx) - 1
# slice_no = 13
# ds.test_data(GT_mask, idx[slice_no])

# Test 90th slice of the volume
ds.test_data(GT_mask, 90)

# Test model
tm = TestModel(ds)
tm.test_model()
tm.compare_slice()
