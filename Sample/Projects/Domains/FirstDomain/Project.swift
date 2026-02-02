import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    moduleType: .domain(name: "FirstDomain"),
    product: .staticFramework,
    dependencies: [
    ],
    interfaceDependencies: [
        .Module.core,
    ]
)
