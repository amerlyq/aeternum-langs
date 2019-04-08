if(NOT TARGET ${PROJECT_NAME})
  message(FATAL_ERROR "Variable 'PROJECT_NAME=${PROJECT_NAME}' must be an existing target")
endif()

get_target_property(_srcs ${PROJECT_NAME} SOURCES)
get_target_property(_incs ${PROJECT_NAME} INCLUDE_DIRECTORIES)
get_target_property(_libs ${PROJECT_NAME} LINK_LIBRARIES)

### Create new (virtual) objects library with "--coverage" enabled
## REF: how to use object libraries (i.e. reasoning why PRIVATE/PUBLIC/INTERFACE)
#   https://cmake.org/pipermail/cmake-developers/2015-February/024555.html
#   https://cmake.org/pipermail/cmake-developers/2015-February/024559.html
add_library(${PROJECT_NAME}_cov OBJECT ${_srcs})
target_include_directories(${PROJECT_NAME}_cov PUBLIC ${_incs})
target_compile_options(${PROJECT_NAME}_cov PRIVATE --coverage)
set_property(TARGET ${PROJECT_NAME}_cov APPEND PROPERTY LINK_LIBRARIES ${_libs})


if(NOT TARGET ${PROJECT_NAME}_test)
  message(FATAL_ERROR "Target '${PROJECT_NAME}_test' must exist")
endif()

### Link object lib with coverage to test object lib
target_sources(${PROJECT_NAME}_test INTERFACE $<TARGET_OBJECTS:${PROJECT_NAME}_cov>)
target_include_directories(${PROJECT_NAME}_test PUBLIC ${_incs})

# HACK:(cmake<=3.7):BAD:(does not support): target_link_libraries(<OBJ_LIB> PUBLIC <OBJ_LIB>)
set_property(TARGET ${PROJECT_NAME}_test APPEND PROPERTY LINK_LIBRARIES ${_libs})
set_property(TARGET ${PROJECT_NAME}_test APPEND_STRING PROPERTY LINK_FLAGS "--coverage")

### Finalize tests (augment rest of functionality)
include(project-tests-add)