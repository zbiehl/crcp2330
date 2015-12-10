#! /usr/bin/env ruby

if (ARGV[0] && ARGV[0].include?(".asm") && ARGV.length == 1 &&
    File.exist?(ARGV[0]) && File.readable? (ARGV[0])
    asm_filename = ARGV[0]
    puts asm_filename

else
  abort("Usage: ./assembler.rb Prog.asm")
end