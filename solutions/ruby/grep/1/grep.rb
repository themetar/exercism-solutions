module Grep
  def self.grep(pattern, flags, files)
    output = ''

    # Flags
    emit_line_number_flag = flags.include?('-n')
    case_insensitive_flag = flags.include?('-i')
    file_name_mode_flag   = flags.include?('-l')
    whole_line_flag       = flags.include?('-x')
    inverted_flag         = flags.include?('-v')

    pattern.downcase! if case_insensitive_flag

    files.each do |file_name|
      file = File.new(file_name)

      file.each_line.with_index do |line, line_num|
        test_line = case_insensitive_flag ? line.downcase : line
        test_line = test_line.chomp

        matches = whole_line_flag && test_line == pattern || !whole_line_flag && test_line[pattern]

        matches = inverted_flag ^ matches  # 0 xor A = A , 1 xor A = !A

        if matches
          if file_name_mode_flag
            output << file_name << "\n"
            break # no need to match any more lines; essentially proceed with next file
          else
            output << file_name << ':' if files.length > 1
            output << (line_num + 1).to_s << ':' if emit_line_number_flag
            output << line
          end
        end
      end

      file.close
    end

    output.chomp
  end
end
