"""
Package for scraping property sites like rightmove.co.uk.
"""
from scrapy.spiderloader import SpiderLoader
from scrapy.crawler import CrawlerProcess
from scrapy.settings import Settings

from crib import injection


class Scraper(injection.Component):
    config = injection.Infrastructure()

    def __init__(self, name, container) -> None:
        super(Scraper, self).__init__(name, container)
        self.settings = Settings()
        self.settings.setdict(self.config)
        self.settings.set("CONTAINER", container)

    def crawl(self, spider, loglevel):
        settings = self.settings.copy()
        if loglevel:
            settings.set("LOG_ENABLED", True, priority="cmdline")
            settings.set("LOG_LEVEL", loglevel, priority="cmdline")
        process = CrawlerProcess(settings)
        process.crawl(spider)
        process.start()

    def list_spiders(self):
        loader = SpiderLoader.from_settings(self.settings)
        return loader.list()
