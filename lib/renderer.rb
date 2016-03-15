
class Renderer

  def title
    system'clear'
    title_art= ["  /$$$$$$",
" /$$__  $$",
"| $$  \\__/ /$$   /$$  /$$$$$$   /$$$$$$$ /$$$$$$$",
"| $$ /$$$$| $$  | $$ /$$__  $$ /$$_____//$$_____/",
"| $$|_  $$| $$  | $$| $$$$$$$$|  $$$$$$|  $$$$$$",
"| $$  \\ $$| $$  | $$| $$_____/ \\____  $$\\____  $$",
"|  $$$$$$/|  $$$$$$/|  $$$$$$$ /$$$$$$$//$$$$$$$/",
" \\______/  \\______/  \\_______/|_______/|_______/",
"",
"",
"",
" /$$      /$$                   /$$ /$$",
"| $$$    /$$$                  / $$/ $$",
"| $$$$  /$$$$ /$$   /$$       /$$$$$$$$$$",
"| $$ $$/$$ $$| $$  | $$      |   $$  $$_/",
"| $$  $$$| $$| $$  | $$       /$$$$$$$$$$",
"| $$\\  $ | $$| $$  | $$      |_  $$  $$_/",
"| $$ \\/  | $$|  $$$$$$$        | $$| $$",
"|__/     |__/ \\____  $$        |__/|__/",
"              /$$  | $$",
"             |  $$$$$$/",
"              \\______/",
"",
"              "]

    @width = `tput cols`
    @colors = [:red, :green, :yellow, :blue, :cyan, :magenta]
    if @width.to_i > 50
      title_art.each do |line|
        line = " " * ((@width.to_i-50)/2) + line
        puts Paint[line,@colors.sample]
      end
    else
      title_art.each do |line|
        puts Paint[line,@colors.sample]
      end
    end

    puts Paint["-",:cyan] * @width.to_i
  end


  def render_menu(menu)
    if @width.to_i > 30
      menu.each do |line|
        line = " " * ((@width.to_i-30)/2) + line
        puts Paint[line,:yellow]
      end
    else
      menu.each do |line|
        puts Paint[line,:yellow]
      end
    end

  end

  def print_str(str)
    puts Paint["-",:cyan] * @with.to_i
    puts Paint[str, :yellow]
  end

  def print_input(str)
    puts Paint["-",:cyan] * @with.to_i
    puts Paint[str, :magenta]
    print "> "
  end

  def render_guesses(array)
    print Paint["          Guesses  ", :yellow]
    array.each do |num|
      print Paint["|",:cyan]
      print Paint["  #{num}  ",:yellow]
    end
    puts Paint["|",:cyan]
    print Paint["-",:cyan]* @width.to_i
    puts
  end

  def render_guess_result(array)
    puts Paint[array[-4], :blue]
    puts Paint[array[-3], :blue]
    puts Paint[array[-2], :blue]
    puts Paint[array[-1], :red]
  end

end
