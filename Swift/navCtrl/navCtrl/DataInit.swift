//
//  DataInit.swift
//  navCtrl
//
//  Created by Aditya Narayan on 2/19/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

import Foundation
import UIKit

class DataInit {
    private var companies = Array<Company>()
    private var products = Array<Product>()
    
    init(){
        self.createDefaultCompaniesAndProducts()
        self.addProductsToCompanies()
    }
    
    func createDefaultCompaniesAndProducts(){
        // Create companies
        var apple:Company = Company()
        apple.name = "Apple"
        apple.CompanyID = 1;
        
        var samsung:Company = Company()
        samsung.name = "Samsung"
        samsung.CompanyID = 2
        
        var google:Company = Company()
        google.name = "Google"
        google.CompanyID = 3
        
        var microsoft:Company = Company()
        microsoft.name = "Microsoft"
        microsoft.CompanyID = 4
        
        self.companies = [apple, samsung, google, microsoft]
        
        var ipod:Product = Product(id: 1, name: "iPod")
        ipod.companyId = apple.CompanyID
        self.products.append(ipod) // Add iPod product class to products array
        
        var ipad:Product = Product(id: 2, name: "iPad")
        ipad.name = "iPad"
        ipad.companyId = apple.CompanyID
        self.products.append(ipad) // Add iPad product class to products array
        
        var iphone:Product = Product(id: 3, name: "iPhone")
        iphone.name = "iPhone"
        iphone.companyId = apple.CompanyID
        self.products.append(iphone) // Add iPhone product class to products array
        
        var s5:Product = Product(id: 4, name: "Galaxy S5")
        s5.companyId = samsung.CompanyID
        self.products.append(s5);
        
        var note4:Product = Product(id: 4, name: "Galaxy Note 4")
        note4.companyId = samsung.CompanyID
        self.products.append(note4)
        
        var nexus5:Product = Product(id: 4, name: "Nexus 5")
        nexus5.companyId = google.CompanyID
        self.products.append(nexus5)

        var nexus10:Product = Product(id: 4, name: "Nexus 10")
        nexus10.companyId = google.CompanyID
        self.products.append(nexus10)
        
        var lumia1320:Product = Product(id: 4, name: "Lumia 1320")
        lumia1320.companyId = microsoft.CompanyID
        self.products.append(lumia1320)
        
        var lumia635:Product = Product(id: 4, name: "Lumia 635")
        lumia635.companyId = microsoft.CompanyID
        self.products.append(lumia635)
        
    } // end createDefaultCompaniesAndProducts()
    
    func addProductsToCompanies(){
        for product in self.products{
            for company in self.companies{
                if(product.companyId == company.CompanyID){
                    company.products.append(product)
                }
            }
        }
    } // end addProductsToCompanies()
    
    func getCompanies() -> Array<Company>{
        return self.companies
    }
    
}