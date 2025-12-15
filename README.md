# cmake管理代码
使用cmake管理BL618代码，方便编译以及使用vscode开发，提升编译体验。
# 使用
1. 修改cmake/toolchain.cmake文件中的SDK_ROOT和编译器前缀
2. 在code文件夹中创建项目文件夹，在其中导入CMakeLists.txt并引用cmake/toolchain.cmake
3. 设置源文件、项目名称
4. 在CMakeLists.txt中引用executable.cmake
5. 执行cmake -S. -Bbuild && cmake --build build编译
6. build目录会生成可烧录文件