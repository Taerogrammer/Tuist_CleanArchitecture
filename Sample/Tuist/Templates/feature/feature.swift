//
//  service.swift
//  Config
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Feature module template",
    attributes: [
        nameAttribute
    ],
    items: [
        // MARK: Project
        .file(path: "\(nameAttribute)Feature/Project.swift",
              templatePath: "../stencil/Feature/featureProject.stencil"),
        
        // MARK: Sources
        .file(path: "\(nameAttribute)Feature/Sources/Sample.swift",
              templatePath: "../stencil/sample.stencil"),
        
        // MARK: Tests
        .file(path: "\(nameAttribute)Feature/Tests/Sources/Sample.swift",
              templatePath: "../stencil/Feature/featureTests.stencil"),
        
        // MARK: Testing
        .file(path: "\(nameAttribute)Feature/Testing/Sources/Sample.swift",
              templatePath: "../stencil/sample.stencil"),
        
        // MARK: Example
        .file(path: "\(nameAttribute)Feature/Example/Sources/AppDelegate.swift",
              templatePath: "../stencil/appDelegate.stencil"),
        .file(path: "\(nameAttribute)Feature/Example/Sources/SceneDelegate.swift",
              templatePath: "SceneDelegate.stencil"),
        .file(path: "\(nameAttribute)Feature/Example/Sources/\(nameAttribute)App.swift",
              templatePath: "../stencil/app.stencil"),
        
        // MARK: Interface
        .file(path: "\(nameAttribute)Feature/Interface/Sources/\(nameAttribute)Feature.swift",
              templatePath: "../stencil/sample.stencil")
    ]
)
