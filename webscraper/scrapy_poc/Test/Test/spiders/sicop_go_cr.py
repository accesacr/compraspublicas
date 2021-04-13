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


class SicopGoCr(BasePortiaSpider):
    name = "www.sicop.go.cr"
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
    items = [[Item(MerLinkItem, None, '.tdl', [Field('Enlace', 'a::attr(href)', [], True), Field('Categoria', '.tdl *::text', [], True)])]]
#    items = [[Item(MerLinkItem, None, '.tdl', [Field('Categoria', '.tdl *::text', [], True)])]]
#    items = [
#        [
#            Item(
#                MerLinkItem,
#                None,
#                '.tdl',
#                [
#                    Field('field1', 'a::attr(href)', [])])]]
#    items = [
#        [
#            Item(
#                MerLinkItem,
#                'Categoria',
##                '.trow:nth-child(n+3) > .tdl > a, .trow:nth-child(n+3) > tbody > .tdl > a',
#                '.tdl',
#                [])]]
#   items = [
#       [
#           Item(
#               MerLinkItem,
#               'Categoria',
#               '.trow:nth-child(n+3) > .tdl > a, .trow:nth-child(n+3) > tbody > .tdl > a',
#               [])]]
#	items = [
#        [Item(MerLinkItem, None, '.tdl', [Field('field1', 'a::attr(href)', [])])]]
#
#