import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from sicop_project.items import PgsCategoryItem


class PgsCategoryListSpider(scrapy.Spider):
    name = 'pgs_category_list'
    allowed_domains = ['www.sicop.go.cr']
    start_urls = [
        'https://www.sicop.go.cr/usemn/ra/UM_RAJ_RAQ006.jsp?frm_nm=frm_sch&input_nm1=cate_id&input_nm2=cate_nm&cate_id=&cate_nm='
    ]
    #custom_settings = {
    #    'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/psg_category_list_spider.log',
    #    'LOG_LEVEL': 'INFO'
    #}
    rules = [
        Rule(
            LinkExtractor(
                allow=('.*'),
                deny=()
            ),
            callback='parse',
            follow=True
        )
    ]
    #items = [[Item(PgsCategoryItem, None, '.tdl', [Field('Enlace', 'a::attr(href)', [], True), Field('Categoria', '.tdl *::text', [], True)])]]

    def parse(self, response):
        pass
