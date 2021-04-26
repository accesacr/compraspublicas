import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from scrapy.http import FormRequest
import logging

#from sicop_project.items import PgsCategoryItem


class ProvidersPerWgscategorySpider(scrapy.Spider):
    name = 'providers_per_wgscategory'
    allowed_domains = ['www.sicop.go.cr']
    global custom_count
    custom_count = 0
    # custom_settings = {
    #    'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/psg_category_list_spider.log',
    #    'LOG_LEVEL': 'INFO'
    # }
    def start_requests(self):
        import csv
        category_id_list = []
        with open('/usr/src/app/sicop_project/sicop_project/crawled_data/wgscategories_level4_onlyid_noheader.csv','rt', encoding='utf-16') as csvfile: 
            reader = csv.reader(csvfile, delimiter=',', quotechar='"') 
            for row in reader:
                #print(', '.join(row))
                #logging.info(row[0])
                category_id_list.append(row[0])

        #category_id_list = [
        #    "10101599"
        #    ,"10101501"
        #    ,"10101502"
#
#           
#        ]
        
        for category_id in category_id_list:
            # logging.info(category_id)
            frmdata = {
                "page_size": "1000000"
                ,"cate_id": category_id
                ,"query_fl" : "Y"
                ,"cate_nm" : category_id
            }
            url = "https://www.sicop.go.cr/usemn/co/UM_COJ_CIQ003.jsp"
            yield FormRequest(url, callback=self.parse, formdata=frmdata, headers={
                "Content-Type": "application/x-www-form-urlencoded"
            })

    def parse(self, response):
        category_id = response.css('input[name="cate_id"]::attr(value)').get()
        for row in response.css('.trow'):
            #columns = row.css('td::text').getall()
            values = []
            for column in row.css('td'):
                value = column.css('::text').get()
                if value is None:
                    value = ''
                values.append(value)
            yield {
                'category_id' : category_id
               ,'provider_id' : values[1].strip()
               ,'provider_name' : values[3].strip()
               ,'provider_location' : values[5].strip()
            }
"""        from scrapy.shell import inspect_response
        inspect_response(response, self)
"""
"""        global custom_count
        custom_count = custom_count + 1
        filename = f'providers-' + str(custom_count) + '.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {filename}')
"""
"""
        category_id = response.css('input[name="cate_id"]::attr(value)').get()
        for row in response.css('.trow'):
            #columns = row.css('td::text').getall()
            values = []
            for column in row.css('td'):
                value = column.css('::text').get()
                if value is None:
                	value = ''
                values.append(value)
            yield {
                'category_id' : category_id
               ,'provider_id' : values[1].strip()
               ,'provider_name' : values[3].strip()
               ,'provider_location' : values[5].strip()
            }

            #logging.info(values[0].strip())
"""

"""        from scrapy.shell import inspect_response
        inspect_response(response, self)"""
    	#for raw_category in response.css('.tdl a'):
    	#	logging.info(category_id)
"""filename = f'providers.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {filename}')"""

""""for row in response.css('.trow'):
            #columns = row.css('td::text').getall()
            columns = row.css('td').getall()

            logging.info(columns[0].strip())"""
"""response.css('.trow').css('td')"""
"""
        filename = f'providers.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {filename}')"""