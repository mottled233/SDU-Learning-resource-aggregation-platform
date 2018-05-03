# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy
from lxml.doctestcompare import strip
from scrapy.loader.processors import MapCompose, TakeFirst


def trim(value):
    return strip(value)


class csdn_index_item(scrapy.Item):
    # 作品类型
    article_type = scrapy.Field(
        output_processor=TakeFirst()
    )
    # 发布时间
    created_time = scrapy.Field(
        output_processor=TakeFirst()
    )
    # 作者
    nick_name = scrapy.Field(
        output_processor=TakeFirst()
    )
    # 文章标题
    article_title = scrapy.Field(
        input_processor=MapCompose(trim),
        output_processor=TakeFirst()
    )
    # 文章链接
    article_link = scrapy.Field(
        output_processor=TakeFirst()
    )
    # 作者个人主页连接
    user_link = scrapy.Field(
        output_processor=TakeFirst()
    )
    # 文章阅读量
    view_number = scrapy.Field(
        output_processor=TakeFirst()
    )
    # 爬取的时间
    spider_time = scrapy.Field(
        output_processor=TakeFirst()
    )
