class CLI

    attr_accessor :top, :bottom, :all

    def run
        welcome
        puts "Enter the path to the csv file of your gradebook: "
        # if you've placed the csv in the same dir as this tool, you can just copy the relative path
        filename = gets.strip
        # adds ./ to the beginning of the filname assuming you've place the file in the same dir as this tool
        filename = './' + filename if filename[0..1] != './'
        puts "Enter your section (West, East A, East B, etc.): "
        section = gets.strip
        get_students(filename, section)

        loop do
            menu
            go_again
        end
    end

    def welcome
        puts "\n/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/: \n \n"
        puts "Hi! I'll generate random groups of students for you!"
        puts "You'll need to export your gradebook from Canvas as a CSV file"
        puts "and save it in the same directory as this tool."
        puts "(You might also need to use a CSV editor to normalize your data.)"
        puts "\n/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/:/: \n \n"
    end

    def menu
        puts "How many students per group?"
        group_size = gets.strip.to_i
        puts "Should groups be SORTED by percentage of labs completed? Y/(n)"
        sorted = gets.strip
        if sorted == "Y"
            t, b = @top.clone, @bottom.clone
            generate_groups(t, group_size)
            generate_groups(b, group_size)
        else
            all = @all.clone
            generate_groups(all, group_size)
        end
    end

    def go_again
        puts "Would you like to generate new groups? Y/(n)"
        response = gets.strip
        unless response == "Y"
            exit
        end
    end

    def get_students(filename, section)
        students = SmarterCSV.process(filename)
        @all = students.select{|s| s[:section] == section}
        sorted = @all.sort_by{|s| s[:current_score]}
        @top, @bottom = sorted.each_slice( (sorted.size/2.0).round ).to_a
    end

    def generate_groups(students, num)
        while students.size > 0
          row = ""
          num.times do
            student = students.delete_at(rand(students.size))
            if student
              last, first = student.values_at(:student)[0].split(",")
            else
              last, first = ["", "n/a"]
            end
            row += "| #{first.chomp} #{last.chomp} "
          end
          row += "|"
          puts row
        end
    end
end