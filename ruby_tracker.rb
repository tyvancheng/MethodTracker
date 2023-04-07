
def table_lines(rows)

  columns = ["Type", "Method", "Arguments"] #Header
  max = rows.flatten.inject {|a,e| e.length > a.length ? a=e : a}.length
  max < 10 ? max = 10 : max = max #Defines max length per table
  column_widths = [8,max,max]
  # Print header row
  puts  "| #{columns.map.with_index { |c, i| i==0 ? c.center(8) :  c.center(max) }.join(" | ")} |"

  # Print separator row, 
  puts "|-#{column_widths.map { |w| "-" * (w) }.join("-|-")}-|"

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
        if !rows.empty?
          table_lines(rows) 
          rows = []
        end
        classless = false
        class_name = $1
        puts "\n\e[1m#{line}\e[0m"
      elsif line =~ /^ *module ([a-zA-Z0-9_?!=<>\s]+)(.*)$/
        if !rows.empty?
          table_lines(rows) 
          rows = []
        end
        classless = false
        class_name = $1
        puts "\n\e[1m#{line}\e[0m"
      elsif line =~ /^ *def self\.([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))? *$/
        method_name = $1
        arguments = $2
        rows << ['Class', method_name, arguments]
      elsif line =~ /^ *def ([a-zA-Z0-9_?!=\[\]]+)(.*)\s*(\((.*)\))? *$/
        method_name = $1
        arguments = $2
        rows << ['Instance', method_name, arguments]
      end
    end
    table_lines(rows) if !rows.empty?
  end
end




