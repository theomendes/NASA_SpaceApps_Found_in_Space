//
//  LocalCollection.swift
//  Found in Space
//
//  Created by Theo Mendes on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Firebase

// A type that can be initialized from a Firestore document.
protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

final class LocalCollection<T: DocumentSerializable> {
    
    private(set) var items: [T]
    private(set) var documents: [DocumentSnapshot] = []
    let query: Query
    
    private let updateHandler: ([DocumentChange]) -> ()
    
    private var listener: ListenerRegistration? {
        didSet {
            oldValue?.remove()
        }
    }
    
    var count: Int {
        return self.items.count
    }
    
    subscript(index: Int) -> T {
        return self.items[index]
    }
    
    init(query: Query, updateHandler: @escaping ([DocumentChange]) -> ()) {
        self.items = []
        self.query = query
        self.updateHandler = updateHandler
    }
    
    func index(of document: DocumentSnapshot) -> Int? {
        // swiftlink:disable:next identifier_name
        for count in 0 ..< documents.count {
            if documents[count].documentID == document.documentID {
                return count
            }
        }
        
        return nil
    }
    
    func listen() {
        guard listener == nil else { return }
        listener = query.addSnapshotListener { [unowned self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            let models = snapshot.documents.map { (document) -> T in
                if let model = T(dictionary: document.data()) {
                    return model
                } else {
                    // handle error
                    fatalError("Unable to initialize type \(T.self) with dictionary \(document.data())")
                }
            }
            self.items = models
            self.documents = snapshot.documents
            self.updateHandler(snapshot.documentChanges)
        }
    }
    
    func stopListening() {
        listener = nil
    }
    
    deinit {
        stopListening()
    }
}
