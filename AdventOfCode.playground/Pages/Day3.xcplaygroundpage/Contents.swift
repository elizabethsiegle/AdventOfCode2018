//: [Previous](@previous)

import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int
}
//copied and pasted from day1 lol
var freqs: [Int] = []
let filePath = Bundle.main.path(forResource:"input", ofType: "txt") //get file from Resources
let data = FileManager.default.contents(atPath: filePath!)
let content = String(data: data!, encoding: .utf8)!
let cleanInput = content.split(separator: "\n").map { line -> (id: Int, start: Point, size: Point) in
    let components = line.split(whereSeparator: { " #@,:x".contains($0) }).map { Int($0)! }
    //print(components[0], Point(x: components[1], y: components[2]), Point(x: components[3], y: components[4]))
    return (components[0], Point(x: components[1], y: components[2]), Point(x: components[3], y: components[4]))
}

var part2: Bool = false
var dict: [Point: Int] = [:]
func werk(_ cleanInput: [(id: Int, start: Point, size: Point)]) {
    cleanInput.forEach { el in
        for x in stride(from: el.start.x, to: (el.start.x + el.size.x), by: 1) {
            for y in stride(from: el.start.y, to: (el.start.y + el.size.y), by: 1) {
                dict[Point(x: x, y: y), default: 0] += 1
            }
        }
    }
    print("part 1: ", dict.values.filter({ $0 >= 2 }).count)
    part2 = true
    if part2 {
        outerFor: for el in cleanInput {
            for x in stride(from: el.start.x, to: (el.start.x + el.size.x), by: 1) {
                for y in stride(from: el.start.y, to: (el.start.y + el.size.y), by: 1) {
                    if dict[Point(x: x, y: y)] != 1 {
                        continue outerFor
                    }
                }
            }
            print("part 2: ", el.id)
        }
    }
}
werk(cleanInput)

//: [Next](@next)
