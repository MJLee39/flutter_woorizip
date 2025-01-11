# 📍 프로젝트명

우리집 woorizip


# ✨ 프로젝트 개요

우리집 서비스는 부동산 중개 앱으로, 마이크로 서비스 아키텍처(MSA)와 gRPC 통신을 도입하여 확장성 있고 효율적인 시스템을 구축했습니다. 또한 github webhook과 Jenkins를 이용해 CI/CD 자동 배포를 진행하고 AWS EKS를 활용해 클라우드 인프라 관리를 효율적으로 진행했습니다. 


# 💫 프로젝트 정보

- 개발 기간: 2024.03.18 ~ 2024.05.03 (7주)
  

# ✍️ 프로젝트 로고

![KakaoTalk_20240517_223405216](https://github.com/MJLee39/woorizip-zip/assets/115640392/b12d3a36-beba-4673-983c-c8e65f0cf7b2)


# 👩‍💻 팀 소개

- 이명진 : 매물(zip, estate) 도메인 개발 및 CI/CD 구성
- 조승빈 : 채팅(chatting) 도메인 개발 및 CI/CD 구성
- 권성준 : 조건(condition) 도메인 개발 및 CI/CD 구성
- 한상우 : 계정(account), 첨부파일(attachment) 도메인 개발 및 CI/CD 구성
  

# ✨ 서비스 소개
의뢰인이 부동산을 찾아가는 흐름이 아닌, 중개사가 고객의 조건에 맞는 물건을 찾아 고객에게 결정권을 부여하는 부동산 중개 서비스입니다. 중개사는 조건에 부합하는 매물을 보유하고 있을 때, 의뢰인에게 채팅을 통해 매물의 정보를 전달할 수 있습니다.

![KakaoTalk_20240517_223405216_03](https://github.com/MJLee39/woorizip-zip/assets/115640392/fa977bb4-98d9-4a47-add4-97b07b445a78)


# ⏳ 서비스 아키텍처

![KakaoTalk_20240517_223405216_01](https://github.com/MJLee39/woorizip-zip/assets/115640392/f8d75d5c-841f-4cd9-8c96-209774199025)

MSA 방식으로 도메인 별 요구사항에 맞추어 쓰기가 자주 일어나는 chatting 도메인은 DynamoDB를 사용하고 다른 도메인은 Redis를 사용했습니다.


# 🗺️ 시스템 아키텍처

![KakaoTalk_20240517_223405216_02](https://github.com/MJLee39/woorizip-zip/assets/115640392/8052e342-656e-4a8f-a93c-7d0308603f3f)

- Security
    - ACM을 통해 SSL/TLS 인증서 발급하고 https를 사용해 보안을 강화했습니다.
    - WAF를 사용해 SQL Injection 및 DDos를 방어했습니다.
- 고가용성
    - EKS를 사용해 클러스터를 구성하여 고가용성을 확보했습니다.
    - ALB를 사용해 타겟그룹 간 로드밸런싱을 통해 트래픽을 효육적으로 분산시켰습니다.
    - Karpenter를 사용해 EKS 클러스터의 자동 스케일링을 수행했습니다.
    

# ⛵ CI/CD Pipeline

![argo](https://github.com/MJLee39/woorizip-zip/assets/115640392/3621ca20-3d72-4985-8bd6-690cc1b0445c)

Argo를 사용해 EKS 환경에서 CI/CD 파이프라인을 자동화했습니다.
