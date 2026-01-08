//
//  NotesDataSource.swift
//  Notes
//
//  Created by elene malakmadze on 27.11.25.
//

import Foundation

struct NotesDataSource {
    
    static var shared = NotesDataSource()
    
    private let userDefaultsKey = "savedNotes"
    
    var notesData: [Note] {
        didSet {
            saveNotes()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
                   let decoded = try? JSONDecoder().decode([Note].self, from: data) {
                    notesData = decoded
        } else {
            notesData = [
                .init(name: "Household",
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
                )
            ]
        }
    }
            
    private func saveNotes() {
            if let encoded = try? JSONEncoder().encode(notesData) {
                UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
            }
        }
    }
            
            
            
            
            
            
            
            
            

