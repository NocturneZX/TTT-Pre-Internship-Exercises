//
//  Model.swift
//  ShoppingList
//
//  Created by Oren Goldberg on 8/18/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

import UIKit
import CoreData

@objc(Model)
class Model: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var quantity: String
    @NSManaged var info: String
   
}
