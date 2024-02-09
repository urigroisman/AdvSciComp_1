# In this file, you'll fill in some blanks, and the associated `@test` lines 
# thereafter will check whether you've done it correctly. 
# We'll cover testing systematically later in the course.
# For now, know that:
#    - `@test` checks whether the following expression is `true`
#    - `@testset` wraps a collection of tests and gathers statistics. 
#      Here, I'm using it just so you can run all the tests even if you have some
#      that fail. (Without `@testset`, execution stops at the firstfailing test)

# Example: if you see

#      # Set `a` to be an array with two items, `1` and `7`
#      a =
#      @test length(a) == 2 && a[1] == 1 && a[2] == 7

# notice the blank after `a =`: you would edit this to

#      # Set `a` to be an array with two items, `1` and `7`
#      a = [1, 7]
#      @test length(a) == 2 && a[1] == 1 && a[2] == 7

# Ideally, running the test file passes all tests.

#  Also, it may be helpful to note you can comment out a block of code using matching `#=`, `=#`, but
#  in VS Code it's often just as easy to select the whole range and use Ctrl-/ (⌘/ on Mac) to toggle between
#  commented and uncommented. A good working strategy is to start by commenting out all the tests and then
#  uncomment them one-by-one as you address them. That way, you can run the test script for each new test
#  and check whether all work so far.


using Test

# Try the "gimmee" now!

# Set `a` to be an array with two items, `1` and `7`
a = (1, 7)
typeof(a)
@test length(a) == 2 && a[1] == 1 && a[2] == 7

# OK, now let's get serious!

#@testset "Learning Julia 1" begin
    # Create a range of all integers from 2 to 5, inclusive
    r = 2:5
    typeof(r)
    @test isa(r, AbstractUnitRange) && first(r) == 2 && last(r) == 5

    # Create an array that stores `Float64`s but otherwise holds the same values as `r` above
    r = collect(r)
    rfloat = convert(Array{Float64}, r);
    eltype(rfloat)
    @test eltype(rfloat) == Float64 && rfloat == r

    # Create a matrix equal to a 2x2 identity matrix (1 on the diagonal, zero on the corners)
    M = [1 0; 0 1]
    @test size(M) == (2,2) && M[1,1] == M[2,2] == 1 && M[1,2] == M[2,1] == 0

    # Create a vector of `String`s that has 3 undefined elements, then make the middle one equal to "Julia"
    vstr = Array{String}(undef, 3)
    vstr[2] = "Julia"
    vstr
    # you will need one more line here
    @test length(vstr) == 3 && eltype(vstr) == String && !isassigned(vstr, 1) && !isassigned(vstr, 3) && vstr[2] == "Julia"

    # Create two ranges, `row` and `col`: row should go from 1 to 3 (integers) and `col` should contain the even numbers between 2 and 8.
    # Use broadcasting to form a matrix of their product.
    row = 1:3
    col = 2:2:8
    row = collect(row) # opción 1 sin broadcasting, naive coding
    table
    m = row .* col' # usando broadcasting
    @test isa(row, AbstractUnitRange) && isa(col, AbstractRange) && first(row) == 1 && last(row) == 3 &&
          first(col) == 2 && last(col) == 8 && step(col) == 2
    @test m ==
    [ 2   4   6   8;
      4   8  12  16;
      6  12  18  24
    ]

    # Create a tuple with a `String`, an `Int`, and a `Float64` (of your choice) in that order
    
    # Creating a tuple with explicit types
    my_explicit_tuple = Tuple{String, Int, Float64} # definiendo tipos, sin datos
    
    t1 = Tuple{String, Int, Float64}(["string", 123, 4.0])
    # my_explicit_tuple is also of type Tuple{String,Int,Float64}

    t = ("hola", 1, 1.0)  # Alcanza con esta definición  Julia encuentra los tipos sola.

    @test isa(t, Tuple) && isa(t[1], String) && isa(t[2], Int) && isa(t[3], Float64)

    # Create a NamedTuple with fields `make` and `model` with values "Honda" and "Odyssey", respectively
    nt = (
        make = "Honda",
        model = "Odyssey"
    )
    @test nt.make == "Honda"
    @test nt.model == "Odyssey"
    @test isa(nt, NamedTuple)

    # Split this string into words
    str = "Advanced scientific computing"
    sstr = split(str)
    @test length(sstr) == 3 && sstr[1] == "Advanced" && sstr[2] == "scientific" && sstr[3] == "computing"

    # Now things will start getting a bit (just a bit) harder
    # If it's useful to write a `for` loop, feel free to look ahead to https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow#For_loops_and_iteration
    # Some problems can be solved in a single line using a comprehension or generator, https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow#Comprehensions

    # Alphabetize the words in this string, omitting any that contain a 'u'
    # Do not type the answer directly, generate it by exploiting Julia's string-manipulation functions
    animals = "dog cat opossum feline antelope chimp octopus salamander"
    aanimals = sort(animals) # feel free to use multiple lines to solve this; `aanimals` should hold your final answer
    # Otro camino usando for, if, etc
    animals_1 = split(animals) 
    
    function sort_strings_bubble(strings_array::Array{String})
        n = length(strings_array)
        for i in 1:n
            for j in 1:n-i
                if strings_array[j] > strings_array[j+1]
                    strings_array[j], strings_array[j+1] = strings_array[j+1], strings_array[j]
                end
            end
        end
        return strings_array
    end

# Usage:
aanimals = sort_strings_bubble(animals_1)
println(sorted_strings) # Output will be a sorted array of strings






    @test aanimals == ["antelope", "cat", "chimp", "dog", "feline", "salamander"]

    # Compute the sum of the ascii codes in `animals`, excluding spaces
    sascii =
    @test sascii == 5257

    # What is the most common letter, excluding spaces, in `animals` above?
    d =     # this variable should be a dictionary
    mostcommon =    # compute this from `d`
    @test keytype(d) == Char && valtype(d) == Int
    @test d['l'] == 3
    @test mostcommon == 'o'

    # Determine all the unique characters in `animals` using a Set (including the space ' ' this time)
    chars =
    @test isa(chars, Set) && eltype(chars) == Char && length(chars) == 18 && 't' ∈ chars && 'z' ∉ chars
end