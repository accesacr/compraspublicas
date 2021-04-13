# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

import logging
#import json
from scrapy.exporters import JsonItemExporter
#from scrapy.exporters import CsvItemExporter

class TestPipeline(object):

    def open_spider(self, spider):
        logging.info("PIPELNE TESTMSG: OPENING SPIDER TEST")
        self.file = open('output.json', 'wb')
        self.exporter = JsonItemExporter(self.file, encoding='utf-8', ensure_ascii=False)
#        self.file = open('output.csv', 'wb')
#        self.exporter = CsvItemExporter(self.file, encoding='utf-8')
        self.exporter.start_exporting()

    def close_spider(self, spider):
        logging.info("PIPELNE TESTMSG: CLOSING SPIDER TEST")
        self.exporter.finish_exporting()
        self.file.close()
        
    def process_item(self, item, spider):
        logging.info("PIPELNE TESTMSG: LOGGING ITEM")
        logging.info(str(item))
#		line = json.dumps(dict(item)) + "\n"
#		self.file.write(line)
        self.exporter.export_item(item)
        return item
