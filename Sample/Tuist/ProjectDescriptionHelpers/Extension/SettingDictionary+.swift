//
//  SettingDictionary+.swift
//  ProjectDescriptionHelpers
//
//  Created by 김태형 on 9/26/25.
//

import ProjectDescription

public extension SettingsDictionary {
    // 링커 옵션
    // $(inherited): 상위 설정에 링커 플래그가 있다면, 그 설정을 그대로 상속받아서 사용
    // -Objc: Objective-C 호환성 설정
    static let baseSettings: Self = SettingsDictionary().otherLinkerFlags([
        "$(inherited)", "-ObjC"
    ])
    
    // 디버그 설정 추가
    static let debugSettings: Self = baseSettings
        .swiftOptimizationLevel(.oNone) // 최적화 단계 '없음' 설정 (최적화하면 코드가 재배열되어 디버깅이 어려워질 수 있기 때문)
        .merging([
            "COPY_PHASE_STRIP": "NO",
            "STRIP_INSTALLED_PRODUCT": "NO",
            "ONLY_ACTIVE_ARCH": "YES"
        ]) { _, new in new }

    // 자동 코드 서명 기능 활성화
    // Team ID를 명시하지 않아 누구나 자신의 Apple Developer 계정으로 실행 가능
    func configureAutoCodeSigning() -> SettingsDictionary {
        return merging([
            "CODE_SIGN_STYLE": "Automatic",
            "CODE_SIGN_IDENTITY": "Apple Development",
            "PROVISIONING_PROFILE_SPECIFIER": ""
        ])
    }
    
    func configureVersioning() -> SettingsDictionary {
        currentProjectVersion("1")
            .marketingVersion("1.0.0")
            .appleGenericVersioningSystem()
    }
    
    // 테스트 관련 설정
    func configureTestability() -> SettingsDictionary {
        merging(["ENABLE_TESTABILITY": "YES"])  // 테스트 용이성 옵션 활성화
    }
}
