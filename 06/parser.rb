class AssemblerParserException < Exception; end

class Parser

  A_COMMAND = 0
  C_COMMAND = 1
  L_COMMAND = 2


  def initialize(asm_file)
    @asm_file = asm_file
    @instructions = asm_file.readlines
    @instructions.each { |i| i.gsub! /\/\/.*/, ''; i.strip!}.delete('')
    @index = 0
    @command = @instructions[@index]
  end

  def has_more_commands?
    @instructions[@index]
  end

  def advance
    raise AssemblerParserException.new('No more commands') unless has_more_commands?
    @index += 1
    @command = @instructions[@index]
  end

  def command_type
    return A_COMMAND if @command[0,1] == '@'
    return L_COMMAND if @command[0,1] == '('
    return C_COMMAND
  end

  def symbol
    @command[/@(.*)/, 1]
  end

  def dest
    @command[/(.*)\=/, 1]
  end

  def comp
    if @command.include?('=') && @command.include?(';')
      return @command[/\=(.*);/, 1]
    elsif @command.include?(';')
      return @command[/(.*);/, 1]
    else
      return @command[/\=(.*)/, 1]
    end
  end

  def jump
    @command[/;(.*)/, 1]
  end

end