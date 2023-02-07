//
//  ViewModel.swift
//  GPT3-Tutorial
//
//  Created by Giulio on 07/02/23.
//

import Foundation

//Our request model
struct GPT3Request: Encodable {
    let model: String
    let prompt: String
    let temperature: Double
    let max_tokens: Int
}


//Observable object to generate our GPT-3 request
@MainActor
class GeneratorViewModel: ObservableObject {

    //Type of text completion model
    let model = "text-davinci-003"
    
    //Hard coded prompt to get started
    let prompt = "Write a poem about SwiftUI."
    
    //Temperature value
    let temperature = 0.9
    
    //Max tokens value, length
    let max_tokens = 200
    
    //Replace with your API Key
    let apiKey = "ADD YOUR API KEY HERE"

    //Initialise a JSON Decode object to decode the reponse
    let decoder = JSONDecoder()

    //Create a URLComponents instance to store the general address of OpenAI Key, we'll add the path later
    var urlComponents = URLComponents(string: "https://api.openai.com")!

    @Published var message: String = ""
    
    func generatePoem() async {

            //Add the specific path for text completion to the URLComponents element
            urlComponents.path = "/v1/completions"

            //Add the request body using the data struct we setup earlier
            let requestBody = GPT3Request(model: model,
                                          prompt: prompt,
                                          temperature: temperature,
                                          max_tokens: max_tokens)
                        
            let url = urlComponents.url
            var request = URLRequest(url: url!)
            
            //Type of request
            request.httpMethod = "POST"
            
            //Api Key
            request.addValue(
                "Bearer \(apiKey)",
                forHTTPHeaderField: "Authorization"
            )
            
            //Hedaer
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = try! JSONEncoder().encode(requestBody)


            do {
                //let's print our full request to make sure we spelled everything correctly
                print(request)

                let (data, response) = try await URLSession.shared.data(for: request)

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }

                //Create a variable for the api response and decode it from Json
                let apiResponse = try decoder.decode(GPT3Response.self, from: data)

                //We are using the completion API, first choice
                let completion = apiResponse.choices[0].text

                //Print the GPT-3 response in the Xcode Console
                print(completion)
                
                message = completion

            } catch {

                print(error)
                
            }

        }
}
