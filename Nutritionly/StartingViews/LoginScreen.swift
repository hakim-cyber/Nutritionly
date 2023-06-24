//
//  LoginScreen.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI
import Firebase

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
@State private var error = ""
    @State private var isEmailValid = false
    
    @EnvironmentObject var userStore:UserStore
    @Environment(\.colorScheme) var colorScheme
    
    var namespace:Namespace.ID
    var body: some View {
        if userStore.userIsLoggedIn{
            UserInformationView(namespace: namespace)
                .transition(.move(edge: .bottom))
               
        }else{
            LogView
                .transition(.move(edge: .bottom))
        }
    }
    var LogView:some View{
        ZStack{
          
             
                    
               
            VStack(alignment: .center){
              Spacer()
                
                Text("Email")
                    .font(.system(.subheadline, design: .default))
                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                    .fontWeight(.regular)
                    .padding(.horizontal,10)
                    VStack(alignment: .center, spacing: 20){
                        TextField("", text: $email)
                            .padding()
                            .background(  Color.buttonAndForegroundColor)
                            .foregroundColor(isEmailValid ? (colorScheme == .light ? Color.black : Color.white): .red)
                            .cornerRadius(30)
                            .shadow(color:.gray,radius: 5)
                            .padding(.horizontal,20)
                            .padding(.vertical,2)
                            .labelsHidden()
                            .onChange(of: email){ newEmail in
                                validateEmail(email: newEmail)
                            }
                        
                        VStack(alignment: .leading){
                            Text("Password")
                                .font(.system(.subheadline, design: .default))
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                .fontWeight(.regular)
                                .padding(.horizontal,10)
                        }
                        SecureField("", text: $password)
                            .padding()
                            .background(Color.buttonAndForegroundColor)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(color:.gray,radius: 5)
                            .padding(.horizontal,20)
                            .padding(.vertical,2)
                            .labelsHidden()
                        
                        Button{
                            register()
                        }label: {
                            Text("Sign Up")
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 200,height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                                        .fill(Color.indigo)
                                        .shadow(radius: 5)
                                )
                                .padding()
                        }
                        .disabled(!isEmailValid)
                        Text(error)
                            .foregroundColor(.red)
                        
                        Button{
                            login()
                        }label: {
                            Text("Already have an account? Login")
                                .bold()
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                
                        }
                        .padding(.top)
                        .disabled(!isEmailValid)
                    
                }
                    .onAppear{
                        Auth.auth().addStateDidChangeListener{auth,user in
                            if user != nil{
                                withAnimation(.easeInOut){
                                    userStore.userIsLoggedIn.toggle()
                            }
                            }
                        }
                    }
                Spacer()
                Spacer()
                Spacer()
            }
            
            
        }
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){result , error in
            if error != nil{
                self.error = (error?.localizedDescription ?? "") as String
                return
            }
        }
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){result,error in
            if error != nil{
                self.error = (error?.localizedDescription ?? "") as String
                return
            }
          
        }
    }
    private func validateEmail(email: String) {
           let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
           isEmailValid = emailPredicate.evaluate(with: email)
       }
    
   
}

struct LoginScreen_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        LoginScreen(namespace: namespace)
            .environmentObject(UserStore())
    }
}
