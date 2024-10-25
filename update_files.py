import os

# Define file paths
ROUTE_PATH_FILE = 'lib/router/route_path.dart'
APP_ROUTES_LIST_FILE = 'lib/router/app_routes_list.dart'
APP_INJECTOR_FILE = 'lib/di/app_injector.dart'

def to_camel_case(snake_str):
    # Convert to camel case
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

def to_title_case(snake_str):
    # Convert to title case
    components = snake_str.split('_')
    return ''.join(x.title() for x in components)

def update_route_path_file(module_name):
    camel_case_name = to_camel_case(module_name)
    title_case_name = to_title_case(module_name)
    
    new_route_const = f"  static const String {camel_case_name} = _RoutePath._{camel_case_name};\n"
    new_internal_const = f"  static const String _{camel_case_name} = '/{camel_case_name}';\n"

    with open(ROUTE_PATH_FILE, 'r') as file:
        lines = file.readlines()

    with open(ROUTE_PATH_FILE, 'w') as file:
        for line in lines:
            file.write(line)
            if "static const String activeUsers" in line:
                file.write(new_route_const)
            elif "static const String _activeUsers" in line:
                file.write(new_internal_const)

    print(f"Updated {ROUTE_PATH_FILE} with new route: {module_name}")

def update_app_routes_list_file(module_name):
    camel_case_name = to_camel_case(module_name)
    title_case_name = to_title_case(module_name)
    new_import = f"import 'package:globipay_admin_panel/modules/{module_name}/views/{module_name}_screen.dart';\n"
    new_route = f"        GoRoute(\n          path: RoutePath.{camel_case_name},\n          builder: (context, state) => {title_case_name}Screen(),\n        ),\n"

    with open(APP_ROUTES_LIST_FILE, 'r') as file:
        lines = file.readlines()

    with open(APP_ROUTES_LIST_FILE, 'w') as file:
        in_routes_section = False
        for line in lines:
            # Mark when we are in the routes list section
            if "import 'package:go_router/go_router.dart';" in line:
                file.write(new_import)
            if "GoRoute(" in line:
                in_routes_section = True
            if in_routes_section and "]" in line:
                file.write(new_route)
                in_routes_section = False  # Exit the section once added
            file.write(line)

    print(f"Updated {APP_ROUTES_LIST_FILE} with new route: {module_name}")

def update_app_injector_file(module_name):
    const_name = module_name.title().replace('_', '')
    new_import = f"import 'package:globipay_admin_panel/modules/{module_name}/controller/{module_name}_controller.dart';\n"
    new_register = f"  @Register.factory({const_name}Controller)\n"

    with open(APP_INJECTOR_FILE, 'r') as file:
        lines = file.readlines()

    with open(APP_INJECTOR_FILE, 'w') as file:
        for line in lines:
            # Insert import statement after the kiwi package import
            if "import 'package:kiwi/kiwi.dart';" in line:
                file.write(line)
                file.write(new_import)
            else:
                file.write(line)
            
            # Add new controller registration after existing @Register.factory lines
            if "@Register.factory(ActiveUsersController)" in line:
                file.write(new_register)

    print(f"Updated {APP_INJECTOR_FILE} with new controller registration: {module_name}")

def main():
    module_name = input("Enter the name of the new module (e.g., inactive_users): ").strip()

    if not module_name:
        print("Module name cannot be empty.")
        return

    # Check if files exist
    if not all(os.path.exists(file) for file in [ROUTE_PATH_FILE, APP_ROUTES_LIST_FILE, APP_INJECTOR_FILE]):
        print("One or more specified files do not exist. Please check your project structure.")
        return

    # Update each file
    update_route_path_file(module_name)
    update_app_routes_list_file(module_name)
    update_app_injector_file(module_name)

    print("All files updated successfully.")

if __name__ == "__main__":
    main()
