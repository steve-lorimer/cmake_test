function(install_risk_limits MODULE)
    install(
      FILE
        ${CMAKE_BINARY_DIR}/risk_limits/librisk_limits.so

      MODULE
        ${MODULE}

      DEST
        ${CMAKE_CURRENT_SOURCE_DIR}/librisk_limits.so

      DEPS
        risk_limits
    )
endfunction()
