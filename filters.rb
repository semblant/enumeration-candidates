# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

require './candidates'
require 'date'

##
# find() function takes an ID and returns the matching candidate ID or nil if no match (@candidates is hardcoded)
# Parameters: id {string?/number?} - the id to check
# returns: candidate {hash} or nil
def find(id)
    @candidates.each do |candidate|
      if candidate[:id] == id
        return candidate
      else
        return nil
      end
    end
  end

  ##
  # experienced?() function takes in a candidate and checks if the years of experience is at least 2.
  # Parameters: candidate {hash} - the hash/object to check experience key for
  # returns: true or false
  def experienced?(candidate)
    if candidate[:years_of_experience] >= 2
      return true
    else
      return false
    end
  end

  ##
  # qualified_candidates() function takes in an array of hashes and returns an array of hashes that meet multiple conditions
  # Parameters: candidates {array of hashes} - the array to perform the condition checks on
  # returns: result {array of hashes} - the resulting array of hashes that passed the conditional checks
  def qualified_candidates(candidates)
    result = []
    candidates.each do |candidate|
      if experienced?(candidate) && candidate[:github_points] >= 100 && days_interval(candidate[:date_applied]) < 16 && candidate[:age] > 17 && candidate[:languages].include?("Ruby") || candidate[:languages].include?("Python")
        result.push(candidate)
      else next
      end
    end
    return result
  end

##
# days_interval() function takes in a date and returns the number of days from the current date.
# Parameters: date {string} - the date to subtract from today
# Returns: days_ago {number} - the number of days that have passed since provided date
def days_interval(date)
  new_date = date.to_datetime # parse date into datetime
  today = DateTime.now #  get todays datetime
  days_ago = (today - new_date).to_i # subtract and format into integer
  return days_ago
end

##
# ordered_by_qualifications() function takes in a collection of hashes and returns them sorted on years of experience, when experience is the same, sort by Github points.
# Paramters: candidates {array of hashes} - the collection to perform the reordering on
# returns: result - {array of hashes} - the reordered collection
def ordered_by_qualifications(candidates)
  candidates.sort_by { |candidate| [-candidate[:years_of_experience], -candidate[:github_points]]}
end
