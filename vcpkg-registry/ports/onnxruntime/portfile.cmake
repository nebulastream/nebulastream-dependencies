if (VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(VCPKG_POLICY_DLLS_IN_STATIC_LIBRARY enabled) # onnxruntime_providers_shared is always built and is a dynamic library
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO microsoft/onnxruntime # Please update this port with onnxruntime-cpu togather
    REF  baeece44ba075009c6bfe95891a8c1b3d4571cb3 # v1.15.1
    SHA512 deecbaa09aeb2d03bf5a2c075531862482c44a6ba075dce94e87864659bab0b77a7a91dd9f4713d47efe260748deaf7cc55e16a4354f531c59704bed19a525e2
    HEAD_REF master
    PATCHES
    fix-deps2.patch
    #fix-deps3.patch
    fix-deps4.patch
    fix-deps5.patch
    fix-deps6.patch
    fbs-verify.patch
    #    fix-build-issues.patch # Remove this patch in the next update
    #   export-target-in-static-build.patch  # Remove this patch in the next update
        # flatbuffer-fix.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_SHARED)

if ("${VCPKG_HOST_TRIPLET}" STREQUAL "${VCPKG_TARGET_TRIPLET}")
    set(BUILD_HOST ON)
    set(CROSS_BUILD OFF)
else()
    set(BUILD_HOST OFF)
    set(CROSS_BUILD ON)
endif()
string(COMPARE EQUAL "${VCPKG_HOST_TRIPLET}" "${VCPKG_TARGET_TRIPLET}" BUILD_HOST)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        gpu onnxruntime_USE_CUDA
)

file(TO_CMAKE_PATH "$ENV{CUDA_PATH}/bin/nvcc${VCPKG_HOST_EXECUTABLE_SUFFIX}" NVCC_PATH)

#set(EXTRA_OPTIONS )
#if ("gpu" IN_LIST FEATURES)
#    list(APPEND EXTRA_OPTIONS
#        "-Donnxruntime_CUDA_HOME=$ENV{CUDA_PATH}"
#        "-Donnxruntime_CUDNN_HOME=$ENV{CUDA_PATH}"
#        "-DCMAKE_CUDA_COMPILER=${NVCC_PATH}"
#    )
#endif()

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON_DIR "${PYTHON3}" PATH)
vcpkg_add_to_path(PREPEND "${PYTHON_DIR}")

