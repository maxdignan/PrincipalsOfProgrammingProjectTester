This is an automated test suite for the Tokenizer.

Move these files into your working directory for the project.

run: ruby test_suite.rb <language_name> <runnable_file_name>

Where <language_name> is "java" or "python3.5"
and   <runnable_file_name> is "Tokenizer" or "Tokenizer.py"


This requires ruby version >= 2

THIS TEST SUITE REQUIRES THAT YOU WRITE TO THE STANDARD OUT.

This test suite automatically runs all of the valid cases, writes the output to a file, then checks the output
file against the expectation (result) file provided.

This suite also runs your software against the invalid cases, but only checks that "Error" is in the output string.
You'll need to do your own checks to make sure each invalid cases makes sense - or you can extend this code!


This suite will tell you if all the tests pass, or if one fails, it will tell you which ones, along with a line mismatch.
