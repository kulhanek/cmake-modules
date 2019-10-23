# -----------------------------------------------------------------------------
# setup project for use with IntelCDK including MKL
# -----------------------------------------------------------------------------

IF(LAPACK_CONFIGURED)
    RETURN()
ENDIF(LAPACK_CONFIGURED)

# is MKL enabled?
SET(MKL_HOME "$ENV{MKL_HOME}")
SET(MKL_MODE "$ENV{MKL_MODE}")

IF(MKL_HOME)
    SET(MKL_FOUND TRUE)
    SET(MKL_ILP64 FALSE)
    ADD_DEFINITIONS(-DHAVE_MKL)
    if(MKL_MODE STREQUAL "parallel")
        ADD_DEFINITIONS(-DHAVE_MKL_PARALLEL)
        SET(MKL_LIBS mkl_intel_lp64 mkl_intel_thread mkl_core iomp5 pthread)
        MESSAGE("-- MKL MODE: parallel")
    ELSEIF(MKL_MODE STREQUAL "parallel/ilp64")
        SET(MKL_ILP64 TRUE)
        ADD_DEFINITIONS(-DHAVE_MKL_PARALLEL)
        ADD_DEFINITIONS(-DHAVE_MKL_ILP64)
        SET(MKL_LIBS mkl_intel_ilp64 mkl_intel_thread mkl_core iomp5 pthread)
        MESSAGE("-- MKL MODE: parallel/ilp64")
    ELSEIF(MKL_MODE STREQUAL "single/ilp64")
        SET(MKL_ILP64 TRUE)
        ADD_DEFINITIONS(-DHAVE_MKL_ILP64)
        SET(MKL_LIBS mkl_intel_ilp64 mkl_sequential mkl_core pthread)
        MESSAGE("-- MKL MODE: single/ilp64")
    ELSE()
        SET(MKL_LIBS mkl_intel_lp64 mkl_sequential mkl_core pthread)
        MESSAGE("-- MKL MODE: single")
    ENDIF()
    MESSAGE("-- MKL HOME: ${MKL_HOME}")
    MESSAGE("-- MKL LIBS: ${MKL_LIBS}")
    SET(LAPACK_LIB_NAME ${MKL_LIBS})
    INCLUDE_DIRECTORIES(${MKL_HOME}/include)
    LINK_DIRECTORIES(${MKL_HOME}/lib/intel64)    
ELSE(MKL_HOME)
    # BLAS ======================
    SET(BLAS_ROOT ${DEVELOPMENT_ROOT}/thirdparty/blas/netlib)
    LINK_DIRECTORIES(${BLAS_ROOT}/lib)
    SET(BLAS_LIB_NAME fblasd)

    # LAPACK =====================
    SET(LAPACK_ROOT ${DEVELOPMENT_ROOT}/thirdparty/lapack/3.1.1)
    LINK_DIRECTORIES(${LAPACK_ROOT}/lib)
    SET(LAPACK_LIB_NAME flapackd)
    MESSAGE("-- MKL LIBS: fallback blas/netlib and lapack/3.1.1")
ENDIF(MKL_HOME)

# -----------------------------------------------------------------------------

SET(LAPACK_CONFIGURED TRUE)
