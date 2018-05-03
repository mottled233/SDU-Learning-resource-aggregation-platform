# -*- coding: utf-8 -*-
import threading
import time

import schedule

from resource_aggregation import settings

__author__ = 'lmy'

import sys
import MySQLdb
import MySQLdb.cursors
import os
from scrapy.cmdline import execute

sys.path.append(os.path.dirname(os.path.abspath(__file__)))


# execute(["scrapy", "crawl", "csdn_index_spider", "-a", "user_id=cscmaker"])

# 爬取csdn首页
def csdn_index_job():
    print('========================', '开始爬取csdn首页', '========================')
    execute(["scrapy", "crawl", "csdn_index_spider"])


# 爬取csdn指定用户的全部文章
def csdn_user_article_job():
    print('========================', '开始爬取csdn用户全部文章', '========================')
    # 从数据库中获取需要爬取的用户的id
    dbparams = dict(
        host=settings.MYSQL_HOST,
        db=settings.MYSQL_DBNAME,
        user=settings.MYSQL_USER,
        password=settings.MYSQL_PASSWORD,
        charset='utf8',
        cursorclass=MySQLdb.cursors.DictCursor,
    )  # dict中key的名称固定
    db = MySQLdb.connect(**dbparams)
    cursor = db.cursor()
    cursor.execute('SELECT user_id FROM csdn_users')
    data = cursor.fetchone()
    execute(["scrapy", "crawl", "csdn_user_articles_spider", "-a", "user_id=%s" % data['user_id']])

def csdn_index_task():
    threading.Thread(target=csdn_index_job).start()


def csdn_user_article_task():
    threading.Thread(target=csdn_user_article_job).start()


def run():
    schedule.every(8).hour.do(csdn_index_task)  # 每8小时爬取一次
    schedule.every(3).day.at("02:00").do(csdn_user_article_task)  # 每三天凌晨两点爬取一次

    while True:
        schedule.run_pending()
        time.sleep(1)


run()