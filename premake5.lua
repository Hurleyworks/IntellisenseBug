
-- https://github.com/JohannesMP/Premake-for-Beginners

workspace "IntellisenseBug"
	architecture "x64"
	location ("builds")

if _ACTION == "vs2019" then
   location ("builds/VisualStudio2019")
end
if _ACTION == "vs2022" then
   location ("builds/VisualStudio2022")
end

	configurations 
	{ 
		"Debug", 
        "Release",
    }
	vectorextensions "AVX2"
	filter "configurations:Debug"    defines { "DEBUG" }  symbols  "On"
    filter "configurations:Release"  defines { "NDEBUG" } optimize "On"
    
	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"



project "Example"
     kind "ConsoleApp"
    language "C++"
	defines {  }
	flags { "MultiProcessorCompile", "NoMinimalRebuild" }
	
	if _ACTION == "vs2019" then
		cppdialect "C++17"
		location "builds/VisualStudio2019/projects"
	end
	if _ACTION == "vs2022" then
		cppdialect "C++20"
		location ("builds/VisualStudio2022/projects")
	end
	
	
	targetdir ("builds/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("builds/bin-int/" .. outputdir .. "/%{prj.name}")

	local SOURCE_DIR = "src/"
	local FRAMEWORK_ROOT = "framework/"
    local MINIMAL = FRAMEWORK_ROOT .. "minimal_core/";
    files
    { 
      SOURCE_DIR .. "**.h", 
      SOURCE_DIR .. "**.hpp", 
      SOURCE_DIR .. "**.c",
      SOURCE_DIR .. "**.cpp",
     
	  MINIMAL .. "**.h", 
	  MINIMAL .. "**.cpp",
    }
	

	includedirs
	{
		
	FRAMEWORK_ROOT
		
	}
	
	filter {} -- clear filter!
	filter { "files:framework/**/excludeFromBuild/**.cpp"}
	flags {"ExcludeFromBuild"}
	filter {} -- clear filter!
	
	
	filter "system:windows"
        staticruntime "On"
        systemversion "latest"
		characterset ("MBCS")
        disablewarnings { 
			"5030", "4244", "4267", "4667", "4018", "4101", "4305", "4316", "4146", "4996",
		} 
		buildoptions { "/Zm250", "/bigobj",}
		
		defines 
		{ 
			
			
		}
		
		 -- setting up visual studio filters (basically virtual folders).
		vpaths 
		{
		  ["Header Files/*"] = { 
			SOURCE_DIR .. "**.h", 
			SOURCE_DIR .. "**.hxx", 
			SOURCE_DIR .. "**.hpp",
		  },
		  ["Source Files/*"] = { 
			SOURCE_DIR .. "**.c", 
			SOURCE_DIR .. "**.cxx", 
			SOURCE_DIR .. "**.cpp",
		  },
		}
	
	filter "configurations:Debug"
        defines {"USE_DEBUG_EXCEPTIONS"}
    
	