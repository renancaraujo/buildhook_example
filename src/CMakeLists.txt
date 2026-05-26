cmake_minimum_required(VERSION 3.15)
project(buildhook_example VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_library(buildhook_example SHARED buildhook_example.cpp)
target_include_directories(buildhook_example PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

install(TARGETS buildhook_example DESTINATION lib)
