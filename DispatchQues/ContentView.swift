//
//  ContentView.swift
//  DispatchQues
//
//  Created by Muhammad Tafani Rabbani on 07/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var imageVM = ImageViewModel()
    @State var color : UIColor = .red
    var body: some View {
        ZStack {
            Color(color)
                
            VStack {
                if let img = imageVM.image {
                    Image(uiImage: img)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5)
                        .aspectRatio(contentMode: .fit)
                    
                }else{
                    Rectangle()
                        .stroke(lineWidth: 2)
                        .foregroundColor(.red)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5)
                }
                
                Button("Fetch Random Image"){
                    imageVM.getRandomImage()
                }.padding()
                
                Button("Change Background Color"){
                    color = UIColor(red: CGFloat.random(in: 0.0...0.5), green: CGFloat.random(in: 0.7...0.9), blue: CGFloat.random(in: 0.8...0.9), alpha: 1)
                }.padding()
                Spacer()
            }
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ImageViewModel : ObservableObject{
    @Published private(set) var image:UIImage? = nil
    
    
    func getRandomImage(){
        Log.location(filename: #file)
        let string_url = "https://loremflickr.com/2000/2000"
        self.image = nil
        Log.queue(action: "Fetching URL")
        guard let url = URL(string: string_url) else{
            fatalError("Invalid URL")
        }
        Log.queue(action: "Fetching Image")
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Can't download data from URL")
        }
        Log.queue(action: "Update UI")
        self.image = UIImage(data: data)
    }
}

