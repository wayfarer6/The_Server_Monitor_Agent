# 변수 설정
BINARY_NAME=THE_SERVER_MONITOR_AGENT
MAIN_PATH=./cmd/main.go
OUT_DIR=bin

# 빌드 플래그: 
# -s: 심볼 테이블 제거, -w: DWARF 디버깅 정보 제거 (크기 최소화)
# -extldflags "-static": 완전 정적 빌드 강제
LDFLAGS=-ldflags '-s -w -extldflags "-static"'

.PHONY: all build-all linux-amd64 linux-arm64 clean

all: build-all

## build-all: 두 아키텍처용 바이너리 모두 빌드
build-all: linux-amd64 linux-arm64

## linux-amd64: Linux x86_64용 정적 빌드
linux-amd64:
	@echo "Building for Linux x86_64..."
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a $(LDFLAGS) -o $(OUT_DIR)/$(BINARY_NAME)-amd64 $(MAIN_PATH)

## linux-arm64: Linux aarch64(ARM64)용 정적 빌드
linux-arm64:
	@echo "Building for Linux ARM64..."
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a $(LDFLAGS) -o $(OUT_DIR)/$(BINARY_NAME)-arm64 $(MAIN_PATH)


## test: 모든 패키지의 유닛 테스트를 실행합니다.  _test.go로 시작하는 파일들 확인함.
test:
	@echo "Running tests..."
	CGO_ENABLED=0 go test -v ./...

## test-coverage: 테스트 커버리지를 확인합니다.
test-coverage:
	go test -coverprofile=coverage.out ./...
	go tool cover -func=coverage.out


## clean: 빌드 결과물 삭제
##clean:
##	rm -rf $(OUT_DIR)