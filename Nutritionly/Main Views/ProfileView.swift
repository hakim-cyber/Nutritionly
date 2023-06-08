//
//  ProfileView.swift
//  Nutritionly
//
//  Created by aplle on 5/26/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userstore:UserStore
    @State private var screen = UIScreen.main.bounds
    @Namespace var namespace
    var body: some View {
            NavigationView{
                ZStack{
                    BackGround(namespace: namespace)
                VStack(spacing: 60){
                    HStack(spacing: 10){
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
                            .foregroundColor(.secondary)
                    }
                    Divider()
                    VStack(spacing: 20){
                        // pictures and name email
                        
                        ZStack{
                            // age
                            RoundedRectangle(cornerRadius: 15,style: .continuous)
                                .stroke(.gray.opacity(0.4),lineWidth:1)
                                .padding(.horizontal,10)
                            
                            VStack(spacing: 30){
                                HStack{
                                    Text("Account")
                                        .foregroundColor(.gray)
                                        .fontDesign(.rounded)
                                    Spacer()
                                }
                                NavigationLink{
                         ProfiledData()
                                }label: {
                                    HStack(alignment: .firstTextBaseline){
                                        Image(systemName: "person")
                                            .font(.system(size: 20))
                                            .foregroundColor(.gray)
                                        Text("Profile Data")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                            .font(.callout)
                                            .fontDesign(.rounded)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }
                                }
                                NavigationLink{
                                    MyTargetView()
                                }label: {
                                    HStack(alignment: .firstTextBaseline){
                                        Image(systemName: "target")
                                            .font(.system(size: 20))
                                            .foregroundColor(.gray)
                                        Text("My Target")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                            .font(.callout)
                                            .fontDesign(.rounded)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }
                                   
                                }
                                Button{
                                  
                                        userstore.logOut()
                                    
                                }label: {
                                    Label("Log Out", systemImage:  "trash")
                                        .foregroundColor(.red)
                                }
                               
                                Spacer()
                            }
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            
                            
                        }
                        .frame(maxHeight: 130)
                        
                        Spacer()
                    }
                   
                }
                .padding(.horizontal,20)
                .padding(.top)
            }
        }
    }
    var user:User{
        userstore.fetchUserUsingThisApp()
      
        return userstore.userForApp.first ?? User(name: "Hakim", email: "emaildsdjsdskdskdj.com", height: 120, age: 16, gender: "Male", targetWeight: 70.0, days: [Day]())
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserStore())
    }
}
