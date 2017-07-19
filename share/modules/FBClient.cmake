# ==============================================================================
# Description: try to find fbclient library
#
# Input: (optional)
#    FBClient_INCLUDE_PATH
#    FBClient_LIBRARY_PATH
#
# Output:
#    FBClient_FOUND
#    FBClient_INCLUDE_DIR
#    FBClient_LIBRARY_NAME
#    HAVE_FBClient
#
#############################################################################

FIND_PATH(FBClient_INCLUDE_DIR ibase.h
    $ENV{FBClient_INCLUDE_PATH}
    )

IF(NOT DEFINED FBClient_FOUND)
    IF(FBClient_INCLUDE_DIR)
        MESSAGE(STATUS "Looking for FBClient header file ibase.h ... found.")
    ELSE(FBClient_INCLUDE_DIR)
        MESSAGE(STATUS "Looking for FBClient header file ibase.h ... not found.")
    ENDIF(FBClient_INCLUDE_DIR)
ENDIF(NOT DEFINED FBClient_FOUND)

FIND_LIBRARY(FBClient_LIBRARY_NAME
    NAMES fbclient
    PATHS
    /lib64
    /lib
    /usr/lib64
    /usr/lib
    /usr/local/lib64
    /usr/local/lib
    $ENV{FBClient_LIBRARY_PATH}
    )

IF(NOT DEFINED FBClient_FOUND)
    IF(FBClient_LIBRARY_NAME)
        MESSAGE(STATUS "Looking for FBClient library file fbclient ... found.")
    ELSE(FBClient_LIBRARY_NAME)
        MESSAGE(STATUS "Looking for FBClient library file fbclient ... not found.")
        SET(FBClient_LIBRARY_NAME "")
    ENDIF(FBClient_LIBRARY_NAME)
ENDIF(NOT DEFINED FBClient_FOUND)

# ------------------------------------------------------------------------------

IF(FBClient_INCLUDE_DIR AND FBClient_LIBRARY_NAME)
    SET(FBClient_FOUND TRUE CACHE INTERNAL "FBClient library" FORCE)
    SET(HAVE_FBClient 1)
    ADD_DEFINITIONS(-DHAVE_FBClient)
ELSE(FBClient_INCLUDE_DIR AND FBClient_LIBRARY_NAME)
    SET(FBClient_FOUND FALSE CACHE INTERNAL "FBClient library" FORCE)
ENDIF(FBClient_INCLUDE_DIR AND FBClient_LIBRARY_NAME)

IF(FBClient_FIND_REQUIRED)
    IF(NOT FBClient_FOUND)
        MESSAGE(FATAL_ERROR ">>> ERROR: firebird-dev not installed!")
    ENDIF(NOT FBClient_FOUND)
ENDIF(FBClient_FIND_REQUIRED)
