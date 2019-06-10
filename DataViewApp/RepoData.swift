//
//  DataClass.swift
//  DataViewApp
//
//  Created by Thyago on 07/06/19.
//  Copyright © 2019 tcasablancas. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RepoData {
    
    let name: String?
    let login: String?
    let avatar_url: String?
    let stargazers_count: String?
    
    init(json: JSON) {
        name = json["name"].stringValue
        login = json["owner"]["login"].stringValue
        avatar_url = json["owner"]["avatar_url"].stringValue
        stargazers_count = json["stargazers_count"].stringValue
    }

}
