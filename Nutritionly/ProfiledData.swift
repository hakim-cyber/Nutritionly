//
//  ProfiledData.swift
//  Nutritionly
//
//  Created by aplle on 5/26/23.
//

import SwiftUI

struct ProfiledData: View {
    @EnvironmentObject var userstore:UserStore
    var body: some View {
        Form{
            Section{
                HStack(spacing: 10){
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 50)
                    VStack(alignment: .leading){
                        Text("\(user.name)")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("\(user.email)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        
                    }
                    
                    Spacer()
                    Text("\(user.days.count) days")
                        .font(.callout)
                }
            }
            Section{
                HStack{
                    Text("Age")
                    Spacer()
                    Text("\(user.age)")
                }
                HStack{
                    Text("Height")
                    Spacer()
                    Text("\(user.height)")
                }
                HStack{
                    Text("Gender")
                    Spacer()
                    Text("\(user.gender)")
                }
            }
            
        }
    }
    var user:User{
        userstore.fetchUserUsingThisApp()
      
            return userstore.userForApp.first ?? User(name: "Hakim", email: "emaildsdjsdskdskdj.com", height: 120, age: 16, gender: "Male", days: [Day]())
        
    }
}

struct ProfiledData_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfiledData()
                .environmentObject(UserStore())
        }
    }
}
