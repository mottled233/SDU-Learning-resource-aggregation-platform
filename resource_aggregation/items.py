# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class csdn_item(scrapy.Item):
    # 作品类型
    article_type = scrapy.Field()
    # 发布时间
    created_time = scrapy.Field()
    # 作者
    nick_name = scrapy.Field()
    # 文章标题
    article_title = scrapy.Field()
    # 文章链接
    article_link = scrapy.Field()
    #作者个人主页连接
    user_link = scrapy.Field()
    # 文章阅读量
    view_number = scrapy.Field()
    # 爬取的时间
    spider_time = scrapy.Field()
