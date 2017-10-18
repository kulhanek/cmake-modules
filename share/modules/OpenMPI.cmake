# -----------------------------------------------------------------------------
# setup MPI via OpenMPI
# -----------------------------------------------------------------------------

IF(OPENMPI_CONFIGURED)
    RETURN()
ENDIF(OPENMPI_CONFIGURED)


GET_FILENAME_COMPONENT(FCOMP_NAME ${CMAKE_Fortran_COMPILER} NAME_WE)

IF(FCOMP_NAME STREQUAL mpifort OR FCOMP_NAME STREQUAL mpif90)
    EXECUTE_PROCESS(COMMAND mpifort --showme:version OUTPUT_VARIABLE MPI_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND mpifort --showme:command OUTPUT_VARIABLE MPI_FC OUTPUT_STRIP_TRAILING_WHITESPACE)

    SET(MPI_ENABLED TRUE)
    SET(MPI_HOME "$ENV{MPI_HOME}")
    MESSAGE("-- MPI status:  enabled")
    MESSAGE("-- MPI home:    ${MPI_HOME}")
    MESSAGE("-- MPI version: ${MPI_VERSION}")
    MESSAGE("-- MPI FC:      ${MPI_FC}") 
    
    ADD_DEFINITIONS(-DMPI)
    
    IF(MPI_ENABLED)
        SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH}:${MPI_HOME}/lib")
    ENDIF(MPI_ENABLED)
    
ENDIF(FCOMP_NAME STREQUAL mpifort OR FCOMP_NAME STREQUAL mpif90)

SET(OPENMPI_CONFIGURED TRUE CACHE INTERNAL "Is OpenMPI configured?" FORCE)