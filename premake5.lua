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
        "src/**.cpp",
        "src/**.h",
    }

    defines { 
        "NVRHI_WITH_VALIDATION=1",
        "NVRHI_WITH_VULKAN=1",
        "NVRHI_WITH_D3D11=0",
        "NVRHI_WITH_D3D12=0"
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
