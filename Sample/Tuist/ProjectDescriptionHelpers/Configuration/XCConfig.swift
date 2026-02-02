//
//  XCConfig.swift
//  Packages
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

public struct XCConfig {
    private struct Path {
        static var framework: ProjectDescription.Path {
            .relativeToRoot("xcconfigs/targets/iOS-Framework.xcconfig")
        }

        static var library: ProjectDescription.Path {
            .relativeToRoot("xcconfigs/targets/iOS-Library.xcconfig")
        }

        static var tests: ProjectDescription.Path {
            .relativeToRoot("xcconfigs/targets/iOS-Tests.xcconfig")
        }

        static func project(_ config: String) -> ProjectDescription.Path {
            .relativeToRoot("xcconfigs/Base/Projects/Project-\(config).xcconfig")
        }
    }

    public static let framework: [Configuration] = [
        .debug(name: "Develop", xcconfig: Path.framework),
        .debug(name: "Tests", xcconfig: Path.framework),
        .release(name: "Production", xcconfig: Path.framework),
    ]

    public static let library: [Configuration] = [
        .debug(name: "Develop", xcconfig: Path.library),
        .debug(name: "Tests", xcconfig: Path.tests),
        .release(name: "Production", xcconfig: Path.library),
    ]

    public static let tests: [Configuration] = [
        .debug(name: "Develop", xcconfig: Path.tests),
        .debug(name: "Tests", xcconfig: Path.tests),
        .release(name: "Production", xcconfig: Path.tests),
    ]

    public static let project: [Configuration] = [
        .debug(name: "Develop", xcconfig: Path.project("Develop")),
        .debug(name: "Tests", xcconfig: Path.project("Tests")),
        .release(name: "Production", xcconfig: Path.project("Production")),
    ]
}
