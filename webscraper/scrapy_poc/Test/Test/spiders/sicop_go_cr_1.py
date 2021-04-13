from __future__ import absolute_import

from scrapy import Request
from scrapy.linkextractors import LinkExtractor
from scrapy.loader import ItemLoader
from scrapy.loader.processors import Identity
from scrapy.spiders import Rule

from ..utils.spiders import BasePortiaSpider
from ..utils.starturls import FeedGenerator, FragmentGenerator
from ..utils.processors import Item, Field, Text, Number, Price, Date, Url, Image, Regex
from ..items import PortiaItem, MerLinkItem


class SicopGoCr_1(BasePortiaSpider):
    name = "www.sicop.go.cr_1"
    allowed_domains = ['www.sicop.go.cr']
    start_urls = [
        'https://www.sicop.go.cr/usemn/ra/UM_RAJ_RAQ006.jsp?frm_nm=frm_sch&input_nm1=cate_id&input_nm2=cate_nm&cate_id=&cate_nm=']
    rules = [
        Rule(
            LinkExtractor(
                allow=('.*'),
                deny=()
            ),
            callback='parse_item',
            follow=True
        )
    ]
    items = []
