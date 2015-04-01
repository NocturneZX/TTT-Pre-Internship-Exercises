// Playground - noun: a place where people can play

import UIKit

// if you inherit from NSObject you have access to its members, but the AnyObject is more of a container w/o the same inheritance
// see the Obj.description
//class Person:NSObject {
class Person {
    
    var name:String?
    var address:String?
    
    init(personName:String, personAddress:String) {
        
        self.name = personName
        self.address = personAddress
        
    }
    
    func getName() -> String {
        
        return name!
        
    }
    
    deinit{
        
        var removal = getName()
        println("Removing from memory \(removal)")
    }
    
}



class Employee:Person {
    
    var companyName:String?
    var joinDate:String?
    
    var officeLocation:NSString?  // inherit from NSString obj, which has more functionality that Swift's String Obj
    
    init(personName: String, personAddress: String, personCompanyName:String, personJoinDate:String) {
        
        super.init(personName:personName,personAddress:personAddress)
        
        
        self.companyName = personCompanyName
        self.joinDate = personJoinDate
        
    }
    
}

//Create two Person objects

var nyGuy = Person(personName:"John",personAddress:"Queens, NY")

var caGuy = Person(personName:"Jill",personAddress:"LA, California")


//Create an employee object

var tc = Employee(personName:"TC",personAddress:"LA",personCompanyName:"Apple",personJoinDate:"1998")


var empName = caGuy.getName()

var somebody:AnyObject?

somebody = nyGuy

//Check if someone is an employee or not

if somebody is Employee {
    
    println("an employee")
    
} else {
    
    println("not an employee")
    
}

// 6. ------------- Arrays ------------------

println("\n\n-------------6. Arrays ----------\n\n")

var personArray = [nyGuy, caGuy, tc]

println("Printing names ...")

// for loop to iterate items in an array
//
for person in personArray {
    // p could be AnyObject, but we know it's either Person or Employee, p would also work if Employee b/c it inherits from Person object
    var p:Person
    p = person
    
    println(p.getName())
    
    
    if p is Employee {
        
        println("an employee")
        
    } else {
        
        println("not an employee")
        
    }
    
}
var aGuy = personArray[2]
var howMany = personArray.count
var last = personArray[personArray.count-1]
//var popped = personArray.removeLast()

println(personArray.description) // quickly print info about an object
println(personArray) // if you want a desc, you need to define it in the custom class
//println(tc.description) // doesn't have member if superclass isn't NSObject

//7. ---------- Dictionaries -----------------


println("\n\n ---------- 7. Dictionaries ----------\n\n")

var peopleDirectory = Dictionary<String, Person>() // accepts a String as key, and Person obj as a paired value, this definition isn't available in Obj-C

// pay attention that the key is coming second
//peopleDirectory.updateValue(tc, forKey:"Tim")
peopleDirectory.updateValue(nyGuy, forKey:"John")
peopleDirectory.updateValue(caGuy, forKey:"Jill")
// returns the previous value or nil if it didn't exist
// use case: address book, modifying contact info, give an alert back for success.. 'we updated your address from <prev value> to <new value> OR we created <new value> from <prev nil value>'
var origValue = peopleDirectory.updateValue(tc, forKey:"Tim")
println("origValue = \(origValue)") // first returns nil
origValue = peopleDirectory.updateValue(nyGuy, forKey:"Tim")
println("origValue = \(origValue)")  // second returns prev value


// working example of counting.. interview question

var someList = ["AN", "OG", "AN", "TC", "NY", "TC", "TC"]
// you wanna know how many times each thing appears.. thus counting class

class Counter {
    var count:Int = 0
}

var dict = Dictionary<String, Counter>()  // dictionary  aka hashtable


for obj in someList {
    var currentCount:Counter? = dict[obj]   // optional b/c this can be nil
    if currentCount == nil {
        
        var counterObj = Counter()
        counterObj.count++
        dict[obj] = counterObj
    }
    else {
        
        currentCount!.count = currentCount!.count + 1   // note the ! b/c of optional type
    }
}

for key in dict.keys {
    var obj = dict[key]
    var countObj:Counter = obj!
    println("\(key) \(countObj.count)")
}

/* see pseudo code

result:
AN 2
OG 1
TC 2
NY 1
*/
// other way to set key and value


//Look for someone
var someone:Person? = peopleDirectory["Jill"]


var name = someone!.getName()


//remove Tim from the dictionary

peopleDirectory.removeValueForKey("Tim")

someone = peopleDirectory["Fred"]


for people in peopleDirectory.values {
    
    println(people.getName())
    
}



