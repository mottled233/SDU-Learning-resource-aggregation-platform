# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

import MySQLdb
import MySQLdb.cursors
from bs4 import BeautifulSoup
from twisted.enterprise import adbapi
from readability import Document


# def get_article_content(url):
#     result = requests.get(url)
#     readable_article = Document(result.text).summary()
#     return readable_article

class MysqlTwistedPipeline(object):
    def __init__(self, dbpool):
        self.dbpool = dbpool

    @classmethod
    def from_settings(cls, settings):  # 这个方法会被spider调用，并且将settings.py中的值传递进来，然后就可以通过字典的方式读取settings中的值。这个方法的名称固定
        dbparams = dict(
            host=settings['MYSQL_HOST'],
            db=settings['MYSQL_DBNAME'],
            user=settings['MYSQL_USER'],
            password=settings['MYSQL_PASSWORD'],
            charset='utf8',
            cursorclass=MySQLdb.cursors.DictCursor,
        )  # dict中key的名称固定
        dbpool = adbapi.ConnectionPool('MySQLdb', **dbparams)
        return cls(dbpool)

    def process_item(self, item, spider):
        # 使用twisted将mysql插入变成异步执行
        query = self.dbpool.runInteraction(self.do_insert, item)

    def do_insert(self, cursor, item):
        insert_sql = "INSERT INTO articles (article_type,created_time,nick_name,article_title,article_link,user_link,view_number,spider_time,article_content) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"

        # try:
        #     item['article_content'] = get_article_content(item['article_link'])
        # except Exception as e:
        #     print('==========================================','出错啦','======================================')
        #     print(e)
        #     print('==========================================','尝试进行重试','======================================')
        #     time.sleep(1)
        #     item['article_content'] = get_article_content(item['article_link'])

        print('>>>>>>save to db<<<<<<<')
        try:
            cursor.execute(insert_sql, (
                item['article_type'], item['created_time'], item['nick_name'],
                item['article_title'], item['article_link'], item['user_link'], item['view_number'],
                item['spider_time'], item['article_content']))

        except Exception as e:
            print(e)


class FileWriterPipeline(object):

    def __init__(self):
        self.file = open('items2.txt', 'a+', encoding='utf-8')

    def process_item(self, item, spider):
        doc = Document(item['article_content'])
        soup = BeautifulSoup(doc.summary(), 'lxml')
        [s.decompose() for s in soup(['pre'])]  # 删除pre标签
        print('>>>>>>save to file<<<<<<<')
        self.file.write(soup.get_text(strip=True))
        self.file.write('\n')
        # return item  #处理完之后返回item给其他pipeline继续使用


class IpWriterPipeline(object):
    def __init__(self):
        self.file = open('ip2.txt', 'w+', encoding='utf-8')

    def process_item(self, item, spider):
        ip = item['ip']
        port = item['port']
        proxy = 'http://{}:{}'.format(ip, port)

        print('>>>>>>save to file<<<<<<<')
        self.file.write(proxy)
        self.file.write('\n')
