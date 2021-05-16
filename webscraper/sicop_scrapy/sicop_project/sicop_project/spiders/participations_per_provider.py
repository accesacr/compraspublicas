import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from scrapy.http import FormRequest
import logging

#from sicop_project.items import PgsCategoryItem


class ParticipationsPerProviderSpider(scrapy.Spider):
    name = 'participations_per_provider'
    allowed_domains = ['www.sicop.go.cr']
    #global custom_count
    #custom_count = 0
    #   custom_settings = {
    #    'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/participations_per_provider_spider.log',
    #    'LOG_LEVEL': 'INFO'
    #}
    def start_requests(self):
        import csv
        provider_id_list = []
        with open('/usr/src/app/sicop_project/sicop_project/other_data/all_providers_onlyid_noheaders.csv','rt', encoding='utf-16') as csvfile: 
            reader = csv.reader(csvfile, delimiter=',', quotechar='"') 
            for row in reader:
                #print(', '.join(row))
                #logging.info(row[0])
                provider_id_list.append(row[0])
        for provider_id in provider_id_list:
            # logging.info(category_id)
            url = "https://www.sicop.go.cr/moduloBid/report/EP_REJ_COQ717.jsp?isQuery=Y&biz_reg_no="
            url += provider_id
            url += "&supplier_nm=&proceType=&instNm=&instCd=&submitDtFrom=01/01/2016&submitDtTo=01/01/2021&page_size=100000"
            yield scrapy.Request(url, callback=self.parse)

    def parse(self, response):
        provider_id = response.css('input[name="biz_reg_no"]::attr(value)').get()
        is_first_row_flag = 1
        for row in response.css('table.eptable tr'):
            if is_first_row_flag == 1:
               is_first_row_flag = 0
            else: 
                values = []
                for column in row.css('td'):
                    #value = column.css('::text').get()
                    #if value is None:
                    concat_value = ''
                    value_arr = column.css('::text').getall()
                    if value_arr != []:
                        for value in value_arr:
                            concat_value += value.replace('\n', '|').replace('\t', '|').replace('\r', '|')
                    values.append(concat_value)
                #logging.info(values)
                if values[0].strip().find('Los datos consultados') == -1:
                    yield {
                        'provider_id' : provider_id
                        ,'procedure_num' : values[0].split('|', 1)[0].strip()
                        ,'institution' : values[0].split('|', 1)[1].strip()
                        ,'procedure_num_and_institution' : values[0].strip()
                        ,'budget_item' : values[1].strip()
                        ,'procedure_description' : values[2].strip()
                        ,'opening_act_publication_date' : values[3].strip()
                        ,'opening_act_date' : values[4].strip()
                        ,'budget_amount' : values[5].strip()
                    }
"""                        from scrapy.shell import inspect_response
        inspect_response(response, self)
                provider_id_list = [
            "31011828970"          
        ]
"""