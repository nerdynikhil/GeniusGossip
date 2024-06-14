//
//  ContentView.swift
//  GeniusGossip
//
//  Created by Nikhil Barik on 14/06/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State var userPrompt = ""
    @State var response = "What adventure are we embarking on today?"
    @State var isLoading = false
    
    var body: some View {
        VStack {
            Text("Hey there!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top, 50)
            ZStack{
                ScrollView{
                    Text(response)
                }
                
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(4)
                }
            }
            TextField("Message GeniusGossip",text: $userPrompt, axis: .vertical)
                .lineLimit(5)
                .font(.title3)
                .padding()
                .background(Color(.systemGray6), in: Capsule())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
