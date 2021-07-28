cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "virtual_controller")
project(${PROJECT_NAME} LANGUAGES C CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "virtual_controller_plugin")
set(MY_LIB "virtual_controller")

add_library(${MY_LIB} SHARED "src/${MY_LIB}.c" "src/${MY_LIB}.def")
set_target_properties(${MY_LIB} PROPERTIES
  PREFIX "lib_"
  PUBLIC_HEADER "src/${MY_LIB}.h")

add_library(${PLUGIN_NAME} SHARED
  "virtual_controller_plugin.cc")
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  PREFIX "lib_"
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)

# List of absolute paths to libraries that should be bundled with the plugin
set(virtual_controller_bundled_libraries
  "$<TARGET_FILE:${MY_LIB}>"
  PARENT_SCOPE
)
