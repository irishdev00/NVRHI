project "NVRHI"
    kind "StaticLib"
    language "C++"
    cppdialect "C++23"
    staticruntime "off"

    targetdir ("%{wks.location}/build/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/build/obj/" .. outputdir .. "/%{prj.name}")

    includedirs {
        "include",
        "src",
        "%{IncludeDir.VulkanSDK}"
    }
    
    externalincludedirs { "include" }

    files {
        "include/nvrhi/**.h",
        "include/nvrhi/**.hpp",
        "src/*.cpp",
        "src/*.h",
        "src/vulkan/**.cpp",
        "src/vulkan/**.h",
    }

    removefiles {
        "src/d3d11/**",
        "src/d3d12/**"
    }

    defines { 
        "NVRHI_WITH_VALIDATION=1",
        "NVRHI_WITH_VULKAN=1",
        "NVRHI_WITH_D3D11=0",
        "NVRHI_WITH_D3D12=0",
        "VK_USE_PLATFORM_WIN32_KHR",
        "VK_ENABLE_BETA_EXTENSIONS", 
    }

    filter "system:windows"
        systemversion "latest"
        links { "dxgi" }

    filter "system:linux"
        pic "On"
        links { "vulkan" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        symbols "On"
        optimize "On"

    filter "configurations:Dist"
        runtime "Release"
        symbols "Off"
        optimize "Full"
