# -*- coding: utf-8 -*-
import json

import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
import re

from resource_aggregation.items import IpItem


class IpSpider(CrawlSpider):
    name = 'ip'
    allowed_domains = ['xicidaili.com']
    start_urls = ['http://www.xicidaili.com/wt/1/']

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
        'DOWNLOAD_DELAY': 20
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

            url = 'http://httpbin.org/ip'
            proxy = 'http://' + ip[0] + ':' + port[0]
            meta = {
                # 'proxy': proxy,
                'dont_retry': True,
                'download_timeout': 30,
                '_proxy_ip': ip[0],
                '_proxy_port': port[0]
            }
            yield scrapy.Request(url, callback=self.check_available, meta=meta, dont_filter=True)

    def check_available(self, response):
        proxy_ip = response.meta['_proxy_ip']
        print(proxy_ip)
        print(response.text)

        if proxy_ip == json.loads(response.text)['origin']:
            item = IpItem()
            item['ip'] = proxy_ip
            item['port'] = response.meta['_proxy_port']
            yield item
