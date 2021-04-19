from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

from sicop_ws.spiders.category import CategorySpider


process = CrawlerProcess(get_project_settings())
process.crawl(CategorySpider)
process.start()
