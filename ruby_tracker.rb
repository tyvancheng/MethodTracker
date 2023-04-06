
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
def table_lines
  puts "| %-20s | %-20s | %-35s |" % ["Type", "Method", "Arguments"]
  puts "|-#{"-"*20}-|-#{"-"*20}-|-#{"-"*35}-|"
end

Dir.glob('*.rb') do |file|
  next if file == "ruby_tracker.rb"
  puts
  puts "\e[31m" + "-"*60 + "\e[0m"
  puts "Methods in #{file}:"
  puts
  File.open(file, 'r') do |f|
    classless = true
    class_name = ""
    f.each_line do |line|
      if line =~ /^ *class ([a-zA-Z0-9_?!=]+)(.*)$/
        classless = false
        class_name = $1
        puts "\e[1m#{line}\e[0m"
        table_lines
      elsif line =~ /^ *def self\.([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))?$/
        if classless
          table_lines
          classless = false
        end
        method_name = $1
        arguments = $2
        puts "| %-20s | %-20s | %-35s |" % ["Class", method_name, arguments]
      elsif line =~ /^ *def ([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))?$/
        if classless
          table_lines
          classless = false
        end
        method_name = $1
        arguments = $2
        puts "| %-20s | %-20s | %-35s |" % ["Instance", method_name, arguments]
      end
    end
  end
end

# def table_lines
#   printf("%-20s %-20s %-20s\n", "Type", "Method", "Arguments")
#   puts "-"*60
# end