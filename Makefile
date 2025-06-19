lint:
	dart analyze

unit-tests:
	flutter test ./packages/core --coverage --verbose
	flutter test ./packages/main --coverage --verbose

analyze:
	flutter analyze ./packages/core
	flutter analyze ./packages/main

build-runner:
	cd ./packages/core
	flutter packages pub run build_runner build --delete-conflicting-outputs
	cd ../..

	cd ./packages/main
	flutter packages pub run build_runner build --delete-conflicting-outputs
	cd ../..

	flutter packages pub run build_runner build --delete-conflicting-outputs

clean:
	flutter clean ./packages/core
	flutter clean ./packages/main
	flutter clean

get:
	flutter pub get ./packages/core
	flutter pub get ./packages/main
	flutter pub get

upgrade:
	flutter pub upgrade ./packages/core
	flutter pub upgrade ./packages/main
	flutter pub upgrade


run:
	flutter run -d chrome --web-hostname 127.0.0.1 --web-port 8989 --web-renderer canvaskit --dart-define-from-file=lib/env_json.json

build-web:
	flutter build web --web-renderer canvaskit --dart-define-from-file=lib/env_json.json