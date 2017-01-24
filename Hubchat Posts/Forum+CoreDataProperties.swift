//
//  Forum+CoreDataProperties.swift
//  
//
//  Created by Jovito Royeca on 24/01/2017.
//
//

import Foundation
import CoreData


extension Forum {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forum> {
        return NSFetchRequest<Forum>(entityName: "Forum");
    }

    @NSManaged public var uuid: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var slug: String?
    @NSManaged public var title: String?
    @NSManaged public var description_: String?
    @NSManaged public var adIntegrations: NSData?
    @NSManaged public var embedded: NSData?
    @NSManaged public var blacklistedWords: NSData?
    @NSManaged public var branding: NSData?
    @NSManaged public var headerImage: NSData?
    @NSManaged public var image: NSData?
    @NSManaged public var ownerUUID: String?
    @NSManaged public var createdByUUID: String?
    @NSManaged public var id: String?
    @NSManaged public var location: String?
    @NSManaged public var settings: NSData?
    @NSManaged public var timestamp: Int64
    @NSManaged public var bannedCount: Int32
    @NSManaged public var channels: NSData?
    @NSManaged public var moderators: NSData?
    @NSManaged public var postCount: Int32
    @NSManaged public var memberCount: Int32
    @NSManaged public var flaggedCount: Int32
    @NSManaged public var joinRquestCount: Int32
    @NSManaged public var createdBy: NSData?
    @NSManaged public var owner: NSData?

}
