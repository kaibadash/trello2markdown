# frozen_string_literal: true
require 'trello'
require 'dotenv'
require 'pry'

class Trello2markdown
  def initialize
    Dotenv.load
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
      config.member_token = ENV['TRELLO_MEMBER_TOKEN']
    end
  end

  def puts_markdown(target_borads)
    boards = Trello::Board.all
    boards.each do |board|
      next if board.closed?
      next if target_borads.present? && !target_borads.include?(board.name)
      puts "\n##{board.name}"
      board.lists.each do |list|
        next if list.closed?
        puts "\n###{list.name}"
        list.cards.each do |card|
          next if card.closed?
          puts "- #{card.name}"
        end
      end
    end
  end
end

Trello2markdown.new.puts_markdown(ARGV)
