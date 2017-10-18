# -----------------------------------------------------------------------------
# setup project for use with IntelCDK including MKL
# -----------------------------------------------------------------------------

IF(LAPACK_CONFIGURED)
    RETURN()
ENDIF(LAPACK_CONFIGURED)

# is MKL enabled?
SET(MKL_HOME "$ENV{MKL_HOME}")

IF(MKL_HOME)
    SET(MKL_FOUND TRUE)
    LINK_DIRECTORIES(${MKL_HOME})
    SET(MKL_LIBS mkl_intel_lp64 mkl_sequential mkl_core pthread)
    MESSAGE("-- MKL HOME: ${MKL_HOME}") 
    MESSAGE("-- MKL LIBS: ${MKL_LIBS}")
    SET(LAPACK_LIB_NAME ${MKL_LIBS})
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