//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Jovito Royeca on 24/01/2017.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post");
    }

    @NSManaged public var rawContent: String?
    @NSManaged public var forum: NSData?
    @NSManaged public var forumUUID: String?
    @NSManaged public var createdBy: NSData?
    @NSManaged public var createdByUUID: String?
    @NSManaged public var flags: NSData?
    @NSManaged public var cache: NSData?
    @NSManaged public var sort: NSData?
    @NSManaged public var entities: NSData?
    @NSManaged public var stats: NSData?
    @NSManaged public var uuid: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var id: String?
    @NSManaged public var timestamp: Int64
    @NSManaged public var isDeleted_: Bool
    @NSManaged public var isSeen: Bool
    @NSManaged public var hasUpVote: Bool

}
