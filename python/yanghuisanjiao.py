#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
杨辉三角，使用 generator 生成。
yanghuisanjiao, printf in generator.
"""


def triangles():
    L = [1]
    while True:
        yield L
        L.append(0)
        L = [L[i - 1] + L[i] for i in range(len(L))]
# 测试输出十行
# test printf in ten lines.
# n = 0
# for t in triangles():
#     print(t)
#     n = n + 1
#     if n == 10:
#         break
