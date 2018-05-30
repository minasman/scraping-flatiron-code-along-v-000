require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
  def get_page
    Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
  end
  
  def get_courses
    doc = self.get_page
    courselist = doc.css(".posts-holder article")
  end
  
  def make_courses
    courses = self.get_courses
    courses.each do |article|
      Course.new(article.css("h2").text, article.css("em").text, article.css("p").text)
    end
  end
    
  
end

#courses = Scraper.new.make_courses


