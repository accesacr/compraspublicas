import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from scrapy.http import FormRequest
import logging

#from sicop_project.items import PgsCategoryItem


class WgscategoriesLevel1Spider(scrapy.Spider):
    name = 'wgscategories_level1'
    allowed_domains = ['www.sicop.go.cr']
    start_urls = [
        #'https://www.sicop.go.cr/usemn/ra/UM_RAJ_RAQ006.jsp?frm_nm=frm_sch&input_nm1=cate_id&input_nm2=cate_nm&cate_id=&cate_nm='
        'https://www.sicop.go.cr/usemn/ra/UM_RAJ_RAQ006.jsp?/usemn/ra/UM_RAJ_RAQ16.jsp?cate_nm=&input_nm1=cate_id&cate_id=&input_nm2=cate_nm&frm_nm=frm_sch&page_no=1'
    ]
    #custom_settings = {
    #    'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/psg_category_list_spider.log',
    #    'LOG_LEVEL': 'INFO'
    #}

    def parse(self, response):
        category_id_list = []
        for raw_category in response.css('.tdl a'):
            split_category = raw_category.css('::text').get().split(' ]  ', 1)
            category_id = split_category[0][3:]
            category_name = split_category[1]
            category_id_list.append(category_id)
            yield {
               'category_id' : category_id
               ,'category_name' : category_name
            }
        yield from response.follow_all(css='li a', callback=self.parse)

     