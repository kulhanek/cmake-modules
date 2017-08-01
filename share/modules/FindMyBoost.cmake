# ==============================================================================
# Description: try to find boost library (headers only)
#
# Output:
#    Boost_FOUND
#    Boost_INCLUDE_DIR
#
#############################################################################

IF(IS_DIRECTORY "${DEVELOPMENT_ROOT}/thirdparty/boost/1.59.0/boost")
    SET(Boost_INCLUDE_DIR "${DEVELOPMENT_ROOT}/thirdparty/boost/1.59.0")
ELSE(IS_DIRECTORY "${DEVELOPMENT_ROOT}/thirdparty/boost/1.59.0/boost")
    FIND_PACKAGE(Boost REQUIRED)
ENDIF(IS_DIRECTORY "${DEVELOPMENT_ROOT}/thirdparty/boost/1.59.0/boost")


