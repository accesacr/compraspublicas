import scrapy

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
from scrapy.http import FormRequest
import logging

class ProceduresExpedientsDetails(scrapy.Spider):
    name = 'procedures_expedients_details'
    allowed_domains = ['www.sicop.go.cr']
    #global custom_count
    #custom_count = 0
    custom_settings = {
        'LOG_FILE': '/usr/src/app/sicop_project/sicop_project/spider_logs/procedures_expedients_details_spider_test.log',
        'LOG_LEVEL': 'INFO'
    }
    def start_requests(self):
        import csv
        procedure_expedient_id_list = []
        with open('/usr/src/app/sicop_project/sicop_project/other_data/all_procedure_expedients_onlyid_noheaders.csv','rt', encoding='utf-8') as csvfile: 
            reader = csv.reader(csvfile, delimiter=',', quotechar='"') 
            for row in reader:
                #print(', '.join(row))
                #logging.info(row[0])
                procedure_expedient_id_list.append(row)
        #procedure_expedient_id_list.append(["2014CD-000047-0005400001","SC202001000456","20200100304"])

        for procedure_expedient_id in procedure_expedient_id_list:
            # logging.info(category_id)
            frmdata = {
                "page_size": "1000000"
                , "sch_instNo": procedure_expedient_id[0]
                , "sch_cont_ymd1": "01/01/2016"
                , "sch_cont_ymd2": "01/01/2022"
                , "cateIdKey": "cateId.value"
                , "reqNo" : procedure_expedient_id[1]
                , "cartelNo" : procedure_expedient_id[2]
            }
            url = "https://www.sicop.go.cr/moduloPcont/pcont/ctract/es/CE_CEJ_ESQ002.jsp"
            yield FormRequest(url, callback=self.parse, formdata=frmdata, headers={
                "Content-Type": "application/x-www-form-urlencoded"
            })

    def parse(self, response):
        from scrapy.shell import inspect_response
        inspect_response(response, self)
        param_sch_instNo = response.request.body.decode(encoding="utf-8").split("sch_instNo=",1)[1].split("&",1)[0]
        param_reqNo = response.request.body.decode(encoding="utf-8").split("reqNo=",1)[1].split("&",1)[0]
        param_cartelNo = response.request.body.decode(encoding="utf-8").split("cartelNo=",1)[1].split("&",1)[0]
        sections = response.css('div#cont02')
        for section in sections:
            section_header = section.css('h3').get();
            is_section_01 = section_header.find('Información de solicitud de contratación') != -1;
            if is_section_01:
                rows = section.css('table tr.trow');
                has_data = rows[0].get().find('Los datos consultados no existen') == -1;
                if has_data:
                    for row in rows:
                        columns = row.css('td')
                        row_onclick_attr = columns[0].css('a::attr(onclick)').getall()[0];
                        yield {
                            'param_sch_instNo' : param_sch_instNo
                            ,'param_reqNo' : param_reqNo
                            ,'param_cartelNo' : param_cartelNo
                            ,'num_solicitud_contratacion_v1' : '|'.join(columns[0].css('::text').getall()).strip().replace('\r\n', '').replace('\n', '').replace('\t', '').replace('"', '')
                            ,'num_solicitud_contratacion_v2' : row_onclick_attr.replace("fn_contractReq('", '').replace("');return false;", '').replace('"', '')
                            ,'descripcion' : '|'.join(columns[1].css('::text').getall()).strip().replace('\r\n', '').replace('\n', '').replace('\t', '').replace('"', '')
                            ,'identificacion_institucion' : '|'.join(columns[2].css('::text').getall()).strip().replace('\r\n', '').replace('\n', '').replace('\t', '').replace('"', '')
                            ,'fecha_solicitud_contratacion' : '|'.join(columns[3].css('::text').getall()).strip().replace('\r\n', '').replace('\n', '').replace('\t', '').replace('"', '')
                        }
"""     from scrapy.shell import inspect_response
        inspect_response(response, self)
"""