class Dictionary < Shoes
  url '/',     :index
  url '/(\w+)', :word

  def index
    stack do
      title "Enter a word"
      @word = edit_line
      button "OK" do
        visit "/#{@word.text}"
      end
    end
  end

  def word(string)
    stack do
      para "No definition found for #{strong(string)} .",
            "Sorry, this does not really work."
    end
  end
end

Shoes.app 
