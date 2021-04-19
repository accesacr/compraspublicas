# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class SicopProjectItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass

"""
class PortiaItem(scrapy.Item):
    fields = defaultdict(
        lambda: scrapy.Field(
            input_processor=Identity(),
            output_processor=Identity()
        )
    )

    def __setitem__(self, key, value):
        self._values[key] = value

    def __repr__(self):
        data = str(self)
        if not data:
            return '%s' % self.__class__.__name__
        return '%s(%s)' % (self.__class__.__name__, data)

    def __str__(self):
        if not self._values:
            return ''
        string = super(PortiaItem, self).__repr__()
        return string
"""

class PgsCategoryItem(scrapy.Item):
    Categoria = scrapy.Field(
        input_processor=Text(),
        output_processor=Join(),
    )
#   CatCode = scrapy.Field(
#       input_processor=Text(),
#       output_processor=Join(),
#   )
    Enlace = scrapy.Field(
        input_processor=Url(),
        output_processor=Join(),
    )