import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    moduleType: .general(name: "SharedUI"),
    product: .staticFramework,
    dependencies: [
        .Module.designKit
    ]
)
