# -*- coding: utf-8 -*-
import json

import re
from datetime import datetime
from urllib.parse import urljoin
from lxml.doctestcompare import strip
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
import requests
from resource_aggregation.items import article_item


class CustomSpiderSpider(CrawlSpider):
    name = 'custom_spider'

    def __init__(self, rule, *a, **kw):
        self.rule = rule
        self.name = rule['name']
        self.allowed_domains = rule['allowed_domains'].split(',')
        self.start_urls = rule['start_urls'].split(',')

        rule_list = []

        # 添加"下一页"链接的规则
        if len(rule['next_page_url']):
            rule_list.append(Rule(
                LinkExtractor(allow=rule['next_page_url'].split(','), restrict_xpaths=rule['next_page_location'].split(','), unique=True),
                follow=True))

        # 链接提取规则
        rule_list.append(Rule(LinkExtractor(
            allow=rule['allow_url'].split(','),
            unique=True),  # 链接去重
            follow=True,  # 跟随爬取
            callback='parse_item'))  # 调用parse_item提取数据

        self.rules = tuple(rule_list)

        # 调用父类构造方法启动爬虫
        super().__init__(*a, **kw)

    def parse_item(self, response):
        article = article_item()

        # 判断爬取的是否为博客园
        cnblogs = False
        for allowed_domain in self.allowed_domains:
            matched = re.match('.*?(cnblogs).*',allowed_domain)
            if matched:
                cnblogs = True

        if  cnblogs:
            matched_url = re.match('.*www.cnblogs.com/.*/p/(\d+).html',response.url)
            postId = matched_url.group(1)
            article['view_number'] = self.get_cnblogs_view_number(postId)
        else:
            view_number_result = \
                strip(response.xpath(self.rule['view_number']).xpath('string(.)').extract_first('')) if self.rule['view_number'] is not None else ''

            match_obj = re.match(r'.*?(\d+).*',view_number_result)

            article['view_number'] = match_obj.group(1) if match_obj is not None else ''

        article['article_type'] = \
            strip(response.xpath(self.rule['article_type']).extract_first('')) if self.rule['article_type'] is not None else ''

        article['created_time'] = \
            response.xpath(self.rule['created_time']).extract_first(datetime.now()) if self.rule['created_time'] is not None else ''

        article['nick_name'] = \
            strip(response.xpath(self.rule['nick_name']).extract_first('')) if self.rule['nick_name'] is not None else ''

        article['article_title'] = \
            strip(response.xpath(self.rule['article_title']).extract_first('')) if self.rule['article_title'] is not None else ''

        article['article_link'] = response.url

        article['user_link'] = \
            urljoin(response.url,strip(response.xpath(self.rule['user_link']).extract_first(''))) \
                if self.rule['user_link'] is not None else ''

        article['spider_time'] = datetime.now()

        article_contents =  response.xpath(self.rule['article_content']).extract() if self.rule['article_content'] is not None else ['']
        article_content = ''
        for i in range(0,len(article_contents)):
            article_content += article_contents[i]

        article['article_content'] = article_content


        yield article


    def get_cnblogs_view_number(self,postId):
        return  requests.get('https://www.cnblogs.com/mvc/blog/ViewCountCommentCout.aspx?postId={}'.format(postId)).text