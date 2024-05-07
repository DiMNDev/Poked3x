//
//  ContentView.swift
//  PokeD3X
//
//  Created by Joshua Arnold on 4/30/24.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default)
    private var pokedex: FetchedResults<Pokemon>

    @StateObject private var pokemonVM = PokemonViewModel(controller: FetchController())

    var body: some View {
        switch pokemonVM.status {
        case .notStarted:
            Text("Not Started")
        case .fetching:
            Text("Fetching")
            ProgressView()
        case .failed:
            Text("Failed")
        case .success:
            NavigationStack {
                List(pokedex) { pokemon in

                    NavigationLink(value: pokemon) {
                        AsyncImage(url: pokemon.sprite) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        Text(pokemon.name!.capitalized)
                    }
                }
                .navigationTitle("PokeDex")
                .navigationDestination(for: Pokemon.self, destination: { pokemon in
                    PokemonDetail()
                        .environmentObject(pokemon)
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
