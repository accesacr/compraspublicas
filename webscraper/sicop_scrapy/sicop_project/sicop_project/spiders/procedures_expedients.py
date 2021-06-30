import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from scrapy.http import FormRequest
import logging

#from sicop_project.items import PgsCategoryItem


class ProceduresExpedients(scrapy.Spider):
    name = 'procedures_expedients'
    allowed_domains = ['www.sicop.go.cr']
    #global custom_count
    #custom_count = 0
    #custom_settings = {
    #    'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/procedures_expedients_spider_test.log',
    #    'LOG_LEVEL': 'INFO'
    #}
    def start_requests(self):
        import csv
        procedure_id_list = []
        #with open('/usr/src/app/sicop_project/sicop_project/other_data/all_procedures_onlyid_noheaders.csv','rt', encoding='utf-8') as csvfile: 
        #    reader = csv.reader(csvfile, delimiter=',', quotechar='"') 
        #    for row in reader:
                #print(', '.join(row))
                #logging.info(row[0])
        #        provider_id_list.append(row[0])
        procedure_id_list.append('2020CD-000001-0007300001')
        for procedure_id in procedure_id_list:
            # logging.info(category_id)
            frmdata = {
                "page_size": "1000000", "sch_instNo": procedure_id, "sch_cont_ymd1": "01/01/2016", "sch_cont_ymd2": "01/01/2022", "cateIdKey": "cateId.value"
            }
            url = "https://www.sicop.go.cr/moduloPcont/pcont/ctract/es/CE_CEJ_ESQ001.jsp"
            yield FormRequest(url, callback=self.parse, formdata=frmdata, headers={
                "Content-Type": "application/x-www-form-urlencoded"
            })

    def parse(self, response):      
        got_results = '|'.join(response.css('tr.trow')[0].css('::text').getall()).strip().find('Los datos consultados') == -1
        if got_results:
            for row in response.css('tr.trow'):
                columns = row.css('td');
                response_onclick_attribute = response.css('tr.trow')[0].css('td')[2].css('a::attr(onclick)').getall()[0];
                response_onclick_attribute_parsing = response.css('tr.trow')[0].css('td')[2].css('a::attr(onclick)').getall()[0].replace("fn_detail('","", 1).replace("');return false;","",1).split("','",1)
                yield {
                    'procedure_num' :'|'.join(response.css('tr.trow')[0].css('td')[0].css('::text').getall()).strip()
                    ,'institution_name' : '|'.join(response.css('tr.trow')[0].css('td')[1].css('::text').getall()).strip()
                    ,'description' : '|'.join(response.css('tr.trow')[0].css('td')[2].css('::text').getall()).strip()
                    ,'contract_request_num' : '|'.join(response.css('tr.trow')[0].css('td')[3].css('::text').getall()).strip()
                    ,'request_datetime' : '|'.join(response.css('tr.trow')[0].css('td')[4].css('::text').getall()).strip()
                    ,'response_onclick_attribute' : response_onclick_attribute
                    ,'parsed_req_num' : response_onclick_attribute_parsing[0]
                    ,'parsed_cartel_num' : response_onclick_attribute_parsing[1]
                }
"""
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
""""""                        from scrapy.shell import inspect_response
        inspect_response(response, self)
                provider_id_list = [
            "31011828970"          
        ]
"""