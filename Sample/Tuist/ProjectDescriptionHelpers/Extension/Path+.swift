//
//  Path+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToFeature(path: String) -> Self {
        return .relativeToRoot("Projects/Features/\(path)")
    }
    
    static func relativeToDomain(path: String) -> Self {
        return .relativeToRoot("Projects/Domains/\(path)")
    }
    
    static func relativeToModule(path: String) -> Self {
        return .relativeToRoot("Projects/Modules/\(path)")
    }
    
    static func relativeToCore(path: String) -> Self {
        return .relativeToRoot("Projects/CoreKit/\(path)")
    }

    static func relativeToData(path: String) -> Self {
        return .relativeToRoot("Projects/Data/\(path)")
    }

    static func relativeData() -> Self {
        return .relativeToRoot("Projects/Data/Data")
    }

    static func relativeToNetwork() -> Self {
        return .relativeToRoot("Projects/Data/Networker")
    }

    static func relativeRepository() -> Self {
        return .relativeToRoot("Projects/Data/Repository")
    }

    static func relativeSampleRepository() -> Self {
        return .relativeToRoot("Projects/Data/SampleRepository")
    }

    static func relativeFirstRepository() -> Self {
        return .relativeToRoot("Projects/Data/FirstRepository")
    }

    static func relativeLocalDataSource() -> Self {
        return .relativeToRoot("Projects/Data/LocalDataSource")
    }

    static func relativeLocalDataSourceInterface() -> Self {
        return .relativeToRoot("Projects/Data/LocalDataSource/Interface")
    }

    static func relativeRemoteDataSource() -> Self {
        return .relativeToRoot("Projects/Data/RemoteDataSource")
    }

    static func relativeRemoteDataSourceInterface() -> Self {
        return .relativeToRoot("Projects/Data/RemoteDataSource/Interface")
    }

    static func relativePersistence() -> Self {
        return .relativeToRoot("Projects/Data/Persistence")
    }

    static func relativeUmbrella() -> Self {
        return .relativeToRoot("Projects/Umbrella")
    }
}
