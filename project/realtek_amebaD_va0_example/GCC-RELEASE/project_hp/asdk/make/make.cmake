cmake_minimum_required(VERSION 3.6)

project(make)

set(make_dir ${CMAKE_CURRENT_SOURCE_DIR}/make)

if(${CONFIG_BT_EN})
    #include(${make_dir}/rtl_bluetooth)    # no common/bluetooth folder
endif()

if(${CONFIG_WIFI_EN})
    include(${make_dir}/api/api.cmake)
    include(${make_dir}/network/network.cmake)
    include(${make_dir}/wlan/wlan.cmake)
endif()

    include(${make_dir}/utilities/utilities.cmake)
    #include(${make_dir}/test)
    include(${make_dir}/os/os.cmake)

if(${CONFIG_MBED_TLS_ENABLED})
    include(${make_dir}/mbedtls/mbedtls.cmake)
endif()

if(${CONFIG_GUI_EN})
    #include(${make_dir}/ui)
endif()

if(${CONFIG_LINKKIT_AWSS})
    #include(${make_dir}/linkkit)
endif()

    include(${make_dir}/app/app.cmake)
    include(${make_dir}/target/target.cmake)
    include(${make_dir}/drivers/drivers.cmake)
    #include(${make_dir}/cmsis)    # no cmsis/source folder
    include(${make_dir}/mbed/mbed.cmake)
    include(${make_dir}/utilities_example/utilities_example.cmake)
    include(${make_dir}/file_system/file_system.cmake)
    include(${make_dir}/project/project.cmake)
    include(${make_dir}/application/application.cmake)
    #include(${make_dir}/chip)
