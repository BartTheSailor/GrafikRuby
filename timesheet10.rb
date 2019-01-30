class Duties #wersja działa ze znmienną @nazwisko
  attr_accessor :timesheet
  attr_reader :names

  def initialize
    timesheet = []
    names = []
    timesheet[0] = 'Kowalski'.upcase
    timesheet[1] = 'Malinowski'.upcase
    timesheet[2] = 'Nowak'.upcase

    i = 0
    while i <3 do
      names[i]= timesheet[i]
      i = i + 1
    end
    @names = names
    puts names
    $time = timesheet
  end

  def fill_dates(name)
       
  end
end

class Doctor
  attr_accessor :specialist
  attr_accessor :name
  attr_accessor :forename
  attr_accessor :preffered_days
  attr_accessor :possible_days
  attr_accessor :unwanted_days


  # def self.all
  #   @@all ||= []
  # end
  
  def self.create(name)
    d = Doctor.new
    d.name = name
    puts 'Imię?'
    d.forename = gets.chomp.to_s 
    @@all << d
  end
 
  def self.print_line
    print '+'
    18.times {print '-'}
    print '+'
    9.times { print '---+'} 
    22.times { print '----+'}
    puts
  end
  
  def self.possibilities_table #printing table with possible and unwanted days in current month for all doctors

    # dopisać weryfikację, czy dni possible i unwanted się nie pokrywają
    # dopisać oznaczenie dni świątecznych

    #dopisać podsumowanie ilości na dzień w possibilities_table
    
    print_line
    print '| Name             |'
    (1..9).each { |e| print " #{e} |"}
    (10..31).each { |e| print " #{e} |"}
    puts
    print_line
    i = 0
    while i < 3 
      print "| #{$all[i].name}"
      (17-$all[i].name.length).times {print ' '}
      print '|' 
      e = 1
      while e < 10  
        if  $all[i].possible_days.include?(e) then
        
          print " T |" 
        else 
          if $all[i].unwanted_days.include?(e) then 
            print " n |"
          else
            print "   |"
          end
        end
        e += 1
      end
      
      e = 10
      while e < 32
        if   $all[i].possible_days.include?(e) then

          print " T  |"
        else 
          print "    |"
        end
        e += 1
      end
      puts
      print_line
      i += 1
    end
  end

  def self.duties_chart 

    monthly_chart = Array.new(31) { |i| i = []}
    
    day = 1
    previous_day = []

    monthly_chart.each { |e| 
      # dopisać sprawdzanie, czy nie ma dwóch dyżurów pod rząd
      
      print "dzień miesiąca: #{day}   "

      $all.each { |i|
        if i.preffered_days.include?(day) && e.length < 2 && !previous_day.include?(i.name) then 
        # bo max 2 lekarzy na dyżurze i  lekarz nie może mieć dwóch dyżurów pod rząd, dlatego 
        # sprawdzana pomocnicza zmienna  previous_day 

          e  << i.name 
      
        end
      }
      

      $all.each { |i| # ta iteracja bierze dni dyżurów z possible_days 
        if e.length < 2 && i.possible_days.include?(day) && !e.include?(i.name) && !previous_day.include?(i.name)  then 
          e  << i.name 
        end
      }

      $all.each { |i| # ta iteracja bierze dni dyżurów z tych, które nie są wymienione w unwanted_days
        if e.length < 2 && !e.include?(i.name) && !previous_day.include?(i.name) && \
          !i.unwanted_days.include?(day)  then 
        # bo max 2 lekarzy na dyżurze i  lekarz nie może mieć dwóch dyżurów pod rząd, dlatego 
        # sprawdzana pomocnicza zmienna  previous_day 

          e  << i.name 
      
        end
      }
      previous_day = e    
      puts "#{e}"  
            
      day += 1
    }      
  end
end

no_of_Doctors = 3

$all = Array.new(no_of_Doctors) { |i|  i = Doctor.new} 

$all[0].name = 'House' 
$all[0].forename = 'Gregory'
$all[0].specialist = :true
$all[0].possible_days = [2, 4, 6, 8]
$all[0].unwanted_days = [3, 5, 7, 9]
$all[0].preffered_days = [1, 2, 3, 4, 5]

$all[1].name = 'Burska' 
$all[1].forename = 'Zofia'
$all[1].specialist = :true
$all[1].possible_days = [3, 5, 7, 9]
$all[1].unwanted_days = []
$all[1].preffered_days = [1, 2, 3, 4, 5]

$all[2].name = 'Stelmach' 
$all[2].forename = 'Karol'
$all[2].specialist = :false
$all[2].possible_days = [1]
$all[2].unwanted_days = []
$all[2].preffered_days = [1, 2, 3, 4, 5]

a = 0
while a < no_of_Doctors do
  puts "#{$all[a].name} #{$all[a].forename}"
  a += 1
end

dn = Doctor.possibilities_table

print 'Czy wydrukować propozycję grafiku t/n?'
odp = gets.chomp.to_s
puts ''
if odp == 't' || odp == 'T'  then 
  puts 'GRAFIK'
  ch = Doctor.duties_chart

else  
  puts 'koniec'
end
puts ''
