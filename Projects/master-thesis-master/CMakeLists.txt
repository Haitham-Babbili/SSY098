cmake_minimum_required(VERSION 2.8)
project( affine_2d )
set(CMAKE_CXX_FLAGS "-std=c++11")
find_package(Ceres REQUIRED)
find_package(OpenCV REQUIRED)
set(CMAKE_BUILD_TYPE "RELEASE")
include_directories(${CERES_INCLUDE_DIRS} ${OpenCV_INCLUDE_DIRS})
file(GLOB_RECURSE CURRENT_HEADERS  include/*.h include/*.hpp)
file(GLOB CURRENT_SOURCES  src/*.c src/*.cpp)
source_group("Include" FILES ${CURRENT_HEADERS}) 
source_group("Source" FILES ${CURRENT_SOURCES})
add_executable(affine_2d affine_2d.cpp)
# target_link_libraries(${CERES)
target_link_libraries( affine_2d ${CERES_LIBRARIES} ${OpenCV_LIBS} gflags)