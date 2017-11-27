//
//  APIClient.swift
//  GRT Jewels
//
//  Created by Mahesh Muthusamy on 24/01/17.
//  Copyright © 2017 GRT. All rights reserved.
//

import UIKit
import Alamofire

class APIClient {

    var manager : Alamofire.SessionManager
    let header: HTTPHeaders = [AppConfig.HTTPHeader.contentTypeKey: AppConfig.HTTPHeader.contentTypeValue]
    
    init(){
        manager = APIClient.configureSessionManager()
        handleSessionChallenge()
    }
    
    //MARK: - Private functions
    private static func configureSessionManager()->Alamofire.SessionManager{
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [AppConfig.URLStrings.host: .disableEvaluation]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return manager
        
    }
    /** Handles Session Challenge */
    func handleSessionChallenge(){
        let delegate: Alamofire.SessionDelegate = manager.delegate
        delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = self.manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            return (disposition, credential)
        }
        
    }

}
