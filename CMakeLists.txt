cmake_minimum_required(VERSION 3.10)
project(SovereignShield VERSION 1.0)

# Standard C++17 pour la modernité et la performance
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 1. Gestion des dépendances
# Nous utilisons FetchContent pour télécharger automatiquement la bibliothèque JSON
include(FetchContent)
FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG v3.11.2
)
FetchContent_MakeAvailable(json)

# 2. Configuration des dossiers
include_directories(src/include)

# 3. Définition de l'exécutable
# On compile le main et les modules de logique
add_executable(SovereignShield 
    src/main.cpp 
    src/modules/Orchestrator.cpp
)

# 4. Liaison avec la bibliothèque JSON
target_link_libraries(SovereignShield PRIVATE nlohmann_json::nlohmann_json)

# 5. Installation / Packaging (Optionnel)
# Permet de copier l'exécutable dans un dossier bin propre
set_target_properties(SovereignShield PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)