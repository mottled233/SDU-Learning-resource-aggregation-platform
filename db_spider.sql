
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `article_type` varchar(255) DEFAULT NULL,
  `created_time` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `article_title` varchar(255) DEFAULT NULL,
  `article_link` varchar(255) NOT NULL,
  `user_link` varchar(255) DEFAULT NULL,
  `view_number` varchar(255) DEFAULT NULL,
  `spider_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `article_content` longtext,
  PRIMARY KEY (`article_link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of articles
-- ----------------------------

-- ----------------------------
-- Table structure for csdn_users
-- ----------------------------
DROP TABLE IF EXISTS `csdn_users`;
CREATE TABLE `csdn_users` (
  `user_id` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of csdn_users
-- ----------------------------
INSERT INTO `csdn_users` VALUES ('asd,sad,asd,we', '1');

-- ----------------------------
-- Table structure for custom_spider
-- ----------------------------
DROP TABLE IF EXISTS `custom_spider`;
CREATE TABLE `custom_spider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '' COMMENT '''spider名称''',
  `allowed_domains` varchar(255) DEFAULT '' COMMENT '''字符串.允许爬取的域, 多个域以逗号分隔''',
  `start_urls` varchar(255) DEFAULT '' COMMENT '''爬取的入口, 多个入口以逗号分隔''',
  `next_page_url` varchar(255) DEFAULT NULL COMMENT '''正则表达式,匹配下一页的url''',
  `next_page_location` varchar(255) DEFAULT '' COMMENT '''xpath表达式l, 下一页链接在页面中的位置''',
  `has_next_page_button` int(1) DEFAULT NULL COMMENT '''是否是下拉加载下一页''',
  `allow_url` varchar(255) DEFAULT '' COMMENT '''正则表达式,匹配符合要求的连接''',
  `article_type` varchar(255) DEFAULT NULL COMMENT '''xpath,文章种类''',
  `created_time` varchar(255) DEFAULT NULL COMMENT '''xpath,创建时间''',
  `nick_name` varchar(255) DEFAULT NULL COMMENT '''xpath,用户昵称''',
  `article_title` varchar(255) DEFAULT NULL COMMENT '''xpath,文章标题''',
  `article_link` varchar(255) DEFAULT NULL COMMENT '''xpath,文章连接''',
  `user_link` varchar(255) DEFAULT NULL COMMENT '''xpath,用户主页连接''',
  `view_number` varchar(255) DEFAULT NULL COMMENT '''xpath,阅读量''',
  `article_content` varchar(255) DEFAULT NULL COMMENT '''xpath,文章内容''',
  `enabled` int(1) DEFAULT NULL COMMENT '''是否开启爬取规则''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of custom_spider
-- ----------------------------
INSERT INTO `custom_spider` VALUES ('1', 'ChinaUnix', 'blog.chinaunix.net', 'http://blog.chinaunix.net', 'site/index/page/\\d+\\.html', '//*[@id=\"yw0\"]/li[13]', null, 'uid-\\d+-id-\\d+\\.html', '/html/body/div[2]/div[3]/div[2]/div[1]/div[2]/div[2]/p[1]/text()', '/html/body/div[2]/div[3]/div[2]/div[1]/div[2]/div[2]/p[2]/text()', '/html/body/div[2]/div[3]/div[1]/div[1]/div[1]/p/a/text()', '/html/body/div[2]/div[3]/div[2]/div[1]/div[2]/div[1]/a/text()', '/html/body/div[2]/div[3]/div[2]/div[1]/div[2]/div[1]/a/@href', '/html/body/div[2]/div[3]/div[1]/div[1]/div[1]/p/a/@href', '//div[@class=\'Blog_con2_1 Blog_con3_2\']', '/html/body/div[2]/div[3]/div[2]/div[1]/div[2]/div[3]/div[2]', '0');
INSERT INTO `custom_spider` VALUES ('2', 'ITEYE', 'iteye.com', 'http://www.iteye.com/blogs/subjects,http://www.iteye.com/blogs', '.*\\?page=\\d+,http://www.iteye.com/blogs/subjects/records/\\d+', '//*[@id=\"index_main\"]/div[@class=\'.pagination\']/a[@class=\'.next_page\']', null, '.*/blog/\\d+', '//*[@id=\"main\"]/div[2]/div[7]/ul/li[text()=\'分类:\']/a/text()', '//*[@id=\"main\"]/div[2]/div[7]/ul/li[1]/text()', '//*[@id=\"blog_owner_name\"]/text()', '//*[@id=\"main\"]/div[2]/div[1]/h3/a/text()', '//*[@id=\"main\"]/div[2]/div[1]/h3/a/@href', '//*[@id=\"blog_owner_logo\"]/a/@href', '//*[@id=\"main\"]/div[2]/div[7]/ul/li[2]', '//*[@id=\"blog_content\"]|//*[@id=\"main\"]/div[2]/div[3]', '0');
INSERT INTO `custom_spider` VALUES ('3', 'itpub', 'blog.itpub.net', 'http://blog.itpub.net,http://blog.itpub.net/special/list/', '.*page/\\d+,.*special/show/sid/\\d+', '//*[@id=\"yw0\"]/li[@class=\'.next\']', null, '.*/viewspace-\\d+', '/html/body/div[1]/div[3]/div[2]/div[1]/div[2]/div[2]/p[1]/text()', '/html/body/div[1]/div[3]/div[2]/div[1]/div[2]/div[2]/p[2]/text()', '/html/body/div[1]/div[3]/div[1]/div[1]/div[1]/p/a/text()', '/html/body/div[1]/div[3]/div[2]/div[1]/div[2]/div[1]/a/text()', '/html/body/div[1]/div[3]/div[2]/div[1]/div[2]/div[1]/a/@href', '/html/body/div[1]/div[3]/div[1]/div[1]/div[1]/p/a/@href', '/html/body/div[1]/div[3]/div[2]/div[1]/div[2]/div[3]/div[4]', '/html/body/div[1]/div[3]/div[2]/div[1]/div[2]/div[3]/div[2]', '0');
INSERT INTO `custom_spider` VALUES ('4', 'cnblog', 'cnblogs.com', 'https://home.cnblogs.com/blog/,https://www.cnblogs.com/,https://kb.cnblogs.com/', '.*page/\\d+,/sitehome/p/\\d+', '//*[@id=\"main\"]/div[@class=\'.block_arrow\']/div[@class=\'.pager\'],//*[@id=\"paging_block\"]/div', null, '.*www.cnblogs.com/.*/p/\\d+.html', '//*[@id=\"BlogPostCategory\"]/a[1]/text()', '//*[@id=\"post-date\"]/text()', '//*[@id=\"topics\"]/div/div[3]/a[1]/text()', '//*[@id=\"cb_post_title_url\"]/text()', '//*[@id=\"cb_post_title_url\"]/@href', '//*[@id=\"topics\"]/div/div[3]/a[1]/@href', '//*[@id=\"post_view_count\"]', '//*[@id=\"cnblogs_post_body\"]|//*[@id=\"topics\"]/div', '1');
