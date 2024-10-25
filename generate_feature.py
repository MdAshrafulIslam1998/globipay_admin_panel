import os

# Define the base path where the modules will be created
BASE_PATH = './lib/modules/'

# Templates for the controller, screen_builder, and screen
controller_template = """import 'package:flutter/material.dart';
import 'package:get/get.dart';

class {feature}Controller extends GetxController {{
    var featureName = "{feature}";
    
    // Add your controller logic here
}}
"""

screen_builder_template = """import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class {feature}ScreenBuilder extends StatelessWidget {{
    const {feature}ScreenBuilder({{Key? key}}) : super(key: key);

    @override
    Widget build(BuildContext context) {{
        // Add your screen builder logic here
        return Scaffold(
            appBar: AppBar(title: Text('{feature}')),
            body: Center(child: Text('This is {feature} Page. Build the UI here')),
        );
    }}
}}
"""

screen_template = """import 'package:flutter/cupertino.dart';
import '{feature_snake}_screen_builder.dart';

class {feature}Screen extends StatelessWidget {{
    const {feature}Screen({{Key? key}}) : super(key: key);

    @override
    Widget build(BuildContext context) {{
        return {feature}ScreenBuilder();
    }}
}}
"""

# Function to create folders and files
def create_feature(feature_name):
    # Convert feature name to PascalCase and snake_case
    feature_pascal = ''.join(word.capitalize() for word in feature_name.split('_'))
    feature_snake = feature_name.lower()

    # Paths for the feature
    feature_path = os.path.join(BASE_PATH, feature_snake)
    controller_path = os.path.join(feature_path, 'controller')
    views_path = os.path.join(feature_path, 'views')

    # Create the folder structure
    os.makedirs(controller_path, exist_ok=True)
    os.makedirs(views_path, exist_ok=True)

    # File paths
    controller_file = os.path.join(controller_path, f'{feature_snake}_controller.dart')
    screen_builder_file = os.path.join(views_path, f'{feature_snake}_screen_builder.dart')
    screen_file = os.path.join(views_path, f'{feature_snake}_screen.dart')

    # Write the templates to the files
    with open(controller_file, 'w') as f:
        f.write(controller_template.format(feature=feature_pascal))

    with open(screen_builder_file, 'w') as f:
        f.write(screen_builder_template.format(feature=feature_pascal, feature_snake=feature_snake))

    with open(screen_file, 'w') as f:
        f.write(screen_template.format(feature=feature_pascal, feature_snake=feature_snake))

    print(f'Feature "{feature_pascal}" created successfully with the necessary files!')

# Ask for feature name
feature_name = input("Enter the feature name (use snake_case): ")
create_feature(feature_name)
