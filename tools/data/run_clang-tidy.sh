#!/bin/bash

# First run the normal build
./build.sh $@

cd OpenSpace
cp build/compile_commands.json .

# Filter the compile_commands to remove files we are not interested in
python3 ../filter_compile_commands.py

# And then run clang-tidy
run-clang-tidy-17 -checks=-*,bugprone-*,clang-analyzer-*,cppcoreguidelines-*,llvm-*,misc-*,modernize-*,performance-*,portability-*,readability-*,-bugprone-easily-swappable-parameters,-bugprone-implicit-widening-of-multiplication-result,-bugprone-narrowing-conversions,-bugprone-suspicious-include,-bugprone-switch-missing-default-case,-bugprone-unchecked-optional-access,-clang-analyzer-security.FloatLoopCounter,-cppcoreguidelines-avoid-do-while,-cppcoreguidelines-avoid-magic-numbers,-cppcoreguidelines-avoid-non-const-global-variables,-cppcoreguidelines-narrowing-conversions,-cppcoreguidelines-no-malloc,-cppcoreguidelines-owning-memory,-cppcoreguidelines-pro-bounds-array-to-pointer-decay,-cppcoreguidelines-pro-bounds-constant-array-index,-cppcoreguidelines-pro-bounds-pointer-arithmetic,-cppcoreguidelines-pro-type-member-init,-cppcoreguidelines-pro-type-reinterpret-cast,-cppcoreguidelines-pro-type-static-cast-downcast,-cppcoreguidelines-pro-type-union-access,-cppcoreguidelines-pro-type-vararg,-google-objc-*,-google-build-using-namespace,-google-default-arguments,-google-readability-casting,-google-readability-function-size,-google-readability-namespace-comments,-google-explicit-constructor,-llvm-else-after-return,-llvm-include-order,-llvm-qualified-auto,-misc-include-cleaner,-misc-no-recursion,-misc-non-private-member-variables-in-classes,-modernize-return-braced-init-list,-modernize-use-trailing-return-type,-modernize-use-auto,-performance-no-int-to-ptr,-readability-avoid-unconditional-preprocessor-if,-readability-else-after-return,-readability-function-cognitive-complexity,-readability-identifier-length,-readability-implicit-bool-conversion,-readability-magic-numbers,-readability-named-parameter,-readability-uppercase-literal-suffix,-readability-use-anyofallof


