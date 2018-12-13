# ==============================================================================
# Description: try to find readline library
#
# Input: (optional)
#    ReadLine_INCLUDE_PATH
#    ReadLine_LIBRARY_PATH
#
# Output:
#    ReadLine_FOUND
#    ReadLine_INCLUDE_DIRS
#    ReadLine_LIBRARY_NAME
#    HAVE_ReadLine
#
#############################################################################

FIND_PATH(ReadLine_INCLUDE_DIRS readline/readline.h
    /usr/include
    $ENV{ReadLine_INCLUDE_PATH}
    )

IF(NOT DEFINED ReadLine_FOUND)
    IF(ReadLine_INCLUDE_DIRS)
	MESSAGE(STATUS "Looking for ReadLine header file readline.h ... found: ${ReadLine_INCLUDE_DIRS}")
    ELSE(ReadLine_INCLUDE_DIRS)
	MESSAGE(STATUS "Looking for ReadLine header file readline.h ... not found.")
    ENDIF(ReadLine_INCLUDE_DIRS)
ENDIF(NOT DEFINED ReadLine_FOUND)

FIND_LIBRARY(ReadLine_LIBRARY_NAME
    NAMES readline
    PATHS
    /lib64
    /lib
    /usr/lib64
    /usr/lib
    /usr/local/lib64
    /usr/local/lib
    $ENV{ReadLine_LIBRARY_PATH}
    )

IF(NOT DEFINED ReadLine_FOUND)
    IF(ReadLine_LIBRARY_NAME)
    GET_FILENAME_COMPONENT(ReadLine_LIB_DIRS ${ReadLine_LIBRARY_NAME} DIRECTORY)
    MESSAGE(STATUS "Looking for ReadLine library file readline ... found: ${ReadLine_LIB_DIRS}")
    ELSE(ReadLine_LIBRARY_NAME)
	MESSAGE(STATUS "Looking for ReadLine library file readline ... not found.")
	SET(ReadLine_LIBRARY_NAME "")
    ENDIF(ReadLine_LIBRARY_NAME)
ENDIF(NOT DEFINED ReadLine_FOUND)

# ------------------------------------------------------------------------------

IF(ReadLine_INCLUDE_DIRS AND ReadLine_LIBRARY_NAME)
    SET(ReadLine_FOUND TRUE CACHE INTERNAL "ReadLine library" FORCE)
    SET(HAVE_ReadLine 1)
    ADD_DEFINITIONS(-DHAVE_ReadLine)
ELSE(ReadLine_INCLUDE_DIRS AND ReadLine_LIBRARY_NAME)
    SET(ReadLine_FOUND FALSE CACHE INTERNAL "ReadLine library" FORCE)
ENDIF(ReadLine_INCLUDE_DIRS AND ReadLine_LIBRARY_NAME)

IF(ReadLine_FIND_REQUIRED)
    IF(NOT ReadLine_FOUND)
        MESSAGE(FATAL_ERROR ">>> ERROR: libreadline-dev not installed!")
    ENDIF(NOT ReadLine_FOUND)
ENDIF(ReadLine_FIND_REQUIRED)
