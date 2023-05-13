# RESTful API tutorial in Swift


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
                guard error == nil else { return completion(.failure(ServiceError.thrownError)) }
                
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

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/RestAPI/img/1.png' title='image' width='' alt='image' />





