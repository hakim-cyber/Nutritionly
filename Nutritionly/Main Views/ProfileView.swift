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
    @State private var showAccontDeleteSheet = false
    @AppStorage("backgroundColor") var backgroundColor = Colors.openGreen.rawValue
    @Environment(\.colorScheme) var colorScheme
    let colors = ["mint","orange","purple","openGreen"]
    @Namespace var namespace
    var body: some View {
            NavigationView{
                ZStack{
                    BackGround(namespace: namespace)
                    VStack{
                        VStack(spacing: 60){
                            HStack(spacing: 10){
                                VStack(alignment: .leading){
                                    Text("\(user.name)")
                                        .fontWeight(.bold)
                                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                    Text("\(user.email)")
                                        .font(.callout)
                                        .foregroundColor(.secondary)
                                    
                                }
                                
                                Spacer()
                                Text("\(user.days.count) days")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            }
                            
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
                                                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                                    .fontWeight(.medium)
                                                    .font(.callout)
                                                    .fontDesign(.rounded)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
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
                                                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                                    .fontWeight(.medium)
                                                    .font(.callout)
                                                    .fontDesign(.rounded)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                            }
                                            
                                        }
                                        Menu{
                                           
                                            Picker("",selection:$backgroundColor){
                                                ForEach(colors , id:\.self){color in
                                                    Text("\(color)")
                                                    
                                                    
                                                    
                                                }
                                            }
                                                .labelsHidden()
                                            
                                         
                                            
                                        }label:{
                                            HStack(alignment: .firstTextBaseline){
                                                Image(systemName: "text.below.photo.fill")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.gray)
                                                Text("Background Color")
                                                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                                    .fontWeight(.medium)
                                                    .font(.callout)
                                                    .fontDesign(.rounded)
                                                Spacer()
                                              
                                                
                                                    Image(systemName: "chevron.right")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                                
                                            }
                                        }
                                        
                                        
                                        Button{
                                            
                                            userstore.logOut()
                                            
                                        }label: {
                                            Text("Sign Out")
                                                .foregroundColor(.orange)
                                        }
                                        Button(role:.destructive){
                                            // delete user
                                            self.showAccontDeleteSheet = true
                                            
                                        }label:{
                                            Label("Delete", systemImage:  "trash")
                                            
                                        }
                                        .confirmationDialog("Delete Account And Data", isPresented: $showAccontDeleteSheet){
                                            Button("Yes, delete my account"){
                                                Task{
                                                    await userstore.deleteAccount()
                                                    
                                                }
                                                
                                            }
                                            Button("Cancel",role:.cancel,action: {})
                                        }message: {
                                            Text("Are you sure you want to delete your account and its data?")
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal,20)
                                    .padding(.vertical,10)
                                    
                                    
                                }
                                
                                
                            Spacer()
                            }
                            
                        }
                        .padding(.horizontal,20)
                        .padding(.top)
                    }
            }
                
        }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                           
                       // Give a moment for the screen boundaries to change after
                       // the device is rotated
                       Task { @MainActor in
                           try await Task.sleep(for: .seconds(0.001))
                           withAnimation{
                               self.screen = UIScreen.main.bounds
                           }
                       }
                   }
            .onAppear{
                Task { @MainActor in
                    try await Task.sleep(for: .seconds(0.001))
                    withAnimation{
                        self.screen = UIScreen.main.bounds
                    }
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
