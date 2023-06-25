//
//  ProfiledData.swift
//  Nutritionly
//
//  Created by aplle on 5/26/23.
//

import SwiftUI

struct ProfiledData: View {
    @EnvironmentObject var userstore:UserStore
    @State private var profilePhoto:UIImage?
    @State private var showPicker = false
    var body: some View {
        Form{
            Section{
                HStack(spacing: 10){
                    if profilePhoto != nil{
                    Image(uiImage: profilePhoto!)
                        .resizable()
                        .scaledToFit()
                       
                        .clipShape(Circle())
                        .frame(width: 50)
                        .onTapGesture {
                            self.showPicker.toggle()
                        }
                          }else{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                            .clipShape(Circle())
                            .frame(width: 50)
                            .onTapGesture {
                                self.showPicker.toggle()
                            }
                    }
                    
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
        .sheet(isPresented: $showPicker, content: {ImagePicker(image: $profilePhoto)})
        .onAppear(perform: loadPhoto)
        .onChange(of: self.profilePhoto){_ in
            savePhoto()
        }
      
    }
    func savePhoto(){
        if let imageString = profilePhoto?.jpegData(compressionQuality: 0.75)?.base64EncodedString(){
            if let encoded = try? JSONEncoder().encode(imageString){
                
                UserDefaults.standard.set(encoded, forKey: "photo")
                print("saved")
            }
        }
        
    }
    func loadPhoto(){
        if let string = UserDefaults.standard.data(forKey: "photo"){
            if let decoded = try? JSONDecoder().decode(String.self, from: string){
                let data = Data(base64Encoded: decoded) ?? Data()
                
                let uiImage = UIImage(data: data) ?? UIImage()
                print("loaded")
                self.profilePhoto = uiImage
            }
            
        }
    }
    var user:User{
        userstore.fetchUserUsingThisApp()
      
        return userstore.userForApp.first ?? User(name: "Hakim", email: "emaildsdjsdskdskdj.com", height: 120, age: 16, gender: "Male", targetWeight: 70.0, days: [Day]())
        
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
