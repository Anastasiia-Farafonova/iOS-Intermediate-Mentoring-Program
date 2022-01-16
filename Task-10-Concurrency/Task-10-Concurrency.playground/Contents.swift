import Foundation

class GenericContainer<T> {
    private var container = [T]()
    private let concurrentQueue = DispatchQueue(label: "councurrentQueue", attributes: .concurrent)
    private let semaphore = DispatchSemaphore(value: 1)
    
    func append(_ value: T) {
        container.append(value)
    }
    
    func get() -> T? {
        return container.last
    }
    
// MARK: Completed using barrier
    
    func getDataWithBarrier() -> T? {
        concurrentQueue.sync {
            return container.last
        }
    }

    func appendWithBarrier(_ value: T) {
        concurrentQueue.async(flags: .barrier) {
            self.container.append(value)
        }
    }
    
// MARK: Completed using semaphore
    
    func getDataWithSemaphore() -> T? {
        defer {
            semaphore.signal()
        }
        semaphore.wait()
        return container.last
    }

    func appendWithSemaphore(_ value: T) {
        semaphore.wait()
        container.append(value)
        semaphore.signal()
    }
}

let readerWriter = GenericContainer<Int>()

DispatchQueue.concurrentPerform(iterations: 1000) { item in
    if item % 2 == 0 {
        readerWriter.appendWithSemaphore(item)
    } else {
        print(readerWriter.getDataWithSemaphore() ?? "nil")
    }
}

