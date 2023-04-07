
# Dir.glob('*.rb') do |file|
#   next if file == "ruby_tracker.rb"
#   puts "-------------------------"
#   puts "Methods in #{file}:"
#   puts
#   File.open(file, 'r') do |f|
#     class_name = ""
#     f.each_line do |line|
#       if line =~ /^ *class ([a-zA-Z0-9_?!=]+)(.*)$/
#         method_name = $1
#         class_name = method_name
#           # puts " #{method_name}:"
#           puts line
#           puts
#       elsif line =~ /^ *def self.([a-zA-Z0-9_?!=]+)(.*)$/
#         method_name = $1
#         class_name.split.length > 1? class_name = class_name[0] : class_name
#             puts "  #{class_name}::#{method_name}:"
#             puts line
#             puts
#       elsif line =~ /^ *def ([a-zA-Z0-9_?!=]+)(.*)$/
#           method_name = $1
#           class_name.split.length > 1? class_name = class_name[0] : class_name
#             puts "  #{method_name}:"
#             puts line
#             puts
#       end
#     end
#   end
# end

# Dir.glob('*.rb') do |file|
#   next if file == "ruby_tracker.rb"
#   puts "-------------------------"
#   puts "Methods in #{file}:"
#   printf("%-20s %-20s %s\n", "Class", "Method", "Definition")
#   puts "-"*60
#   File.open(file, 'r') do |f|
#     class_name = ""
#     f.each_line do |line|
#       if line =~ /^ *class ([a-zA-Z0-9_?!=]+)(.*)$/
#         method_name = $1
#         class_name = method_name
#         printf("%-20s %-20s %s", class_name, "", line)
#       elsif line =~ /^ *def self.([a-zA-Z0-9_?!=]+)(.*)$/
#         method_name = $1
#         class_name.split.length > 1? class_name = class_name[0] : class_name
#         printf("%-20s %-20s %s", class_name, method_name, line)
#       elsif line =~ /^ *def ([a-zA-Z0-9_?!=]+)(.*)$/
#         method_name = $1
#         class_name.split.length > 1? class_name = class_name[0] : class_name
#         printf("%-20s %-20s %s", class_name, method_name, line)
#       end
#     end
#   end
# end
# def table_lines
#   puts "| %-20s | %-20s | %-35s |" % ["Type", "Method", "Arguments"]
#   puts "|-#{"-"*20}-|-#{"-"*20}-|-#{"-"*35}-|"
# end

# Dir.glob('*.rb') do |file|
#   next if file == "ruby_tracker.rb"
#   puts
#   puts "\e[31m" + "-"*60 + "\e[0m"
#   puts "Methods in #{file}:"
#   puts
#   File.open(file, 'r') do |f|
#     classless = true
#     class_name = ""
#     f.each_line do |line|
#       if line =~ /^ *class ([a-zA-Z0-9_?!=]+)(.*)$/
#         classless = false
#         class_name = $1
#         puts "\e[1m#{line}\e[0m"
#         table_lines
#       elsif line =~ /^ *def self\.([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))?$/
#         if classless
#           table_lines
#           classless = false
#         end
#         method_name = $1
#         arguments = $2
#         puts "| %-20s | %-20s | %-35s |" % ["Class", method_name, arguments]
#       elsif line =~ /^ *def ([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))?$/
#         if classless
#           table_lines
#           classless = false
#         end
#         method_name = $1
#         arguments = $2
#         puts "| %-20s | %-20s | %-35s |" % ["Instance", method_name, arguments]
#       end
#     end
#   end
# end

# def table_lines
#   printf("%-20s %-20s %-20s\n", "Type", "Method", "Arguments")
#   puts "-"*60
# end



def table_lines(rows)
  # puts rows
  columns = ["Type", "Method", "Arguments"] ###throws error
  max = rows.flatten.max {|el| el.length}.length
  column_widths = [4,max,max]
  # puts max
  # Print header row
  puts  "| #{columns.map.with_index { |c, i| i==0 ? c.ljust(8) :  c.ljust(max) }.join(" | ")} |"

  # Print separator row, 
  puts "|-#{column_widths.map { |w| "-" * (w + 2) }.join("-|-")}-|"

  # Print data rows
  rows.each do |row|
    puts "| #{row.map.with_index { |c, i| i==0? c.to_s.ljust(8) : c.to_s.ljust(max) }.join(" | ")} |"
  end
end

Dir.glob('*.rb') do |file|
  next if file == "ruby_tracker.rb"
  puts "\n\e[31m" + "-"*60 + "\e[0m"
  puts "\nMethods in #{file}:"
  File.open(file, 'r') do |f|
    classless = true
    rows = []

    f.each_line do |line|
      unless line =~ /^\s*(def|class|module)/
        next
      end
      if line =~ /^ *class ([a-zA-Z0-9_?!=<>\s]+)(.*)$/
        classless = false
        class_name = $1
        puts "\n\e[1m#{line}\e[0m"
      elsif line =~ /^ *module ([a-zA-Z0-9_?!=<>\s]+)(.*)$/
        classless = false
        class_name = $1
        puts "\n\e[1m#{line}\e[0m"
      elsif line =~ /^ *def self\.([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))? *$/
        # if classless
        #   table_lines(rows)
        #   rows = []
        #   classless = false
        # end
        method_name = $1
        arguments = $2
        rows << ['Class', method_name, arguments]
      elsif line =~ /^ *def ([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))? *$/
        # if classless
        #   table_lines(rows)
        #   rows = []
        #   classless = false
        # end
        method_name = $1
        arguments = $2
        rows << ['Instance', method_name, arguments]
      end
    end
    table_lines(rows)
  end
end



def table_lines(rows)
  columns = ["Type", "Method", "Arguments"]
  column_widths = columns.map { |c| [c.length, rows.map { |r| r[columns.index(c)].to_s.length }.max].max }

  # Print header row
  puts "| #{columns.map.with_index { |c, i| c.ljust(column_widths[i]) }.join(" | ")} |"

  # Print separator row
  puts "|-#{column_widths.map { |w| "-" * (w + 2) }.join("-|-")}-|"

  # Print data rows
  rows.each do |row|
    puts "| #{row.map.with_index { |c, i| c.to_s.ljust(column_widths[i]) }.join(" | ")} |"
  end
end





