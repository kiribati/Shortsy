//
//  Error+.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

enum YoutubeError: Error {
    case scriptError
    case notfound
}

enum OpenAIError: Error {
    case parsingError
}
