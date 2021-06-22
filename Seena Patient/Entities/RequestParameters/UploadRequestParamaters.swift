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
    init(images: [FileModel], documentType: Int, token: String) {
        self.token = token
        let documetTypeData = "\(documentType + 1)".data(using: .utf8) ?? Data()
        self.multipartData = images.map {
             $0.type == 0 ? MultipartFormData(provider: .data($0.file!), name: "images[]", fileName: "image.jpeg", mimeType: "image/jpeg") : MultipartFormData(provider: .data($0.file!), name: "images[]", fileName: "file.pdf", mimeType: "pdf/*")
        }
        self.multipartData.append(MultipartFormData(provider: .data(documetTypeData), name: "type"))
    }
}
