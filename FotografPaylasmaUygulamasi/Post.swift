//
//  Post.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Yusuf Emin Günay on 15.03.2026.
//

import Foundation

class Post{
    
    var email : String
    var yorum : String
    var gorselUrl : String
    
    init(email: String, yorum: String, gorselUrl: String) {
        self.email = email
        self.yorum = yorum
        self.gorselUrl = gorselUrl
    }
    
}
