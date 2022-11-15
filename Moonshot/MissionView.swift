//
//  MissionView.swift
//  Moonshot
//
//  Created by Roman on 11/12/22.
//

import SwiftUI


struct HorizontalScrollView: View{
    
    let crew: [CrewMember]
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(crew, id: \.role){
                    crewMember in
                    NavigationLink{
                        AstronautView(astronaut: crewMember.astronaut)
                    } label:{
                        HStack{
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                                .overlay(RoundedRectangle(cornerRadius: 50, style: .continuous).strokeBorder(.white, lineWidth: 1))
                        }
                        VStack{
                            Text(crewMember.astronaut.name)
                                .foregroundColor(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View{
    
   
    
    let mission: Mission
    let crew: [CrewMember]
    
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        self.crew = mission.crew.map{
            member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            
                
            }else{
                fatalError("Missing \(member.name)")
            }
        }
        
            
        
    }
    
    
    
    
    var body: some View{
       GeometryReader { geometry in
            ScrollView{
                VStack{
                   
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.4)
                        .padding(.top)
                  
                    if(mission.formattedLaunchDate != "N/A"){
                        Text(mission.formattedLaunchDate)
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.yellow)
                    }
                    
                       
                    VStack(alignment: .leading){
                        //Divider
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        Text("Crew")
                            .font(.title2.bold())
                            
                            .padding(.top, 10)
                        //Divider
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                       
                    }
                    .padding(.horizontal)
                    
                    HorizontalScrollView(crew: crew)
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            
        }
    }
  
    
}


struct MissionView_Previews: PreviewProvider{
    
    
    
    
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View{
        
        
      
        MissionView(mission: missions[1], astronauts: astronauts )
            .preferredColorScheme(.dark)
    }
}
