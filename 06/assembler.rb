require_relative 'code'
require_relative 'parser'
require_relative 'symbol_table'

class AssemblerException < Exception; end

class Assembler

  def initialize(asm_file, hack_file)
    unless (File.readable?(asm_file.path) && File.writable?(hack_file.path))
      raise AssemblerException.new('Could not read/write files.')
    end
    @asm_file = asm_file
    @hack_file = hack_file
    @parser = Parser.new(asm_file)
    @code = Code.new
    @symbol_table = SymbolTable.new
  end

  def assemble!
    assemble_command while @parser.has_more_commands?
  end

  def assemble_command
    if @parser.command_type == Parser::C_COMMAND
      assemble_c_command
    elsif @parser.command_type == Parser::A_COMMAND
      assemble_a_command
    elsif @parser.command_type == Parser::L_COMMAND
      # Do nothing
    end
    @parser.advance
  end

  def assemble_a_command
    @hack_file << "0#{@code.constant(@parser.symbol)}\n"
  end

  def assemble_c_command
    comp = @code.comp(@parser.comp)
    dest = @code.dest(@parser.dest)
    jump = @code.jump(@parser.jump)
    @hack_file << "111#{comp}#{dest}#{jump}\n"
  end

end

def args_valid?
  ARGV[0] && File.extname(ARGV[0]) == '.asm' && ARGV.size == 1
end

abort('Usage: ./assembler.rb Prog.asm') unless args_valid?

begin
  asm_filename = ARGV[0]
  asm_basename = File.basename(asm_filename, '.asm')
  asm_path = File.split(asm_filename)[0]
  hack_filename = "#{asm_path}/#{asm_basename}.mine.hack"
  File.open(asm_filename, 'r') do |asm_file|
    File.open(hack_filename, 'w') do |hack_file|
      assembler = Assembler.new(asm_file, hack_file)
      assembler.assemble!
    end
  end
rescue Exception => e
  print e.backtrace.join("\n")
  abort(e.message)
end