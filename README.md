first install dependence via vcpkg
```shell
vcpkg install boost:x64-windows #(windows)
vcpkg install boost
```

then prebuild and use vs .sln file to build your project

with cmake build you should use command
```shell
premake5 cmake
```
the compile order in the main CMakeLists.txt should be sorted as your dependency hierarchy.

```shell
# When done tweaking common stuff, configure the components (subprojects).
# NOTE: The order matters! The most independent ones should go first.
```
add_subdirectory(libA) # A is a static library 
add_subdirectory(libB) # B is a shared library (depends on B)

add_subdirectory(app1) # (depends on A and B)
