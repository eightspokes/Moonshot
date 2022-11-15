//
//  ContentView.swift
//  Moonshot
//
//  Created by Roman on 11/10/22.
//

import SwiftUI

struct MissionViewList: View{
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    
    
    var body: some View{
        
           List{
                ForEach(missions) { mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack{
                                Text(mission.displayName)
                                    .font(.title3.bold())
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                            )
                    }
                }
            }
            .padding([.horizontal,.bottom])
        
    }
}




struct MissionViewGrid: View{
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns){
                ForEach(missions) { mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack{
                                Text(mission.displayName)
                                    .font(.title3.bold())
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                            )
                    }
                }
            }
            .padding([.horizontal,.bottom])
        }
    }
}


struct ContentView: View {
   
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    @State private var gridViewType = true
    var body: some View {
        NavigationView{
            if gridViewType{
                MissionViewGrid(astronauts: astronauts, missions: missions)
                    .navigationTitle("Moonshot")
                   
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    .toolbar{
                        ToolbarItem(placement: .bottomBar){
                            Toggle(isOn: $gridViewType){
                                if gridViewType{
                                    Text("Grid View")
                                }else{
                                    Text("List View")
                                }
                            }
                           
                        }
                    }
            }else{
                MissionViewList(astronauts: astronauts, missions: missions)
                    .navigationTitle("Moonshot")
                   
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)                    .toolbar{
                        ToolbarItem(placement: .bottomBar){
                            Toggle(isOn: $gridViewType){
                                if gridViewType{
                                    Text("Grid View")
                                }else{
                                    Text("List View")
                                }
                            }
                           
                        }
                    }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
