//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    moduleType: .feature(name: "FirstFeature"),
    product: .staticFramework,
    dependencies: [
    ],
    interfaceDependencies: [
        .Module.core,
        .Module.sharedUI,
        .Domain.Sample.interface,
    ]
)
