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

    func radixSorted() -> [Int] {
        let positiveNums = self.filter { $0 >= 0 }.map{UInt($0)}
        let negaitveNums = self.filter { $0 < 0 }.map { UInt($0 * (-1)) }
        return radSort(negaitveNums).reversed().map { Int($0) * (-1) } + radSort(positiveNums).map{ Int($0) }
    }

    private func radSort(_ input:[UInt]) -> [UInt] {
        guard let maxVal = input.max() else { return [] }

        guard maxVal > 0 else { return input }

        let numPasses = UInt(floor(log10(Float(maxVal)))) + 1

        let emptyBuckets:[[UInt]] = [ [], [], [], [], [], [], [], [], [], [] ]

        var buckets = emptyBuckets
        var partialSolution = input
        var operand:UInt = 1

        for _ in 0..<numPasses {
            for elem in partialSolution {
                buckets[Int((elem / operand) % 10)].append(elem)
            }

            partialSolution = [UInt](buckets.joined())
            buckets = emptyBuckets
            operand *= 10
        }
        
        return partialSolution
    }
}