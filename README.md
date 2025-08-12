# 🌏 KODI - Korean Travel Community Platform

**실시간 자동번역 기반 한국 여행 정보 공유 커뮤니티**

KODI는 한국을 여행하는 외국인들과 한국인들이 언어 장벽 없이 소통할 수 있는 실시간 번역 지원 여행 커뮤니티 플랫폼입니다.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.1-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg)](https://www.mysql.com/)

## 📋 목차
- [주요 기능](#-주요-기능)
- [기술 스택](#-기술-스택)
- [시스템 요구사항](#-시스템-요구사항)
- [설치 및 실행](#-설치-및-실행)
- [API 설정](#-api-설정)
- [프로젝트 구조](#-프로젝트-구조)
- [기여하기](#-기여하기)

## ✨ 주요 기능

### 🔄 실시간 자동번역
- **다국어 지원**: 한국어, 영어, 일본어, 중국어 자동 번역
- **실시간 채팅**: WebSocket 기반 즉시 번역 채팅
- **Papago API 연동**: 네이버 번역 엔진 활용

### 💬 소셜 커뮤니티
- **게시판 시스템**: 여행 후기, 질문, 정보 공유
- **실시간 채팅**: 1:1 및 그룹 채팅 지원
- **친구 시스템**: 사용자 간 친구 추가 및 관리
- **좋아요 & 댓글**: 게시물 상호작용 기능

### 🗺️ 여행 도구
- **지도 통합**: Kakao Map, Google Maps 연동
- **여행 플래너**: 일정 계획 및 관리 도구
- **비용 계산기**: 여행 경비 관리 시스템
- **위치 정보**: 관광지, 맛집 정보 공유

### 👤 사용자 관리
- **회원가입/로그인**: 이메일 인증 시스템
- **프로필 관리**: 개인정보 및 프로필 사진 관리
- **관리자 패널**: 사용자 및 콘텐츠 관리

## 🛠 기술 스택

### Backend
- **Framework**: Spring Boot 3.2.1
- **Language**: Java 17
- **Build Tool**: Maven
- **Database**: MySQL 8.0 / MariaDB
- **ORM**: MyBatis 3.0.3
- **Real-time**: WebSocket

### Frontend
- **Template Engine**: JSP
- **Styling**: CSS3, Bootstrap
- **JavaScript**: ES6+, jQuery
- **Maps**: Kakao Map API, Google Maps API

### External APIs
- **Translation**: Naver Papago API
- **Email**: SMTP 이메일 서비스
- **File Upload**: 멀티파트 파일 업로드

### Infrastructure
- **Server**: Apache Tomcat 10.1.17
- **Security**: Spring Security (Optional)
- **DevTools**: Spring Boot DevTools

## 💻 시스템 요구사항

- **Java**: JDK 17 이상
- **Database**: MySQL 8.0 또는 MariaDB 10.6 이상
- **Memory**: 최소 2GB RAM
- **Storage**: 최소 1GB 여유 공간

## 🚀 설치 및 실행

### 1. 프로젝트 클론
```bash
git clone https://github.com/eunsoni/KODI.git
cd KODI/KODI
```

### 2. 데이터베이스 설정
MySQL/MariaDB에 접속하여 다음 명령어 실행:

```sql
-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS kodi_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 사용자 생성 및 권한 부여
CREATE USER 'kodi_user'@'localhost' IDENTIFIED BY 'kodi';
GRANT ALL PRIVILEGES ON kodi_db.* TO 'kodi_user'@'localhost';
FLUSH PRIVILEGES;
```

### 3. 애플리케이션 설정
`src/main/resources/` 디렉토리에 설정 파일들을 생성:

**application.properties**
```properties
# Server Configuration
server.port=8080
server.servlet.context-path=

# Database Configuration
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/kodi_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=kodi_user
spring.datasource.password=kodi

# MyBatis Configuration
mybatis.mapper-locations=classpath:mybatis/mapper/*.xml
mybatis.type-aliases-package=kodi.dto

# File Upload
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
my.file.dir=/path/to/upload/directory

# Profile
spring.profiles.active=dev
```

### 4. 애플리케이션 실행
```bash
# Gradle을 이용한 실행
./gradlew bootRun

# 또는 WAR 파일 생성 후 실행
./gradlew clean bootWar
java -jar build/libs/KODI_project-0.0.1-SNAPSHOT.war
```

### 5. 접속 확인
브라우저에서 `http://localhost:8080` 접속

## 🔑 API 설정

프로덕션 환경에서는 다음 API 키들을 설정해야 합니다:

### Papago API (번역 서비스)
1. [네이버 개발자 센터](https://developers.naver.com/)에서 애플리케이션 등록
2. `application.properties`에 API 키 추가:
```properties
papago.client.id=YOUR_CLIENT_ID
papago.client.secret=YOUR_CLIENT_SECRET
```

### Kakao Map API
1. [카카오 개발자](https://developers.kakao.com/)에서 앱 등록
2. JavaScript 키를 JSP 파일에 설정

### Google Maps API
1. [Google Cloud Console](https://console.cloud.google.com/)에서 프로젝트 생성
2. Maps JavaScript API 활성화 및 키 발급

## 📁 프로젝트 구조

```
KODI/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── kodi/
│   │   │       ├── KodiApplication.java          # 메인 애플리케이션
│   │   │       ├── config/                       # 설정 클래스
│   │   │       │   ├── WebSocketConfig.java      # WebSocket 설정
│   │   │       │   ├── WebSocketHandler.java     # WebSocket 핸들러
│   │   │       │   └── ResourceConfig.java       # 리소스 설정
│   │   │       ├── controller/                   # REST 컨트롤러
│   │   │       │   ├── HomeController.java       # 홈페이지
│   │   │       │   ├── MemberController.java     # 회원 관리
│   │   │       │   ├── LiveChatController.java   # 실시간 채팅
│   │   │       │   ├── MapController.java        # 지도 서비스
│   │   │       │   └── ...
│   │   │       ├── service/                      # 비즈니스 로직
│   │   │       │   ├── MemberService.java        # 회원 서비스
│   │   │       │   ├── PapagoService.java        # 번역 서비스
│   │   │       │   ├── ChatListService.java      # 채팅 서비스
│   │   │       │   └── ...
│   │   │       ├── dao/                          # 데이터 접근 객체
│   │   │       └── dto/                          # 데이터 전송 객체
│   │   ├── resources/
│   │   │   ├── mybatis/mapper/                   # MyBatis 매퍼 XML
│   │   │   ├── static/                           # 정적 리소스
│   │   │   └── application.properties            # 애플리케이션 설정
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── views/                        # JSP 뷰 파일
│   └── test/                                     # 테스트 코드
├── target/                                       # 빌드 결과물
├── pom.xml                                       # Maven 설정
└── README.md                                     # 프로젝트 문서
```

## 🤝 기여하기

1. 프로젝트를 Fork 합니다
2. 새로운 기능 브랜치를 생성합니다 (`git checkout -b feature/amazing-feature`)
3. 변경사항을 커밋합니다 (`git commit -m 'Add some amazing feature'`)
4. 브랜치에 Push 합니다 (`git push origin feature/amazing-feature`)
5. Pull Request를 생성합니다

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 📞 문의

프로젝트에 대한 문의사항이 있으시면 [Issues](https://github.com/eunsoni/KODI/issues)를 통해 연락해 주세요.

---
**KODI** - 언어의 벽을 넘어 함께하는 한국 여행 🇰🇷
