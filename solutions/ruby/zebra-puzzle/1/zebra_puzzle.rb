module ZebraPuzzle
  # 1. There are five houses.

  COLORS = %i[red green ivory yellow blue]
  NATIONALITIES = %i[English Spanish Ukranian Japanese Norwegian]
  PETS = %i[dog snail fox horse zebra]
  BEVERAGES = %i[water coffee tea milk juice ]
  HOBBIES = %i[dancing painting reading football chess]

  catch(:done) do
    NATIONALITIES.permutation do |nationalities|
      # 10. The Norwegian lives in the first house.
      next unless nationalities.first == :Norwegian

      COLORS.permutation do |colors|
        # 2. The Englishman lives in the red house.
        next unless nationalities[colors.index(:red)] == :English
        # 6. The green house is immediately to the right of the ivory house.
        next unless colors[colors.index(:ivory) + 1] == :green
        # 15. The Norwegian lives next to the blue house.
        next unless (nationalities.index(:Norwegian) - colors.index(:blue)).abs == 1

        BEVERAGES.permutation do |beverages|
          # 9. The person in the middle house drinks milk.
          next unless beverages[2] == :milk
          # 4. The person in the green house drinks coffee.
          next unless beverages[colors.index(:green)] == :coffee
          # 5. The Ukrainian drinks tea.
          next unless beverages[nationalities.index(:Ukranian)] == :tea

          HOBBIES.permutation do |hobbies|
            # 8. The person in the yellow house is a painter.
            next unless hobbies[colors.index(:yellow)] == :painting
            # 13. The person who plays football drinks orange juice.
            next unless beverages[hobbies.index(:football)] == :juice
            # 14. The Japanese person plays chess.
            next unless hobbies[nationalities.index(:Japanese)] == :chess

            PETS.permutation do |pets|
              # 3. The Spaniard owns the dog.
              next unless pets[nationalities.index :Spanish] == :dog
              # 7. The snail owner likes to go dancing.
              next unless hobbies[pets.index :snail] == :dancing
              # 11. The person who enjoys reading lives in the house next to the person with the fox.
              next unless (hobbies.index(:reading) - pets.index(:fox)).abs == 1
              # 12. The painter's house is next to the house with the horse.
              next unless (hobbies.index(:painting) - pets.index(:horse)).abs == 1

              # success!
              HOUSES = [
                nationalities,
                colors,
                beverages,
                hobbies,
                pets
              ]

              throw :done
            end
          end
        end
      end
    end
  end

  def self.water_drinker
    HOUSES[0][HOUSES[2].index :water].to_s
  end

  def self.zebra_owner
    HOUSES[0][HOUSES[4].index :zebra].to_s
  end
end
