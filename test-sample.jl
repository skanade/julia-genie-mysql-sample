using Test
using DataFrames

@test true

push!(LOAD_PATH,"$(pwd())/app/resources/persons/")

using PersonsController

# Given
# override PersonsController methods for test
function PersonsController.mysql_connect(db_config)
end

function PersonsController.query_people(conn)
  df = DataFrame( id = [1, 2],
                  first = ["David", "Michelle"],
                  last = ["Smith", "Williams"] )
  @info df
  return df
end

function PersonsController.html_display(my_people_list)
  @info my_people_list
  @info length(my_people_list)
  # Then
  @test 2 == length(my_people_list)  
end

# When
a = PersonsController.peoplelist("foo")

