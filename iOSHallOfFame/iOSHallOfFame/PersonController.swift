//
//  PersonController.swift
//  iOSHallOfFame
//
//  Created by Pete Parks on 4/29/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

class PersonController {
    //MARK: Properties
    static let shared = PersonController()
    var people: [Person] = []
    private var baseURL = URL(string: "https://ios-api.devmoutain.com/api/")
    private var peopleEndpoint = "people"
    private var personEndpoint = "person"
    private var offsetQueryItemName = "offset"  // i.e. "offset=50"
    private var contentTypeValue = "application/json"
    private var contentTypeKey = "Content-Type"
    // MARK: Methods
    
    // POST  (c)
    
    // GET  (r)
    
    func getPeople(page: Int, completion: @escaping (Result<[Person], PersonError>) -> Void) {
        // URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let peopleURL = baseURL.appendingPathComponent(peopleEndpoint)
        // Components
        var components = URLComponents(url: peopleURL, resolvingAgainstBaseURL:  true)
        components?.queryItems = [URLQueryItem(name: offsetQueryItemName, value: String(page * 50))]
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        // request
        var request = URLRequest(url: finalURL)
        request.setValue(contentTypeValue, forHTTPHeaderField: contentTypeKey)
        
        // data task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Error
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            // Data
            guard let data = data else { return completion(.failure(.noData)) }
            // Decode
            do {
                let people = try JSONDecoder().decode([Person].self, from: data)
                self.people += people
                return completion(.success(people))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.thrown(error)))
            }
        }.resume()

    }
    
    
    func getPersonDetails(person: Person, completion: @escaping (Result<Person, PersonError>) -> Void) {
        guard let id = person.id, let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let personURL = baseURL.appendingPathComponent(personEndpoint)
        let personIdURL = personURL.appendingPathComponent(String(id))
        
        // data task
        URLSession.shared.dataTask(with: personIdURL) { (data, _, error) in
            // Error
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            // Data
            guard let data = data else { return completion(.failure(.noData)) }
            // Decode
            do {
                let response = try JSONDecoder().decode([Person].self, from: data)
                guard let person = response.first else { return completion(.failure(.noData)) }
                return completion(.success(person))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    // Delete (d)
    
    
}
