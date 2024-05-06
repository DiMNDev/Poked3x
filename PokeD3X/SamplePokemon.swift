//
//  SamplePokemon.swift
//  PokeD3X
//
//  Created by Joshua Arnold on 5/6/24.
//

import CoreData
import Foundation
import SwiftUI

func GetSamplePokemonFor(_ view: any View) -> any View {
    let context = PersistenceController.preview.container.viewContext
    
    let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
    
    fetchRequest.fetchLimit = 1
    
    let results = try! context.fetch(fetchRequest)
    
    return view
        .environmentObject(results.first!)
}

struct SamplePokemon {
    static let samplePokemon = {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        
        let results = try! context.fetch(fetchRequest)
        
        return results.first!
    }()
}
