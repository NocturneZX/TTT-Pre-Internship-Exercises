// Playground - noun: a place where people can play

import UIKit

var str = "This is a test"

let newstr : String = str.stringByReplacingOccurrencesOfString("te", withString:
    "gho", options: NSStringCompareOptions.LiteralSearch, range: nil)

println(newstr)

func isStringEqual(firstString: String, secondString: String) -> Bool{
    return (firstString == secondString) ? true: false
}

let first = "This is the first."
let second = "This is the second."
let copyfirst = "This is the first."

isStringEqual(first, second)

isStringEqual(first, copyfirst)



var num = 0
do{
    println(num++)
}while(num <= 100)
println("REAL QUICK!")

class Car {
    var name: String      = ""
    var odometer: Double     = 0
    var driverName = "John Smith"
    func drive(){
        println("This car is a \(self.name) and it's going vroom")
        odometer += 1000
    }
    
    func checkOdometer(){
        println("This car has this much mileage: \(self.name)")
    }
}

class Tesla: Car{
    var charge: Int = 100
    init(aName: String){
        super.init()
        self.driverName = aName
    }
    func setName(aTeslaName: String){ // Superclass
        self.name = aTeslaName
    }
    func setCharge(aCharge: Int){
        self.charge = aCharge
    }
    override func drive() {
        println("This car is a \(self.name) and it's doesn't go vroom. It purrs.")
        odometer += 1000
        charge -= 10
    }
    func checkCharge(){
        if self.charge < 50 && self.charge > 30{
            println("This car has \(self.charge)% charge!")
        }else if self.charge <= 30{
            println("Holy shit. \(self.charge)% CHARGE! Hurry up and refuel.")
        }else{
            println("Charge is \(self.charge)% charge. All systems nominal.")

        }
    }
}

var someCar: Car = Car()
someCar.name = "Old car"
someCar.drive()

var someTesla: Tesla = Tesla(aName: "Julio");
someTesla.setName("Tesla Model Z")
someTesla.drive()
someTesla.drive()
someTesla.checkCharge()
someTesla.drive()
someTesla.checkCharge()
someTesla.drive()
someTesla.drive()
someTesla.drive()
someTesla.drive()
someTesla.checkCharge()

