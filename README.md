# 📻 KPOP CTZen Radio App

> KPOP 팬들을 위한 실시간 라디오 스트리밍 & 인터랙티브 커뮤니티 앱

[![Flutter](https://img.shields.io/badge/Flutter-3.7+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![License: KPCT-SAL](https://img.shields.io/badge/License-KPCT--SAL-blueviolet.svg)](LICENSE)

## 📖 소개

**KPOP CTZen Radio**는 KPOP 팬들이 실시간 라디오를 청취하며 다양한 인터랙티브 콘텐츠를 즐길 수 있는 Flutter 기반 모바일 앱입니다. 라디오 청취와 함께 아이템 수집, 기어 장착, 크래프팅 등 게이미피케이션 요소를 결합하여 색다른 팬 경험을 제공합니다.

> 📚 **[기획서 보기](docs/KPCT_RADIO_APP.pdf)** | 📊 **[데이터(CSV) 보기](docs/csv/)**

## ✨ 주요 기능

| 기능                 | 설명                                       |
| -------------------- | ------------------------------------------ |
| 🎵 **라이브 라디오** | KPOP 라이브 라디오 스트리밍 (YouTube 기반) |
| 🎒 **아이템 시스템** | 아이템 수집 및 인벤토리 관리               |
| ⚙️ **기어 시스템**   | 라디오, 액세서리, 젬, 파츠 등 기어 장착    |
| 🔨 **크래프팅**      | 아이템을 조합하여 새로운 아이템 제작       |
| 🏪 **상점**          | 인앱 상점에서 아이템 구매                  |
| 🏆 **티어 시스템**   | 활동 기반 등급 시스템                      |
| 👤 **사용자 프로필** | Google / Apple 소셜 로그인 지원            |

## 🛠 기술 스택

- **프레임워크**: Flutter 3.7+
- **상태관리**: flutter_bloc + freezed
- **라우팅**: go_router
- **백엔드**: Firebase (Auth, Firestore, Cloud Functions)
- **미디어**: youtube_player_iframe
- **인증**: Google Sign-In, Sign in with Apple
- **공통 패키지**: [kpct_radio_app_common](https://github.com/Rowoon-Labs/kpct_radio_app_common)

## 📁 프로젝트 구조

```
kpct_radio_app/
├── lib/
│   ├── main.dart                 # 앱 진입점
│   ├── app/                      # 앱 코어 (인증, 에셋, 설정)
│   ├── model/                    # 데이터 모델
│   ├── route/
│   │   ├── sign/                 # 로그인 화면
│   │   └── home/                 # 메인 화면
│   │       ├── page/
│   │       │   ├── idle/         # 메인 (라디오 청취)
│   │       │   ├── shop/         # 상점
│   │       │   ├── crafting/     # 크래프팅
│   │       │   ├── gear/         # 기어 관리
│   │       │   └── status/       # 상태 / 프로필
│   │       └── modal/            # 모달 다이얼로그
│   └── widget/                   # 공통 위젯
├── assets/                       # 이미지, 아이콘 등 리소스
├── functions/                    # Firebase Cloud Functions
├── kpct_switcher/                # 커스텀 스위처 위젯 패키지
├── kpct_aspect_ratio/            # 커스텀 비율 위젯 패키지
├── kpct_cupertino_button/        # 커스텀 버튼 위젯 패키지
└── docs/                         # 기획서 및 데이터 (KPCT_RADIO_APP.pdf)
```

## 🚀 시작하기

### 사전 준비

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.7 이상
- [Firebase 계정](https://console.firebase.google.com/) 및 프로젝트 생성
- [Firebase CLI](https://firebase.google.com/docs/cli) 및 [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) 설치

### 설치 및 실행

```bash
# 1. 저장소 클론
git clone https://github.com/Rowoon-Labs/kpct_radio_app.git
git clone https://github.com/Rowoon-Labs/kpct_radio_app_common.git

# 2. 공통 패키지 의존성 설치
cd kpct_radio_app_common
flutter pub get

# 3. 메인 앱 의존성 설치
cd ../kpct_radio_app
flutter pub get

# 4. Firebase 설정 (본인의 Firebase 프로젝트와 연동)
flutterfire configure

# 5. 코드 생성
flutter pub run build_runner build --delete-conflicting-outputs

# 6. 실행
flutter run
```

> [!NOTE]
> 이 프로젝트는 Firebase를 사용합니다. 보안을 위해 Firebase 설정 파일(`google-services.json`, `GoogleService-Info.plist`, `firebase_options.dart`)은 저장소에 포함되어 있지 않으므로, 본인의 Firebase 프로젝트를 연동해야 합니다.

## 🤝 기여하기

프로젝트에 기여해 주셔서 감사합니다! 아래 절차를 참고해 주세요.

1. 이 저장소를 **Fork** 합니다
2. 새로운 **Feature Branch**를 생성합니다 (`git checkout -b feature/amazing-feature`)
3. 변경 사항을 **커밋**합니다 (`git commit -m 'feat: Add amazing feature'`)
4. 브랜치에 **Push**합니다 (`git push origin feature/amazing-feature`)
5. **Pull Request**를 생성합니다

## 📄 라이선스

이 프로젝트는 **KPOP CTZen Source Available License (KPCT-SAL)** 하에 배포됩니다.

- ✅ **비상업적 사용**: 누구나 자유롭게 사용, 수정, 배포 가능
- ✅ **소스 열람 및 기여**: 누구나 소스 코드 열람, 버그 리포트, PR 제출 가능
- 🔒 **상업적 사용**: 아래 조건 중 하나를 충족하는 홀더만 허용

| 조건             | 요구사항                                                                                                                     |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| NFT 보유         | [V1](https://opensea.io/collection/kpopctzen-official) + [V2](https://opensea.io/collection/kpop-ctzen-v2) 합산 **5개 이상** |
| HODDAO 토큰 보유 | [HODDAO](https://mint.club/token/base/HODDAO?tab=overview) **50,000개 이상** 연속 보유                                       |

자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 📬 문의

- **GitHub Issues**: [이슈 등록](https://github.com/Rowoon-Labs/kpct_radio_app/issues)
