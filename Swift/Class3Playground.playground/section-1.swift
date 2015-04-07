// Playground - noun: a place where people can play

import UIKit


println("OK. C'mon, C'mon")


var str = "Hello, playground"

func testThisClosure() -> ( ()->() ){
    
    var name = "Jules"
    
    func nestedFunctionInside(){
        name = "Dirty Dan"
        println( "\(name) is in the nested function" )
    }
    
    return nestedFunctionInside
}

var a = testThisClosure()
a()


var dBag = {
    (i: Int, j:Int, s:String)  -> () in
    println("\(i))")
    println("Pinhead Larry")
    
}


dBag(1, 2, "dik")
