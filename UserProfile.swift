import Foundation

struct UserProfile: Codable, Identifiable {
    static var  date_formatter = "yyyy-MM-dd"
    var id: String
    var carbon: Double
    var level: Int
    var points: Int
    var userid: String
    var lastCalculationDate: String?
    var dailyFootprintList: [String: UserDailyFootprint]
    
    init(userID: String){
        id = userID
        userid = userID
        carbon = 0
        level = 1
        points = 0
        lastCalculationDate = "1970-01-01"
        dailyFootprintList = [String: UserDailyFootprint]()
    }
    mutating func addDailyTransportStat(date:String, transportStat:TransportationStat){
        var dailyStat = self.dailyFootprintList[date]
        if dailyStat != nil {
            dailyStat?.setTransportation(transStat: transportStat)
        } else {
            dailyStat = UserDailyFootprint(date:date)
            dailyStat?.setTransportation(transStat: transportStat)
        }
        self.dailyFootprintList[date] = dailyStat
    }
    
    mutating func addDailyTransportStat(date:Date, transportStat:TransportationStat){
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: date)
        return addDailyTransportStat(date: dateStr, transportStat: transportStat)
    }
    
    mutating func addDailyUtilityStat(date:String, utilityStat:UtilityStat){
        var dailyStat = self.dailyFootprintList[date]
        if dailyStat != nil {
            dailyStat?.setUtility(utilityStat: utilityStat)
        } else {
            dailyStat = UserDailyFootprint(date:date)
            dailyStat?.setUtility(utilityStat: utilityStat)
        }
        self.dailyFootprintList[date] = dailyStat
    }
    
    mutating func addDailyUtilityStat(date:Date, utilityStat:UtilityStat){
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: date)
        return addDailyUtilityStat(date: dateStr, utilityStat: utilityStat)
    }
    
    mutating func addDailyFoodStat(date:String, foodStat:FoodStat){
        var dailyStat = self.dailyFootprintList[date]
        if dailyStat != nil {
            dailyStat?.setFood(foodStat: foodStat)
        } else {
            dailyStat = UserDailyFootprint(date:date)
            dailyStat?.setFood(foodStat: foodStat)
        }
        self.dailyFootprintList[date] = dailyStat
    }
    
    mutating func addDailyFoodStat(date:Date, foodStat: FoodStat){
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: date)
        return addDailyFoodStat(date: dateStr, foodStat: foodStat)
    }
    
    mutating func addDailyWasteStat(date:String, wasteStat:WasteStat){
        var dailyStat = self.dailyFootprintList[date]
        if dailyStat != nil {
            dailyStat?.setWaste(wasteStat: wasteStat)
        } else {
            dailyStat = UserDailyFootprint(date:date)
            dailyStat?.setWaste(wasteStat: wasteStat)
        }
        self.dailyFootprintList[date] = dailyStat
    }
    
    mutating func addDailyWasteStat(date:Date, wasteStat: WasteStat){
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: date)
        return addDailyWasteStat(date: dateStr, wasteStat: wasteStat)
    }
    
    mutating func addDailyCumulativeStat(date:String, cumulativeStat:CumulativeStat){
        var dailyStat = self.dailyFootprintList[date]
        if dailyStat != nil {
            dailyStat?.setCumulative(cumulativeStat: cumulativeStat)
        } else {
            dailyStat = UserDailyFootprint(date:date)
            dailyStat?.setCumulative(cumulativeStat: cumulativeStat)
        }
        self.dailyFootprintList[date] = dailyStat
    }
    
    mutating func addDailyCumulativeStat(date:Date, cumulativeStat: CumulativeStat){
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: date)
        return addDailyCumulativeStat(date: dateStr, cumulativeStat: cumulativeStat)
    }
    
    func getDailyStat(date:Date)-> UserDailyFootprint{
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: date)
        return self.dailyFootprintList[dateStr] ?? UserDailyFootprint(date:dateStr)
    }
    
    func getTodayStat()-> UserDailyFootprint{
        return getDailyStat(date: Date.now)
    }
    
    func getYesterdayStat()-> UserDailyFootprint{
        let yesterdayStat = getDailyStat(date:(Date.now.addingTimeInterval(-86480)))
        return yesterdayStat
    }
    
    mutating func copyTodayToYesterdayStat() { //For Test Purposes
        let todayStat = getTodayStat()
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: Date.now.addingTimeInterval(-86480))
        var yesterdayStat = UserDailyFootprint(date: dateStr)
        yesterdayStat.transportation = todayStat.transportation
        yesterdayStat.food = todayStat.food
        yesterdayStat.utility = todayStat.utility
        yesterdayStat.waste = todayStat.waste
        self.dailyFootprintList[dateStr] = yesterdayStat
    }
    
    mutating func calculatePoints() {
        let  dateformatter = DateFormatter()
        dateformatter.dateFormat = UserProfile.date_formatter
        let dateStr = dateformatter.string(from: Date.now)
        if lastCalculationDate ?? "1970-01-01" >= dateStr{
            return
        }
        
        let todayStat = getTodayStat()
        let yesterdayStat = getYesterdayStat()
        if todayStat == nil {
            return
        } else if (yesterdayStat == nil) {
            return
        } else {
            if todayStat.transportation?.co2inGrams ?? .zero + Double .zero == 0.0 || todayStat.waste?.co2inGrams ?? .zero + Double .zero == 0.0 || todayStat.utility?.co2inGrams ?? .zero + Double .zero == 0.0 || todayStat.food?.co2inGrams ?? .zero + Double .zero == 0.0 {
                return
            }
            let yesterdayCo2 = yesterdayStat.transportation?.co2inGrams ?? 0.0 + (yesterdayStat.food?.co2inGrams ?? 0.0) + (yesterdayStat.utility?.co2inGrams ?? 0.0) + (yesterdayStat.waste?.co2inGrams ?? 0.0)
            let todayCo2 = todayStat.transportation?.co2inGrams ?? .zero + Double .zero + (todayStat.food?.co2inGrams ?? .zero + Double .zero) + (todayStat.utility?.co2inGrams ?? .zero + Double .zero) + (todayStat.waste?.co2inGrams ?? .zero + Double .zero)
            
            if todayCo2 < yesterdayCo2 {
                points = points + 100
                if points >= 1000 {
                    level = level + 1
                    points = 0
                }
                lastCalculationDate = dateStr
            }
            
        }
    }
    
}

