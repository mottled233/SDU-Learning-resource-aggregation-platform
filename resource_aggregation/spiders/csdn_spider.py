import datetime
import json
import time

import re
import scrapy
from scrapy.loader import ItemLoader

from resource_aggregation.items import csdn_index_item


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

        self.count[category] += 1

        print('记录爬取次数: {}'.format(self.count))

        for article in articles:
            item = csdn_index_item()
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
            yield scrapy.Request(url, headers=self.header, meta={'category': category}, callback=self.parse,
                                 dont_filter=True)

    # 首先访问csdn主页，获取cookie
    def start_requests(self):
        yield scrapy.Request(self.home_url, headers=self.header, callback=self.get_offset)

    # 获取offset
    def get_offset(self, response):
        for category in self.categories:
            url = self.crawl_url.format(type=self.types[0], category=category, offset=int(time.time() * 1000000))
            yield scrapy.Request(url, headers=self.header, meta={'category': category}, callback=self.parse)


class csdn_user_articles_spider(scrapy.Spider):
    name = "csdn_user_articles_spider"
    allowed_domains = ["blog.csdn.net"]
    start_urls = ['https://blog.csdn.net/c10WTiybQ1Ye3/article/list/1']
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

    def parse(self, response):
        articles = response.css('.article-list .article-item-box')
        if len(articles) == 0:
            return
        for article in articles:
            article_info = article.css('.info-box')

            view_number = re.match('.*(\d)', article_info.css('.read-num').extract_first())
            item_loader = ItemLoader(item=csdn_index_item(), selector=article)
            item_loader.add_value('article_type', 'personal')
            item_loader.add_css('article_title', '.text-truncate a::text')
            item_loader.add_css('article_link', '.text-truncate a::attr(href)')
            item_loader.add_value('view_number', view_number.group(1))
            item_loader.add_value('created_time', article_info.css('.date::text').extract_first())
            item_loader.add_value('spider_time', datetime.datetime.now())
            item_loader.add_value('nick_name', response.css('.user-info .name a::text').extract_first())
            item_loader.add_value('user_link', response.css('.user-info .name a::attr(href)').extract_first())
            article_item = item_loader.load_item()
            yield article_item

        url = response.url
        page_number = int(url[url.rfind('/')+1:])
        url = url[0:url.rfind('/')+1]
        url += str(page_number + 1)
        yield scrapy.Request(url=url, callback=self.parse)