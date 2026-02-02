//
//  Project+.swift
//  Packages
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

extension Project {
    /// 앱 프로젝트 설정
    static func configureApp(
        configuration: AppConfiguration,
        dependencies: [TargetDependency]
    ) -> Self {
        let appTarget = Target.target(
            name: configuration.projectName,
            destinations: configuration.destination,
            product: .app,
            bundleId: configuration.bundleIdentifier,
            deploymentTargets: configuration.deploymentTarget,
            infoPlist: .extendingDefault(with: configuration.infoPlist),
            sources: ["Sources/**"],
            resources: [.glob(pattern: "Resources/**", excluding: [])],
            entitlements: configuration.entitlements,
            dependencies: dependencies,
            settings: configuration.commonSettings
        )
        
        let appScheme = Scheme.configureAppScheme(
            schemeName: configuration.projectName
        )
        
        return Project(
            name: configuration.projectName,
            organizationName: configuration.organizationName,
            settings: configuration.commonSettings,
            targets: [appTarget],
            schemes: appScheme
        )
    }
    
    /// 단순 모듈
    // 하나의 프레임워크 ex) Data, Repository 등
    static func configureModule(
        configuration: AppConfiguration,
        name: String,
        product: Product,
        hasResources: Bool = false,
        hasTests: Bool = false,
        hasTesting: Bool = false,
        hasExample: Bool = false,
        hasInterface: Bool = false,
        dependencies: [TargetDependency],
        interfaceDependencies: [TargetDependency] = [],
        testingDependencies: [TargetDependency] = []
    ) -> Self {
        var targets: [Target] = []
        var schemes: [Scheme] = [Scheme.configureScheme(
            schemeName: name
        )]

        if hasInterface {
            let interfaceTarget = createInterfaceTarget(
                name: name,
                configuration: configuration,
                product: product,
                dependencies: interfaceDependencies
            )
            targets.append(interfaceTarget)
        }

        // 구현체 의존성: Interface + dependencies
        var implementationDependencies = dependencies
        if hasInterface {
            implementationDependencies.insert(.target(name: "\(name)Interface"), at: 0)
        }

        let frameworkTarget = createFrameworkTarget(
            name: name,
            configuration: configuration,
            hasResources: hasResources,
            product: product,
            dependencies: implementationDependencies
        )
        targets.append(frameworkTarget)
        
        if hasTests {
            var testsDependencies: [TargetDependency] = [.target(name: name)]

            if hasTesting {
                var testingModuleDependencies = (hasInterface ? [TargetDependency.target(name: "\(name)Interface")] : [])
                testingModuleDependencies.append(contentsOf: testingDependencies)

                let testingTarget = Target.target(
                    name: "\(name)Testing",
                    destinations: configuration.destination,
                    product: product,
                    bundleId: "\(configuration.bundleIdentifier).\(name.lowercased())Testing",
                    deploymentTargets: configuration.deploymentTarget,
                    infoPlist: .default,
                    sources: ["Testing/Sources/**"],
                    dependencies: testingModuleDependencies
                )
                targets.append(testingTarget)
                testsDependencies.append(.target(name: "\(name)Testing"))
            }

            let testsTarget = createTestTarget(
                name: name,
                configuration: configuration,
                dependencies: testsDependencies
            )
            targets.append(testsTarget)
        }
        
        if hasExample {
            let exampleTarget = createExampleTarget(
                name: name,
                configuration: configuration,
                hasTesting: hasTesting
            )
            targets.append(exampleTarget)
            schemes.append(Scheme.configureExampleAppScheme(schemeName: "\(name)Example"))
        }
        
        return Project(
            name: name,
            organizationName: configuration.organizationName,
            settings: configuration.commonSettings,
            targets: targets,
            schemes: schemes
        )
    }
}

// MARK: Create Target
extension Project {
    private static func createExampleTarget(
        name: String,
        configuration: AppConfiguration,
        hasTesting: Bool = false
    ) -> Target {
        var dependencies: [TargetDependency] = [.target(name: name)]

        if hasTesting {
            dependencies.append(.target(name: "\(name)Testing"))
        }
        return Target.target(
            name: "\(name)Example",
            destinations: configuration.destination,
            product: .app,
            bundleId: "\(configuration.bundleIdentifier).\(name.lowercased())Example",
            deploymentTargets: configuration.deploymentTarget,
            sources: ["Example/Sources/**"],
            resources: [.glob(pattern: "Example/Resources/**", excluding: [])],
            dependencies: dependencies
        )
    }
    
    private static func createFrameworkTarget(
        name: String,
        configuration: AppConfiguration,
        hasResources: Bool = false,
        product: Product,
        dependencies: [TargetDependency]
    ) -> Target {
        return Target.target(
            name: name,
            destinations: configuration.destination,
            product: product,
            bundleId: "\(configuration.bundleIdentifier).\(name.lowercased())",
            deploymentTargets: configuration.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
            dependencies: dependencies
        )
    }
    
    private static func createInterfaceTarget(
        name: String,
        configuration: AppConfiguration,
        product: Product,
        dependencies: [TargetDependency]
    ) -> Target {
        return Target.target(
            name: "\(name)Interface",
            destinations: configuration.destination,
            product: product,
            bundleId: "\(configuration.bundleIdentifier).\(name.lowercased())Interface",
            deploymentTargets: configuration.deploymentTarget,
            infoPlist: .default,
            sources: ["Interface/Sources/**"],
            dependencies: dependencies
        )
    }
    
    static func createTestTarget(
        name: String,
        configuration: AppConfiguration,
        dependencies: [TargetDependency]
    ) -> Target {
        return Target.target(
            name: "\(name)Tests",
            destinations: configuration.destination,
            product: .unitTests,
            bundleId: "\(configuration.bundleIdentifier).\(name.lowercased())Tests",
            deploymentTargets: configuration.deploymentTarget,
            sources: ["Tests/Sources/**"],
            dependencies: dependencies
        )
    }
}
