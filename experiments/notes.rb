Shoes.app do
  stack :margin => 20, :width => 250 do
    subtitle "Shoes Notebook"
    para "Add a note:"
    @add_line = edit_line

    button "Save" do
      @notes.append do
        para @add_line.text, " ",
          link("delete") { |x| p x }
      end
      @add_line.text = ""
    end
  end
  @notes = stack :margin => 20, :width => -250
end
