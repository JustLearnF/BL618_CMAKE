cmake_minimum_required(VERSION 3.24)
include(${CMAKE_CURRENT_LIST_DIR}/../../cmake/toolchain.cmake)

project(helloworld LANGUAGES C CXX)

aux_source_directory(${CMAKE_CURRENT_LIST_DIR} SRC)
aux_source_directory(${CMAKE_CURRENT_LIST_DIR}/source SRC)
include_directories(${CMAKE_CURRENT_LIST_DIR}/include)

include(${CM_ROOT}/executable.cmake)
