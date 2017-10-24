# -----------------------------------------------------------------------------
# setup compilers for building
# -----------------------------------------------------------------------------

IF(COMPILERS_CONFIGURED)
    RETURN()
ENDIF(COMPILERS_CONFIGURED)

# GNU Compilers are defaults 

# C options
SET(CMAKE_C_FLAGS_RELEASE "-O2 -m64")
SET(CMAKE_C_FLAGS_DEBUG "-g -m64 -Wall -Wundef -Wno-long-long")
# C++ options
SET(CMAKE_CXX_FLAGS_RELEASE "-O2 -m64")
SET(CMAKE_CXX_FLAGS_DEBUG "-O0 -m64 -g -Wall -Wundef -Wno-long-long")
# gfortran
SET(CMAKE_Fortran_FLAGS_RELEASE "-O3 -ffree-line-length-none")
SET(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g")

# IntelCDK
get_filename_component(FCOMP_NAME ${CMAKE_Fortran_COMPILER} NAME_WE)
IF(MPI_ENABLED)
    EXECUTE_PROCESS(COMMAND mpifort --showme:command OUTPUT_VARIABLE FCOMP_NAME OUTPUT_STRIP_TRAILING_WHITESPACE)
ENDIF(MPI_ENABLED)

# IntelCDK Fortran
IF(FCOMP_NAME STREQUAL ifort)
    SET(CMAKE_Fortran_FLAGS_RELEASE "-O3 -ip -msse3 -axAVX,CORE-AVX2")
    SET(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -traceback -check all -warn all")
ENDIF(FCOMP_NAME STREQUAL ifort)

MESSAGE("-- FC Comp:      ${FCOMP_NAME}")

SET(COMPILERS_CONFIGURED TRUE)
