//
//  AuthResponse.swift
//  Spotify
//
//  Created by Mitya Kim on 4/12/23.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}

//{
//    "access_token" = "BQCXVuD6u3H0fvkB6lBtY3ELo6Q6DvCc1H3kbjKnPRz83f3IOkBb0tZnPYHP2Lsa4Lqu2nzOG-imBboYczJHU17cYlewwQwg4alFao939aAD1GBwYdPoKTUr56h9yALv75FHN0C2ANZuT7vBwASa18-nU6BrbxJHt9-j_dSxJ6jRXa2MVl0Bu7crQAHtROuYUUItHwW3jObURqDZYESN";
//    "expires_in" = 3600;
//    "refresh_token" = "AQBmGDchG38bHeOk5Gx_xJjCTdsm5a9b7hSRK3805xXEgUkEhfGPAsAReoFUsf8wu46FkoGQgOLnipMZfd0auJKfgWqhjGFMdGfKLuJck-Uj_GnBbKrXZqb3_7oo7FfR55I";
//    scope = "user-read-private";
//    "token_type" = Bearer;
//}
