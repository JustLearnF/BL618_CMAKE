option(ENABLE_WIFI "enable wifi support" on)

function(set_env_byFile filename target_var)
  if(NOT EXISTS "${filename}")
    set(${target_var} "" PARENT_SCOPE)
    return()
  endif()
  
  file(STRINGS "${filename}" lines)
  set(result_list "")
  
  foreach(line IN LISTS lines)
    string(STRIP "${line}" clean_line)
    if(clean_line)
      separate_arguments(args UNIX_COMMAND "${clean_line}")
      list(APPEND result_list ${args})
    endif()
  endforeach()
  set(${target_var} "${result_list}" PARENT_SCOPE)
endfunction()

# 设置include directories
set_env_byFile("${SDK_ROOT}/scripts/includes.txt" bl_includes)
string(REPLACE "\${SDK_ROOT}" "${SDK_ROOT}" bl_includes_expanded "${bl_includes}")
include_directories(${bl_includes_expanded})

# 设置链接选项
set_env_byFile("${SDK_ROOT}/scripts/ldflags.txt" bl_ldflags)
add_link_options(-T${SDK_ROOT}/scripts/linker_script.ld ${bl_ldflags})

# 设置宏定义
set_env_byFile("${SDK_ROOT}/scripts/defines.txt" bl_defines)
add_compile_definitions(${bl_defines})

# 链接静态库
link_directories(${SDK_ROOT}/libs)
if(ENABLE_WIFI)
  link_libraries(-Wl,--start-group app lhal std utils mm mbedtls libc freertos lwip rf rfparam wifi6 bl6_os_adapter csi_xt900p32f_dsp dhcpd pka shell m -Wl,--end-group)
else()
  link_libraries(-Wl,--start-group app lhal std utils mm mbedtls libc freertos -Wl,--end-group)
endif()

add_executable(${PROJECT_NAME} ${SRC} )

# 设置编译选项
set_env_byFile("${SDK_ROOT}/scripts/cflags.txt" bl_cflags)
set_env_byFile("${SDK_ROOT}/scripts/cxxflags.txt" bl_cxxflags)
target_compile_options(${PROJECT_NAME} PRIVATE
  $<$<COMPILE_LANGUAGE:C>:${bl_cflags}>
  $<$<COMPILE_LANGUAGE:CXX>:${bl_cxxflags}>
)

add_custom_command(
  TARGET
    ${PROJECT_NAME}
  POST_BUILD
  COMMAND 
    ${COMPILER_SUFFIX}objcopy -O binary ${PROJECT_NAME} ${PROJECT_NAME}.bin
  COMMENT 
  "Generate binary file." 
)
