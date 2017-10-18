# -----------------------------------------------------------------------------
# setup project for use with IntelCDK including MKL
# -----------------------------------------------------------------------------

IF(MKL_CONFIGURED)
    RETURN()
ENDIF(MKL_CONFIGURED)

# intel core libraries
SET(INTEL_CORE_HOME "$ENV{INTEL_CORE_HOME}")

IF(INTEL_CORE_HOME)
    MESSAGE("-- ICL HOME: ${INTEL_CORE_HOME}")
    SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH}:${INTEL_CORE_HOME}")
ENDIF(INTEL_CORE_HOME)

SET(MKL_CONFIGURED TRUE CACHE INTERNAL "Is MKL configured?" FORCE)