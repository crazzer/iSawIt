//
//  TVDBApi.swift
//  iSawIt3
//
//  Created by craz on 11.10.15.
//  Copyright © 2015 craz. All rights reserved.
//

import UIKit

//@implementation TVDBApi
//
//@synthesize currentElement;
//@synthesize currentDic;
//@synthesize SeriesName;
//@synthesize SerialsId;
//@synthesize SerialsOverview;
//@synthesize SeriesFirstAired;
//@synthesize SeriesRating;
//@synthesize foundShowArray;



struct SeriesTags {
    static let seriesId = "seriesid"
    static let language = "language"
    static let SeriesName = "SeriesName"
    static let AliasNames = "AliasNames"
    static let banner = "banner"
    static let Overview = "Overview"
    static let FirstAired = "FirstAired"
    static let IMDB_ID = "IMDB_ID"
    static let zap2it_id = "zap2it_id"
    static let Network = "Network"
    
    static func contains(tagName: String) -> Bool {
        return [seriesId, language, SeriesName, AliasNames, banner, Overview, FirstAired, IMDB_ID, zap2it_id, Network].contains(tagName)
    }
}

class TVDBApi: NSObject, NSXMLParserDelegate {
    var foundShows: [Show]
    let APIKey: String = "72AA32193EAB0EDD"
    let mirrorPath: String = "http://www.thetvdb.com/api"
    let getSeriesPath: String = "GetSeries.php?seriesname="
    
    var seriesName: String?
    var seriesId: String?
    var seriesLanguage: String?
    var seriesAliasNames: String?
    var seriesBannerPath: String?
    var seriesOverview: String?
    var seriesFirstAired: String?
    var seriesIMDB: String?
    var seriesZap2It: String?
    var seriesNetwork: String?
    
    var parser: NSXMLParser?
    var currentElement: String?
    
    override init() {
        self.foundShows = [Show]()
        super.init()
        clearCurrentValues()
    }
    
    func searchForTVDBShowsId(showId: Int) {
        let showSearchURL: NSURL = NSURL(string: "\(mirrorPath)/\(APIKey)/series/\(showId)/ru.xml")!
        
        // Очищаем предыдущие результаты
        foundShows.removeAll()
        clearCurrentValues()
        currentElement = nil
        
        self.parser = NSXMLParser(contentsOfURL: showSearchURL)!
        
        // Становимся делегатами для парсера
        parser!.delegate = self
        
        // Парсим
        parser!.parse()
    }
    
    func searchForTVDBShowsName(showName: String) {
        let escapedShowName = showName.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let urlString = "\(mirrorPath)/\(getSeriesPath)\(escapedShowName!)&language=ru"
        let showSearchURL: NSURL = NSURL(string: urlString)!
        foundShows.removeAll()
        clearCurrentValues()
        currentElement = nil
        
        self.parser = NSXMLParser(contentsOfURL: showSearchURL)
        
        parser!.delegate = self
        print("Parsing?")
        if !parser!.parse() {
            print("Parsing failed with error: \(parser?.parserError)!")
        }
    }
    
    
    func clearCurrentValues() {
        self.seriesId = nil
        self.seriesLanguage = nil
        self.seriesName = nil
        self.seriesAliasNames = nil
        self.seriesBannerPath = nil
        self.seriesOverview = nil
        self.seriesFirstAired = nil
        self.seriesIMDB = nil
        self.seriesZap2It = nil
        self.seriesNetwork = nil
    }
    
    
    // MARK: NSXMLParserDelegate
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "Series" {
            // Для каждой новой серии очищаем значения переменных и заполняем словарь пустыми значениями строки
            // (чтобы потом отслеживать в другом классе, где у нас пустые значения) т.к. поля overview 
            // может и не быть, посему мы можем записать в словарь для текущего сериала чужое значение поля
            self.clearCurrentValues()
            self.currentElement = nil
        }
        else if SeriesTags.contains(elementName) {
            self.currentElement = elementName
        }
        else {
            self.currentElement = nil
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == SeriesTags.seriesId {
            self.seriesId = self.seriesId ?? ""
            self.seriesId?.appendContentsOf(string)
        } else if currentElement == SeriesTags.language {
            self.seriesLanguage = self.seriesLanguage ?? ""
            self.seriesLanguage!.appendContentsOf(string)
        } else if currentElement == SeriesTags.SeriesName {
            self.seriesName = self.seriesName ?? ""
            self.seriesName!.appendContentsOf(string)
        } else if currentElement == SeriesTags.Overview {
            self.seriesOverview = self.seriesOverview ?? ""
            self.seriesOverview!.appendContentsOf(string)
        } else if currentElement == SeriesTags.banner {
            self.seriesBannerPath = self.seriesBannerPath ?? ""
            self.seriesBannerPath!.appendContentsOf(string)
        } else if currentElement == SeriesTags.FirstAired {
            self.seriesFirstAired = self.seriesFirstAired ?? ""
            self.seriesFirstAired!.appendContentsOf(string)
        }

    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Series" {
            var id: Int = Int(self.seriesId!.stringByReplacingOccurrencesOfString("\n", withString: ""))!
            if let show = Show(id: id, name: self.seriesName!, language: self.seriesLanguage, overview:  self.seriesOverview, bannerPath: self.seriesBannerPath, firstAired: self.seriesFirstAired) {
                self.foundShows.append(show)
            }
            currentElement = nil
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("End!")
    }
    
}