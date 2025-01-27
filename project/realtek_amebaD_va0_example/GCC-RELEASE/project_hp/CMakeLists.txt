cmake_minimum_required(VERSION 3.6)

project(flash_bin)

# root of realtek_amebapro2_v0_example
set (prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../..")
# root of SDK
set (sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../..")
set (ameba_matter_root $ENV{AMEBA_MATTER})
set (matter_output_path $ENV{MATTER_OUTPUT})
set (matter_example_path $ENV{MATTER_EXAMPLE_PATH})
set (matter_config_path $ENV{MATTER_CONFIG_PATH})

set (BUILD_TZ OFF)

message(STATUS "Build TZ ${BUILD_TZ}")

#add_subdirectory (bootloader)
if(BUILD_TZ)
	set(target flash_tz)
	set(fw application_tz/firmware_tz.bin)
	set(bttrace application_tz/APP.trace)
	set(app_dep application.s application.ns)
	add_subdirectory (application_tz)
else()
	set(target flash_ntz)
	set(fw application_ntz/firmware_ntz.bin)
#	set(bttrace application_ntz/APP.trace)
	set(app_dep asdk)
	add_subdirectory (asdk)
endif()

add_custom_target(
	flash

#	COMMAND cp ${prj_root}/GCC-RELEASE/keycfg.json keycfg.json
#	COMMAND cp ${prj_root}/GCC-RELEASE/partition.json partition.json
#	COMMAND cp ${prj_root}/GCC-RELEASE/amebapro2_partition.json amebapro2_partition.json
#	COMMAND ${prj_root}/GCC-RELEASE/elf2bin.exe keygen keycfg.json

#	COMMAND ${prj_root}/GCC-RELEASE/elf2bin.exe convert amebapro2_partition.json PARTITIONTABLE
	COMMAND cp bootloader/boot.bin .

	COMMAND cp ${fw} ./firmware.bin
	COMMAND ${prj_root}/GCC-RELEASE/elf2bin.exe combine ${target}.bin PTAB=partition.bin,BOOT=boot.bin,FW1=firmware.bin

#	COMMAND cp ${bttrace} ./APP.trace

	DEPENDS bootloader
	DEPENDS ${app_dep}
)
