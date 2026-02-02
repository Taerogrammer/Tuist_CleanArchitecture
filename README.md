# tuist-template

## 📐 Architecture

이 프로젝트는 확장성 및 유지보수성을 극대화하기 위해, 클린 아키텍처를 기반으로 한 모듈화 구조를 채택하고 있습니다.

### 주요 원칙

1.  **관심사의 분리 (SoC)**: 각 레이어(`Feature`, `Domain`, `Data`)는 명확하게 자신의 책임에만 집중합니다.
2.  **의존성 규칙 (Dependency Rule)**: 의존성 방향은 항상 외부에서 내부로, 불안정한 것에서 안정적인 것으로 향합니다.
3.  **의존성 역전 원칙 (DIP)**: 상위 모듈은 하위 모듈의 구체적인 구현이 아닌, 추상화(Interface)에 의존합니다.

### 의존성 흐름

`Core`와 `SharedUI`는 서로를 의존하지 않는 **독립적인 형제 관계**입니다. `Feature`와 같은 상위 계층에서 이 둘을 모두 필요로 할 경우, 각각 의존성을 추가하여 사용합니다.

```
            [App]
              │
              ▼
        [Umbrella(DI)]
┌─────────────┴─────────────┐
│             │             │
▼             ▼             ▼
[Feature]     [Data]     [Domain]
    │             │           │
    ├─────────────┴───────────┤
    │                         │
    ▼                         ▼
[SharedUI]                  [Core]
    │
    ▼
[DesignKit]
```

**의존성 상세 흐름:**
*   `App` → `Umbrella(DI)`
*   `Umbrella(DI)` → `Feature`, `Domain`, `Data`, `SharedUI`, `Core`, `DesignKit` 등 모든 구현체
*   `Feature` → `Domain.Interface`, `SharedUI`, `Core`
*   `Data` → `Domain.Interface` (이를 통해 간접적으로 `Core` 사용)
*   `Domain` → `Core`
*   `SharedUI` → `DesignKit`
*   **`Core`는 다른 프로젝트 모듈에 의존하지 않습니다.**
*   **`SharedUI`는 `Core`에 의존하지 않습니다.**
*   **`DesignKit`은 다른 프로젝트 모듈에 의존하지 않습니다.**

### 레이어 설명

#### 📲 `Feature`
- **역할**: 사용자가 보는 화면과 상호작용을 담당하는 UI 레이어입니다.
- **의존성**: 자신이 필요한 `Domain.Interface`와 UI 구성을 위한 `SharedUI`, 그리고 비즈니스 로직과 무관한 공통 기능이 필요할 경우 `Core`를 의존합니다.

#### 🧠 `Domain`
- **역할**: 앱의 핵심 비즈니스 로직을 담당합니다. 순수한 비즈니스 규칙, 유즈케이스(Use Case), 엔티티(Entity), 그리고 Repository의 **인터페이스(Interface)**를 포함합니다.
- **의존성**: `Core`를 의존합니다. `Feature`나 `Data` 등 외부 레이어에 대해서는 알지 못합니다.
- **특징**: 각 기능 단위(`FirstDomain`, `SampleDomain`)로 모듈이 분리되어, 인터페이스 분리 원칙을 준수합니다.

#### 💽 `Data`
- **역할**: `Domain` 레이어에 선언된 `Repository Interface`의 **구현체**를 제공합니다. 실제 데이터 소스(네트워크, 데이터베이스 등)와의 통신을 책임집니다.
- **의존성**: 자신이 구현해야 할 `Domain Interface`와 실제 데이터 통신에 필요한 `DataSource` 모듈에 의존합니다.

#### 🏗️ Foundation Layers
- **역할**: 앱의 가장 기반이 되는 공통 기능 및 UI 요소들을 제공합니다. **`Core`와 `SharedUI`는 서로 의존하지 않는 독립적인 관계입니다.**
- **`Core`**: 'Shared Kernel' 역할을 하는 가장 중요한 공통 모듈입니다. **UI와 완전히 무관하며**, 기본 모델, 유틸리티, 확장 기능 등 모든 레이어에서 공유하는 코드를 포함합니다.
- **`DesignKit`**: 색상, 폰트, 기본 UI 컴포넌트(Atom) 등 가장 순수한 UI 부품들을 모아둔 모듈입니다.
- **`SharedUI`**: `DesignKit`을 바탕으로, 여러 피처에서 재사용될 수 있는 더 복잡한 UI 컴포넌트(Molecule, Organism)를 제공합니다.

#### ☂️ `Umbrella`
- **역할**: 의존성 주입(DI)을 전담하는 '조립 공장'입니다. 앱 실행에 필요한 모든 모듈들의 구체적인 구현체를 생성하고, 서로의 의존성을 연결해주는 역할을 합니다.
