class CLI

    attr_accessor :top, :bottom

    def run
        welcome
        puts "Enter the path to the csv file of your gradebook: "
        filename = gets.strip
        puts "Enter your section (West, East A, East B, etc.): "
        section = gets.strip
        get_students(filename, section)
        # students = SmarterCSV.process('./2021-07-02T1325_Grades-SENG-LIVE-062821-PHASE-1.csv')

        loop do
            menu
            go_again
        end
    end

    def welcome
        puts "Hi! I'll generate random groups of students for you!"
    end

    def menu
        puts "How many students per group?"
        group_size = gets.strip.to_i
        t, b = @top.clone, @bottom.clone
        generate_groups(t, group_size)
        generate_groups(b, group_size)
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
        selected = students.select{|s| s[:section] == section}
        sorted = selected.sort_by{|s| s[:unposted_final_score]}
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
              last, first = ["n/a", "n/a"]
            end
            row += "| #{first.chomp} #{last.chomp} "
          end
          row += "|"
          puts row
        end
    end
end