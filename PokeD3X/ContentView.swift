//
//  ContentView.swift
//  PokeD3X
//
//  Created by Joshua Arnold on 4/30/24.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default
    ) private var pokedex: FetchedResults<Pokemon>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        predicate: NSPredicate(format: "favorite = %d", true),
        animation: .default
    ) private var favoritePokemon: FetchedResults<Pokemon>

    @State var filterByFavorites = false

    @StateObject private var pokemonVM = PokemonViewModel(controller: FetchController())

    let dummyStatus: PokemonViewModel.Status = .success

    var body: some View {
        switch pokemonVM.status {
//        switch dummyStatus {
        case .notStarted:
            Text("Not Started")
        case .fetching:
            Text("Fetching")
            ProgressView()
        case .failed:
            Text("Failed")
        case .success:
            NavigationStack {
                List(filterByFavorites ? favoritePokemon : pokedex) { pokemon in

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
                        if pokemon.favorite {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .shadow(color: colorScheme == .dark ? .white : .black, radius: 1)
                        }
                    }
                }
                .navigationTitle("PokeDex")
                .navigationDestination(for: Pokemon.self, destination: { pokemon in
                    PokemonDetail()
                        .environmentObject(pokemon)
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                filterByFavorites.toggle()
                            }
                        } label: {
                            Label("Filter By Favorites", systemImage: filterByFavorites ? "star.fill" : "star")
                        }
                        .font(.title)
                        .foregroundStyle(.yellow, .yellow)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
