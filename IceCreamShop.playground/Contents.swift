struct Flavor {
    let name: String
    var rating: Double
}

enum Size: Double {
    case small = 2.99
    case medium = 3.59
    case large = 4.29
}

struct Cone {
    let flavor: Flavor
    let topping: String
    let size: Size
    
    func eat() {
        print("This \(flavor) ice cream is amazing. I can't get enough!")
    }
}

class IceCreamShop {
    var flavors: [Flavor]
    var sizes: [Size]
    var toppings: [String]
    
    var totalSales: Double
    
    init(flavors: [Flavor], sizes: [Size], toppings: [String]) {
        self.flavors = flavors
        self.sizes = sizes
        self.toppings = toppings
        
        totalSales = 0.0
    }
    
    func listTopFlavors() {
        // I could also do this with a for loop, but since I am more than comfortable with loops, I will use filter and map, which I haven't used as much
        let topFlavorNames = flavors.filter({$0.rating > 4.0}).map({ $0.name }).joined(separator: ", ")
        
        print("Our top rated flavors at the moment are \(topFlavorNames).")
    }
    
    func orderCone(flavor: Flavor, topping: String?, size: Size) -> Cone? {
        let cone = Cone(flavor: flavor, topping: topping ?? "None", size: size)
        totalSales += cone.size.rawValue
        
        
        var priceString = "Your \(size) \(flavor) ice cream cone "
        if let topping = topping {
            priceString += "with \(topping) "
        }
        priceString += "is going to be \(cone.size.rawValue)"
        
        return cone
    }
}




