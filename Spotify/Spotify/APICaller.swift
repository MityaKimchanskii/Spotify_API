//
//  APICaller.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import Foundation


final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    // MARK: - Albums
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + album.id), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    
                    do {
    //                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    //                    print(result)
                        let result = try JSONDecoder().decode(AlbumDetailResponse.self, from: data)
    //                    print(result)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Playlists
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    do {
//                        let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                        print(result)
                        let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
//                        print(result)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                print(urlString)
                self?.createRequest(with: URL(string: urlString), type: .POST) { baseRequest in
                    var request = baseRequest
                    let json = [
                        "name": name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    print("Starting creation...")
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }

                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let response = result as? [String: Any], response["id"] as? String != nil {
                                print("created")
                                completion(true)
                            }
                            else {
                                print("Failed to get id")
                                completion(false)
                            }
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(false)
                        }
                    }
                    task.resume()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func addTrackToPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
            var request = baseRequest
            let json = [
                "uris": [
                    "spotify:track:\(track.id)"
                ]
            ]
            
            print(json)
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Adding...")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else{
                        completion(false)
                        return
                    }

                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            print(result)
                        if let response = result as? [String: Any],
                           response["snapshot_id"] as? String != nil {
                            completion(true)
                        }
                        else {
                            completion(false)
                        }
                    }
                    catch {
                        completion(false)
                    }
                }
            }
            task.resume()
        }
    }
    
    public func removeTrackFromPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .DELETE) { baseRequest in
            var request = baseRequest
            let json: [String: Any] = [
                "tracks": [
                    [
                        "uri": "spotify:track:\(track.id)"
                    ]
                ]
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Adding...")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else{
                        completion(false)
                        return
                    }

                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            print(result)
                        if let response = result as? [String: Any],
                           response["snapshot_id"] as? String != nil {
                            completion(true)
                        }
                        else {
                            completion(false)
                        }
                    }
                    catch {
                        completion(false)
                    }
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/playlists/?limit=50"), type: .GET) { request in
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                        print(json)
                        
                        let result = try JSONDecoder().decode(LibraryPlaylistsResponse.self, from: data)
                        completion(.success(result.items))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
    
    
    // MARK: - Profile
    public func getCurrentUserProfile(completion: @escaping(Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Browse (Home)
    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(json)
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    //                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Category
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                        print(json)
                        
                        let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
//                        print(result.categories.items)
                        completion(.success(result.categories.items))
                        
                    } catch {
//                        print(error.localizedDescription)
                        completion(.failure(APIError.failedToGetData))
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Category Playlist
    public func getCategoryPlaylist(category: Category, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                        print(json)
                        
                        let result = try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data)
                        let playlists = result.playlists.items
//                        print(playlists)
                        completion(.success(playlists))
                        
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(APIError.failedToGetData))
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Futured Playlist
    public func getFuturedPlayList(completion: @escaping (Result<FeaturedPlaylistResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=30"), type: .GET) { request in
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(json)
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    // MARK: - Recommendation
    public func getRecommendations(genres: Set<String>, completion: @escaping (Result<RecommendationResponse, Error>) -> Void) {
        
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=50&seed_genres=\(seeds)"), type: .GET) { request in
            
//            print(request.url?.absoluteString)
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(json)
                    let result = try JSONDecoder().decode(RecommendationResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    public func getRecommendationsGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(json)
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
    }
    
    // MARK: - Search
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { request in
            
            print(request)
            
            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    DispatchQueue.main.async {
                        guard let data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }
                        
                        do {
    //                        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
    //                        print(json)
                            
                            let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                            
                            var searchResult: [SearchResult] = []
                            
                            searchResult.append(contentsOf: result.tracks.items.compactMap({ SearchResult.track(model: $0 )}))
                            searchResult.append(contentsOf: result.albums.items.compactMap({ SearchResult.album(model: $0 )}))
                            searchResult.append(contentsOf: result.artists.items.compactMap({ SearchResult.artist(model: $0 )}))
                            searchResult.append(contentsOf: result.playlists.items.compactMap({ SearchResult.playlist(model: $0 )}))
                            
                            completion(.success(searchResult))
                            
                        } catch {
                            print(error.localizedDescription)
                            completion(.failure(error))
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            
            guard let apiURL = url else { return }
            
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
