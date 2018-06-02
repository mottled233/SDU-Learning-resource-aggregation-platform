# -*- coding: utf-8 -*-
import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
import re
from resource_aggregation.items import IpItem


class IpSpider(CrawlSpider):
    name = 'ip'
    allowed_domains = ['xicidaili.com']
    start_urls = ['http://www.xicidaili.com/wt/1/']

    count = 0  # 用于爬取计数， 一般爬取10页就够用

    custom_settings = {
        'DEFAULT_REQUEST_HEADERS': {
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            "Accept-Encoding": "gzip, deflate",
            "Accept-Language": "zh-CN,zh;q=0.9",
            "Cache-Control": "max-age=0",
            "Connection": "keep-alive",
            "Host": "www.xicidaili.com",
            "Upgrade-Insecure-Requests": 1,
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36",
        },
        'DOWNLOADER_MIDDLEWARES': {},
        'ITEM_PIPELINES': {
            'resource_aggregation.pipelines.IpWriterPipeline': 300,
        },
        'DOWNLOAD_DELAY': 5
    }

    rules = (
        Rule(LinkExtractor(allow=r'.*/wt/(\d+)'), callback='parse_item', follow=True),
    )

    def parse_item(self, response):
        raws = response.css('#ip_list tr').extract()  # 获取表格的每一行ip数据 (tr)

        for raw in raws[1:]:
            # 对表格中的每一行除去开头的标题，进行提取
            patternIP = re.compile(r'(?<=<td>)[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}')
            patternPORT = re.compile(r'(?<=<td>)[\d]{2,5}(?=</td>)')

            ip = re.findall(patternIP, raw)
            port = re.findall(patternPORT, raw)

            re.match(patternIP, raw)
            item = IpItem()
            item['ip'] = ip[0]
            item['port'] = port[0]
            yield item

        # 判断爬取的页数是否到达上限
        if self.count == 10:
            return
        else:
            self.count += 1
