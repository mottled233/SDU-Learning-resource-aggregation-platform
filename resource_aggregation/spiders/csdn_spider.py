import datetime
import json
import time

import scrapy

from resource_aggregation.items import csdn_item


class csdn_index_spider(scrapy.Spider):
    name = "csdn_index_spider"
    allowed_domains = ["blog.csdn.net"]
    categories = ['news', 'ai', 'cloud', 'blockchain', 'db', 'career', 'game', 'engineering',
                  'web', 'mobile',
                  'iot', 'arch', 'avi', 'sec', 'other']
    types = ['more']
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

    count = {'news': 0, 'ai': 0, 'cloud': 0, 'blockchain': 0, 'db': 0, 'career': 0, 'game': 0, 'engineering': 0,
             'web': 0, 'mobile': 0,
             'iot': 0, 'arch': 0, 'avi': 0, 'sec': 0, 'other': 0}

    def parse(self, response):
        category = response.meta.get('category')
        articles = json.loads(response.text)["articles"]
        # if articles is None:
        #     offset = int(time.time() * 1000000)
        # else:
        #     offset = articles[-1]['shown_offset']

        self.count[category] += 1

        print('记录爬取次数: {}'.format(self.count))

        # if len(str(offset)) < 16:
        #     offset = int(offset) * 1000000

        # print('==============================================offset: {}'.format(offset))
        for article in articles:
            item = csdn_item()
            item["article_type"] = category
            item["created_time"] = article['created_at']
            item["nick_name"] = article['nickname']
            item["article_title"] = article['title']
            item["article_link"] = article['url']
            item["user_link"] = article['user_url']
            item["view_number"] = article['views']
            item["spider_time"] = datetime.datetime.now()
            yield item

        if not self.count[category] == 500:
            url = self.crawl_url.format(type=self.types[0], category=category, offset=0)
            yield scrapy.Request(url, headers=self.header, meta={'category': category}, callback=self.parse,dont_filter=True)

    # 首先访问csdn主页，获取cookie
    def start_requests(self):
        yield scrapy.Request(self.home_url, headers=self.header, callback=self.get_offset)

    # 获取offset
    def get_offset(self, response):
        for category in self.categories:
            url = self.crawl_url.format(type=self.types[0], category=category, offset=int(time.time() * 1000000))
            yield scrapy.Request(url, headers=self.header, meta={'category': category}, callback=self.parse)
