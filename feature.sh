# Generate basic folders for a new feature
cd lib/features
echo enter name the new feature:
read feature
mkdir $feature
cd $feature
touch $feature.dart
mkdir presentation
touch presentation/presentation.dart
cd presentation
mkdir screens widgets
touch screens/screens.dart
touch widgets/widgets.dart