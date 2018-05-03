# -*- coding: utf-8 -*-
__author__ = 'lmy'

from scrapy.cmdline import execute

import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
execute(["scrapy", "crawl", "csdn_user_articles_spider"])