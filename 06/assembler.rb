#! /usr/bin/env ruby

def args_valid?
  ARGV[0] && ARGV[0].include?(".asm") && ARGV.length == 1 
end

def is_readable?(path)
    File.readable?(path)
end

unless args_valid?
  abort("Usage: ./assembler.rb Prog.asm")
end

asm_filename = ARGV[0]

unless isreadable?(asm_filename)
  abort("#{asm_filename} not found or is unreadable.")
end

puts "The contents of #{asm_filename}"
asm_file = File.open(asm_filename)
puts asm_file.read