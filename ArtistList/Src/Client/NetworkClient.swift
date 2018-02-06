//
//  NetworkClient.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class NetworkClient {
    
    let queue: OperationQueue
    
    init() {
        
        self.queue = OperationQueue()
        self.queue.maxConcurrentOperationCount = 5
    }
    
    func invalidate () -> Void {
        
        self.queue.cancelAllOperations()
    }
    
    func addRequest(request: URLRequest, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        
        let operation: NetworkOperation = NetworkOperation(request: request, requestCompletionHandler: completion)
        self.queue.addOperation(operation)
    }
}

class NetworkOperation: AsynchronousOperation {
    
    private let request: URLRequest
    private var requestCompletionHandler: ((_ data: Data?, _ urlResponse: URLResponse?, _ error: Error?) -> ())?
    private var task: URLSessionTask?
    
    init(request: URLRequest, requestCompletionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        self.request = request
        self.requestCompletionHandler = requestCompletionHandler
        super.init()
    }
    
    override func main() {
    
        let task: URLSessionTask = URLSession.shared.dataTask(with: self.request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.requestCompletionHandler?(data, response, error)
            self.requestCompletionHandler = nil
            self.completeOperation()
        })
        self.task = task
        task.resume()
    }
    
    override func cancel() {
        
        self.requestCompletionHandler = nil
        super.cancel()
        if let taskUnwrapped: URLSessionTask = self.task {
            
            taskUnwrapped.cancel()
            self.task = nil
        }
    }
    
}

public class AsynchronousOperation : Operation {
    
    override public var isAsynchronous: Bool { return true }
    private let stateLock = NSLock()
    private var _executing: Bool = false
    override private(set) public var isExecuting: Bool {
        get {
            return stateLock.withCriticalScope { _executing }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            stateLock.withCriticalScope { _executing = newValue }
            didChangeValue(forKey: "isExecuting")
        }
    }
    private var _finished: Bool = false
    override private(set) public var isFinished: Bool {
        get {
            return stateLock.withCriticalScope { _finished }
        }
        set {
            willChangeValue(forKey: "isFinished")
            stateLock.withCriticalScope { _finished = newValue }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    public func completeOperation() {
        
        if isExecuting {
        
            self.isExecuting = false
            self.isFinished = true
        }
    }
    
    override public func start() {
        
        if self.isCancelled {
        
            self.isFinished = true
            return
        }
        self.isExecuting = true
        main()
    }
}

extension NSLock {
    
    func withCriticalScope<T>( block: () -> T) -> T {
        
        lock()
        let value = block()
        unlock()
        return value
    }
}
