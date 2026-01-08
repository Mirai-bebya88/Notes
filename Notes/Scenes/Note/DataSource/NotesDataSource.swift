//
//  NotesDataSource.swift
//  Notes
//
//  Created by elene malakmadze on 27.11.25.
//

struct NotesDataSource {
    
    static var shared = NotesDataSource()
    
    var notesData: [Note] = [
        .init(
            name: "Household",
            content: "Making the bed, Washing dishes or loading/unloading the dishwasher, Sweeping, vacuuming, mopping floors,Taking out the trash and recycling"
        ),
        .init(
            name: "Cleaning",
            content: "Doing laundry: sorting, washing, drying, folding, putting away,Dusting surfaces and wiping counters, "
        ),
        .init(
            name: "Workplace",
            content: "Checking and triaging email inbox, Scheduling meetings and calendar maintenance, Filing documents (digital or paper), Restocking office supplies"
        ),
        .init(
            name: "Car maintenance",
            content: "checking oil, tire pressure, washing car, Filling car with fuel"
        ),
    ]
}
