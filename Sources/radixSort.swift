/******************** 
Author: Alex Ramey
Updated: July 8, 2017
********************/

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

public extension Array where Element == Int {

    func radixSort() -> [Int] {
        let positiveNums = self.filter { $0 >= 0 }
        let negaitveNums = self.filter { $0 < 0 }.map { $0 * (-1) }
        return radSort(negaitveNums).reversed().map { $0 * (-1) } + radSort(positiveNums)
    }

    private func radSort(_ input:[Int]) -> [Int] {
        /// TODO: throw an error here if the input contains a negative value
        guard let maxVal = input.max() else { return [] }

        guard maxVal > 0 else { return input }

        let numPasses = Int(floor(log10(Float(maxVal)))) + 1

        let emptyBuckets:[[Int]] = [ [], [], [], [], [], [], [], [], [], [] ]

        var buckets = emptyBuckets
        var partialSolution = input
        var operand = 1

        for _ in 0..<numPasses {
            for elem in partialSolution {
                buckets[(elem / operand) % 10].append(elem)
            }

            partialSolution = Array(buckets.joined())
            buckets = emptyBuckets
            operand *= 10
        }
        
        return partialSolution
    }
}