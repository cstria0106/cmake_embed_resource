cmake_minimum_required(VERSION 3.26)
project(example)

add_executable(example example.cpp)

include(../cmake/EmbedResource.cmake)
EmbedResource(
    EXAMPLE_RESOURCES_LIBRARIES    # libraries variable
    EXAMPLE_RESOURCES_INCLUDE_DIRS # include directories variable
    resources/example.h            # header file name
    EXAMPLE_RESOURCE_              # prefix
    resources                      # directory to embed
)

target_include_directories(example PRIVATE ${EXAMPLE_RESOURCES_INCLUDE_DIRS})
target_link_libraries(example ${EXAMPLE_RESOURCES_LIBRARIES})