//
//  Project+Template.swift
//  Packages
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

extension Project {
    public static func configure(
        moduleType: ModuleLayer,
        product: Product,
        dependencies: [TargetDependency],
        interfaceDependencies: [TargetDependency] = [],
        testingDependencies: [TargetDependency] = [],
        hasInterface: Bool = false,
        hasTests: Bool = false,
        hasTesting: Bool = false,
        hasResources: Bool = false,
        hasExample: Bool = false
    ) -> Project {
        let configuration = AppConfiguration()
        
        switch moduleType {
        case .app:
            return configureApp(
                configuration: configuration,
                dependencies: dependencies
            )

        case let .feature(name):
            return configureModule(
                configuration: configuration,
                name: name,
                product: product,
                hasTests: true,
                hasTesting: true,
                hasExample: true,
                hasInterface: true,
                dependencies: dependencies,
                interfaceDependencies: interfaceDependencies,
                testingDependencies: testingDependencies
            )

        case let .domain(name):
            return configureModule(
                configuration: configuration,
                name: name,
                product: product,
                hasResources: hasResources,
                hasTests: true,
                hasTesting: hasTesting,
                hasInterface: true,
                dependencies: dependencies,
                interfaceDependencies: interfaceDependencies,
                testingDependencies: testingDependencies
            )

        case let .data(name):
            return configureModule(
                configuration: configuration,
                name: name,
                product: product,
                hasTests: true,
                hasInterface: true,
                dependencies: dependencies,
                interfaceDependencies: interfaceDependencies,
                testingDependencies: testingDependencies
            )

        case let .general(name):
            return configureModule(
                configuration: configuration,
                name: name,
                product: product,
                hasResources: hasResources,
                hasTests: hasTests,
                hasTesting: hasTesting,
                hasExample: hasExample,
                hasInterface: hasInterface,
                dependencies: dependencies,
                interfaceDependencies: interfaceDependencies,
                testingDependencies: testingDependencies
            )
        }
    }
}
