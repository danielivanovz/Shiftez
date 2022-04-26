//
//  Types.swift
//  Shiftez
//
//  Created by Daniel Ivanov on 26/04/22.
//

import Foundation

public struct ICredentials: Codable {
    var credentials: Credentials

    enum CodingKeys: String, CodingKey {
        case credentials = "Credentials"
    }
}

public struct Credentials: Codable {
    var accessKeyID, secretAccessKey, sessionToken, expiration: String

    enum CodingKeys: String, CodingKey {
        case accessKeyID = "AccessKeyId"
        case secretAccessKey = "SecretAccessKey"
        case sessionToken = "SessionToken"
        case expiration = "Expiration"
    }
}

public struct Inputs: Codable {

    public let otp: Int32?
    public let arn, profile, iam: String?

    public init(
        otp: Int32? = nil,
        arn: String? = nil,
        profile: String? = nil,
        iam: String? = nil
    ) {
        self.otp = otp
        self.arn = arn
        self.profile = profile
        self.iam = iam
    }
}
