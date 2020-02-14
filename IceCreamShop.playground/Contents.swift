//MARK: - Model

struct Flavor {
    let name: String
    
    private var _rating = 0.0
    
    var rating: Double {
        get { _rating }
        set {
            if newValue < 0.0 {
                print("You can't give something a negative rating, silly.")
                _rating = 0.0
            } else if newValue > 5.0 {
                print("Our rating scale only goes up to 5.0")
                _rating = 5.0
            } else {
                _rating = newValue
            }
        }
    }
    
    init(name: String, rating: Double) {
        self.name = name
        self.rating = rating
    }
}

enum Size: Double, CaseIterable {
    case small = 2.99
    case medium = 3.59
    case large = 4.29
}

struct Cone {
    let flavor: Flavor
    let topping: String
    let size: Size
    
    func eat() {
        print("This \(flavor.name.lowercased()) ice cream is amazing. I can't get enough!")
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
        let topFlavorNames = flavors.filter({$0.rating > 4.0}).map({ $0.name.lowercased() })
        
        // I could also do this with a for loop, but since I am more than comfortable with loops, I used filter and map, which I haven't used as much
        //        var topFlavorNames = [String]()
        //        for flavor in flavors {
        //            if flavor.rating > 4.0 {
        //                topFlavorNames.append(flavor.name.lowercased())
        //            }
        //        }

        switch topFlavorNames.count {
        case 0:
            print("Sorry, we actually don't have any top flavors right now.")
        case 1:
            print("Our top rated flavor at the moment is \(topFlavorNames[0]).")
        default:
            let topFlavorList = topFlavorNames.dropLast(1).joined(separator: ", ") +
                (topFlavorNames.count > 2 ? "," : "") +
                " and " +
                (topFlavorNames.last ?? "")
            print("Our top rated flavors at the moment are \(topFlavorList).")
        }
        
    }
    
    func orderCone(flavor: Flavor, topping: String?, size: Size) -> Cone? {
        guard flavors.contains(where: { $0.name == flavor.name }) else {
            print("I'm so sorry, we actually don't carry that flavor here.")
            return nil
        }
        
        let cone = Cone(flavor: flavor, topping: topping ?? "None", size: size)
        totalSales += cone.size.rawValue
        
        
        var priceString = "Your \(size) \(flavor.name.lowercased()) ice cream cone "
        if let topping = topping {
            priceString += "with \(topping) "
        }
        priceString += "is going to be \(cone.size.rawValue)."
        print(priceString)
        
        return cone
    }
}


//MARK: - Test Implementation

let vanilla = Flavor(name: "Vanilla", rating: 3.2)
let chocolate = Flavor(name: "Chocolate", rating: 3.9)
let cookiesnCream = Flavor(name: "Cookies N'Cream", rating: 3.8)
let bacon = Flavor(name: "Bacon", rating: 2.1)
let cottonCandy = Flavor(name: "Cotton Candy", rating: 1.3)
let garlic = Flavor(name: "Garlic", rating: 0.1)

let sizes = Size.allCases

let toppings = ["peanuts", "sprinkles", "chocolate shell", "hot fudge", "caramel"]

let heraldsDairyDelight = IceCreamShop(flavors: [vanilla, chocolate, cookiesnCream, bacon, cottonCandy],
                                       sizes: sizes,
                                       toppings: toppings)

// Changing the flavors ratings here to test print statements
heraldsDairyDelight.listTopFlavors()
heraldsDairyDelight.flavors[0] = Flavor(name: "Vanilla", rating: 4.9)
heraldsDairyDelight.listTopFlavors()
heraldsDairyDelight.flavors[1] = Flavor(name: "Chocolate", rating: 4.5)
heraldsDairyDelight.listTopFlavors()
heraldsDairyDelight.flavors[2] = Flavor(name: "Cookies N'Cream", rating: 4.1)
heraldsDairyDelight.listTopFlavors()

let myCone: Cone?
myCone = heraldsDairyDelight.orderCone(flavor: vanilla, topping: "hot fudge", size: .small)
myCone?.eat()
print(heraldsDairyDelight.totalSales)

// Attempting to order a flavor that's not on the menu
let gabbysCone = heraldsDairyDelight.orderCone(flavor: garlic, topping: "hot fudge", size: .small)

// Try to make flavors with invalid ratings
let onion = Flavor(name: "Onion", rating: -4.5)
print("Onion has a rating of \(onion.rating)")

let gold = Flavor(name: "Gold", rating: 11.0)
print("Gold has a rating of \(gold.rating)")



