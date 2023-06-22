function(EmbedResource LIBRARIES_VARIABLE INCLUDE_DIRS_VARIABLE INCLUDE_NAME SYMBOL_PREFIX DIRECTORY)
    set (PROJECT_NAME _resources_${DIRECTORY})
    string(REGEX REPLACE "\\.| |-|/" "_" PROJECT_NAME ${PROJECT_NAME})
    project(${PROJECT_NAME})

    # Create directory
    set (TARGET_DIRECTORY ${CMAKE_BINARY_DIR}/_resources)
    
    # Create source
    set (SOURCE_DIRECTORY ${TARGET_DIRECTORY}/src)
    set (SOURCE_FILE ${SOURCE_DIRECTORY}/resource.c)
    file(WRITE ${SOURCE_FILE} "")
    add_library(${PROJECT_NAME} STATIC ${SOURCE_FILE})
    set (${LIBRARIES_VARIABLE} ${PROJECT_NAME} PARENT_SCOPE)

    # Create header
    set (INCLUDE_DIRECTORY ${TARGET_DIRECTORY}/include)
    set (INCLUDE_FILE ${INCLUDE_DIRECTORY}/${INCLUDE_NAME})
    file(WRITE ${INCLUDE_FILE} "#pragma once\n#ifdef __cplusplus\nextern \"C\"\n{\n#endif\n")
    set (${INCLUDE_DIRS_VARIABLE} ${INCLUDE_DIRECTORY} PARENT_SCOPE)


    # Collect input files
    file(GLOB_RECURSE FILES ${DIRECTORY}/*)

    # Iterate through input files
    foreach(FILE_PATH ${FILES})
        # Replace filename spaces & extension separator for C compatibility
        string(REGEX MATCH "${DIRECTORY}/(.+)$" _ ${FILE_PATH})
        set(FILE_REL_PATH ${CMAKE_MATCH_1})

        string(REGEX REPLACE "/" "__" SYMBOL_NAME ${FILE_REL_PATH})
        string(REGEX REPLACE "\\.| |-" "_" SYMBOL_NAME ${SYMBOL_NAME})
        set(SYMBOL_NAME ${SYMBOL_PREFIX}${SYMBOL_NAME})

        # Read hex data from file
        file(READ ${FILE_PATH} FILE_DATA HEX)
        if("${FILE_DATA}" STREQUAL "")
            message(WARNING "${FILE_PATH} is empty, so it's not included in resource.")
            continue()
        endif()
        
        # Convert hex data for C compatibility
        string(REGEX REPLACE "([0-9a-f][0-9a-f])" "0x\\1," FILE_DATA ${FILE_DATA})

        file(SIZE ${FILE_PATH} FILE_SIZE)

        # Write header
        file(APPEND ${INCLUDE_FILE} "extern const unsigned char ${SYMBOL_NAME}[${FILE_SIZE}];\n")

        # Write source
        file(APPEND ${SOURCE_FILE}  "const unsigned char ${SYMBOL_NAME}[${FILE_SIZE}] = {${FILE_DATA}};\n")
    endforeach()
    file(APPEND ${INCLUDE_FILE} "#ifdef __cplusplus\n}\n#endif\n")
endfunction()