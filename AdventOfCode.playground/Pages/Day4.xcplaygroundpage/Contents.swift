//: [Previous](@previous)

import Foundation

//copied and pasted from day1 lol
var freqs: [Int] = []
let filePath = Bundle.main.path(forResource:"input", ofType: "txt") //get file from Resources
let data = FileManager.default.contents(atPath: filePath!)
let content = String(data: data!, encoding: .utf8)!
let sortedArrSepByNewLine = content.trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: "\n")
    .sorted()

func regex(for reg: String, in txt: String) -> [String] {
    do {
        let rx = try NSRegularExpression(pattern: reg)
        let res = rx.matches(in: txt, range: NSRange(txt.startIndex..., in: txt))
        return res.map { String(txt[Range($0.range, in: txt)!]) }
    } catch let err {
        print("Bad regex: \(err.localizedDescription)")
        return []
    }
}

var dict = Dictionary<Int, (Int, [Int])>() //key: guard ID, value: tuple w/ sleep time + freq arr w/ # times asleep for each min
var currId = 0, startSleep = 0, maxTimesAsleep = 0, mostFreqMin = 0, mostFreqId = 0
var minRegExArr = "(?<=:)(\\d+)", guardRegExArr = "(?<=#)(\\d+)"

sortedArrSepByNewLine.forEach { line in
    let min = Int(regex(for: minRegExArr, in: line)[0])!
    if line.contains("begins shift") {
        currId = Int(regex(for: guardRegExArr, in: line)[0])!
        if dict[currId] == nil { //add to dict if not there yet
            dict[currId] = (0, [Int](repeating: 0, count: 60))
        }
    }
    else if line.contains("asleep") {
        startSleep = min //new time current guard begins sleeping
    }
    else if line.contains("wakes") {
        dict[currId]?.0 += min - startSleep + 1 //mins current guard was asleep
        
        for x in stride(from: startSleep, to: min, by: 1) {
            dict[currId]?.1[x] += 1 //new freq array
            
            //part 2
            if maxTimesAsleep < (dict[currId]?.1[x])! {
                mostFreqMin = x
                maxTimesAsleep = (dict[currId]?.1[x])!
                mostFreqId = currId
            }
        }
    }
}

// Part 1
let guardWithMostSleep = dict.max { a, b in a.value.0 < b.value.0 }!.key
let mostMinsAsleep = dict.max { a, b in a.value.0 < b.value.0 }!.value.1.enumerated().max(by: {$0.element < $1.element})!.offset
print("Part 1: \(guardWithMostSleep * mostMinsAsleep)")
// Part 2
print("Part 2: \(mostFreqMin * mostFreqId)")

//: [Next](@next)
