
add_executable (TestClient "main.cpp")

set_target_properties(TestClient
 PROPERTIES
  CXX_STANDARD 17
  CXX_EXTENSIONS OFF
  CXX_STANDARD_REQUIRED ON
)

target_link_libraries(TestClient ACNAL)
