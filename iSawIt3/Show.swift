//
//  Show.swift
//  iSawIt3
//
//  Created by craz on 11.10.15.
//  Copyright © 2015 craz. All rights reserved.
//


import UIKit

class Show: NSObject//, NSCoding 
                    {
    
    // MARK: Properties
    
    var id: Int
    var name: String
    var language: String?
    var overview: String?
    var bannerPath: String?
    var firstAired: String?
//    var rating: Int
//    var photo: UIImage?
    
    // MARK: Archiving Paths
    
//    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Types
    
//    struct PropertyKey {
//        static let nameKey = "name"
//        static let photoKey = "photo"
//        static let ratingKey = "rating"
//    }
    
    // MARK: Initialization
    
    init?(id: Int, name: String, language: String?, overview: String?, bannerPath: String?, firstAired: String?) {
        self.id = id
        self.name = name
        self.language = language
        self.overview = overview
        self.bannerPath = bannerPath
        self.firstAired = firstAired
        
        super.init()
        
        // Fail if incorrect
        if name.isEmpty || id < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
//        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
//        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
//        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
//        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
//        
//        self.init(name: name, photo: photo, rating: rating)
//    }
}