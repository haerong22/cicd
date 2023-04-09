# [NUMBLE 딥다이브] 배포자동화 도구 활용하기

### 1. 인프라 구축
```terraform
terraform init
terraform apply
```

- EC2 생성 (jenkins서버, web서버) 및 도커 설치
- 퍼블릭 키 및 빌드파일 저장용 S3 생성

- 완료 후 EC2 public ip응답 및 host파일에 저장

  ![image](https://user-images.githubusercontent.com/62274314/230756810-300ff99f-f10c-40a9-9f59-7a48e6397a4a.png)

  ![image](https://user-images.githubusercontent.com/62274314/230756948-e11148a2-28aa-462a-91c9-0cdf78d769f4.png)

### 2. 젠킨스 서버 설정
```shell
sh jenkins.sh
```
- jenkins 도커로 실행
- ansible 설치
- key pair생성 및 public 키 s3 업로드

- 완료 후 jenkins 초기 비밀번호 응답

  ![image](https://user-images.githubusercontent.com/62274314/230757157-1d755918-4971-4257-aaf3-a4d499305265.png)

### 3. 웹 서버 설정
```shell
sh web.sh
```
- nginx 도커로 실행
- s3에 업로드 된 public 키 다운로드 및 등록

- 기본 실행화면

  ![image](https://user-images.githubusercontent.com/62274314/230757367-2c1e241c-7e1e-4d42-918e-c1919e74e590.png)

### 4. 젠킨스 설정
- Node js 모듈 설치

  ![image](https://user-images.githubusercontent.com/62274314/230757669-7c0f5642-f60d-42e3-a1c4-679653087242.png)
  
  ![image](https://user-images.githubusercontent.com/62274314/230758156-736b29b3-3151-4e5a-b9d2-52d1ff6d094d.png)

- 파이프라인 생성
  - 생성된 빌드파일 압축 후 S3업로드
  - 빌드 파일 다운로드 및 압축 해제
  
  ![image](https://user-images.githubusercontent.com/62274314/230757814-7e1547e9-bf22-4a26-8c5f-7b5982fe38b8.png)

  ![image](https://user-images.githubusercontent.com/62274314/230757855-cbe5813a-f1cc-4244-b33a-ded11c9de01c.png)


### 5. 배포 자동화 - github hook 연동

- github webhook 설정
  
  ![image](https://user-images.githubusercontent.com/62274314/230757935-07cedbfc-a80c-40d0-9a38-14845a8495bb.png)


- 파이프라인 설정 변경

  ![image](https://user-images.githubusercontent.com/62274314/230758041-8f27f358-152d-47ac-be45-50cbd504e242.png)

- main 브랜치 코드 푸시

  ![image](https://user-images.githubusercontent.com/62274314/230758677-7c17ccff-182c-456f-927f-c4e11470fbb0.png)

- 배포 완료

  ![image](https://user-images.githubusercontent.com/62274314/230758701-555eacba-e205-48d8-8c06-63ebff7f7fab.png)


---
