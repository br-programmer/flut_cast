fc_packages:
	flutter pub get

fc_build:
	dart run build_runner build --delete-conflicting-outputs

fc_slang:
	dart run slang

fc_api_client_packages:
	cd packages/fc_api_client && flutter pub get

fc_api_client_build:
	cd packages/fc_api_client && dart run build_runner build --delete-conflicting-outputs

fc_common_packages:
	cd packages/fc_common && flutter pub get

fc_common_build:
	cd packages/fc_common && dart run build_runner build --delete-conflicting-outputs

fc_data_packages:
	cd packages/fc_data && flutter pub get
fc_domain_packages:
	cd packages/fc_domain && flutter pub get

fc_domain_build:
	cd packages/fc_domain && dart run build_runner build --delete-conflicting-outputs

fc_geolocator_packages:
	cd packages/fc_geolocator && flutter pub get
	
fc_local_storage_packages:
	cd packages/fc_local_storage && flutter pub get	
fc_ui_packages:
	cd packages/fc_ui && && flutter pub get	

fc_ui_gen:
	cd packages/fc_ui && fluttergen -c pubspec.yaml