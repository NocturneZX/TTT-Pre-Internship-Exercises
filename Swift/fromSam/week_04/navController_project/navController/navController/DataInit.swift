//
//  DataInit.swift
//  navController
//
//  Created by FT_MacBookPro on 2/19/15.
//  Copyright (c) 2015 FTslo. All rights reserved.
//

import Foundation       // what's this  prepopulated
import UIKit            // probably unnecessary for viewController, this you need for a View

class DataInit{
    private var companies = [Company]()
    private var products = [Product]()
    
    init(){
        self.createDefaultCompaniesandProducts()
        self.addProductsToCompanies()
    }
    
    func createDefaultCompaniesandProducts() {
        // manually create companies

        var apple:Company = Company()
        apple.name = "Apple"
        apple.companyId = 1
        
        var samsung:Company = Company()
        samsung.name = "Samsung"
        samsung.companyId = 1
        
        var google:Company = Company()
        google.name = "Google"
        google.companyId = 1
        
        var microsoft:Company = Company()
        microsoft.name = "Microsoft"
        microsoft.companyId = 1
        
        self.companies = [apple, samsung, google, microsoft]
        
        var ipod:Product = Product(id:1, name:"iPod")
        ipod.companyId = 1
        self.products.append(ipod)
        
        var ipad:Product = Product(id:2, name:"iPad")
        ipad.companyId = 1
        self.products.append(ipad)
        
        var iphone:Product = Product(id:3, name:"iPhone")
        iphone.companyId = 1
        self.products.append(iphone)
        
        var s5:Product = Product(id:1, name:"Galaxy S5")
        s5.companyId = 2
        self.products.append(s5)
        
        var note4:Product = Product(id:2, name:"Galaxy Note 4")
        note4.companyId = 2
        self.products.append(note4)
        
        var nexus5:Product = Product(id:1, name:"Nexus 5")
        nexus5.companyId = 3
        self.products.append(nexus5)
        
        var nexus10:Product = Product(id:2, name:"Nexus 10")
        nexus10.companyId = 3
        self.products.append(nexus10)

        var lumia1320:Product = Product(id:1, name:"Lumia 1320")
        lumia1320.companyId = 4
        self.products.append(lumia1320)
        
        var lumia635:Product = Product(id:2, name:"Lumia 635")
        lumia635.companyId = 4
        self.products.append(lumia635)
}
    
    func addProductsToCompanies() {
        
        for product in self.products{
            for company in self.companies{
                if(product.companyId == company.companyId){
                    company.products.append(product)
                }
            }
        }
    }
    
    func getCompanies()->[Company] {
    
        return self.companies
        // returns all the companies.. need this getter b/c companies is a private var
    }
}