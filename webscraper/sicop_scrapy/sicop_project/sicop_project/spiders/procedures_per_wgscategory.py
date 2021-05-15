import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from scrapy.http import FormRequest
import logging

#from sicop_project.items import PgsCategoryItem


class ProceduresPerWgscategorySpider(scrapy.Spider):
    name = 'procedures_per_wgscategory'
    allowed_domains = ['www.sicop.go.cr']

    #custom_settings = {
    #    'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/procedures_per_wgscategory_level4_spider.log',
    #    'LOG_LEVEL': 'INFO'
    # }
    def start_requests(self):
        import csv
        category_id_list = []
        with open('/usr/src/app/sicop_project/sicop_project/crawled_data/wgscategories_level4_onlyid_noheader.csv', 'rt', encoding='utf-16') as csvfile:
            reader = csv.reader(csvfile, delimiter=',', quotechar='"')
            for row in reader:
                #print(', '.join(row))
                # logging.info(row[0])
                category_id_list.append(row[0])

        for category_id in category_id_list:
            # logging.info(category_id)
            frmdata = {
                "page_size": "1000000", "cateId": category_id, "sch_cont_ymd1": "01/01/2016", "sch_cont_ymd2": "01/01/2021", "cateIdKey": "cateId.value"
            }
            url = "https://www.sicop.go.cr/moduloPcont/pcont/ctract/es/CE_CEJ_ESQ001.jsp"
            yield FormRequest(url, callback=self.parse, formdata=frmdata, headers={
                "Content-Type": "application/x-www-form-urlencoded"
            })

    def parse(self, response):
        #category_id = response.css('input[name="cateId"]::attr(value)').get()
        category_id = response.request.body.decode(encoding="utf-8").split("cateId=",1)[1].split("&",1)[0]
        for row in response.css('.trow'):
            #columns = row.css('td::text').getall()
            values = []
            for column in row.css('td'):
                value = column.css('::text').get()
                if value is None:
                    value = ''
                values.append(value)
            if values[0].strip() != 'Los datos consultados no existen.':
                yield {
                    'category_id': category_id                , 'procedure_num' : values[0].strip()
                   , 'institution_name': values[1].strip()
                   , 'description': values[2].strip()
                   , 'num_contract_request': values[3].strip()
                   , 'request_date_time': values[4].strip()
                }

            # logging.info(values[0].strip())


"""        from scrapy.shell import inspect_response
        inspect_response(response, self)"""
      # for raw_category in response.css('.tdl a'):
      #	logging.info(category_id)
"""filename = f'procedures.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {filename}')"""

""""for row in response.css('.trow'):
            #columns = row.css('td::text').getall()
            columns = row.css('td').getall()

            logging.info(columns[0].strip())"""
"""response.css('.trow').css('td')"""
"""
        filename = f'procedures.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {filename}')"""
""" CATEGORIES LEVEL 1
    def start_requests(self):
        category_id_list = [
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "20",
            "21",
            "22",
            "23",
            "86",
            "90",
            "91",
            "92",
            "93",
            "94",
            "95",
            "73",
            "76",
            "77",
            "78",
            "80",
            "81",
            "82",
            "83",
            "84",
            "85",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "20",
            "21",
            "22",
            "23",
            "52",
            "53",
            "54",
            "55",
            "56",
            "60",
            "64",
            "70",
            "71",
            "72",
            "42",
            "43",
            "44",
            "45",
            "46",
            "47",
            "48",
            "49",
            "50",
            "51",
            "24",
            "25",
            "26",
            "27",
            "30",
            "31",
            "32",
            "39",
            "40",
            "41"
        ]

        for category_id in category_id_list:
            # logging.info(category_id)
            frmdata = {
                "page_size": "1000000"
                ,"cateId": category_id, "sch_cont_ymd1" : "01/01/2016"
                , "sch_cont_ymd2" : "01/01/2021"
                ,"cateIdKey" : "cateId.value"
            }
            url = "https://www.sicop.go.cr/moduloPcont/pcont/ctract/es/CE_CEJ_ESQ001.jsp"
            yield FormRequest(url, callback=self.parse, formdata=frmdata, headers={
                "Content-Type": "application/x-www-form-urlencoded"
            })"""