class TestSuite
  def test(language_name, runnable_file)
    available_tests_for_each_project = [
      self.get_all_testable_cases_without_file_type_extension_for_project(1)
    ]

    tests_pass = true

    available_tests_for_each_project.each_with_index do |project_tests, index|
      project_tests.each do |test_file_name|
        system("#{language_name} #{runnable_file} test_suite/test-pa#{index + 1}/#{test_file_name}.core > test_output.file")

        file_same = self.compare_file("test_output.file", "test_suite/test-pa#{index + 1}/results/#{test_file_name}.txt")

        tests_pass = tests_pass && file_same

        puts file_same, test_file_name
      end
    end


    invalid_tests_for_each_project = [
      self.get_all_invalid_tests_without_file_type_extensions_for_project(1)
    ]

    invalid_tests_for_each_project.each_with_index do |project_tests, index|
      project_tests.each do |test_file_name|
        error_TEST_OUTPUT_FILE = "error_test_output.file"

        system("#{language_name} #{runnable_file} test_suite/test-pa#{index + 1}/#{test_file_name}.core > #{error_TEST_OUTPUT_FILE}")

        file = File.read(error_TEST_OUTPUT_FILE)

        file_includes_error_word = file.include?("Error")

        tests_pass = tests_pass && file_includes_error_word

        puts file_includes_error_word, test_file_name
      end

    end

    if tests_pass
      puts ""
      puts "TESTS PASSED!"
    else
      puts ""
      puts "One of more tests failed!"
    end

    tests_pass
  end

  def get_all_testable_cases_without_file_type_extension_for_project(project_number)
    available_expectation_files = Dir["test_suite/test-pa#{project_number}/results/*.txt"]

    available_expectation_files.map { |file| file.split('/').last.gsub(".txt", '') }
  end

  def get_all_invalid_tests_without_file_type_extensions_for_project(project_number)
    available_invalids = Dir["test_suite/test-pa#{project_number}/invalid*.core"]

    available_invalids.map { |file| file.split("/").last.gsub(".core", "") }
  end

  def compare_file(file1, file2)
    lines1 = File.readlines(file1).each
    lines2 = File.readlines(file2).each

    begin
      i = 0
      while true
        i +=1
        line1 = lines1.next
        line2 = lines2.next

        if line1 != line2
          puts "Line #{i} broken: #{line1} vs #{line2}"
          return false
        end
      end
    rescue StopIteration
    end

    true
  end
end


language_name = ARGV[0]
puts language_name
runnable_file = ARGV[1]
puts runnable_file
puts TestSuite.new.test(language_name, runnable_file)

# puts TestSuite.new.get_all_invalid_tests_without_file_type_extensions_for_project(1)
