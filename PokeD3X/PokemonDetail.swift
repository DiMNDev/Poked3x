//
//  PokemonDetail.swift
//  PokeD3X
//
//  Created by Joshua Arnold on 5/6/24.
//

import CoreData
import SwiftUI

struct PokemonDetail: View {
    @EnvironmentObject var pokemon: Pokemon
    @State var showShiny = false
    var body: some View {
        ScrollView {
            ZStack {
                Image(pokemon.background)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 6)

                AsyncImage(url: showShiny ? pokemon.shiny : pokemon.sprite) { image in
                    image.image?
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 50)
                        .shadow(color: .black, radius: 10)
                }
            }

            HStack {
                ForEach(pokemon.types!, id: \.self) { type in
                    Text(type.capitalized)
                        .font(.title2)
                        .shadow(color: .white, radius: 1)
                        .padding([.top, .bottom], 7)
                        .padding([.leading, .trailing])
                        .background(Color(type.capitalized))
                        .clipShape(.rect(cornerRadius: 50))
                        .shadow(color: .black, radius: 3)
                }
                Spacer()
            }
            .padding()
            
            Text("Stats")
                .font(.title)
                .padding(.bottom, -7)
            
            Stats()
                .environmentObject(pokemon)
        }
        .navigationTitle(pokemon.name!.capitalized)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showShiny.toggle()
                } label: {
                    if showShiny {
                        Image(systemName: "want.and.stars")
                            .foregroundStyle(.yellow)
                    } else {
                        Image(systemName: "want.and.stars.inverse")
                    }
                }
            }
        }
    }
}

#Preview {
//        GetSamplePokemonFor(PokemonDetail())
    PokemonDetail()
        .environmentObject(SamplePokemon.samplePokemon)
}
