

def factorial(n)
    if n <= 1
        return 1
    else
        return n * factorial(n-1)
    end
end

def n_lg_n_roots(constant, max_value)

    # find roots of n*lg(n) = c using bisection
    # as suggested here: https://stackoverflow.com/a/3847435/

    lower = 2
    upper = max_value

    until lower >= upper do
        lower = lower.ceil
        upper = upper.floor
        midpoint = (lower + upper) / 2.0
        if (midpoint * Math.log2(midpoint)) > constant
            upper = midpoint
        else
            lower = midpoint
        end
    end

    return (lower + upper) / 2.0
end


# time intervals available for solving the problem, in seconds
intervals = [
    {
        :seconds => 1,
        :display => "1 second"
    },
    {
        :seconds => 60,
        :display => "1 minute"
    },
    {
        :seconds => 3600,
        :display => "1 hour"
    },
    {
        :seconds => 24 * 3600,
        :display => "1 day"
    },
    {
        :seconds => 30 * 24 * 3600,
        :display => "1 day"
    },
    {
        :seconds => 365 * 24 * 3600,
        :display => "1 year"
    },
    {
        :seconds => 100 * 365 * 24 * 3600,
        :display => "1 century"
    },
]


functions = [
    # finding roots of some functions iteratively is too slow, so use optimizations to get the "solution" fast.
    {
        :display => "lg n",
        :fn      => nil,
        :solution => Proc.new { |t| "2 ^ #{t}" }
    },
    {
        :display => "sqrt(n)",
        :fn      => nil,
        :solution => Proc.new { |t| t ** 2 }
    },
    {
        :display => "n",
        :fn      => nil,
        :solution => Proc.new { |t| t }
    },
    {
        :display => "n lg n",
        :fn      => nil,
        :solution => Proc.new { |t| n_lg_n_roots(t, 10**15) }
    },
    {
        :display => "n²",
        :fn      => Proc.new { |n| n*n }
    },
    {
        :display => "n³",
        :fn      => Proc.new { |n| n*n*n }
    },
    {
        :display => "2^n",
        :fn      => Proc.new { |n| 2**n }
    },
    {
        :display => "n!",
        :fn      => Proc.new { |n| factorial(n) }
    },
]


# solutions verified with https://sites.math.rutgers.edu/~ajl213/CLRS/Ch1.pdf

functions.each do |info|
    puts "Computing for function: #{info[:display]}"

    intervals.each do |t_info|
        usecs = t_info[:seconds] * 1_000_000.0

        result = nil
        if info[:solution]
            result = info[:solution].call(usecs)
        else
            i = 2
            fn = info[:fn]
            until fn.call(i) >= usecs do
                i+=1
            end
            result = i-1
        end

        puts "n = #{result} for #{t_info[:display]}"
    end

    puts "\n\n"
end


