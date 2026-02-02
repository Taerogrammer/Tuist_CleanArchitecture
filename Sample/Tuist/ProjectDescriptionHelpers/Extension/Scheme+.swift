//
//  AppScheme.swift
//  TestProjectManifests
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

import ProjectDescription

extension Scheme {
    static func configureAppScheme(
        schemeName: String
    ) -> [Scheme] {
        let developConfiguration: ConfigurationName = .configuration("Develop")
        let testConfiguration: ConfigurationName = .configuration("Tests")
        let productionConfiguration: ConfigurationName = .configuration("Production")
        
        let buildAction = BuildAction.buildAction(targets: [TargetReference(stringLiteral: schemeName)])
        
        return [
            Scheme.scheme(
                name: schemeName + "-Develop",
                shared: true,
                buildAction: buildAction,
                runAction: .runAction(configuration: developConfiguration),
                archiveAction: .archiveAction(configuration: developConfiguration),
                profileAction: .profileAction(configuration: developConfiguration),
                analyzeAction: .analyzeAction(configuration: developConfiguration)
            ),
            Scheme.scheme(
                name: schemeName + "-Tests",
                shared: true,
                buildAction: buildAction,
                runAction: .runAction(configuration: testConfiguration),
                archiveAction: .archiveAction(configuration: testConfiguration),
                profileAction: .profileAction(configuration: testConfiguration),
                analyzeAction: .analyzeAction(configuration: testConfiguration)
            ),
            Scheme.scheme(
                name: schemeName + "-Production",
                shared: true,
                buildAction: buildAction,
                runAction: .runAction(configuration: productionConfiguration),
                archiveAction: .archiveAction(configuration: productionConfiguration),
                profileAction: .profileAction(configuration: productionConfiguration),
                analyzeAction: .analyzeAction(configuration: productionConfiguration)
            )
        ]
    }
    
    static func configureExampleAppScheme(
        schemeName: String
    ) -> Scheme {
        let developConfiguration: ConfigurationName = .configuration("Develop")
        
        let buildAction = BuildAction.buildAction(targets: [TargetReference(stringLiteral: schemeName)])
        
        return Scheme.scheme(
            name: schemeName,
            shared: true,
            buildAction: buildAction,
            runAction: .runAction(configuration: developConfiguration),
            archiveAction: .archiveAction(configuration: developConfiguration),
            profileAction: .profileAction(configuration: developConfiguration),
            analyzeAction: .analyzeAction(configuration: developConfiguration)
        )
    }
    
    static func configureScheme(
        schemeName: String
    ) -> Scheme {
        let configuration: ConfigurationName = .configuration("Develop")

        let buildAction = BuildAction.buildAction(targets: [TargetReference(stringLiteral: schemeName)])

        // Tests 타겟 참조 생성
        let testAction = TestAction.targets(
            [TestableTarget(stringLiteral: "\(schemeName)Tests")],
            configuration: configuration
        )

        return Scheme.scheme(
                name: schemeName,
                shared: true,
                buildAction: buildAction,
                testAction: testAction,
                runAction: .runAction(configuration: configuration),
                archiveAction: .archiveAction(configuration: configuration),
                profileAction: .profileAction(configuration: configuration),
                analyzeAction: .analyzeAction(configuration: configuration)
        )
    }
}
