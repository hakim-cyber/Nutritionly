//
//  WorkoutCardView.swift
//  Nutritionly
//
//  Created by aplle on 5/22/23.
//

import SwiftUI

struct WorkoutCardView: View {
    @EnvironmentObject var dataManager:NutritionData_Manager
   
    @State private var screen = UIScreen.main.bounds
    
   
    var body: some View {
        
        ZStack{
          
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red.opacity(0.5),lineWidth:3)
            VStack{
                
                HStack(spacing: 0){
                    Image(systemName: "dumbbell")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(9)
                        .background(Color.orange)
                        .clipShape(Circle())
                    Text("workouts")
                        .fontDesign(.rounded)
                       
                        .fontWeight(.medium)
                  Spacer()
                    
                    
                }
                
                Spacer()
                
                HStack{
                    
                    TextField("", value: $dataManager.workoutMinutes,formatter: NumberFormatter())
                        .padding(8)
                        .background(Color.backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color:.gray,radius: 5)
                        .padding(.horizontal,5)
                        .padding(.vertical,2)
                        .labelsHidden()
                        .keyboardType(.numberPad)
                        
                        
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.vertical,10)
          
        }

      
    }
      
}

struct WorkoutCardView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCardView()
            .environmentObject(NutritionData_Manager())
            .previewLayout(.sizeThatFits)
    }
}