#        -Donnxruntime_BUILD_SHARED_LIB=${BUILD_SHARED}
#        -Donnxruntime_BUILD_FOR_NATIVE_MACHINE=${BUILD_HOST}
#        -Donnxruntime_CROSS_COMPILING=${CROSS_BUILD}
#        -DCMAKE_INSTALL_INCLUDEDIR=include
#        -Donnxruntime_RUN_ONNX_TESTS=OFF
#        -Donnxruntime_ENABLE_CUDA_PROFILING=OFF
#        -Donnxruntime_ENABLE_CUDA_LINE_NUMBER_INFO=OFF
#        -Donnxruntime_GENERATE_TEST_REPORTS=OFF
#        -Donnxruntime_ENABLE_STATIC_ANALYSIS=OFF
#        -Donnxruntime_ENABLE_PYTHON=OFF
#        -Donnxruntime_ENABLE_MEMLEAK_CHECKER=OFF
#        -Donnxruntime_USE_NNAPI_BUILTIN=OFF
#        -Donnxruntime_DEV_MODE=OFF
#        -Donnxruntime_BUILD_UNIT_TESTS=OFF
#        -Donnxruntime_BUILD_CSHARP=OFF
#        -Donnxruntime_BUILD_OBJC=OFF
#        -Donnxruntime_USE_PREINSTALLED_EIGEN=ON
#        -Donnxruntime_BUILD_BENCHMARKS=OFF
#        -Donnxruntime_USE_LLVM=OFF
#        -Donnxruntime_USE_AVX=OFF
#        -Donnxruntime_USE_AVX2=OFF
#        -Donnxruntime_USE_AVX512=OFF
#        -Donnxruntime_USE_OPENMP=OFF
#        -Donnxruntime_BUILD_APPLE_FRAMEWORK=OFF
#        -Donnxruntime_ENABLE_MICROSOFT_INTERNAL=OFF
#        -Donnxruntime_USE_TENSORRT=OFF
#        -Donnxruntime_ENABLE_LTO=ON
#        -Donnxruntime_DEBUG_NODE_INPUTS_OUTPUTS=OFF
#        -Donnxruntime_USE_ROCM=OFF # AMD GPU SUPPORT
#        -Donnxruntime_PREFER_SYSTEM_LIB=ON
#        -Donnxruntime_MINIMAL_BUILD=OFF
#        -Donnxruntime_EXTENDED_MINIMAL_BUILD=OFF
#        -Donnxruntime_MINIMAL_BUILD_CUSTOM_OPS=OFF
#        -Donnxruntime_DISABLE_EXTERNAL_INITIALIZERS=OFF
#        -Donnxruntime_USE_VALGRIND=OFF
#        -Donnxruntime_RUN_MODELTEST_IN_DEBUG_MODE=OFF
#        -Donnxruntime_FUZZ_TEST=OFF
#        -Donnxruntime_USE_NCCL=OFF
#        -Donnxruntime_USE_MPI=OFF
#        -Donnxruntime_ENABLE_BITCODE=OFF
#        -Donnxruntime_BUILD_OPSCHEMA_LIB=OFF
#        -Donnxruntime_USE_EXTENSIONS=OFF
#        ${FEATURE_OPTIONS}
#        ${EXTRA_OPTIONS}

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/cmake"
    OPTIONS
        "-DPython_EXECUTABLE=${PYTHON3}"
        -Donnxruntime_USE_PREINSTALLED_EIGEN=ON
        -Donnxruntime_ENABLE_LTO=ON
        -Donnxruntime_USE_EXTENSIONS=OFF
        -Donnxruntime_BUILD_UNIT_TESTS=OFF
        -Donnxruntime_RUN_ONNX_TESTS=OFF
        -Donnxruntime_GENERATE_TEST_REPORTS=OFF
        -Donnxruntime_USE_MIMALLOC=OFF
        -Donnxruntime_ENABLE_PYTHON=OFF
        -Donnxruntime_BUILD_CSHARP=OFF
        -Donnxruntime_BUILD_JAVA=OFF
        -Donnxruntime_BUILD_NODEJS=OFF
        -Donnxruntime_BUILD_OBJC=OFF
        -Donnxruntime_BUILD_SHARED_LIB=ON
        -Donnxruntime_BUILD_APPLE_FRAMEWORK=OFF
        -Donnxruntime_USE_DNNL=OFF
        -Donnxruntime_USE_NNAPI_BUILTIN=OFF
        -Donnxruntime_USE_RKNPU=OFF
        -Donnxruntime_USE_LLVM=OFF
        -Donnxruntime_ENABLE_MICROSOFT_INTERNAL=OFF
        -Donnxruntime_USE_VITISAI=OFF
        -Donnxruntime_USE_TENSORRT=OFF
        -Donnxruntime_USE_TENSORRT_BUILTIN_PARSER=ON
        -Donnxruntime_USE_TVM=OFF
        -Donnxruntime_TVM_CUDA_RUNTIME=OFF
        -Donnxruntime_TVM_USE_HASH=OFF
        -Donnxruntime_USE_MIGRAPHX=OFF
        -Donnxruntime_DISABLE_CONTRIB_OPS=OFF
        -Donnxruntime_DISABLE_ML_OPS=OFF
        -Donnxruntime_DISABLE_RTTI=OFF
        -Donnxruntime_DISABLE_EXCEPTIONS=OFF
        -Donnxruntime_MINIMAL_BUILD=OFF
        -Donnxruntime_EXTENDED_MINIMAL_BUILD=OFF
        -Donnxruntime_MINIMAL_BUILD_CUSTOM_OPS=OFF
        -Donnxruntime_REDUCED_OPS_BUILD=OFF
        -Donnxruntime_ENABLE_LANGUAGE_INTEROP_OPS=OFF
        -Donnxruntime_USE_DML=OFF
        -Donnxruntime_USE_WINML=OFF
        -Donnxruntime_BUILD_MS_EXPERIMENTAL_OPS=OFF
        -Donnxruntime_USE_TELEMETRY=OFF
        -Donnxruntime_ENABLE_LTO=OFF
        -Donnxruntime_USE_ACL=OFF
        -Donnxruntime_USE_ACL_1902=OFF
        -Donnxruntime_USE_ACL_1905=OFF
        -Donnxruntime_USE_ACL_1908=OFF
        -Donnxruntime_USE_ACL_2002=OFF
        -Donnxruntime_USE_ARMNN=OFF
        -Donnxruntime_ARMNN_RELU_USE_CPU=ON
        -Donnxruntime_ARMNN_BN_USE_CPU=ON
        -Donnxruntime_USE_JSEP=OFF
        -Donnxruntime_ENABLE_NVTX_PROFILE=OFF
        -Donnxruntime_ENABLE_TRAINING=OFF
        -Donnxruntime_ENABLE_TRAINING_OPS=OFF
        -Donnxruntime_ENABLE_TRAINING_APIS=OFF
        -Donnxruntime_ENABLE_CPU_FP16_OPS=OFF
        -Donnxruntime_USE_NCCL=OFF
        -Donnxruntime_BUILD_BENCHMARKS=OFF
        -Donnxruntime_USE_ROCM=OFF
        -DOnnxruntime_GCOV_COVERAGE=OFF
        -Donnxruntime_USE_MPI=OFF
        -Donnxruntime_ENABLE_MEMORY_PROFILE=OFF
        -Donnxruntime_ENABLE_CUDA_LINE_NUMBER_INFO=OFF
        -Donnxruntime_BUILD_WEBASSEMBLY_STATIC_LIB=OFF
        -Donnxruntime_ENABLE_WEBASSEMBLY_EXCEPTION_CATCHING=ON
        -Donnxruntime_ENABLE_WEBASSEMBLY_API_EXCEPTION_CATCHING=OFF
        -Donnxruntime_ENABLE_WEBASSEMBLY_EXCEPTION_THROWING=ON
        -Donnxruntime_WEBASSEMBLY_RUN_TESTS_IN_BROWSER=OFF
        -Donnxruntime_ENABLE_WEBASSEMBLY_THREADS=OFF
        -Donnxruntime_ENABLE_WEBASSEMBLY_DEBUG_INFO=OFF
        -Donnxruntime_ENABLE_WEBASSEMBLY_PROFILING=OFF
        -Donnxruntime_ENABLE_LAZY_TENSOR=OFF
        -Donnxruntime_ENABLE_EXTERNAL_CUSTOM_OP_SCHEMAS=OFF
        -Donnxruntime_ENABLE_CUDA_PROFILING=OFF
        -Donnxruntime_ENABLE_ROCM_PROFILING=OFF
        -Donnxruntime_USE_XNNPACK=OFF
        -Donnxruntime_USE_CANN=OFF
        -DFETCHCONTENT_QUIET=OFF
        -Donnxruntime_ENABLE_MEMLEAK_CHECKER=OFF
    MAYBE_UNUSED_VARIABLES
        Python_EXECUTABLE
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
