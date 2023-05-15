# RESTful API tutorial in Swift

A `RESTful API` is an architectural style for an application program interface (API) that uses HTTP requests to access and use data. That data can be used to `GET`, `PUT`, `POST` and `DELETE` data types, which refers to the reading, updating, creating and deleting of operations concerning resources.

- Create a `singleton` class and internally create a `shared` instance of that class, then create a methods.
- The `URLSession` class has a shared instance and a `dataTask` method that we use for the Network.
- Handle Errors - When we work with a network, there are many places where errors can appear. To handle errors and easily find where they occur, we can use `enum` which handles all kinds of errors.

```swift

enum ServiceError: Error {
    case invalidURL
    case thrownError
    case noData
    case unableToDecode
}

```

- Since we need to update the view and it always runs on the main thread, we need to make a call in the `DispatchQueue.main.async` method because the network in the App runs in the background.

```swift

    public func fetchPokemon(name: String, completion: @escaping(Result<Pokemon, ServiceError>) -> Void) {
        
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // 1 - URL
        let url = baseURL.appending(path: name.lowercased())
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                
                // 3 - Error headling
                guard error == nil else { return completion(.failure(.thrownError)) }
                
                // 4 - Check for Data
                guard let data = data else { return completion(.failure(.noData)) }
                
                // 5 - Decode Data
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(ServiceError.unableToDecode))
                }
            }
        }.resume()
    }

```

- Create `Model` and confirm to the `Codable` Protocol, so that we can decode and encode the data in both ways.

```swift

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprite
}

struct Sprite: Codable {
    let spriteURL: URL
    
    enum CodingKeys: String, CodingKey {
        case spriteURL = "front_default"
    }
}

```

- Use `JSONSerialization.jsonObject(with: Data)` to make sure we get response from the network.

```swift
    do {
        let json = try JSONSerialization.jsonObject(with: data)
        print(json)
    }
```

- To get data like images we can transform the data

```swift

    public func fetchImage(_ pokemon: Pokemon, completion: @escaping (Result<UIImage, ServiceError>) -> Void) {
        
        let imageURL = URLRequest(url: pokemon.sprites.spriteURL)
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            DispatchQueue.main.async {
                guard error == nil else { return completion(.failure(.thrownError)) }
                guard let data else { return completion(.failure(.noData)) }
                guard let image = UIImage(data: data) else { return completion(.failure(.invalidURL))}
                completion(.success(image))
            }
        }.resume()
    }

```

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/RestAPI/img/1.gif' title='image' width='' alt='image' />





