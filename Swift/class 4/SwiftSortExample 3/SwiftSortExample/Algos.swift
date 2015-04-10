var customMap = {
    
    (a:Int, b:Int ) -> Int in
    
    return a+b
    
    
}

func mapDemo() {
    
    println("-------- START: Algo demo ----------------")
    
    let array = [5, 10, 15]
    
    //let reducedArray = array.reduce(12) { $0 + $1 }
    let reducedArray = array.reduce(100,customMap)
    
    println(reducedArray)
    
    
    println("-------- END: Algo demo ----------------")
    
}

