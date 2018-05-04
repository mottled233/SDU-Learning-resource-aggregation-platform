# -*- coding: utf-8 -*-
from datetime import datetime

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
from resource_aggregation.items import article_item

class CustomSpiderSpider(CrawlSpider):
    name = 'custom_spider'

    def __init__(self, rule, *a, **kw):
        super().__init__(*a, **kw)
        self.rule = rule
        self.name = rule['name']
        self.allowed_domains = rule['allowed_domains'].split(',')
        self.start_urls = rule['start_urls'].split(',')

        rule_list = []

        rule_list.append(Rule(LinkExtractor(
            allow=rule['allow_url'].split(','),
            unique=True),#链接去重
            follow=True,#跟随爬取
            callback='parse_item'))#调用parse_item提取数据

        self.rules = tuple(rule_list)

    def parse_item(self, response):
        article = article_item()

        article['article_type'] = response.xpath(self.rule['article_type']).extract_first()
        article['created_time'] = response.xpath(self.rule['created_time']).extract_first(datetime.now())
        article['nick_name'] = response.xpath(self.rule['nick_name']).extract_first()
        article['article_title'] = response.xpath(self.rule['article_title']).extract_first()
        article['article_link'] = response.xpath(self.rule['article_link']).extract_first()
        article['user_link'] = response.xpath(self.rule['user_link']).extract_first()
        article['view_number'] = response.xpath(self.rule['view_number']).extract_first()
        article['spider_time'] = datetime.now()
        article['article_content'] = response.xpath(self.rule['article_content']).extract_first()

        yield article