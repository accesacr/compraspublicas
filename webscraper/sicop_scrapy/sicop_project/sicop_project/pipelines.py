# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter

import logging
#import json
from scrapy.exporters import JsonItemExporter
#from scrapy.exporters import CsvItemExporter


class SicopProjectPipeline:
    def process_item(self, item, spider):
        return item

class PgsCategoryPipeline(object):

    def open_spider(self, spider):
        logging.info("MANUAL LOG | PgsCategoryPipeline: Opening spider")
        self.file = open('/usr/src/app/sicop_project/sicop_project/crawled_data/output.json', 'wb')
        self.exporter = JsonItemExporter(self.file, encoding='utf-8', ensure_ascii=False)
#        self.file = open('crawled_data/output.csv', 'wb')
#        self.exporter = CsvItemExporter(self.file, encoding='utf-8')
        self.exporter.start_exporting()

    def close_spider(self, spider):
        logging.info("MANUAL LOG | PgsCategoryPipeline: Closing spider")
        self.exporter.finish_exporting()
        self.file.close()
        
    def process_item(self, item, spider):
        logging.info("MANUAL LOG | PgsCategoryPipeline: Preocessing item")
        logging.info(str(item))
#		line = json.dumps(dict(item)) + "\n"
#		self.file.write(line)
        self.exporter.export_item(item)
        return item
