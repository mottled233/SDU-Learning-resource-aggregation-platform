#!/usr/bin/env python
# -*- coding: utf-8 -*-

import jieba

def cut(text):
  seg_list = jieba.cut(text)  # 默认是精确模式
  string = ", ".join(seg_list)
  print(string)
  return string