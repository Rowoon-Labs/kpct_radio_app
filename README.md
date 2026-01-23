# kpct_radio_app

KPOP CTZen Radio 공식 애플리케이션입니다.

## 주요 기능

- KPOP 라이브 라디오 스트리밍
- 사용자 계정 관리 (Firebase Auth)
- 실시간 데이터 동기화 (Firestore)
- 다국어 지원 (intl)

## 시작하기

본 프로젝트는 Firebase를 사용합니다. 오픈 소스 보안을 위해 설정 파일은 포함되어
있지 않으므로, 아래 절차에 따라 본인의 Firebase 설정을 적용해야 합니다.

### 1. 사전 준비

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 설치
- [Firebase 계정](https://console.firebase.google.com/) 및 프로젝트 생성
- [Firebase CLI](https://firebase.google.com/docs/cli) 및
  [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) 설치

### 2. 프로젝트 설정

저장소를 클론한 후 프로젝트 루트 폴더에서 아래 명령어를 실행합니다.

```bash
flutter pub get
flutterfire configure
```

### 3. 실행

```bash
flutter run
```

## 라이선스

MIT License. 상세 내용은 [LICENSE](LICENSE) 파일을 참조하세요.
