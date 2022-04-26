//
//  Helpers.swift
//  Shiftez
//
//  Created by Daniel Ivanov on 26/04/22.
//

import Foundation

let defaults = UserDefaults.standard

var aws = [
    "access_key": "aws_access_key_id",
    "secret_key": "aws_secret_access_key",
    "session_token": "aws_session_token"
]

func fetchSavedValues(arn: inout String, selectedProfile: inout String, selectedIAMProfile: inout String, dir: inout String) -> Void {
    arn = defaults.string(forKey: "arn") ?? ""
    selectedProfile = defaults.string(forKey: "profile") ?? ""
    selectedIAMProfile = defaults.string(forKey: "iam") ?? ""
    dir = defaults.string(forKey: "dir") ?? ""
}

func fetchProfiles(profiles: inout [String], arn: inout String, selectedProfile: inout String, selectedIAMProfile: inout String, dir: inout String) -> Void {
    profiles = try! exec(program: "/usr/local/bin/aws", arguments: ["configure", "list-profiles"]).stdout!.components(separatedBy: "\n")
    fetchSavedValues(arn: &arn, selectedProfile: &selectedProfile, selectedIAMProfile: &selectedIAMProfile, dir: &dir)
}

func saveValues(arn: inout String, selectedProfile: inout String, selectedIAMProfile: inout String, dir: inout String) -> Void {
    defaults.set(arn, forKey: "arn")
    defaults.set(selectedProfile, forKey: "profile")
    defaults.set(selectedIAMProfile, forKey: "iam")
    defaults.set(dir, forKey: "dir")
}

func getKeys(otp: inout String, selectedProfile: inout String, arn: inout String) -> ICredentials {
    var result: ExecResult
    do {
        result = try exec(program: "/usr/local/bin/aws", arguments: ["sts", "get-session-token", "--serial-number", "\(arn)", "--token-code", "\(otp)", "--profile", "\(selectedProfile)"])
    } catch {
        let error = error as! ExecError
        result = error.execResult
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys
    
    let data = try! decoder.decode(ICredentials.self, from: Data(result.stdout!.utf8))
    return data
}

func setConf(key: inout String, value: inout String, profile: inout String) -> ExecResult {
    var result: ExecResult
    do {
        result = try exec(program: "/usr/local/bin/aws", arguments: ["configure", "set", "\(key)", "\(value)", "--profile", "\(profile)"])
    } catch {
        let error = error as! ExecError
        result = error.execResult
    }
    return result
}

func initConfigurations(data: inout ICredentials, profile: inout String) -> Void {
    setConf(key: &aws["access_key"]!, value: &data.credentials.accessKeyID, profile: &profile)
    setConf(key: &aws["secret_key"]!, value: &data.credentials.secretAccessKey, profile: &profile)
    setConf(key: &aws["session_token"]!, value: &data.credentials.sessionToken, profile: &profile)
}