struct UserDailyFootprint: Codable{
    var date: String // in yyyy-MM-dd
    var transportation: TransportationStat?
    var utility: UtilityStat?
    var food: FoodStat?
    var waste: WasteStat?
    var cumulative: CumulativeStat?
    
    init(date:String){
        self.date = date
        self.transportation = TransportationStat()
        self.utility = UtilityStat()
        self.food = FoodStat()
        self.waste = WasteStat()
        self.cumulative = CumulativeStat()
    }
    
    
    mutating func setTransportation(transStat: TransportationStat){
        self.transportation = transStat
    }
    mutating func setUtility(utilityStat: UtilityStat){
        self.utility = utilityStat
    }
    mutating func setFood(foodStat: FoodStat){
        self.food = foodStat
    }
    mutating func setWaste(wasteStat: WasteStat){
        self.waste = wasteStat
    }
    mutating func setCumulative(cumulativeStat: CumulativeStat){
        self.cumulative = cumulativeStat
    }
}

struct TransportationStat: Codable {
    var driving_hours: Double
    var avg_speed: Double
    var miles: Double
    var co2inGrams: Double
    var co2inTons: Double
    init() {
        driving_hours = 0.0
        avg_speed = 0.0
        miles = 0.0
        co2inGrams = 0.0
        co2inTons = 0.0
    }
}

struct UtilityStat: Codable {
    var water: Double
    var electricity: Double
    var co2inGrams: Double
    var co2inTons: Double
    init() {
        water = 0.0
        electricity = 0.0
        co2inGrams = 0.0
        co2inTons = 0.0
    }
}

struct FoodStat: Codable{
    var beefservings: Double
    var porkservings: Double
    var chickenservings: Double
    var lambservings: Double
    var prawnservings: Double
    var cheeseservings: Double
    var co2inGrams: Double
    var co2inTons: Double
    init() {
        beefservings = .zero
        porkservings = .zero
        chickenservings = .zero
        lambservings = .zero
        prawnservings = .zero
        cheeseservings = .zero
        co2inGrams = 0.0
        co2inTons = 0.0
    }
    
}

struct WasteStat: Codable{
    var waste: Double
    var co2inGrams: Double
    var co2inTons: Double
    init() {
        waste = 1.0
        co2inGrams = 0.0
        co2inTons = 0.0
    }
}

struct CumulativeStat: Codable{
    var co2inGrams: Double
    var co2inTons: Double
    init() {
        co2inGrams = 0.0
        co2inTons = 0.0
    }
}
