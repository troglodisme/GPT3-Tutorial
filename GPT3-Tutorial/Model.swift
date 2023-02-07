//
//  Model.swift
//  GPT3-Tutorial
//
//  Created by Giulio on 07/02/23.
//

import Foundation


/*
//Data struct to decode the response we'll get from a OpenAI GPT-3 request.
// Our request demo looks like this:
 
% curl https://api.openai.com/v1/completions \
-H "Content-Type: application/json" \
-H "Authorization: Bearer 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" \
-d '{"model": "text-davinci-003", "prompt": "What is an API?", "temperature": 1, "max_tokens": 50}'
 
*/

struct GPT3Response: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
}

struct Choice: Decodable {
    let text: String
    let index: Int
    let logprobs: String?
    let finish_reason: String
}

struct Usage: Decodable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}
