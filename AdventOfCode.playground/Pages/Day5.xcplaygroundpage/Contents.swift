//: [Previous](@previous)

import Foundation

//copied and pasted from day1 lol
var freqs: [Int] = []
let filePath = Bundle.main.path(forResource:"input", ofType: "txt") //get file from Resources
let data = FileManager.default.contents(atPath: filePath!)
let content = String(data: data!, encoding: .utf8)!
var cleanArr = content.split(separator: "\n")
//print(cleanArr)
var inputPolymer = ""
cleanArr.forEach { el in
    inputPolymer += el
}
var final = ""
//part1
let part1 = inputPolymer.reduce("") { (sean, ricky) in
    let thankUNext = String(ricky)
    if !sean.isEmpty {
        final = String(sean.last!)
    }
    if final != String(thankUNext) {
        if final.caseInsensitiveCompare(thankUNext) == ComparisonResult.orderedSame {
            return String(String(sean).dropLast())
        }
    }
    return sean + String(ricky)
}
print(part1.count)

//part 2
let letters = Set(inputPolymer.lowercased()).sorted()
print(letters)
let part2 = letters.reduce([Character: Int]()) { (dict, ari) -> [Character: Int] in
    let polymer2 = inputPolymer.filter { String(ari).caseInsensitiveCompare(String($0)) != ComparisonResult.orderedSame }
    let num = polymer2.reduce("") { (pete, malcolm) in
        let thankUNext = String(malcolm)
        if !pete.isEmpty {
            final = String(pete.last!)
        }
        if final != String(thankUNext) {
            if final.caseInsensitiveCompare(thankUNext) == ComparisonResult.orderedSame {
                //print(pete, malcolm)
                return String(String(pete).dropLast())
            }
        }
        return pete + String(malcolm)
        }.count
    var dict = dict
    dict[ari] = num
    return dict
}
print(part2.values.min()!)
