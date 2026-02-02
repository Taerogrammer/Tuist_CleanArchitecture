//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

public extension TargetDependency.Module {
    // MARK: - Foundation
    static let designKit = dependency(
        target: "DesignKit",
        path: .relativeToCore(path: "DesignKit")
    )

    static let sharedUI = dependency(
        target: "SharedUI",
        path: .relativeToCore(path: "SharedUI")
    )

    static let core = dependency(
        target: "Core",
        path: .relativeToCore(path: "Core")
    )

    // MARK: - Data
    static let data = dependency(
        target: "Data",
        path: .relativeData()
    )

    static let persistence = dependency(
        target: "Persistence",
        path: .relativePersistence()
    )

    static let networker = dependency(
        target: "Networker",
        path: .relativeToNetwork()
    )

    // MARK: - DataSource
    static let localDataSource = LocalDataSource.self
    static let remoteDataSource = RemoteDataSource.self

    struct LocalDataSource {
        public static let implement = dependency(
            target: "LocalDataSource",
            path: .relativeLocalDataSource()
        )

        public static let interface = dependency(
            target: "LocalDataSourceInterface",
            path: .relativeLocalDataSource()
        )
    }

    struct RemoteDataSource {
        public static let implement = dependency(
            target: "RemoteDataSource",
            path: .relativeRemoteDataSource()
        )

        public static let interface = dependency(
            target: "RemoteDataSourceInterface",
            path: .relativeRemoteDataSource()
        )
    }
}

public extension TargetDependency.App {
    static let umbrella = dependency(
        target: "Umbrella",
        path: .relativeUmbrella()
    )
}
