import json
import time

import MySQLdb
import MySQLdb.cursors
import requests
from twisted.enterprise import adbapi
from twisted.internet import reactor


class CSDNSpider:
    home_url = "https://blog.csdn.net/"
    crawl_url = "https://blog.csdn.net/api/articles?type={type}&category={category}&shown_offset={offset}"
    header = {
        'Accept': 'application/json',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Connection': 'keep-alive',
        'Host': 'www.csdn.net',
        'Referer': 'https://www.csdn.net',
        'server': 'openresty',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',
        'X-Requested-With': 'XMLHttpRequest'
    }

    def __init__(self):
        self.dbparams = dict(
            host='127.0.0.1',
            db='db_spider',
            user='root',
            password='123456',
            charset='utf8',
            cursorclass=MySQLdb.cursors.DictCursor,
        )  # dict中key的名称固定

        self.dbpool = adbapi.ConnectionPool('MySQLdb', **self.dbparams)

    def start(self):
        cookies = requests.get(self.home_url, headers=self.header).cookies

        result = requests.get(self.crawl_url.format(type='more', category='home', offset=int(time.time() * 1000000)),
                              cookies=cookies).text

        offset = json.loads(result)['shown_offset']
        articles = json.loads(result)['articles']
        self.save_articles(articles)

        for i in range(100):
            request = requests.get(self.crawl_url.format(type='more', category='home', offset=offset),
                                   cookies=cookies)
            result = request.text
            articles = json.loads(result)['articles']
            offset = articles[-1]['shown_offset']
            if len(str(offset)) < 16:
                offset = int(offset)*1000000
            print('下载成功，文本内容：{}'.format(result))
            print('offset:{}'.format(offset))
            self.save_articles(articles)

            time.sleep(1)

        reactor.callLater(5, reactor.stop)
        reactor.run()

    def save_articles(self, articles):
        for article in articles:
            self.dbpool.runInteraction(self.do_insert, article)

    def do_insert(self, cursor, item):
        insert_sql = "INSERT INTO csdn_articles VALUES (%s,%s,%s,%s,%s,%s,%s)"
        try:
            cursor.execute(insert_sql, (
                item['category'], item['created_at'], item['user_name'],
                item['title'], item['url'], item['user_url'], item['views']))
        except Exception as e:
            print(e)


def test():
    home_url = "https://blog.csdn.net/api/articles?type=more&category=home&shown_offset={}".format(
        int(time.time() * 1000000))
    crawl_url = "https://blog.csdn.net/api/articles?type={type}&category={category}&shown_offset={offset}"
    cookies = requests.get(home_url).cookies
    offset = int(time.time() * 1000000)
    while True:
        request = requests.get(crawl_url.format(type='more', category='home', offset=offset),
                               cookies=cookies)
        result = request.text
        cookies = request.cookies
        offset = json.loads(result)['shown_offset']
        print(result)
        time.sleep(1)


if __name__ == '__main__':
    spider = CSDNSpider()
    spider.start()
