@echo off
REM Building all docker containers that are generally useful, meaning
REM the ones in the `build` folder and the `tools` folder
cd build
for %%f in (*.Dockerfile) do (
  echo "Building %%f"
  docker build --tag openspace-%%~nf --file %%f .
)
cd ..

cd tools
docker build --tag tool-openspace-clang_tidy --file clang_tidy.Dockerfile .
cd ..
