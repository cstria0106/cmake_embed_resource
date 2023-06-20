# CMake EmbedResource
It's simple and (maybe) portable CMake function to embed binary data in executables. It embeds actual resource binary data in target binary exactly once (no duplicates).

## How to use?
Please refer to example/CMakeLists.txt and example/example.cpp.

```cmake
include(cmake/EmbedResource.cmake)

EmbedResource(
    EXAMPLE_RESOURCES_LIBRARIES    # libraries variable
    EXAMPLE_RESOURCES_INCLUDE_DIRS # include directories variable
    resources/example.h            # header file name
    EXAMPLE_RESOURCE_              # prefix
    example                        # directory to embed
)

target_include_directories(${PROJECT} PRIVATE ${TEST_RESOURCES_INCLUDE_DIRS})
target_link_libraries(${PROJECT} ${TEST_RESOURCES_LIBRARIES})
```
You can use use binary data in c/c++ code like this.
```cpp
#include <resources/example.h>

int main() {
    ...
    memcpy(buffer, EXAMPLE_RESOURCE_img_png, sizeof(EXAMPLE_RESOURCE_img_img)); // Copy contents of example/img.png into buffer
    ...
}
```

## Limitations
- CMake configure task gets significantly slow on large files. 
- No ability to reconfiguration on resources file change.

Someone please fix this!


## Code
Some piece of code from [here](https://stackoverflow.com/questions/11813271/embed-resources-eg-shader-code-images-into-executable-library-with-cmake).