//
//  IssueTrackModel.swift
//  RxMoyaExample
//
//  Created by Fabio Salata on 28/07/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct  IssueTrackModel {
    let provider: RxMoyaProvider<GitHub>
    let repositoryName: Observable<String>
    
    func trackIssues() -> Observable<[Issue]> {
        return repositoryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<Repository?> in
                print("Name: \(name)")
                return self
                    .findRepository(name: name)
            }
            .flatMapLatest { repository -> Observable<[Issue]?> in
                guard let repository = repository else { return Observable.just(nil) }
                
                print("Repository: \(repository.fullName)")
                return self.findIssues(repository: repository)
            }
            .replaceNilWith([])
    }
    
    internal func findIssues(repository: Repository) -> Observable<[Issue]?> {
        return self.provider
            .request(GitHub.issues(repositoryFullName: repository.fullName))
            .debug()
            .mapArrayOptional(type: Issue.self)
    }
    
    internal func findRepository(name: String) -> Observable<Repository?> {
        return self.provider
            .request(GitHub.repo(fullName: name))
            .debug()
            .mapObjectOptional(type: Repository.self)
    }
}
