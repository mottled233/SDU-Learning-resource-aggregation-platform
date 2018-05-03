# -*- coding: utf-8 -*-
import threading
import time

import schedule
from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

from resource_aggregation import settings

__author__ = 'lmy'

import sys
import MySQLdb
import MySQLdb.cursors
import os
from scrapy.cmdline import execute

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# execute(["scrapy", "crawl", "csdn_index_spider", "-a", "user_id=cscmaker"])

dbparams = dict(
    host=settings.MYSQL_HOST,
    db=settings.MYSQL_DBNAME,
    user=settings.MYSQL_USER,
    password=settings.MYSQL_PASSWORD,
    charset='utf8',
)  # dict中key的名称固定


# 运行动态可配置爬虫
def custom_spider():
    db = MySQLdb.connect(**dbparams)
    cursor = db.cursor()
    cursor.execute('SELECT * FROM custom_spider WHERE enabled=1')
    rules = cursor.fetchall()

    process = CrawlerProcess(get_project_settings())
    for rule in rules:
        process.crawl(custom_spider,rule)

    process.start()
    db.close()


# 爬取csdn首页
def csdn_index_job():
    print('========================', '开始爬取csdn首页', '========================')
    execute(["scrapy", "crawl", "csdn_index_spider"])


# 爬取csdn指定用户的全部文章
def csdn_user_article_job():
    print('========================', '开始爬取csdn用户全部文章', '========================')
    # 从数据库中获取需要爬取的用户的id

    db = MySQLdb.connect(**dbparams)
    cursor = db.cursor()
    cursor.execute('SELECT user_id FROM csdn_users')
    data = cursor.fetchone()
    execute(["scrapy", "crawl", "csdn_user_articles_spider", "-a", "user_id=%s" % data['user_id']])

    db.close()


def csdn_index_task():
    threading.Thread(target=csdn_index_job).start()


def csdn_user_article_task():
    threading.Thread(target=csdn_user_article_job).start()


def run():
    schedule.every(10).hour.do(csdn_index_task)  # 每10小时爬取一次
    schedule.every(3).day.at("02:00").do(csdn_user_article_task)  # 每三天凌晨两点爬取一次

    while True:
        schedule.run_pending()
        time.sleep(1)


###################################
#         注意此处的分割           #
#        以上为函数定义            #
#        以下为函数执行            #
###################################

run()
