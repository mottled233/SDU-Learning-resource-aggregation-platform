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
        if articles is None:
            offset = int(time.time() * 1000000)
        else:
            offset = articles[-1]['shown_offset']

        self.count[category] += 1

        print('记录爬取次数: {}'.format(self.count))

        if len(str(offset)) < 16:
            offset = int(offset) * 1000000

        print('==============================================offset: {}'.format(offset))
        for article in articles:
            item = csdn_item()
            item["article_type"] = category
            item["created_time"] = article['created_at']
            item["nick_name"] = article['nickname']
            item["article_title"] = article['title']
            item["article_link"] = article['url']
            item["user_link"] = article['user_url']
            item["view_number"] = article['views']
            yield item

        if not self.count[category] == 1000:
            url = self.crawl_url.format(type=self.types[0], category=category, offset=offset)
            yield scrapy.Request(url, headers=self.header, meta={'category': category}, callback=self.parse)

    # 首先访问csdn主页，获取cookie
    def start_requests(self):
        yield scrapy.Request(self.home_url, headers=self.header, callback=self.get_offset)

    # 获取offset
    def get_offset(self, response):
        for category in self.categories:
            url = self.crawl_url.format(type=self.types[0], category=category, offset=int(time.time() * 1000000))
            yield scrapy.Request(url, headers=self.header, meta={'category': category}, callback=self.parse)

            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[0],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_0)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[1],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_1)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[2],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_2)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[3],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_3)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[4],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_4)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[5],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_5)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[6],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_6)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[7],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_7)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[8],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_8)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[9],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_9)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[10],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_10)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[11],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_11)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[12],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_12)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[13],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_13)
            #
            #     url = self.crawl_url.format(type=self.types[0], category=self.categories[14],
            #                                 offset=int(time.time() * 1000000))
            #     yield scrapy.Request(url, headers=self.header, callback=self.parse_14)
            #
            # def parse_0(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[0], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_1(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[1], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_2(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[2], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_3(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[3], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_4(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[4], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_5(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[5], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_6(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[6], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_7(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[7], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_8(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[8], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_9(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     articles = json.loads(response.text)['articles']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[9], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_10(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     articles = json.loads(response.text)['articles']
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[00], category=self.categories[10], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_11(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     articles = json.loads(response.text)['articles']
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[11], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_12(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     articles = json.loads(response.text)['articles']
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[12], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_13(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     articles = json.loads(response.text)['articles']
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[13], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
            #
            # def parse_14(self, response):
            #     offset = json.loads(response.text)['shown_offset']
            #     if offset == 0:
            #         offset = int(time.time() * 1000000)
            #     articles = json.loads(response.text)['articles']
            #     for article in articles:
            #         item = csdn_item()
            #         item["article_type"] = article['category']
            #         item["created_time"] = article['created_at']
            #         item["nick_name"] = article['nickname']
            #         item["article_title"] = article['title']
            #         item["article_link"] = article['url']
            #         item["user_link"] = article['user_url']
            #         item["view_number"] = article['views']
            #         yield item
            #
            #     for i in range(10):
            #         url = self.crawl_url.format(type=self.types[0], category=self.categories[14], offset=offset - 10 * i)
            #         yield scrapy.Request(url, headers=self.header, callback=self.parse)
