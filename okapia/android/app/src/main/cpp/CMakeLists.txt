cmake_minimum_required(VERSION 3.4.1)

add_library(
        dummy-lib
        SHARED
        dummy-lib.cpp)


find_library(
        log-lib
        log)

target_link_libraries(
        dummy-lib
        ${log-lib})