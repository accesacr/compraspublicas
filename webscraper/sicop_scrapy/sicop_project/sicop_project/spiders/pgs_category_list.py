import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from scrapy.http import FormRequest
import logging

#from sicop_project.items import PgsCategoryItem


class PgsCategoryListSpider(scrapy.Spider):
    name = 'pgs_category_list'
    allowed_domains = ['www.sicop.go.cr']
    start_urls = [
        #'https://www.sicop.go.cr/usemn/ra/UM_RAJ_RAQ006.jsp?frm_nm=frm_sch&input_nm1=cate_id&input_nm2=cate_nm&cate_id=&cate_nm='
        'https://www.sicop.go.cr/usemn/ra/UM_RAJ_RAQ006.jsp?/usemn/ra/UM_RAJ_RAQ16.jsp?cate_nm=&input_nm1=cate_id&cate_id=&input_nm2=cate_nm&frm_nm=frm_sch&page_no=1'
    ]
    #custom_settings = {
    #    'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/psg_category_list_spider.log',
    #    'LOG_LEVEL': 'INFO'
    #}
    """rules = [
        Rule(
            LinkExtractor(
                allow=('.*'),
                deny=()
            ),
            callback='parse',
            follow=True
        )
    ]"""

    #items = [[Item(PgsCategoryItem, None, '.tdl', [Field('Enlace', 'a::attr(href)', [], True), Field('Categoria', '.tdl *::text', [], True)])]]
    def parse(self, response):
#        for raw_category in response.css('.tdl a::attr(onclick)').getall():
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
#        yield {
#            'categories' : response.css('.tdl a::attr(onclick)').getall()
#        }
        yield from response.follow_all(css='li a', callback=self.parse)

        for category_id in category_id_list:
            #logging.info(category_id)
            frmdata = {"frm_nm": "frm_sch", "cate_id": category_id}
            url = "https://www.sicop.go.cr/usemn/ra/UM_RAJ_RAQ006.jsp?page_no=1"
            yield FormRequest(url, callback=self.parse, formdata=frmdata, headers= {
                "Content-Type": "application/x-www-form-urlencoded"
            })
"""
        next_page = response.css('li a::attr(href)').get()
        if next_page is not None:
            next_page = response.urljoin(next_page)
            yield scrapy.Request(next_page, callback=self.parse)"""
"""
        for category in response.css('.tdl a::attr(onclick)'):
            yield {
                '': category.css('span.text::text').get(),
                'author': category.css('small.author::text').get(),
                'tags': quote.css('div.tags a.tag::text').getall(),
            }
"""
"""
    def parse(self, response):
        page = response.url.split("/")[-2]
        filename = f'quotes-{page}.html'
        with open(filename, 'wb') as f:
            f.write(response.body)"""

"""
        def start_requests(self):
        urls = [
            'http://quotes.toscrape.com/page/1/',
            'http://quotes.toscrape.com/page/2/',
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)"""