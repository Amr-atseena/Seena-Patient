//
//  UploadRequestParamaters.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 19/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya

struct UploadRequestParamaters {
    var multipartData: [MultipartFormData]
    let token: String
    init(images: [Data], documentType: Int, token: String) {
        self.token = token
        let documetTypeData = "\(documentType + 1)".data(using: .utf8) ?? Data()
        self.multipartData = images.map {
            MultipartFormData(provider: .data($0), name: "images[]", fileName: "image.jpeg", mimeType: "image/jpeg")
        }
        self.multipartData.append(MultipartFormData(provider: .data(documetTypeData), name: "type"))
    }
}
