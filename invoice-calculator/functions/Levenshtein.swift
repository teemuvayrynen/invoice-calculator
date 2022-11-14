//
//  Levenshtein.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 14.11.2022.
//

import Foundation

// Minimize 3
public func min3(a: Int, b: Int, c: Int) -> Int {
    
    return min( min(a, c), min(b, c))
    
}

public extension String {
    
    subscript(index: Int) -> Character {
        return self[self.index(startIndex, offsetBy: index)]
    }
    
    subscript(range: Range<Int>) -> String {
        
        let char0 = self.index(startIndex, offsetBy: range.lowerBound)
        
        let charN = self.index(startIndex, offsetBy: range.upperBound)
        
        return String(self[char0..<charN])
        
    }
    
}

public struct Array2D {
    
    var columns: Int
    var rows: Int
    var matrix: [Int]
    
    
    init(columns: Int, rows: Int) {
        
        self.columns = columns
        
        self.rows = rows
        
        matrix = Array(repeating:0, count:columns*rows)
        
    }
    
    subscript(column: Int, row: Int) -> Int {
        
        get {
            
            return matrix[columns * row + column]
            
        }
        
        set {
            
            matrix[columns * row + column] = newValue
            
        }
        
    }
    
    func columnCount() -> Int {
        
        return self.columns
        
    }
    
    func rowCount() -> Int {
        
        return self.rows
        
    }
}

public func levenshtein(sourceString: String, target targetString: String) -> Int {
    
    let source = Array(sourceString.unicodeScalars)
    let target = Array(targetString.unicodeScalars)
    
    let (sourceLength, targetLength) = (source.count, target.count)
    
    var distance = Array2D(columns: sourceLength + 1, rows: targetLength + 1)
    
    for x in 1...sourceLength {
        
        distance[x, 0] = x
        
    }
    
    for y in 1...targetLength {
        
        distance[0, y] = y
        
    }
    
    for x in 1...sourceLength {
        
        for y in 1...targetLength {
            
            if source[x - 1] == target[y - 1] {
                
                // no difference
                distance[x, y] = distance[x - 1, y - 1]
                
            } else {
                
                distance[x, y] = min3(
                    
                    // deletions
                    a: distance[x - 1, y] + 1,
                    // insertions
                    b: distance[x, y - 1] + 1,
                    // substitutions
                    c: distance[x - 1, y - 1] + 1
                    
                )
                
            }
            
        }
        
    }
    
    return distance[source.count, target.count]
    
}

public extension String {
    func getLevenshtein(target: String) -> Int {
        
        return levenshtein(sourceString: self, target: target)
        
    }
    
}
