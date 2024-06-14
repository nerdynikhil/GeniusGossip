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
    @FocusState private var isTextFieldFocused: Bool
    
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
            HStack {
                TextField("Message GeniusGossip", text: $userPrompt)
                    .lineLimit(5)
                    .font(.title3)
                    .padding()
                    .background(Color(.systemGray6), in: Capsule())
                    .focused($isTextFieldFocused)

                Button(action: {
                    generateResponse()
                    isTextFieldFocused = false
                }) {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .padding()
            }
        }
        .padding()
    }
    
    func generateResponse(){
        isLoading = true
        response = ""
        Task{
            do{
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = result.text ?? "No reply discovered."
                userPrompt = ""
            } catch{
                response = "Oops, we hit a snag.\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
