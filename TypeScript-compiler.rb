arg = ARGV[0]
if arg == "info"
  puts "TypeScript-compiler v1.0, using for compile Ruby into ts"
  exit
end

ruby_file = ARGV[0]
ts_file = ARGV[1]

unless ruby_file && ts_file
  puts "Usage: ruby TypeScript-compiler.rb input.rb output.ts"
  exit
end

unless File.exist?(ruby_file)
  puts "Error: file #{ruby_file} not found"
  exit
end

ruby_code = File.read(ruby_file)
ts_code = ""
indent = 0

ruby_code.each_line do |line|
  line.strip!
  next if line.empty?

  if line =~ /^class (\w+)/
    ts_code += "class #{$1} {\n"
    indent += 2

  elsif line =~ /^module (\w+)/
    ts_code += "namespace #{$1} {\n"
    indent += 2

  elsif line =~ /^def (\w+)\((.*)\)/
    func_name = $1
    params = $2.split(",").map(&:strip).reject(&:empty?).map { |p| "#{p}: any" }.join(", ")
    ts_code += " " * indent + "function #{func_name}(#{params}): any {\n"
    indent += 2

  elsif line == "end"
    indent -= 2
    ts_code += " " * indent + "}\n"

  elsif line.start_with?("puts ")
    content = line.sub("puts ", "")
    ts_code += " " * indent + "console.log(#{content});\n"

  elsif line =~ /^if (.+)/
    ts_code += " " * indent + "if (#{$1}) {\n"
    indent += 2

  elsif line =~ /^elsif (.+)/
    indent -= 2
    ts_code += " " * indent + "} else if (#{$1}) {\n"
    indent += 2

  elsif line == "else"
    indent -= 2
    ts_code += " " * indent + "} else {\n"
    indent += 2

  elsif line =~ /^while (.+)/
    ts_code += " " * indent + "while (#{$1}) {\n"
    indent += 2

  elsif line =~ /^for (.+) in (.+)/
    ts_code += " " * indent + "for (let #{$1} of #{$2}) {\n"
    indent += 2

  elsif line =~ /^(\w+)\s*=\s*(.+)/
    var, value = $1, $2
    type = case value
           when /^["'].*["']$/ then "string"
           when /^\d+$/ then "number"
           when /^(true|false)$/ then "boolean"
           when /^\[.*\]$/ then "any[]"
           when /^\{.*\}$/ then "object"
           else "any"
           end
    ts_code += " " * indent + "let #{var}: #{type} = #{value};\n"

  else
    ts_code += " " * indent + "#{line}\n"
  end
end

File.write(ts_file, ts_code)
puts "TypeScript file generated: #{ts_file}"
