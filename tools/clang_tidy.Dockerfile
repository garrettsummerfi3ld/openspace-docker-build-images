FROM openspace-ubuntu-2204-clang17

RUN apt-get install -y clang-tidy-17
RUN apt-get install python3

COPY data/run_clang-tidy.sh /
COPY data/filter_compile_commands.py /
