import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    moduleType: .domain(name: "SampleDomain"),
    product: .staticFramework,
    dependencies: [
        .Data.Sample.interface,
    ],
    interfaceDependencies: [
        .Module.core,
    ]
)
