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
IF(FCOMP_NAME STREQUAL mpifort OR FCOMP_NAME STREQUAL mpif90)
    MESSAGE("-- FC Comp(MPI): ${FCOMP_NAME}")
    EXECUTE_PROCESS(COMMAND mpifort --showme:command OUTPUT_VARIABLE FCOMP_NAME OUTPUT_STRIP_TRAILING_WHITESPACE)
ENDIF(FCOMP_NAME STREQUAL mpifort OR FCOMP_NAME STREQUAL mpif90)

# IntelCDK Fortran
IF(FCOMP_NAME STREQUAL ifort)
    SET(CMAKE_Fortran_FLAGS_RELEASE "-O3 -ip -msse3 -axAVX,CORE-AVX2")
    SET(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -traceback -check all -warn all")
ENDIF(FCOMP_NAME STREQUAL ifort)

# HPCKit Fortran
IF(FCOMP_NAME STREQUAL ifx)
    SET(CMAKE_Fortran_FLAGS_RELEASE "-O3 -msse3 -axAVX,CORE-AVX2")
    SET(CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -traceback -check all -warn all")
ENDIF(FCOMP_NAME STREQUAL ifx)

# is MKL in 64bit mode?
IF(MKL_ILP64)
    INCLUDE(CheckFortranCompilerFlag)
    CHECK_FORTRAN_COMPILER_FLAG("-i8" FortranI8)
    IF(FortranI8)
        SET(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -i8")
    ELSE()
        MESSAGE(FATAL_ERROR "MKL_ILP64 but -i8 is not supported by fortran compiler!")
    ENDIF()
ENDIF()

MESSAGE("-- FC Comp:      ${FCOMP_NAME}")
MESSAGE("-- FC Flags (R): ${CMAKE_Fortran_FLAGS_RELEASE}")
MESSAGE("-- FC Flags (D): ${CMAKE_Fortran_FLAGS_DEBUG}")

SET(COMPILERS_CONFIGURED TRUE)
