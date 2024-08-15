//
//  DrawModel.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import Foundation

struct Number: Equatable {
    var number: String
    var isBonusBall: Bool
    
    init(_ number: String, _ isBonusBall: Bool = false) {
        self.number = number
        self.isBonusBall = isBonusBall
    }
}

struct DrawsResponse: Decodable {
    let draws: [Draw]
}

struct Draw: Decodable, Equatable {
    let id: String
    let drawDate: Date
    let topPrize: String
    private(set) var date: String = ""
    private(set) var numbers: [Number] = []
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    enum CodingKeys: String, CodingKey {
        case id, drawDate, number1, number2, number3, number4, number5, number6, topPrize
        case bonusBall = "bonus-ball"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        drawDate = try container.decode(Date.self, forKey: .drawDate)
        let prize = try container.decode(UInt.self, forKey: .topPrize)

        let one = try container.decode(String.self, forKey: .number1)
        let two = try container.decode(String.self, forKey: .number2)
        let three = try container.decode(String.self, forKey: .number3)
        let four = try container.decode(String.self, forKey: .number4)
        let five = try container.decode(String.self, forKey: .number5)
        let six = try container.decode(String.self, forKey: .number6)
        let bonusBall = try container.decode(String.self, forKey: .bonusBall)
        
        topPrize = prize.formatted(.currency(code: "GBP").precision(.fractionLength(.zero)))
        date = formatter.string(from: drawDate)
        numbers += [
            .init(one),
            .init(two),
            .init(three),
            .init(four),
            .init(five),
            .init(six),
            .init(bonusBall, true)
        ]
    }

    init(
        id: String,
        drawDate: Date = .now,
        topPrize: String = "",
        numbers: [Number] = [])
    {
        self.id = id
        self.drawDate = drawDate
        self.topPrize = topPrize
        self.date = formatter.string(from: drawDate)
        self.numbers = numbers
    }
}
