//
//  Color.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import Foundation
import SwiftUI

extension Color{
    static let backgroundColor = Color(uiColor: UIColor(red: 0.28, green: 0.26, blue: 0.64, alpha: 1))
    static let buttonAndForegroundColor = Color(uiColor: UIColor(red: 0.55, green: 0.44, blue: 0.25, alpha: 1))
    static let openGreen = Color(UIColor(red: 0.788, green: 0.930, blue: 0.302, alpha: 1))
}


import Foundation
import PhotosUI
import SwiftUI


struct ImagePicker:UIViewControllerRepresentable{
    @Binding var image:UIImage?
    class Coordinator:NSObject,PHPickerViewControllerDelegate{
        
        var parent:ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else{return}
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){ image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
