--[[
    premake5.lua
        windows: vs2019
        linuxL cmake
]]
require("cmake")
require("lua")

solution "ptest"
    location ("build_".._ACTION) -- subdir vs2015 (or gmake, ...)
    configurations { "Debug", "Release" }
    platforms { "Win32", "x64" }
    targetdir "bin/%{cfg.platform}/%{cfg.buildcfg}"
    objdir ("bin/inter/%{prj.name}")

project "network"
    basedir "network"
    location("network/build")
    targetdir "lib"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"

    files {"./%{prj.name}/src/**.h", "./%{prj.name}/src/**.cpp"}

    dependson {"protobuf", "curl"} -- used for cmake include and find_package...
    -- forceincludes { "stdafx.h" } -- Applies one or more "forced include" files to the project; these includes behave as it they had been injected into the first line of each source file in the project.

    configuration "Debug"
        defines { "DEBUG" }
        symbols "On"

    configuration "Release"
        defines { "NDEBUG" }
        optimize "On"

project "main"
    basedir "main"
    location("main/build")
    targetdir "bin/%{cfg.buildcfg}"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"

    includedirs { "network/include" }
    libdirs { "lib" }
    files { "./%{prj.name}/src/**.h", "./%{prj.name}/src/**.cpp" }
    removefiles { "**/Win32Specific/**" }

    links {
        "network"
    }

    configuration "Debug"
        defines { "DEBUG" }
        symbols "On"

    configuration "Release"
        defines { "NDEBUG" }
        optimize "On"
    --[[
        configuration "windows"
        links { "user32", "gdi32" }

        configuration "linux"
        links { "m", "png" }

        configuration "macosx"
        -- OS X frameworks need the extension to be handled properly
        links { "Cocoa.framework", "png" }
    ]]
